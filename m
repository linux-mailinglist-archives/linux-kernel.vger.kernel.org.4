Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE186955F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBNBaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBNBaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:30:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422DAC66F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:30:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDA4EB81A2E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD715C433EF;
        Tue, 14 Feb 2023 01:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676338207;
        bh=TcSWSVDQG/HWhzEa4mElyIfq2q468pRmSvFT+IS5NWU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fbBUnU6NdnohbS7Jm9U9zWWCqWzl5jum7XKz8hnUbXfE/YuE/TSSZtaky2dr8FUFj
         qhjkyliPAKBK1y0CkSMAAf+BAADglJO+q9SDCJayBa7MW0eif/pTm7BNInLYzYfhf1
         IcR5icarCcBI86m3pPKaZGiaEKSPuTkraVeIhlInp1bxlABa3b/TWi+nlo8vnROeAo
         iLMqgU6mmOGSUuw/636coxoVbRAJBgyBnFhRB4SORCy+Jk2h4qo4A22WojS4hVVI/f
         c9IVsfXbgocpBjo3vAwYtZ0LDe9mC3MjOWPKXPO3Ql7trL47YO8oRw36xCz1NUIqUa
         owNIt2x5BNCdg==
Message-ID: <a7ccac95-384c-f4de-a60f-ee6b8680c9d7@kernel.org>
Date:   Tue, 14 Feb 2023 09:30:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong segment count
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230210213250.3471246-1-jaegeuk@kernel.org>
 <1a66e32b-efc0-626b-b585-7f2bfac506a7@kernel.org>
 <Y+p311Vi/odYKuC2@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y+p311Vi/odYKuC2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/14 1:48, Jaegeuk Kim wrote:
> On 02/13, Chao Yu wrote:
>> On 2023/2/11 5:32, Jaegeuk Kim wrote:
>>> MAIN_SEGS is for data area, while TOTAL_SEGS includes data and metadata.
>>
>> Good catch!
>>
>> Could you please add fixes line?
> 
> It seems this is not a bug case, and exisits from the first F2FS patch. :)

Alright, anyway, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/segment.h | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>> index 8ee5e5db9287..6003fbaf4b7d 100644
>>> --- a/fs/f2fs/segment.h
>>> +++ b/fs/f2fs/segment.h
>>> @@ -720,7 +720,7 @@ static inline unsigned char curseg_alloc_type(struct f2fs_sb_info *sbi,
>>>    static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
>>>    {
>>> -	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
>>> +	f2fs_bug_on(sbi, segno > MAIN_SEGS(sbi) - 1);
>>>    }
>>>    static inline void verify_fio_blkaddr(struct f2fs_io_info *fio)
>>> @@ -775,7 +775,7 @@ static inline int check_block_count(struct f2fs_sb_info *sbi,
>>>    	/* check segment usage, and check boundary of a given segment number */
>>>    	if (unlikely(GET_SIT_VBLOCKS(raw_sit) > usable_blks_per_seg
>>> -					|| segno > TOTAL_SEGS(sbi) - 1)) {
>>> +					|| segno > MAIN_SEGS(sbi) - 1)) {
>>>    		f2fs_err(sbi, "Wrong valid blocks %d or segno %u",
>>>    			 GET_SIT_VBLOCKS(raw_sit), segno);
>>>    		set_sbi_flag(sbi, SBI_NEED_FSCK);
