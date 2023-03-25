Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2756C8C2D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjCYHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCYHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:25:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440FA423A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9860B81212
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 07:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97B9C433EF;
        Sat, 25 Mar 2023 07:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679729144;
        bh=ntEalkUYAGwjABuQ56Tv6dEUJ7uXtdZVc6w4gHVNPp0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S8j7Jo+/Py1QDPuJxYBwBV5JXrI0Yk63/fCXos0cWxtd0BYDsMFZgyRyZMw7hS3Ue
         7CRsh5nNqKuuy3tDaXJj0id7BSq/YrJeIHNEcryYRpNHjZQIrZM4JWGnBNSrfi2vkb
         dlgMaMLt2kU0LPgy7TMvm54ZNH+kjC3BcLwgW1vTi9G3xpTeYTXkcRRWQZ+EMcZrUY
         opSFyUCnRlARr2RDqiP31x40LEcTg5K8xLs9NhOs47Qa2I3ynXIcdN6mu2MXEu4gm4
         axAiHhp06eXBA3hPfFkl1HOFGInMxs36ZAlNeaZZgYTzpDz7ahP5ALtP4RKsOXcWxR
         Kf3yCKGht1Gkg==
Message-ID: <7524b5b2-95c1-f39f-c375-bdfb55778c5d@kernel.org>
Date:   Sat, 25 Mar 2023 15:25:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] f2fs: Fix discard bug on zoned block devices with 2MiB
 zone size
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     yonggil.song@samsung.com,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <a24d66ad-4048-fd5c-ae47-2dd17c87bcbe@kernel.org>
 <ZBzMql6DkrUWiRKP@google.com>
 <35dd1eea-f1b9-418e-5f97-cfd10b7ff803@kernel.org>
 <ZB3Vz9w2ybNVSY8C@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZB3Vz9w2ybNVSY8C@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/25 0:54, Jaegeuk Kim wrote:
> On 03/24, Chao Yu wrote:
>> On 2023/3/24 6:03, Jaegeuk Kim wrote:
>>> On 03/23, Chao Yu wrote:
>>>> On 2023/3/13 17:48, Yonggil Song wrote:
>>>>> When using f2fs on a zoned block device with 2MiB zone size, IO errors
>>>>> occurs because f2fs tries to write data to a zone that has not been reset.
>>>>>
>>>>> The cause is that f2fs tries to discard multiple zones at once. This is
>>>>> caused by a condition in f2fs_clear_prefree_segments that does not check
>>>>> for zoned block devices when setting the discard range. This leads to
>>>>> invalid reset commands and write pointer mismatches.
>>>>>
>>>>> This patch fixes the zoned block device with 2MiB zone size to reset one
>>>>> zone at a time.
>>>>>
>>>>> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
>>>>> ---
>>>>>     fs/f2fs/segment.c | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index acf3d3fa4363..2b6cb6df623b 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -1953,7 +1953,8 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>>>     					(end - 1) <= cpc->trim_end)
>>>>>     				continue;
>>>>> -		if (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi)) {
>>>>> +		if (!f2fs_sb_has_blkzoned(sbi) &&
>>>>
>>>> Could you please add one line comment here for this change?
>>>
>>> This was merged in -dev a while ago. I don't think this would be critical
>>> to rebase it again.
>>
>> Yes, it's not critical, fine to me.
> 
> Added:
> 
> /* Should cover 2MB zoned device for zone-based reset */

Thanks a lot for the change. :)

Thanks,

> 
> So lucky since I had to rebase to fix other patch. :(
> 
> "f2fs: factor out discard_cmd usage from general rb_tree use"
> 
> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Otherwise it looks good to me.
>>>>
>>>> Thanks,
>>>>
>>>>> +		    (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi))) {
>>>>>     			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
>>>>>     				(end - start) << sbi->log_blocks_per_seg);
>>>>>     			continue;
