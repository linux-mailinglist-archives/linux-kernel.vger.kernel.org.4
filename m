Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD15B6819
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiIMGoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiIMGod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:44:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20DB6174
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:44:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F48261325
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F0EC433C1;
        Tue, 13 Sep 2022 06:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663051470;
        bh=0e9xHpDVUmc8i3sNd336+sReKkmZIVLIQ0HMJ/k2lbw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S5aRUfxdIXYuJPeMRwCwwVPHQdoxY1IV8PHIqccGRdOwJL6B2XCOLzW+tV5+ZUNhX
         jaLVJc1Jlm8nvDc7LMLNBptPTB9aWLLZVLVxOPucOlJFKbFgVkMeJH3Pq9Sm9ibYhk
         0wWiHBPlTdZO5XxwSb75tRyEuupHghBGAP9hNfy4NllflSuSAASYI1dfs3NSa4DlE5
         KBydAI+DCRa+XdH7KmTW87CSwVhVRQj+B8t2YPc5aFuXWdtQ35EJFuUmHo7hmvvKbq
         vxqJgcD3PXQjUQN9hTP8CjwsHqDMprGa2hLnaedMnAwlaHLtPyJpkXGGzekjUGhxEB
         JJVdyLyk+UAFA==
Message-ID: <4efaecb4-7179-ae6c-05b6-49a168b3c8bd@kernel.org>
Date:   Tue, 13 Sep 2022 14:44:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] f2fs: fix to disallow getting inner inode via
 f2fs_iget()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220830225358.300027-1-chao@kernel.org>
 <YxlNGeh6Sr4isEFf@google.com>
 <0af788ed-8797-22a2-ae0c-433fdd6a2188@kernel.org>
 <YxlRMRA7AVIusfav@google.com>
 <e5abac5f-433b-62d4-b2fa-974b5f978d61@kernel.org>
 <Yx9SulcDlMfO/hiW@google.com>
 <6c54e0b1-9c75-af90-565b-61174ddb5cbc@kernel.org>
 <YyAbBroLzLPaSyCF@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YyAbBroLzLPaSyCF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/13 13:54, Jaegeuk Kim wrote:
> On 09/13, Chao Yu wrote:
>> On 2022/9/12 23:39, Jaegeuk Kim wrote:
>>> On 09/08, Chao Yu wrote:
>>>> On 2022/9/8 10:19, Jaegeuk Kim wrote:
>>>>> On 09/08, Chao Yu wrote:
>>>>>> On 2022/9/8 10:02, Jaegeuk Kim wrote:
>>>>>>> On 08/31, Chao Yu wrote:
>>>>>>>> From: Chao Yu <chao.yu@oppo.com>
>>>>>>>>
>>>>>>>> Introduce f2fs_iget_inner() for f2fs_fill_super() to get inner inode:
>>>>>>>> meta inode, node inode or compressed inode, and add f2fs_check_nid_range()
>>>>>>>> in f2fs_iget() to avoid getting inner inode from external interfaces.
>>>>>>>
>>>>>>> So, we don't want to check the range of inner inode numbers? What'd be the
>>>>>>> way to check it's okay?
>>>>>>
>>>>>> For node_ino, meta_ino, root_ino, we have checked them in sanity_check_raw_super()
>>>>>> as below:
>>>>>>
>>>>>> 	/* check reserved ino info */
>>>>>> 	if (le32_to_cpu(raw_super->node_ino) != 1 ||
>>>>>> 		le32_to_cpu(raw_super->meta_ino) != 2 ||
>>>>>> 		le32_to_cpu(raw_super->root_ino) != 3) {
>>>>>> 		f2fs_info(sbi, "Invalid Fs Meta Ino: node(%u) meta(%u) root(%u)",
>>>>>> 			  le32_to_cpu(raw_super->node_ino),
>>>>>> 			  le32_to_cpu(raw_super->meta_ino),
>>>>>> 			  le32_to_cpu(raw_super->root_ino));
>>>>>> 		return -EFSCORRUPTED;
>>>>>> 	}
>>>>>>
>>>>>> compressed_ino should always be NM_I(sbi)->max_nid, it can be checked in
>>>>>> f2fs_init_compress_inode()?
>>>>>
>>>>> Hmm, I'm not sure whether we really need this patch, since it'd look better
>>>>> to handle all the iget with single f2fs_iget?
>>>>
>>>> Well, the main concern is previously f2fs_iget() won't check validation for inner
>>>> inode due to it will skip do_read_inode() - f2fs_check_nid_range(), so that in a
>>>> fuzzed image, caller may pass inner ino into f2fs_iget(), result in incorrect use
>>>> of inner inode. So I add f2fs_check_nid_range() in prior to f2fs_iget_inner() in
>>>> f2fs_iget() as below to detect and avoid this case.
>>>
>>> FWIW, sanity_check_raw_super() checked the inode numbers.
>>
>> However, previously, f2fs_iget() will return inner inode to caller directly, if caller
>> passes meta_ino, node_ino or compress_ino to f2fs_iget()?
> 
> Do you want to do sanity check on corrupted dentry? If so, how about checking

Yes, including:

- corrupted ino in dentry
- corrupted ino of orphan inode

As I replied in this thread:

https://lore.kernel.org/lkml/b1c74dc1-8d01-9041-9469-036273c5618d@kernel.org/

> it in f2fs_iget instead?
> 
> 	if (is_meta_ino(ino)) {
> 		if (!(inode->i_state & I_NEW)
> 			return -EFSCORRUPTED;
> 		goto make_now;
> 	}

Fine to me, let me revise in v3.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>>>>>> +struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>>>>>>>> +{
>>>>>>>> +	int ret;
>>>>>>>> +
>>>>>>>> +	ret = f2fs_check_nid_range(F2FS_SB(sb), ino);
>>>>>>>> +	if (ret)
>>>>>>>> +		return ERR_PTR(ret);
>>>>>>>> +
>>>>>>>> +	return f2fs_iget_inner(sb, ino);
