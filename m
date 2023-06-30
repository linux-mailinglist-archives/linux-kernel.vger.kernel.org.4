Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C363744542
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjF3Xg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjF3XgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBED12683;
        Fri, 30 Jun 2023 16:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70EFF61807;
        Fri, 30 Jun 2023 23:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF1FC433C7;
        Fri, 30 Jun 2023 23:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688168183;
        bh=aK6yYJgscyZwWj5dtSV65RXKY0BEz1UX2yJwu5X1aZ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MoIiIYi0ETQup2yAMpWWZEQCL1KgbttW38aGQd9oj+soN2lWps5H2gS+e10zrOeST
         bTYKG04zuQ/1RY/buL8tObEzyG5DsCX+jwcOIuKgCwJO5MDC2QzCT7OkGEWGJXjUy5
         GfdV59i3bUnftyi704U/xTI9rRpXMwBsrgxNKlws2o2SjCiK9GRp/EV8ZV6bs1gChd
         id2amycXugMhySZcMTI/9KHDXzTEzD9s6OvocDP8wmPuSUnvZa1RukVnsPvAOw2faJ
         YPebe6SIx7l1pbsjb1GBRjhXOAo4r6lGELCl7fHFeCVYXUX9neYzHGixjio2Vfvnp3
         mSGzs+zqKYv0g==
Message-ID: <44777f8c-6f2e-a9bd-6923-b12d0326d3cb@kernel.org>
Date:   Sat, 1 Jul 2023 07:36:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix deadlock in i_xattr_sem and inode
 page lock and fix the original issue
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230613233940.3643362-1-jaegeuk@kernel.org>
 <e5788348-b547-8e10-21af-90544f3aa75c@kernel.org>
 <ZJvqZTX1SIwvDCUn@google.com>
 <e4ee00c4-c20a-4613-87ec-3b144d6252ed@kernel.org>
 <ZJx8/0eOB4PcftQe@google.com> <ZJ9QPLd6LF9dy5bm@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZJ9QPLd6LF9dy5bm@google.com>
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

On 2023/7/1 5:59, Jaegeuk Kim wrote:
> On 06/28, Jaegeuk Kim wrote:
>> On 06/28, Chao Yu wrote:
>>> On 2023/6/28 16:08, Jaegeuk Kim wrote:
>>>> Thread #1:
>>>>
>>>> [122554.641906][   T92]  f2fs_getxattr+0xd4/0x5fc
>>>>       -> waiting for f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
>>>>
>>>> [122554.641927][   T92]  __f2fs_get_acl+0x50/0x284
>>>> [122554.641948][   T92]  f2fs_init_acl+0x84/0x54c
>>>> [122554.641969][   T92]  f2fs_init_inode_metadata+0x460/0x5f0
>>>> [122554.641990][   T92]  f2fs_add_inline_entry+0x11c/0x350
>>>>       -> Locked dir->inode_page by f2fs_get_node_page()
>>>>
>>>> [122554.642009][   T92]  f2fs_do_add_link+0x100/0x1e4
>>>> [122554.642025][   T92]  f2fs_create+0xf4/0x22c
>>>> [122554.642047][   T92]  vfs_create+0x130/0x1f4
>>>>
>>>> Thread #2:
>>>>
>>>> [123996.386358][   T92]  __get_node_page+0x8c/0x504
>>>>       -> waiting for dir->inode_page lock
>>>>
>>>> [123996.386383][   T92]  read_all_xattrs+0x11c/0x1f4
>>>> [123996.386405][   T92]  __f2fs_setxattr+0xcc/0x528
>>>> [123996.386424][   T92]  f2fs_setxattr+0x158/0x1f4
>>>>       -> f2fs_down_write(&F2FS_I(inode)->i_xattr_sem);
>>>>
>>>> [123996.386443][   T92]  __f2fs_set_acl+0x328/0x430
>>>> [123996.386618][   T92]  f2fs_set_acl+0x38/0x50
>>>> [123996.386642][   T92]  posix_acl_chmod+0xc8/0x1c8
>>>> [123996.386669][   T92]  f2fs_setattr+0x5e0/0x6bc
>>>> [123996.386689][   T92]  notify_change+0x4d8/0x580
>>>> [123996.386717][   T92]  chmod_common+0xd8/0x184
>>>> [123996.386748][   T92]  do_fchmodat+0x60/0x124
>>>> [123996.386766][   T92]  __arm64_sys_fchmodat+0x28/0x3c
>>>
>>> Back to the race condition, my question is why we can chmod on inode before
>>> it has been created?
>>
>> This is touching the directory.
> 
> Chao,
> 
> Do you have other concern? Otherwise, I'll include this into the next pull
> request.

Jaegeuk,

Sorry for late reply, I was misled by "dir->inode_page" and "inode" words in commit
message, it should be "dir->inode_page" and "dir_inode".

Anyway, the patch looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> 
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Fixes: 27161f13e3c3 "f2fs: avoid race in between read xattr & write xattr"
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> ---
>>>>    fs/f2fs/dir.c   | 9 ++++++++-
>>>>    fs/f2fs/xattr.c | 6 ++++--
>>>>    2 files changed, 12 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>>>> index 887e55988450..d635c58cf5a3 100644
>>>> --- a/fs/f2fs/dir.c
>>>> +++ b/fs/f2fs/dir.c
>>>> @@ -775,8 +775,15 @@ int f2fs_add_dentry(struct inode *dir, const struct f2fs_filename *fname,
>>>>    {
>>>>    	int err = -EAGAIN;
>>>> -	if (f2fs_has_inline_dentry(dir))
>>>> +	if (f2fs_has_inline_dentry(dir)) {
>>>> +		/*
>>>> +		 * Should get i_xattr_sem to keep the lock order:
>>>> +		 * i_xattr_sem -> inode_page lock used by f2fs_setxattr.
>>>> +		 */
>>>> +		f2fs_down_read(&F2FS_I(dir)->i_xattr_sem);
>>>>    		err = f2fs_add_inline_entry(dir, fname, inode, ino, mode);
>>>> +		f2fs_up_read(&F2FS_I(dir)->i_xattr_sem);
>>>> +	}
>>>>    	if (err == -EAGAIN)
>>>>    		err = f2fs_add_regular_entry(dir, fname, inode, ino, mode);
>>>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>>>> index 213805d3592c..476b186b90a6 100644
>>>> --- a/fs/f2fs/xattr.c
>>>> +++ b/fs/f2fs/xattr.c
>>>> @@ -528,10 +528,12 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>>>>    	if (len > F2FS_NAME_LEN)
>>>>    		return -ERANGE;
>>>> -	f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
>>>> +	if (!ipage)
>>>> +		f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
>>>>    	error = lookup_all_xattrs(inode, ipage, index, len, name,
>>>>    				&entry, &base_addr, &base_size, &is_inline);
>>>> -	f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
>>>> +	if (!ipage)
>>>> +		f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
>>>>    	if (error)
>>>>    		return error;
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
