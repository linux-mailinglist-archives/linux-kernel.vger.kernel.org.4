Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7706E1986
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDNBTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNBTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:19:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2212D5F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 18:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 871C963BB4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA50CC433D2;
        Fri, 14 Apr 2023 01:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681435139;
        bh=GpyqswlkR5WgrTmui+S0AaHMMIflP1m47uRsisRn0N8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ShgZ2Hz3viX7fEiwFXbfXEECNWNK4RBYOS83qbbUxpdPNS93Dt2xOlHESUPGZGC//
         JvfNDB+AfGphfTPIILlzD23Wo3p65QyMmDBP5PPQvgj9Bu0zqroC0l0TIATtNVHB55
         7gEBRjiGKQPqI8jZztu9HPVtZeTg0jtfzL/IlZHImvNxM8KRVk5/Je2c6GnrYLPWIx
         eryiiQ10XyLT97bBBZD7/Sv/cXXt/P+qIl5rPnt/AaJS177GieGs22grSdIRUhtVsX
         KOmpYpTLYsZwJHGQntdFFbBHkoYU4RIhp0ohMqOEt8juzOck3g0JQpofG9mDK1zGHm
         oXN5pvFBi8/lw==
Message-ID: <9e77c30c-0770-6cb7-cb75-2e22bc52b8d2@kernel.org>
Date:   Fri, 14 Apr 2023 09:18:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: relax sanity check if checkpoint is
 corrupted
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230407181539.4136580-1-jaegeuk@kernel.org>
 <ZDbZlwH5u3/nOTwL@google.com>
 <82ecc91f-a739-4744-29da-227daf5e45a2@kernel.org>
 <ZDglMgnxctYzMNnr@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZDglMgnxctYzMNnr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/13 23:52, Jaegeuk Kim wrote:
> On 04/13, Chao Yu wrote:
>> On 2023/4/13 0:17, Jaegeuk Kim wrote:
>>> 1. extent_cache
>>>    - let's drop the largest extent_cache
>>> 2. invalidate_block
>>>    - don't show the warnings
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>
>>>    Change log from v1:
>>>     - add one more case to skip the error message
>>>
>>>    fs/f2fs/checkpoint.c   | 10 ++++++++++
>>>    fs/f2fs/extent_cache.c | 22 +++++++++++++++-------
>>>    2 files changed, 25 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 448ecf5000b8..64b3860f50ee 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -152,6 +152,11 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>>>    	se = get_seg_entry(sbi, segno);
>>>    	exist = f2fs_test_bit(offset, se->cur_valid_map);
>>> +
>>> +	/* skip data, if we already have an error in checkpoint. */
>>> +	if (unlikely(f2fs_cp_error(sbi)))
>>> +		return exist;
>>> +
>>>    	if (exist && type == DATA_GENERIC_ENHANCE_UPDATE) {
>>>    		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
>>>    			 blkaddr, exist);
>>> @@ -202,6 +207,11 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>>    	case DATA_GENERIC_ENHANCE_UPDATE:
>>>    		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
>>>    				blkaddr < MAIN_BLKADDR(sbi))) {
>>> +
>>> +			/* Skip to emit an error message. */
>>> +			if (unlikely(f2fs_cp_error(sbi)))
>>> +				return false;
>>> +
>>>    			f2fs_warn(sbi, "access invalid blkaddr:%u",
>>>    				  blkaddr);
>>>    			set_sbi_flag(sbi, SBI_NEED_FSCK);
>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>> index 9a8153895d20..bea6ab9d846a 100644
>>> --- a/fs/f2fs/extent_cache.c
>>> +++ b/fs/f2fs/extent_cache.c
>>> @@ -23,18 +23,26 @@ bool sanity_check_extent_cache(struct inode *inode)
>>>    {
>>>    	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>    	struct f2fs_inode_info *fi = F2FS_I(inode);
>>> +	struct extent_tree *et = fi->extent_tree[EX_READ];
>>>    	struct extent_info *ei;
>>> -	if (!fi->extent_tree[EX_READ])
>>> +	if (!et)
>>> +		return true;
>>> +
>>> +	ei = &et->largest;
>>> +	if (!ei->len)
>>>    		return true;
>>> -	ei = &fi->extent_tree[EX_READ]->largest;
>>> +	/* Let's drop, if checkpoint got corrupted. */
>>> +	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
>>> +		ei->len = 0;
>>> +		et->largest_updated = true;
>>
>> Thsi field indicates whether it is needed to update largest extent into
>> inode page, since cp_error is unrecoverable, it seems we don't needed to
>> update it.
> 
> Intention is to avoid any assumption like that, but sync the same logic when
> updating this.

Sure, fine to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Thanks,
>>
>>> +		return true;
>>> +	}
>>> -	if (ei->len &&
>>> -		(!f2fs_is_valid_blkaddr(sbi, ei->blk,
>>> -					DATA_GENERIC_ENHANCE) ||
>>> -		!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
>>> -					DATA_GENERIC_ENHANCE))) {
>>> +	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
>>> +	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
>>> +					DATA_GENERIC_ENHANCE)) {
>>>    		set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>    		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
>>>    			  __func__, inode->i_ino,
