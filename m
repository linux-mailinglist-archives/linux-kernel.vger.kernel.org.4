Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE504669B21
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjAMO63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjAMO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:57:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A5997488;
        Fri, 13 Jan 2023 06:45:13 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 91F53607B4;
        Fri, 13 Jan 2023 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673621112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oJMxd0NdjDpbFfMPktCneUuO99VYCmKvChtNw4xNjD8=;
        b=KTRs3d/2ZWAXCFkTJitI4tkBmp0uw59UcO43ZB9gHHeM7TDHaQdukyw+EUZV1KACS7b+96
        QM97r8d8SXVB+uePAMVDsktuQpK6nfnYObNdSOwooUD/1szsLcvrlemVEdFIAuX4HWlczx
        bQaqT9viFLxb2fK3r9cAFBrkdkZzFKY=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 743FA2C141;
        Fri, 13 Jan 2023 14:45:12 +0000 (UTC)
Date:   Fri, 13 Jan 2023 15:45:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mcgrof@kernel.org, david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] selftests: kmod: Add tests for merging same-name
 module load requests
Message-ID: <Y8Ft7q/NBK5utN+I@alley>
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-5-petr.pavlu@suse.com>
 <Y01d50Z2DK3f9V+Q@alley>
 <edeee00c-c101-460a-0682-a2fa638b95f4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edeee00c-c101-460a-0682-a2fa638b95f4@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-12 10:03:10, Petr Pavlu wrote:
> [A different fix that the one from this thread was selected but it is still
> useful to discuss these test cases and if they should be added in some form.]
> 
> On 10/17/22 15:51, Petr Mladek wrote:
> > On Sun 2022-10-16 14:30:31, Petr Pavlu wrote:
> >> Add two tests to check that loading the same module multiple times in
> >> parallel results only in one real attempt to initialize it.
> >> Synchronization of the loads is done by waiting 1000 ms in the init
> > 
> > I do not have a good experience with this kind of synchronization.
> > It usually is not reliable. The test might be very slow especially when
> > false positives are solved by prolonging the delay.
> > 
> > Alternative solution would be to have two modules:
> > 
> > 1st module would provide a counter, for example:
> > 
> > int modB_load_cnt;
> > module_param(modB_load_cnt, int, 0444);
> > EXPORT_SYMBOL(modB_load_cnt);
> > 
> > EXPORT_SYMBOL() should allow to directly increment the counter
> > from the 2nd module.
> > 
> > module_param() should make the value readable via
> > /sys/module/modA/parameters/modB_load_cnt. It can be
> > checked by kmod_sh.
> 
> I agree that it would be best to avoid any synchronization based on timeouts
> in these tests.
> 
> My reading is that your idea should allow the tests to remove measuring how
> long it took in total to process all module inserts. It was possible for me to
> implement this change.
> 
> It unfortunately doesn't help with the 1 second timeout that the
> kmod_test_0014 module (modB in your description) has in its init function. Its
> purpose is to make sure that any parallel loads of the same module which were
> started by kmod.sh manage to reach add_unformed_module(), sleep there and
> therefore hit the updated logic.

I see.

> One option how to avoid this timeout is to extend modA to register a kprobe on
> finished_loading() and export via a parameter which loads started by kmod.sh
> reached this point. This approach works ok on my system and a prototype is
> pasted at the end of this mail. Two shortcomings are that it relies on
> internal knowledge of the module loader code and function finished_loading()
> might not be always available for probing as it could get inlined in some
> configurations.

Yeah, it is a bit fragile as well.

> To summarize, I see the following options for these tests:
> * Use a timeout to synchronize the loads.
> * Use the outlined kprobe approach.
> * Don't add these tests at all.

Yet another solution would be to add a support for this test into
the module loaded code. I mean that add_unformed_module() might
increment a global counter when a certain module is waiting there.
The global counter then might be used to unblock the init()
callback.

The test module might be distinguished, for example, by a test
specific module info string. For example, see
check_modinfo_livepatch(). It looks for the info string defined
in the livepatch modules, see MODULE_INFO(livepatch, "Y"); in
samples/livepatch/livepatch-sample.c.

That said, I do not like this much either. I am not sure if it is
more or less crazy than the kprobe approach.


> Any opinions what would be preferred? I'm leaning towards not adding these
> tests as they look fragile to me.

I do not have strong opinion.

My experience is that some tests are not worth the effort. The
maintenance or false positives might add more harm than good.

My feeling is that this one belongs into this category.
We could keep the timeout and make it error prone.
Or we could use some hacks and make it hard to maintain.

Best Regards,
Petr
