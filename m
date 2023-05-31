Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5C6717A45
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjEaIiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjEaIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:38:04 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD89E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:38:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vjx-bEe_1685522277;
Received: from 30.221.149.27(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vjx-bEe_1685522277)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 16:37:58 +0800
Message-ID: <42ae7d2b-5d2d-bf91-ec2d-265f26a52602@linux.alibaba.com>
Date:   Wed, 31 May 2023 16:37:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/5] erofs: unify xattr_iter structures
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230531031330.3504-1-jefflexu@linux.alibaba.com>
 <20230531031330.3504-3-jefflexu@linux.alibaba.com>
 <577b11e6-75f5-c07d-76c3-bb2f166a601b@linux.alibaba.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <577b11e6-75f5-c07d-76c3-bb2f166a601b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/23 2:53 PM, Gao Xiang wrote:
> 
> 
> On 2023/5/31 11:13, Jingbo Xu wrote:
>> Unify xattr_iter/listxattr_iter/getxattr_iter structures into
>> erofs_xattr_iter structure.
>>
>> This is in preparation for the following further cleanup.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>   fs/erofs/xattr.c | 155 ++++++++++++++++++++---------------------------
>>   1 file changed, 65 insertions(+), 90 deletions(-)
>>
>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>> index df6c4e6f1f4e..dffca38a46fd 100644
>> --- a/fs/erofs/xattr.c
>> +++ b/fs/erofs/xattr.c
>> @@ -20,16 +20,25 @@ static inline unsigned int
>> erofs_xattr_blkoff(struct super_block *sb,
>>       return erofs_blkoff(sb, xattr_id * sizeof(__u32));
>>   }
>>   -struct xattr_iter {
>> +struct erofs_xattr_iter {
>>       struct super_block *sb;
>>       struct erofs_buf buf;
>>       void *kaddr;
>> -
>>       erofs_blk_t blkaddr;
>>       unsigned int ofs;
>> +
>> +    char *buffer;
>> +    int buffer_size, buffer_ofs;
>> +
>> +    /* getxattr */
>> +    int index, infix_len;
>> +    struct qstr name;
>> +
>> +    /* listxattr */
>> +    struct dentry *dentry;
>>   };
>>   -static inline int erofs_xattr_iter_fixup(struct xattr_iter *it,
>> bool nospan)
>> +static inline int erofs_xattr_iter_fixup(struct erofs_xattr_iter *it,
>> bool nospan)
>>   {
>>       if (it->ofs < it->sb->s_blocksize)
>>           return 0;
>> @@ -50,7 +59,7 @@ static inline int erofs_xattr_iter_fixup(struct
>> xattr_iter *it, bool nospan)
>>   static int erofs_init_inode_xattrs(struct inode *inode)
>>   {
>>       struct erofs_inode *const vi = EROFS_I(inode);
>> -    struct xattr_iter it;
>> +    struct erofs_xattr_iter it;
>>       unsigned int i;
>>       struct erofs_xattr_ibody_header *ih;
>>       struct super_block *sb = inode->i_sb;
>> @@ -153,15 +162,15 @@ static int erofs_init_inode_xattrs(struct inode
>> *inode)
>>    *                            and need to be handled
>>    */
>>   struct xattr_iter_handlers {
>> -    int (*entry)(struct xattr_iter *_it, struct erofs_xattr_entry
>> *entry);
>> -    int (*name)(struct xattr_iter *_it, unsigned int processed, char
>> *buf,
>> +    int (*entry)(struct erofs_xattr_iter *it, struct
>> erofs_xattr_entry *entry);
>> +    int (*name)(struct erofs_xattr_iter *it, unsigned int processed,
>> char *buf,
>>               unsigned int len);
>> -    int (*alloc_buffer)(struct xattr_iter *_it, unsigned int value_sz);
>> -    void (*value)(struct xattr_iter *_it, unsigned int processed,
>> char *buf,
>> +    int (*alloc_buffer)(struct erofs_xattr_iter *it, unsigned int
>> value_sz);
>> +    void (*value)(struct erofs_xattr_iter *it, unsigned int
>> processed, char *buf,
>>                 unsigned int len);
>>   };
>>   -static int inline_xattr_iter_begin(struct xattr_iter *it,
>> +static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
>>                      struct inode *inode)
>>   {
>>       struct erofs_inode *const vi = EROFS_I(inode);
>> @@ -189,7 +198,7 @@ static int inline_xattr_iter_begin(struct
>> xattr_iter *it,
>>    * Regardless of success or failure, `xattr_foreach' will end up with
>>    * `ofs' pointing to the next xattr item rather than an arbitrary
>> position.
>>    */
>> -static int xattr_foreach(struct xattr_iter *it,
>> +static int xattr_foreach(struct erofs_xattr_iter *it,
>>                const struct xattr_iter_handlers *op,
>>                unsigned int *tlimit)
>>   {
>> @@ -280,18 +289,10 @@ static int xattr_foreach(struct xattr_iter *it,
>>       return err < 0 ? err : 0;
>>   }
>>   -struct getxattr_iter {
>> -    struct xattr_iter it;
>> -
>> -    char *buffer;
>> -    int buffer_size, index, infix_len;
>> -    struct qstr name;
>> -};
>> -
>> -static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
>> +static int erofs_xattr_long_entrymatch(struct erofs_xattr_iter *it,
>>                          struct erofs_xattr_entry *entry)
>>   {
>> -    struct erofs_sb_info *sbi = EROFS_SB(it->it.sb);
>> +    struct erofs_sb_info *sbi = EROFS_SB(it->sb);
>>       struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
>>           (entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
>>   @@ -309,11 +310,9 @@ static int erofs_xattr_long_entrymatch(struct
>> getxattr_iter *it,
>>       return 0;
>>   }
>>   -static int xattr_entrymatch(struct xattr_iter *_it,
>> +static int xattr_entrymatch(struct erofs_xattr_iter *it,
>>                   struct erofs_xattr_entry *entry)
>>   {
>> -    struct getxattr_iter *it = container_of(_it, struct
>> getxattr_iter, it);
>> -
>>       /* should also match the infix for long name prefixes */
>>       if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
>>           return erofs_xattr_long_entrymatch(it, entry);
>> @@ -325,32 +324,27 @@ static int xattr_entrymatch(struct xattr_iter *_it,
>>       return 0;
>>   }
>>   -static int xattr_namematch(struct xattr_iter *_it,
>> +static int xattr_namematch(struct erofs_xattr_iter *it,
>>                  unsigned int processed, char *buf, unsigned int len)
>>   {
>> -    struct getxattr_iter *it = container_of(_it, struct
>> getxattr_iter, it);
>> -
>>       if (memcmp(buf, it->name.name + it->infix_len + processed, len))
>>           return -ENOATTR;
>>       return 0;
>>   }
>>   -static int xattr_checkbuffer(struct xattr_iter *_it,
>> +static int xattr_checkbuffer(struct erofs_xattr_iter *it,
>>                    unsigned int value_sz)
>>   {
>> -    struct getxattr_iter *it = container_of(_it, struct
>> getxattr_iter, it);
>>       int err = it->buffer_size < value_sz ? -ERANGE : 0;
>>         it->buffer_size = value_sz;
>>       return !it->buffer ? 1 : err;
>>   }
>>   -static void xattr_copyvalue(struct xattr_iter *_it,
>> +static void xattr_copyvalue(struct erofs_xattr_iter *it,
>>                   unsigned int processed,
>>                   char *buf, unsigned int len)
>>   {
>> -    struct getxattr_iter *it = container_of(_it, struct
>> getxattr_iter, it);
>> -
>>       memcpy(it->buffer + processed, buf, len);
>>   }
>>   @@ -361,41 +355,40 @@ static const struct xattr_iter_handlers
>> find_xattr_handlers = {
>>       .value = xattr_copyvalue
>>   };
>>   -static int inline_getxattr(struct inode *inode, struct
>> getxattr_iter *it)
>> +static int inline_getxattr(struct inode *inode, struct
>> erofs_xattr_iter *it)
>>   {
>>       int ret;
>>       unsigned int remaining;
>>   -    ret = inline_xattr_iter_begin(&it->it, inode);
>> +    ret = inline_xattr_iter_begin(it, inode);
>>       if (ret < 0)
>>           return ret;
>>         remaining = ret;
>>       while (remaining) {
>> -        ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
>> +        ret = xattr_foreach(it, &find_xattr_handlers, &remaining);
>>           if (ret != -ENOATTR)
>>               break;
>>       }
>>       return ret ? ret : it->buffer_size;
>>   }
>>   -static int shared_getxattr(struct inode *inode, struct
>> getxattr_iter *it)
>> +static int shared_getxattr(struct inode *inode, struct
>> erofs_xattr_iter *it)
>>   {
>>       struct erofs_inode *const vi = EROFS_I(inode);
>> -    struct super_block *const sb = it->it.sb;
>> +    struct super_block *const sb = it->sb;
>>       unsigned int i, xsid;
>>       int ret = -ENOATTR;
>>         for (i = 0; i < vi->xattr_shared_count; ++i) {
>>           xsid = vi->xattr_shared_xattrs[i];
>> -        it->it.blkaddr = erofs_xattr_blkaddr(sb, xsid);
>> -        it->it.ofs = erofs_xattr_blkoff(sb, xsid);
>> -        it->it.kaddr = erofs_read_metabuf(&it->it.buf, sb,
>> -                          it->it.blkaddr, EROFS_KMAP);
>> -        if (IS_ERR(it->it.kaddr))
>> -            return PTR_ERR(it->it.kaddr);
>> -
>> -        ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
>> +        it->blkaddr = erofs_xattr_blkaddr(sb, xsid);
>> +        it->ofs = erofs_xattr_blkoff(sb, xsid);
>> +        it->kaddr = erofs_read_metabuf(&it->buf, sb, it->blkaddr,
>> EROFS_KMAP);
> 
> could we use erofs_bread() here?

Okay I will make all the conversions to erofs_bread() a separate patch.



-- 
Thanks,
Jingbo
