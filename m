Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B086A6DEC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjDLHIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDLHIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:08:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD746210C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:08:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7FB1A1F890;
        Wed, 12 Apr 2023 07:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681283285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ob/KC0Tj25QeUxrsnTrJM0BtRp2Yi+/k4YcYZk7GvcQ=;
        b=Dq5U/+PjUo3hz2fWCvXkY2C7bnVPbwms9SfWXkiFAQ4KEUshx0DoFI+fnwRk8vQwlKbLu0
        J5pJplU3tqfBZW4Buuk2czCZ9b7b64JEmX7OHMBgNYS2Yb9x/raybK9w9CWDBgJbE9dRjd
        KR68NU52/1IwIzngg+VDukkGa1JvjEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681283285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ob/KC0Tj25QeUxrsnTrJM0BtRp2Yi+/k4YcYZk7GvcQ=;
        b=Kms5aCXKfqZfQX+Bfabn0TktLqKvJGdKX5f8f37aonbXSgNs7zZFG3OnkGc/MLSy0lXz1S
        wJm2iZCliW6brGBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68F4E13498;
        Wed, 12 Apr 2023 07:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fwgPGNVYNmTGLgAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 12 Apr 2023 07:08:05 +0000
Date:   Wed, 12 Apr 2023 10:08:04 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: rmem: Make reserved region name unique
Message-ID: <fojltyl6pkx6dkidb55lwtvygr4qz4f7k7fxw2m72i4r2kqmqy@fzz4pcg2jr25>
References: <20230411135035.106725-1-iivanov@suse.de>
 <c1943fbf-46fc-b20a-1351-a7328188aab0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1943fbf-46fc-b20a-1351-a7328188aab0@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 04-11 17:56, Srinivas Kandagatla wrote:
> 
> On 11/04/2023 14:50, Ivan T. Ivanov wrote:
> > They could be multiple reserved memory regions,
> > so let's make their names unique.
> > 
> > This fixes following kernel error:
> > 
> > [    9.831285] sysfs: cannot create duplicate filename '/bus/nvmem/devices/rmem0'
> 
> Have you considered using NVMEM_DEVID_AUTO?

Thanks,  I missed this one. I will rework it and resend.

Regards,
Ivan

