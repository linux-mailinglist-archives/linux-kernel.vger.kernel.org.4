Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00716BC03F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjCOW4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCOW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:56:31 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A66B6421A;
        Wed, 15 Mar 2023 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=uzyrWVbMqjtX62g56ZChx3MGVBwqngXFUkvajmUUQHY=; b=UOcE4KAGH+awyIWmfsgrTTuJ18
        bL+PqD3WM2geTjWrzMZG+UcpwiXID2AWv9R3UIqIds0xbEmlOhpbArk8ptKFThNR0rZB8dk4LWWiR
        HBWOV17BQCjUUlUGfVOvrB3weljEDRWjZASQJ2Mql2rN06AlUkktsblvoNI66Wk/TmH4rEJSD/rhy
        CIZcRSodvx7fxAEtqHVqCRFCDUSAwjrEQP+qcu9PJgnqKPqo9i2/YxBvo54kfJt7brqZEQEOm1fzL
        Ku0VhUz3BI4ckryLeWxbJ2B+UA4wFwJsdqcaKIyZaIrFg5JEgObjBed5lNOc9i9ZuoSVVr1j3DDYj
        f7zWkpnQ==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pca2K-000oaI-4Z; Wed, 15 Mar 2023 16:56:01 -0600
Message-ID: <606b1388-10e7-a0ae-f314-52274b0942dd@deltatee.com>
Date:   Wed, 15 Mar 2023 16:55:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, agk@redhat.com,
        snitzer@kernel.org, song@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230315061810.653263-1-yukuai1@huaweicloud.com>
 <e1a5fe1c-ea3d-adef-62ec-3b30bedbe4f8@molgen.mpg.de>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <e1a5fe1c-ea3d-adef-62ec-3b30bedbe4f8@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: pmenzel@molgen.mpg.de, yukuai1@huaweicloud.com, agk@redhat.com, snitzer@kernel.org, song@kernel.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 0/5] md: fix uaf for sync_thread
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-15 02:30, Paul Menzel wrote:
> Am 15.03.23 um 07:18 schrieb Yu Kuai:
>> I tested this pathset with mdadm tests, and there are no new regression,
>> by the way, following test will failed with or without this patchset:
>>
>> 01raid6integ
>> 04r1update
>> 05r6tor0
>> 10ddf-create
>> 10ddf-fail-spare
>> 10ddf-fail-stop-readd
>> 10ddf-geometry
> 
> As you improved the tests in the past, can you confirm, these failed on
> your test systems too and are fixed now?

Hmm, well Yu did not claim that those tests were fixed. If you re-read
what was said, the tests listed failed with or without the new changes.
As I read it, Yu asserts no new regressions were created with the patch
set, not that failing tests were fixed.

Unfortunately, the tests listed are largely not ones I saw failing the
last time I ran the tests (though it's been a few months since I last
tried). I know 01raid6integ used to fail some of the time, but the other
6 tests mentioned worked the last time I ran them; and there are many
other tests that failed when I ran them. (My notes on which tests are
broken are included in the most recent mdadm tree in tests/*.broken)

I was going to try and confirm that no new regressions were introduced
by Yu's patches, but seems the tests are getting worse. I tried running
the tests on the current md-next branch and found that one of the early
tests, 00raid5-zero, hangs indefinitely. I quickly ran the same test on
v6.3-rc2 and found that it runs just fine there. So it looks like
there's already a regression in md-next that is not part of this series
and I don't have the time to dig into the root cause right now.

Yu's patches don't apply cleanly to v6.3-rc2 and I can't run the tests
against md-next; so I didn't bother running them, but I did do a quick
review. The locking changes make sense to me so it might be worth
merging for correctness. However, I'm not entirely sure it's the best
solution -- the md thread stuff seems like a bit of a mess and passing
an mddev to thread functions that were not related to the mddev to get a
lock seems to just make the mess a bit worse.

For example, it seems a bit ugly to me for the lock mddev->thread_lock
to protect the access of a pointer in struct r5l_log. Just spit-balling,
but perhaps RCU would be more appropriate here. Then md_wakeup_thread()
would just need to hold the RCU read lock when dereferencing, and
md_unregister_thread() would just need to synchronize_rcu() before
stopping and freeing the thread. This has the benefit of not requiring
the mddev object for every md_thread and would probably require a lot
less churn than the current patches.

Logan




