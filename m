Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB8695610
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBNBq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjBNBq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:46:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D14219F2E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:46:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECFA6B819C8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253CBC4339B;
        Tue, 14 Feb 2023 01:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676339213;
        bh=+0BJys0OpkHX3oV/BPdHXI+zldnOERXmDqR0P9RpspE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dBHUmqKkkQYUMGwN2daTFvHHXIf0WEA/iUz8y2sfkXN+O7WxIT6UjFwCFAuZeXKus
         ArNFD1M10ZtrGJ5bZD7a2rzWPtJ5EoqV85m+I0G44h1tU6FfKUlbs15be7oWhawOOu
         qy1Mgk9Sb4ztJjLsGbYPGjw4yOcoCmBKK/eFlDiaUrjd7XvRE26JGZxo8ZJKuLLyMv
         OgPIscKmxUrD5jPeEibLDqFFQXGw/EMVZFikHOKcC+4awXtQaAtsjJDAxTSrouqMDR
         6awrjgPzt8PN4Cq/xQLo0W068pjFp8VePeGmHdIstf/M6XTiJP+a8zcxY8IqzQ3QM9
         O3XKveaBoWWoQ==
Message-ID: <6160a9a2-16b9-e37c-eabc-57f71a1932af@kernel.org>
Date:   Tue, 14 Feb 2023 09:46:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [f2fs-dev] [PATCH] f2fs: synchronize atomic write aborts
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
References: <20230209181819.2333522-1-daeho43@gmail.com>
 <18916dd5-67cc-fe21-f78b-8a6dfbcb1c97@kernel.org>
 <CACOAw_w5Mc3aqS_RD_W7MdLGFQV3O_Jq1WSAVKAxJkEk5uUgeQ@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_w5Mc3aqS_RD_W7MdLGFQV3O_Jq1WSAVKAxJkEk5uUgeQ@mail.gmail.com>
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

On 2023/2/14 4:14, Daeho Jeong wrote:
>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>> index 28c9c72dda2a..7bf660d4cad9 100644
>>> --- a/fs/f2fs/inode.c
>>> +++ b/fs/f2fs/inode.c
>>> @@ -777,11 +777,18 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>>>    void f2fs_evict_inode(struct inode *inode)
>>>    {
>>>        struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>> -     nid_t xnid = F2FS_I(inode)->i_xattr_nid;
>>> +     struct f2fs_inode_info *fi = F2FS_I(inode);
>>> +     nid_t xnid = fi->i_xattr_nid;
>>>        int err = 0;
>>>
>>>        f2fs_abort_atomic_write(inode, true);
>>>
>>> +     if (fi->cow_inode) {
>>> +             clear_inode_flag(fi->cow_inode, FI_COW_FILE);
>>> +             iput(fi->cow_inode);
>>> +             fi->cow_inode = NULL;
>>> +     }
>>
>> It looks "fi->cow_inode = NULL" here may race w/ cow_inode allocation in
>> f2fs_ioc_start_atomic_write due to f2fs_write_inode() has not been covered
>> by inode_lock()? IIUC.
> 
> Sorry, I couldn't understand it, since I couldn't find any relation
> between f2fs_ioc_start_atomic_write and f2fs_write_inode. Could you
> elaborate more on this? I thought the code might be safe, since it
> happens in the inode eviction phase.

int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
void f2fs_evict_inode(struct inode *inode)

Oops, it looks I was misled by f2fs_write_inode() above f2fs_evict_inode(),
please ignore my comments, sorry. :(

Thanks,
