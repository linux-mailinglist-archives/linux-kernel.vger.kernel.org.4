Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DEA7492BB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjGFAqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGFAqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:46:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A153171A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 984B7617D5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1787EC433C7;
        Thu,  6 Jul 2023 00:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688604409;
        bh=K7XtV0MJ+Qrk4bv1eFylFG3uLMZzjyg4PV7PAJHk7Pk=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=Bl1SkOIpVGW6hcGbc5cMMbxqYDDiCdcSfZDOEME5PNVHWUXtVrd7PwkgRrH8kaOQe
         akXjeHKdJglMoNRnv49qPMCIJv6IlXXl7HTEG3HHY9vA832LkWy6dskn3Pix4zb1GN
         Ac8LXbPHO4oZdVnAy7WYoyqteIRAmhH1V+MjPsN4kU2ebT/yMEMDJ53iLhHRgnqlUg
         N5A9BopyHz1FoMhK56fICuN0So84NopPypNQSPfxVZKYDpFETLe5NnTPncOJErG0WR
         RgFq6/v3O1zqwbGjJeuBYGSZzHEG5oMHWKQSxdHUYj+0Wi05QlLH5m2JsVtFZTiVbX
         47ZbChLsDUvyw==
Message-ID: <cadfb8d7-f5d0-a3ec-cafb-a0c06ad7d290@kernel.org>
Date:   Thu, 6 Jul 2023 08:46:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daejun Park <daejun7.park@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230613203947.2745943-1-jaegeuk@kernel.org>
 <ZInmkgjDnAUD5Nk0@google.com>
 <50d5fa8c-4fe9-8a03-be78-0b5383e55b62@kernel.org>
 <ZKP6EJ5dZ4f4wScp@google.com>
 <65143701-4c19-ab66-1500-abd1162639cd@kernel.org>
 <ZKWovWZDiHjMavtB@google.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: do not issue small discard commands
 during checkpoint
In-Reply-To: <ZKWovWZDiHjMavtB@google.com>
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

On 2023/7/6 1:30, Jaegeuk Kim wrote:
> On 07/04, Chao Yu wrote:
>> On 2023/7/4 18:53, Jaegeuk Kim wrote:
>>> On 07/03, Chao Yu wrote:
>>>> On 2023/6/15 0:10, Jaegeuk Kim wrote:
>>>>> If there're huge # of small discards, this will increase checkpoint latency
>>>>> insanely. Let's issue small discards only by trim.
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>
>>>>>     Change log from v1:
>>>>>      - move the skip logic to avoid dangling objects
>>>>>
>>>>>     fs/f2fs/segment.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index 8c7af8b4fc47..0457d620011f 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -2193,7 +2193,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>>>     			len = next_pos - cur_pos;
>>>>>     			if (f2fs_sb_has_blkzoned(sbi) ||
>>>>> -			    (force && len < cpc->trim_minlen))
>>>>> +					!force || len < cpc->trim_minlen)
>>>>>     				goto skip;
>>>>
>>>> Sorry for late reply.
>>>>
>>>> We have a configuration for such case, what do you think of setting
>>>> max_small_discards to zero? otherwise, w/ above change, max_small_discards
>>>> logic may be broken?
>>>>
>>>> What:           /sys/fs/f2fs/<disk>/max_small_discards
>>>> Date:           November 2013
>>>> Contact:        "Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>>>> Description:    Controls the issue rate of discard commands that consist of small
>>>>                   blocks less than 2MB. The candidates to be discarded are cached until
>>>>                   checkpoint is triggered, and issued during the checkpoint.
>>>>                   By default, it is disabled with 0.
>>>>
>>>> Or, if we prefer to disable small_discards by default, what about below change:
>>>
>>> I think small_discards is fine, but need to avoid long checkpoint latency only.
>>
>> I didn't get you, do you mean we can still issue small discard by
>> fstrim, so small_discards functionality is fine?
> 
> You got the point.

Well, actually, what I mean is max_small_discards sysfs entry's functionality
is broken. Now, the entry can not be used to control number of small discards
committed by checkpoint.

I think there is another way to achieve "avoid long checkpoint latency caused
by committing huge # of small discards", the way is we can set max_small_discards
to small value or zero, w/ such configuration, it will take checkpoint much less
time or no time to committing small discard due to below control logic:

f2fs_flush_sit_entries()
{
...
			if (!(cpc->reason & CP_DISCARD)) {
				cpc->trim_start = segno;
				add_discard_addrs(sbi, cpc, false);
			}
...
}

add_discard_addrs()
{
...
	while (force || SM_I(sbi)->dcc_info->nr_discards <=
				SM_I(sbi)->dcc_info->max_discards) {

It will break the loop once nr_discards is larger than max_discards, if
max_discards is set to zero, checkpoint won't take time to handle small discards.

...
		if (!de) {
			de = f2fs_kmem_cache_alloc(discard_entry_slab,
						GFP_F2FS_ZERO, true, NULL);
			de->start_blkaddr = START_BLOCK(sbi, cpc->trim_start);
			list_add_tail(&de->list, head);
		}
...
	}
...

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>>   From eb89d9b56e817e3046d7fa17165b12416f09d456 Mon Sep 17 00:00:00 2001
>>>> From: Chao Yu <chao@kernel.org>
>>>> Date: Mon, 3 Jul 2023 09:06:53 +0800
>>>> Subject: [PATCH] Revert "f2fs: enable small discard by default"
>>>>
>>>> This reverts commit d618ebaf0aa83d175658aea5291e0c459d471d39 in order
>>>> to disable small discard by default, so that if there're huge number of
>>>> small discards, it will decrease checkpoint's latency obviously.
>>>>
>>>> Also, this patch reverts 9ac00e7cef10 ("f2fs: do not issue small discard
>>>> commands during checkpoint"), due to it breaks small discard feature which
>>>> may be configured via sysfs entry max_small_discards.
>>>>
>>>> Fixes: 9ac00e7cef10 ("f2fs: do not issue small discard commands during checkpoint")
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>    fs/f2fs/segment.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 14c822e5c9c9..0a313368f18b 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -2193,7 +2193,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>>    			len = next_pos - cur_pos;
>>>>
>>>>    			if (f2fs_sb_has_blkzoned(sbi) ||
>>>> -					!force || len < cpc->trim_minlen)
>>>> +			    (force && len < cpc->trim_minlen))
>>>>    				goto skip;
>>>>
>>>>    			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
>>>> @@ -2269,7 +2269,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>>>    	atomic_set(&dcc->queued_discard, 0);
>>>>    	atomic_set(&dcc->discard_cmd_cnt, 0);
>>>>    	dcc->nr_discards = 0;
>>>> -	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>>>> +	dcc->max_discards = 0;
>>>>    	dcc->max_discard_request = DEF_MAX_DISCARD_REQUEST;
>>>>    	dcc->min_discard_issue_time = DEF_MIN_DISCARD_ISSUE_TIME;
>>>>    	dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
>>>> -- 
>>>> 2.40.1
>>>>
>>>>
>>>>
>>>>>     			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
