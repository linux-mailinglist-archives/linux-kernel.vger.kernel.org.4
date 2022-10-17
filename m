Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA41601083
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJQNvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJQNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:51:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3081C125;
        Mon, 17 Oct 2022 06:51:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 81BF73400A;
        Mon, 17 Oct 2022 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666014696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wsWr+Ep+EK7rnuxntXQBk+r8nFSCsmWYWDo+ktsF+E8=;
        b=A0yN/V4qtthZpmxpz2jrPEuoGvck4A9nlmJIVT00d+XsIa9YkV9RRAh7dlAU12gj57j/et
        Ie33KUNQee6OtTH2SX9985b1hwXSlJiJLxOKuR2pGXuDPWzurg2TI0KvHPsnGY60+qold2
        FyjQ9PvxSYI+6yHGT4vvpiojZPaiCT8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6226D2C141;
        Mon, 17 Oct 2022 13:51:36 +0000 (UTC)
Date:   Mon, 17 Oct 2022 15:51:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mcgrof@kernel.org, david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] selftests: kmod: Add tests for merging same-name
 module load requests
Message-ID: <Y01d50Z2DK3f9V+Q@alley>
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-5-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016123031.3963-5-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-10-16 14:30:31, Petr Pavlu wrote:
> Add two tests to check that loading the same module multiple times in
> parallel results only in one real attempt to initialize it.
> Synchronization of the loads is done by waiting 1000 ms in the init

I do not have a good experience with this kind of synchronization.
It usually is not reliable. The test might be very slow especially when
false positives are solved by prolonging the delay.

Alternative solution would be to have two modules:

1st module would provide a counter, for example:

int modB_load_cnt;
module_param(modB_load_cnt, int, 0444);
EXPORT_SYMBOL(modB_load_cnt);

EXPORT_SYMBOL() should allow to directly increment the counter
from the 2nd module.

module_param() should make the value readable via
/sys/module/modA/parameters/modB_load_cnt. It can be
checked by kmod_sh.

> function of a sample module kmod_test_0014. The tests measure time
> needed to perform all inserts to verify that the loads get merged by the
> module loader and are not serialized.
> 
> * Case 0014 checks a situation when the load is successful. It should
>   result in one insert returning 0 and remaining inserts returning
>   EEXIST.
> * Case 0015 checks a situation when the load is failing because the
>   module init function returns ENODEV. It should result in one insert
>   returning this error code and remaining inserts returning EBUSY.
> 
> The tests use a simple init_module program to load kmod_test_0014.ko. It
> enables to obtain directly a return code from the finit_module syscall.

The tested scenarios look good.

Best Regards,
Petr
