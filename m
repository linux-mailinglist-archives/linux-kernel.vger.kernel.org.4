Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF05BC570
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiISJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiISJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:33:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45716140A2;
        Mon, 19 Sep 2022 02:33:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BA85221FF;
        Mon, 19 Sep 2022 09:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663580017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1foqMVRLKucwhtU+4p7jj4OsS55xsQDfzr/9xoTDYE=;
        b=gDbIHBDDhT4dTZ5EDxs5haLrHLhypRHT9cJX6mG2DGFPTdF/1lIDNOFq7Uwa4P7/6Lxag2
        BeshCW9tdTMzclCyJziQfPa6kxIiOSJxdgl1HVcfaKPDy7SQOlLyU6vUTr3H0kxNEJZTXM
        gJm3IKIaqwM5W3oryS4w9K1v7YlM1Xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663580017;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1foqMVRLKucwhtU+4p7jj4OsS55xsQDfzr/9xoTDYE=;
        b=HcGBeK0UFDjAEx3ddw+nM913QDDSytveuYV5Q/qd+/9ucCYraBMF7Sz405vTYuElc9geiY
        WDbrBOyglC1S0vBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5376C13ABD;
        Mon, 19 Sep 2022 09:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ALfOEXE3KGOdWAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 19 Sep 2022 09:33:37 +0000
Date:   Mon, 19 Sep 2022 11:33:35 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] watchdog: wdat_wdt: Set the min and max timeout values
 properly
Message-ID: <20220919113335.18cebc74@endymion.delvare>
In-Reply-To: <5a1c9872-52b5-1f96-6931-801185b03fd4@roeck-us.net>
References: <20220806000706.3eeafc9c@endymion.delvare>
        <5a1c9872-52b5-1f96-6931-801185b03fd4@roeck-us.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

A few questions from an old discussion:

On Mon, 8 Aug 2022 04:36:42 -0700, Guenter Roeck wrote:
> On 8/5/22 15:07, Jean Delvare wrote:
> > To be honest, I'm not sold to the idea of a software-emulated
> > maximum timeout value above what the hardware can do, but if doing
> > that makes sense in certain situations, then I believe it should be
> > implemented as a boolean flag (named emulate_large_timeout, for
> > example) to complement max_timeout instead of a separate time value.
> > Is there a reason I'm missing, why it was not done that way?
>
> There are watchdogs with very low maximum timeout values, sometimes less than
> 3 seconds. gpio-wdt is one example - some have a maximum value of 2.5 seconds.
> rzn1_wd is even more extreme with a maximum of 1 second. With such low values,
> accuracy is important, second-based limits are insufficient, and there is an
> actual need for software timeout handling on top of hardware.

Out of curiosity, what prevents user-space itself from pinging
/dev/watchdog every 0.5 second? I assume hardware using such watchdog
devices is "special" and would be running finely tuned user-space, so
the process pinging /dev/watchdog could be given higher priority or
even real-time status to ensure it runs without delays. Is that not
sufficient?

> At the same time, there is actually a need to make timeouts milli-second based
> instead of second-based, for uses such as medical devices where timeouts need
> to be short and accurate. The only reason for not implementing this is that
> the proposals I have seen so far (including mine) were too messy for my liking,
> and I never had the time to clean it up. Reverting milli-second support would
> be the completely wrong direction.

I might look into this at some point (for example as a SUSE Hackweek
project). Did you post your work somewhere? I'd like to take a look.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
