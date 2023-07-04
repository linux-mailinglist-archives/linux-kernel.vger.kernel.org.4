Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1402274749D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGDO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGDO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:58:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47B10CA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DBEF61291
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 14:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B27C433C8;
        Tue,  4 Jul 2023 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688482716;
        bh=TqHLxq6TgLs4mAvW37Gf9sulJ3v19NarWJwdoDxqmqE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MVhADanhafYJGF3952CbMFV7tj3X38l35gED65EcGVnYgIBiqmC+4jgoSwHovTnBy
         V8y/TNnLawcZFJ/SmZvo+9KzN7pdDXaXRLG+cXItRdhx5csNKPLVBSHFom9w6bjIcr
         W3VgmCkAFdh3f7lDZJLMicf2FcHPadzX402BuztafTKoqA0jG3EqTSbQAnLyjiEmoj
         EX37+diYCMluQwPs0SKp963f4i374/+goqX8p5Z0tvcJ799hhpbDe08s7VtiVuR2YC
         N3qA7kcy+V5Pq6PpxBw4T1ihzCTDpak1jWfTX77zVSz3phkpjjOC1Y7OUs5u0Ju2ke
         hRO5r/tQ+EEZQ==
Message-ID: <65143701-4c19-ab66-1500-abd1162639cd@kernel.org>
Date:   Tue, 4 Jul 2023 22:58:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: do not issue small discard commands
 during checkpoint
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daejun Park <daejun7.park@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230613203947.2745943-1-jaegeuk@kernel.org>
 <ZInmkgjDnAUD5Nk0@google.com>
 <50d5fa8c-4fe9-8a03-be78-0b5383e55b62@kernel.org>
 <ZKP6EJ5dZ4f4wScp@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZKP6EJ5dZ4f4wScp@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/4 18:53, Jaegeuk Kim wrote:
> On 07/03, Chao Yu wrote:
>> On 2023/6/15 0:10, Jaegeuk Kim wrote:
>>> If there're huge # of small discards, this will increase checkpoint latency
>>> insanely. Let's issue small discards only by trim.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>
>>>    Change log from v1:
>>>     - move the skip logic to avoid dangling objects
>>>
>>>    fs/f2fs/segment.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 8c7af8b4fc47..0457d620011f 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -2193,7 +2193,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>    			len = next_pos - cur_pos;
>>>    			if (f2fs_sb_has_blkzoned(sbi) ||
>>> -			    (force && len < cpc->trim_minlen))
>>> +					!force || len < cpc->trim_minlen)
>>>    				goto skip;
>>
>> Sorry for late reply.
>>
>> We have a configuration for such case, what do you think of setting
>> max_small_discards to zero? otherwise, w/ above change, max_small_discards
>> logic may be broken?
>>
>> What:           /sys/fs/f2fs/<disk>/max_small_discards
>> Date:           November 2013
>> Contact:        "Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>> Description:    Controls the issue rate of discard commands that consist of small
>>                  blocks less than 2MB. The candidates to be discarded are cached until
>>                  checkpoint is triggered, and issued during the checkpoint.
>>                  By default, it is disabled with 0.
>>
>> Or, if we prefer to disable small_discards by default, what about below change:
> 
> I think small_discards is fine, but need to avoid long checkpoint latency only.

I didn't get you, do you mean we can still issue small discard by
fstrim, so small_discards functionality is fine?

Thanks,

> 
>>
>>  From eb89d9b56e817e3046d7fa17165b12416f09d456 Mon Sep 17 00:00:00 2001
>> From: Chao Yu <chao@kernel.org>
>> Date: Mon, 3 Jul 2023 09:06:53 +0800
>> Subject: [PATCH] Revert "f2fs: enable small discard by default"
>>
>> This reverts commit d618ebaf0aa83d175658aea5291e0c459d471d39 in order
>> to disable small discard by default, so that if there're huge number of
>> small discards, it will decrease checkpoint's latency obviously.
>>
>> Also, this patch reverts 9ac00e7cef10 ("f2fs: do not issue small discard
>> commands during checkpoint"), due to it breaks small discard feature which
>> may be configured via sysfs entry max_small_discards.
>>
>> Fixes: 9ac00e7cef10 ("f2fs: do not issue small discard commands during checkpoint")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/segment.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 14c822e5c9c9..0a313368f18b 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2193,7 +2193,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>   			len = next_pos - cur_pos;
>>
>>   			if (f2fs_sb_has_blkzoned(sbi) ||
>> -					!force || len < cpc->trim_minlen)
>> +			    (force && len < cpc->trim_minlen))
>>   				goto skip;
>>
>>   			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
>> @@ -2269,7 +2269,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>   	atomic_set(&dcc->queued_discard, 0);
>>   	atomic_set(&dcc->discard_cmd_cnt, 0);
>>   	dcc->nr_discards = 0;
>> -	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>> +	dcc->max_discards = 0;
>>   	dcc->max_discard_request = DEF_MAX_DISCARD_REQUEST;
>>   	dcc->min_discard_issue_time = DEF_MIN_DISCARD_ISSUE_TIME;
>>   	dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
>> -- 
>> 2.40.1
>>
>>
>>
>>>    			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
