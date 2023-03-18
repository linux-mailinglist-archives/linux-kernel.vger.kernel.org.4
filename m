Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED66BFB36
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCRP2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCRP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:28:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A0168A5;
        Sat, 18 Mar 2023 08:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 537C5B8015A;
        Sat, 18 Mar 2023 15:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72901C433D2;
        Sat, 18 Mar 2023 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679153282;
        bh=TfkymS/0UtxxXLVQX0IAZAlCFa1g/qoFFz33Aw2cDP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EYzi7k5Shpe1V/FX4jtI7ba2bvlLmXhkezcgjC3YlwSXarKkuA8EJFeS3md6T5+eG
         K8WEKNdaN3Ai8k+mVF3zEHPnVwRv2usaOCwd1eziABm+jZpxm5enKmHqa4HnrfqmJU
         lD8/M6dbLgTOY0fKaMubpYydknDb56kfooQLaVn4Tn9Z8Tzwqi9sdW5vvLq1vYnhiT
         9OXBzJ9koG0owY1T7wAIY1rhgYRtNFFeXwL23uDw4stPuVgSeslEk0i3cTYQujyeMc
         baPoJPjd6IsSxRSojAkfZl4UCVVR/hIiQ2RiKztLh5+LSRlB7F8p12ZcaVZWLnBQ1n
         pWdkLH0Z8NMFw==
Date:   Sun, 19 Mar 2023 00:27:58 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: selftests: ftrace: event filter function - test event filtering
 on functions [FAIL]
Message-Id: <20230319002758.84a3893c88f6bfbf7ff9ad85@kernel.org>
In-Reply-To: <CA+G9fYv5G5Hows6Ex=1NMgSW3wtieKNNsFPBTpaLcF-bzaUtrw@mail.gmail.com>
References: <CA+G9fYtF-XEKi9YNGgR=Kf==7iRb2FrmEC7qtwAeQbfyah-UhA@mail.gmail.com>
        <20230315173257.1311e50729c73e0cb6e0aa0d@kernel.org>
        <CA+G9fYv5G5Hows6Ex=1NMgSW3wtieKNNsFPBTpaLcF-bzaUtrw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Wed, 15 Mar 2023 14:41:51 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Hi Masami San,
> 
> 
> On Wed, 15 Mar 2023 at 14:03, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Naresh,
> >
> > On Tue, 14 Mar 2023 15:52:44 +0530
> > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > > Results from Linaro’s test farm.
> > >
> > > selftests ftrace failed on qemu-x86_64 and qemu-arm64.
> > > Please find the test log below.
> >
> > Thanks for reporting!
> > Can you share the kernel config which you used for this build?
> > And the kernel is "next-20230314", is that correct?
> 
> I have attached a test log file and Kconfig file.

Thanks! I could reproduced.

The error log is here.
----
+ . /mnt/ftrace/test.d/filter/event-filter-function.tc
+ echo 'Test event filter function name'
Test event filter function name
+ echo 0
+ echo 0
+ echo
+ echo 'call_site.function == exit_mmap'
+ echo 1
+ echo 1
+ ls
+ echo 0
+ + wcgrep -l
 exit_mmap
+ grep kmem_cache_free trace
+ hitcnt=0
+ + wcgrep -l
 -v+  exit_mmap
grep kmem_cache_free trace
+ misscnt=0
+ '[' 0 -eq 0 ]
+ exit_fail
+ exit 1

And the test case is here.
-----
echo 'call_site.function == exit_mmap' > events/kmem/kmem_cache_free/filter
echo 1 > events/kmem/kmem_cache_free/enable
echo 1 > tracing_on
ls > /dev/null
echo 0 > events/kmem/kmem_cache_free/enable

hitcnt=`grep kmem_cache_free trace| grep exit_mmap | wc -l`
misscnt=`grep kmem_cache_free trace| grep -v exit_mmap | wc -l`

if [ $hitcnt -eq 0 ]; then
        exit_fail
fi
-----

The test case expects the `ls > /dev/null` involves 'kmem_cache_free' trace
event, but it doesn't.

BTW, this code is a bit fragile because the function caller can be changed
frequently. I think it should sample the events and use one of them.
Let me fix that.

Thank you,


> 
> >
> > >
> > > Is this expected to fail ? Am I missing anything ?
> >
> > No, it should be a bug. I would like to reproduce it.
> 
> - Naresh


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
