Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DE86C7539
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjCXBwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCXBwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:52:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9170723668
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 18:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1394FB822AE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1FFC433D2;
        Fri, 24 Mar 2023 01:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679622748;
        bh=7Ov5bcBJRytUEv+2NcWM9mM0KBzimX69aeySA71KuQQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ULPZ1Hb5Fx37otUY1CFhOilyXzeSeno+3EKAk+3D0advy9ZCTEGh9FiBfvXlRoxZJ
         EUzg/uvG6IDzVqDVnfeCe4TC0WoWELgL8ErWr1/xokXizv0YWca81VMVQhUwCdDBUj
         nEJxbb3rzHeyqYndELjP1dnDFtFGbtE8dpfUl6segz4dmJO6D6t69AXvfhrh9ZX+xd
         YMkTHuh/SK7f4kKJCu7hxXoUeVXoaTb8uNco/p52C6yAvXfD/waEaDNcCEPGeJ0JuX
         DpmMs2GpNNA4IsNtGPwC+GvxLbDVClC05suMJWEEprCFkSNViy6QgarmIY915Gv7+U
         P6QfpgjXL7d4g==
Message-ID: <35dd1eea-f1b9-418e-5f97-cfd10b7ff803@kernel.org>
Date:   Fri, 24 Mar 2023 09:52:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
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
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZBzMql6DkrUWiRKP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/24 6:03, Jaegeuk Kim wrote:
> On 03/23, Chao Yu wrote:
>> On 2023/3/13 17:48, Yonggil Song wrote:
>>> When using f2fs on a zoned block device with 2MiB zone size, IO errors
>>> occurs because f2fs tries to write data to a zone that has not been reset.
>>>
>>> The cause is that f2fs tries to discard multiple zones at once. This is
>>> caused by a condition in f2fs_clear_prefree_segments that does not check
>>> for zoned block devices when setting the discard range. This leads to
>>> invalid reset commands and write pointer mismatches.
>>>
>>> This patch fixes the zoned block device with 2MiB zone size to reset one
>>> zone at a time.
>>>
>>> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
>>> ---
>>>    fs/f2fs/segment.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index acf3d3fa4363..2b6cb6df623b 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1953,7 +1953,8 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>    					(end - 1) <= cpc->trim_end)
>>>    				continue;
>>> -		if (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi)) {
>>> +		if (!f2fs_sb_has_blkzoned(sbi) &&
>>
>> Could you please add one line comment here for this change?
> 
> This was merged in -dev a while ago. I don't think this would be critical
> to rebase it again.

Yes, it's not critical, fine to me.

Thanks,

> 
>>
>> Otherwise it looks good to me.
>>
>> Thanks,
>>
>>> +		    (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi))) {
>>>    			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
>>>    				(end - start) << sbi->log_blocks_per_seg);
>>>    			continue;
