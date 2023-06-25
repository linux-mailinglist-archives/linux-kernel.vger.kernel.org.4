Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34D473D017
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjFYK1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFYK1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C08E47;
        Sun, 25 Jun 2023 03:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AE8160B87;
        Sun, 25 Jun 2023 10:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864A2C433C0;
        Sun, 25 Jun 2023 10:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687688863;
        bh=zNDv0rJ1JFrpa40hA5kU8PjgiXyqQg1Bdpc7cE33+ac=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=doyFu9VMBsbOGEH7Fb1qBuAtd0cB/uvUYFk3t/YR2/CfMA74Cbx6/kJVbnJvo4i5c
         +SfTGigasBvSHbiR8jOfxKcc6UqzpOuuVTxB8qcx7acUqbmDkVSbQWwTnlQUoXtO6/
         VMgT7aiK6sKBevHZWT7g3eAgLa8iOwR1aXN1eV1MpxIVv10VtJiw1rZnaRu1Xmug2m
         WP6HQZU59MNf0feR96Pe3gE6BzTFap1NjkG+Wh/nPOvrkJy5Jk1qenE6F4sA0851d7
         3+L9qaCV65ILKrhWRvliAPmzqFgsdaigcTHitlgvjlBEmo5aXGSU76jnQEYfCm0cyi
         MzkF0r4OMXvAQ==
Message-ID: <d0ec4a04-ab81-7e71-ad56-5b22e1815919@kernel.org>
Date:   Sun, 25 Jun 2023 18:27:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove i_xattr_sem to avoid deadlock and
 fix the original issue
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stable@vger.kernel.org
References: <20230613233940.3643362-1-jaegeuk@kernel.org>
 <e5788348-b547-8e10-21af-90544f3aa75c@kernel.org>
In-Reply-To: <e5788348-b547-8e10-21af-90544f3aa75c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/25 15:26, Chao Yu wrote:
> One concern below:
> 
> Thread A:                    Thread B:
> - f2fs_getxattr
>   - lookup_all_xattrs
>    - read_inline_xattr
>     - f2fs_get_node_page(ino)
>     - memcpy inline xattr
>     - f2fs_put_page
>                          - f2fs_setxattr
>                           - __f2fs_setxattr
>                            - __f2fs_setxattr
>                             - write_all_xattrs
>                              - write xnode and inode
>    ---> inline xattr may out of update here.
>    - read_xattr_block
>     - f2fs_get_node_page(xnid)
>     - memcpy xnode xattr
>     - f2fs_put_page
> 
> Do we need to keep xattr_{get,set} being atomical operation?

It seems xfstest starts to complain w/ below message...

[ 3400.856443] F2FS-fs (vdc): inode (2187) has invalid last xattr entry, entry_size: 21468
[ 3400.864042] F2FS-fs (vdc): inode (1595) has invalid last xattr entry, entry_size: 26580
[ 3400.865764] F2FS-fs (vdc): inode (2187) has invalid last xattr entry, entry_size: 21468
[ 3400.880067] F2FS-fs (vdc): inode (9839) has corrupted xattr
[ 3400.880714] F2FS-fs (vdc): inode (10855) has corrupted xattr

Thanks,

> 
> Thanks,
> 
>>
>> I think we don't need to truncate xattr pages eagerly which introduces lots of
>> data races without big benefits.
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>   fs/f2fs/f2fs.h  |  1 -
>>   fs/f2fs/super.c |  1 -
>>   fs/f2fs/xattr.c | 31 ++++++++-----------------------
>>   3 files changed, 8 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 3f5b161dd743..7b9af2d51656 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -838,7 +838,6 @@ struct f2fs_inode_info {
>>       /* avoid racing between foreground op and gc */
>>       struct f2fs_rwsem i_gc_rwsem[2];
>> -    struct f2fs_rwsem i_xattr_sem; /* avoid racing between reading and changing EAs */
>>       int i_extra_isize;        /* size of extra space located in i_addr */
>>       kprojid_t i_projid;        /* id for project quota */
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 1b2c788ed80d..c917fa771f0e 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1418,7 +1418,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>>       INIT_LIST_HEAD(&fi->gdirty_list);
>>       init_f2fs_rwsem(&fi->i_gc_rwsem[READ]);
>>       init_f2fs_rwsem(&fi->i_gc_rwsem[WRITE]);
>> -    init_f2fs_rwsem(&fi->i_xattr_sem);
>>       /* Will be used by directory only */
>>       fi->i_dir_level = F2FS_SB(sb)->dir_level;
>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>> index 213805d3592c..bdc8a55085a2 100644
>> --- a/fs/f2fs/xattr.c
>> +++ b/fs/f2fs/xattr.c
>> @@ -433,7 +433,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>>   {
>>       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>       size_t inline_size = inline_xattr_size(inode);
>> -    struct page *in_page = NULL;
>> +    struct page *in_page = ipage;
>>       void *xattr_addr;
>>       void *inline_addr = NULL;
>>       struct page *xpage;
>> @@ -446,29 +446,19 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>>       /* write to inline xattr */
>>       if (inline_size) {
>> -        if (ipage) {
>> -            inline_addr = inline_xattr_addr(inode, ipage);
>> -        } else {
>> +        if (!in_page) {
>>               in_page = f2fs_get_node_page(sbi, inode->i_ino);
>>               if (IS_ERR(in_page)) {
>>                   f2fs_alloc_nid_failed(sbi, new_nid);
>>                   return PTR_ERR(in_page);
>>               }
>> -            inline_addr = inline_xattr_addr(inode, in_page);
>>           }
>> +        inline_addr = inline_xattr_addr(inode, in_page);
>> -        f2fs_wait_on_page_writeback(ipage ? ipage : in_page,
>> -                            NODE, true, true);
>> -        /* no need to use xattr node block */
>> +        f2fs_wait_on_page_writeback(in_page, NODE, true, true);
>>           if (hsize <= inline_size) {
>> -            err = f2fs_truncate_xattr_node(inode);
>> -            f2fs_alloc_nid_failed(sbi, new_nid);
>> -            if (err) {
>> -                f2fs_put_page(in_page, 1);
>> -                return err;
>> -            }
>>               memcpy(inline_addr, txattr_addr, inline_size);
>> -            set_page_dirty(ipage ? ipage : in_page);
>> +            set_page_dirty(in_page);
>>               goto in_page_out;
>>           }
>>       }
>> @@ -502,12 +492,13 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>>       memcpy(xattr_addr, txattr_addr + inline_size, VALID_XATTR_BLOCK_SIZE);
>>       if (inline_size)
>> -        set_page_dirty(ipage ? ipage : in_page);
>> +        set_page_dirty(in_page);
>>       set_page_dirty(xpage);
>>       f2fs_put_page(xpage, 1);
>>   in_page_out:
>> -    f2fs_put_page(in_page, 1);
>> +    if (in_page != ipage)
>> +        f2fs_put_page(in_page, 1);
>>       return err;
>>   }
>> @@ -528,10 +519,8 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>>       if (len > F2FS_NAME_LEN)
>>           return -ERANGE;
>> -    f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
>>       error = lookup_all_xattrs(inode, ipage, index, len, name,
>>                   &entry, &base_addr, &base_size, &is_inline);
>> -    f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
>>       if (error)
>>           return error;
>> @@ -565,9 +554,7 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>>       int error;
>>       size_t rest = buffer_size;
>> -    f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
>>       error = read_all_xattrs(inode, NULL, &base_addr);
>> -    f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
>>       if (error)
>>           return error;
>> @@ -794,9 +781,7 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
>>       f2fs_balance_fs(sbi, true);
>>       f2fs_lock_op(sbi);
>> -    f2fs_down_write(&F2FS_I(inode)->i_xattr_sem);
>>       err = __f2fs_setxattr(inode, index, name, value, size, ipage, flags);
>> -    f2fs_up_write(&F2FS_I(inode)->i_xattr_sem);
>>       f2fs_unlock_op(sbi);
>>       f2fs_update_time(sbi, REQ_TIME);
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
