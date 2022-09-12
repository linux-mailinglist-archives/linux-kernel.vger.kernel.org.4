Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF005B5D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiILPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiILPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:33:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF0028E23;
        Mon, 12 Sep 2022 08:33:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 63116203C0;
        Mon, 12 Sep 2022 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662996808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kozuecFuYGcaj4dmvVphhLmDqddAMEHY4So8DzM3m+A=;
        b=xSGCDg4mGumtpFsXYWWYWKLnjJtrUpYMAN8BK30kG8qvorkziyEYkwXSI4qOjTSXPB93KA
        3/On2InK0WuPDgrGtY0CSyvnCOTQmvVyTLnhZFVpbYRFRO3yN0H5uGETDfm1NLrUZsD/iN
        E//Z5DubrCP2AaNfySW6Nvg6kjV780U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662996808;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kozuecFuYGcaj4dmvVphhLmDqddAMEHY4So8DzM3m+A=;
        b=3VcY/WHXR6j0C/Jn49QCE3raFVIlSfKXqXJdOF38hAJhljnY11MPODqQoqFtNiA2Zn3o/+
        FGyqL0e1cxQUC0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C5F5139E0;
        Mon, 12 Sep 2022 15:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l3UwEUhRH2NuYgAAMHmgww
        (envelope-from <iivanov@suse.de>); Mon, 12 Sep 2022 15:33:28 +0000
Date:   Mon, 12 Sep 2022 18:33:27 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: bcm2835: fix bcm2835_clock_rate_from_divisor
 declaration
Message-ID: <20220912153327.b6yjpqofq52pzdz6@suse>
References: <20220904141037.38816-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904141037.38816-1-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-04 16:10, Stefan Wahren wrote:
> Date: Sun,  4 Sep 2022 16:10:37 +0200
> From: Stefan Wahren <stefan.wahren@i2se.com>
> To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
>  <sboyd@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui
>  <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Maxime Ripard
>  <maxime@cerno.tech>
> Cc: linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
>  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan
>  Wahren <stefan.wahren@i2se.com>
> Subject: [PATCH] clk: bcm2835: fix bcm2835_clock_rate_from_divisor
>  declaration
> Message-Id: <20220904141037.38816-1-stefan.wahren@i2se.com>
> 
> The return value of bcm2835_clock_rate_from_divisor is always unsigned
> and also all caller expect this. So fix the declaration accordingly.
> 
> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Ivan T. Ivanov <iivanov@suse.de>

