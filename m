Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BB672D8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbjFMFMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjFMFMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:12:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6EFE62;
        Mon, 12 Jun 2023 22:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C15261E69;
        Tue, 13 Jun 2023 05:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF78BC433EF;
        Tue, 13 Jun 2023 05:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686633168;
        bh=4kqAAS3SX9JNXmuGjywNhA17eJxvCECeHra6VxQaDBw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rbAhe7NZu5CJGvuBXPpPG9QRfEHcXU6mWWC3lAqUMgJzZksZaGuq9abalEXyNQYGq
         hwydWjeaSTHnGfeihlk8Kmug70g1h7hY7vlcCGy91OCznH28V746nwhAY8RT6HZxMp
         s2Pq9aTX4hi3DPFQBSnRlrM/x32KueeG78qNoPb5g7g/fplZXe+qnav5lGsE/IQMW9
         Kd8/aDie78OS+g09yFMTWQNuNMUHjrAAh/wWl0mVa8mcXlJYb4M2yPxkhPYUM68Spd
         DONz2xi4bc1UsrQZ9oTFlgrGtdWdwj5bNqxIdfHHSSGfp+j00IZDGDJkv+xjyCKcaj
         svkSn+eGuYPTg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Replace RX workqueues with kthreads
References: <20230609103651.313194-1-treapking@chromium.org>
        <87o7lohq9e.fsf@kernel.org>
        <CAEXTbpdDsoghsxbJqszx0OWWw1o9D8p9f_9-4OgOM-a-w7OzSA@mail.gmail.com>
        <ZIeuhU/vnoL1yWmQ@google.com>
Date:   Tue, 13 Jun 2023 08:12:42 +0300
In-Reply-To: <ZIeuhU/vnoL1yWmQ@google.com> (Brian Norris's message of "Mon, 12
        Jun 2023 16:47:17 -0700")
Message-ID: <87r0qgdjxx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> Hi,
>
> Thanks Pin-yen for most of the investigation here and for pushing the
> patch. With some additional information though, I might suggest *not*
> landing this patch at the moment. More details appended:
>
> On Sat, Jun 10, 2023 at 01:41:51AM +0800, Pin-yen Lin wrote:
>> I realized that I might have over-simplified the background and the
>> impact of this patch...
>> 
>> The short answer to the question is that the throughput improved from
>> 100 mbps to 180 mbps. The test was run on ChromeOS's v5.15 kernel
>> fork. More detailed test setting is mentioned in [1].
>> 
>> However, the throughput of the same test case on our v4.19 kernel is
>> 320 mbps. That is, we observed a 320 mbps --> 100 mbps regression when
>> we tried to update the kernel version. This patch is more like a
>> mitigation of the regression. It improves the throughput, even though
>> it is still not as good as the older kernel.
>> 
>> That being said, this patch does improve the throughput, so we think
>> this patch can be landed into the mainline kernel.
>> 
>> Best regards,
>> Pin-yen
>> 
>> [1]: https://lore.kernel.org/all/ZFvpJb9Dh0FCkLQA@google.com/
>
> I (we?) was optimistic this would be an improvement (or at least, no
> worse) due to some of the reasoning at [1]. And, the work here is just a
> single work item, queued repeatedly to the same unbound workqueue. So
> conceptually, it shouldn't be much different than a kthread_worker,
> except for scheduler details -- where again, we'd think this should be
> an improvement, as the scheduler would now better track load for the
> task (mwifiex RX) in question.
>
> But additional testing on other mwifiex-based systems (RK3399 + PCIE
> 8997) showed the inverse: some throughput drops on similar benchmarks,
> from 110 Mbps to 80 Mbps. (Frankly, both numbers are significantly below
> where we might like...)
>
> Considering we still don't have a full explanation for all the
> performance differences we've been seeing (on either test platform), and
> that at least one of our platforms showed a (smaller) regression, I
> think we might want to do more research before committing to this.

Yeah, I agree and I'll drop this. This is a really weird problem, I hope
you can get to the bottom of it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
