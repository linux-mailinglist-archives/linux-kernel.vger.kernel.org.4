Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3803E7091D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjESIla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjESIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6AE5A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684485639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egBPRHVpdHSfd20nm0e9mbT5sU7zP2+9zHGLlUwPTiM=;
        b=Y77Oh3f7BbqcfJAya9qhO8BC23iyJEZx3HziCeSQzEQQ599j2qfpmgfm7k+H1sGowKMamg
        RhjRf+yEOfGQLldxYGJqMxWAiDakcFBZkknCfFWlqTqdSidTIxHuS6So5ljtjYRQTJp4rL
        005bhweGkCVLmz1VxYS0ZpsndKRkmpc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Xy109IeYPI21oHsHQJUJ_A-1; Fri, 19 May 2023 04:40:38 -0400
X-MC-Unique: Xy109IeYPI21oHsHQJUJ_A-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-64d1cdf9fa0so1127023b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684485636; x=1687077636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egBPRHVpdHSfd20nm0e9mbT5sU7zP2+9zHGLlUwPTiM=;
        b=COz+uQObb89FMXX/3BsG7haBBuKqkv71InZ3zWT6TUqK0EDPNoJ8NeAvfU8husVx8y
         0NbR5ZJMs0fsH0sEIzDnCQkz2bPbF+RxIXZdXrZSA+sfmb5y1eMzmTGKy7W2ZpES2SJs
         wmLyVtRQaz72LkYt+hGOAleYHW9pP9Es3GkBJD9k7yhyDtcNAeo/41KR2AWIGSrJAfRn
         80GI2tRAng+ugiHuyyOz0ctSvwz9H8Z7gu8FZ1XcZi/6Ks1LB7BhDJ8NjoBCjazh5I5b
         s5UyIGMgRlzs2li5hUVP03zR5tILCnIHj3ZkhlTHK/m4Z0om38vUq4fHmoNziKqCbH7L
         I3wg==
X-Gm-Message-State: AC+VfDxB6ExfdO+yTX4ZbXyCORAj3dfhQAdbovyXBG/swvuncStjEdNV
        lfHVG2DjIfLEKoceIU+qSf+Qv9KoJpFi6/PRpIwOrYlfhA42dHm82FeZm7X35fL4ltNe6ADCJ96
        RYrwwIL0LR/HPlU4dvCJ1zfCEowBgf1eP9VE=
X-Received: by 2002:a05:6a20:12ce:b0:103:4188:5dc6 with SMTP id v14-20020a056a2012ce00b0010341885dc6mr1404873pzg.61.1684485636692;
        Fri, 19 May 2023 01:40:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qifzK49CJEVh43BJzHJgxewYSM92TBkBZCMgJvFD6rw1sXkY73qala5W0RRLrYfUw1jrMRQ==
X-Received: by 2002:a05:6a20:12ce:b0:103:4188:5dc6 with SMTP id v14-20020a056a2012ce00b0010341885dc6mr1404860pzg.61.1684485636344;
        Fri, 19 May 2023 01:40:36 -0700 (PDT)
Received: from [10.72.12.98] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78e18000000b00622e01989cbsm2609668pfr.176.2023.05.19.01.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 01:40:36 -0700 (PDT)
Message-ID: <c1fd63b9-42ea-fa83-ecb1-9af715e37ffa@redhat.com>
Date:   Fri, 19 May 2023 16:40:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v20 13/32] ceph: Provide a splice-read stub
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-14-dhowells@redhat.com>
Content-Language: en-US
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20230519074047.1739879-14-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/23 15:40, David Howells wrote:
> Provide a splice_read stub for Ceph.  This does the inode shutdown check
> before proceeding and jumps to direct_splice_read() if O_DIRECT is set, the
> file has inline data or is a synchronous file.
>
> We try and get FILE_RD and either FILE_CACHE and/or FILE_LAZYIO caps and
> hold them across filemap_splice_read().  If we fail to get FILE_CACHE or
> FILE_LAZYIO capabilities, we use direct_splice_read() instead.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Xiubo Li <xiubli@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: ceph-devel@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>   fs/ceph/file.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index f4d8bf7dec88..382dd5901748 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1745,6 +1745,70 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   	return ret;
>   }
>   
> +/*
> + * Wrap filemap_splice_read with checks for cap bits on the inode.
> + * Atomically grab references, so that those bits are not released
> + * back to the MDS mid-read.
> + */
> +static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
> +				struct pipe_inode_info *pipe,
> +				size_t len, unsigned int flags)
> +{
> +	struct ceph_file_info *fi = in->private_data;
> +	struct inode *inode = file_inode(in);
> +	struct ceph_inode_info *ci = ceph_inode(inode);
> +	ssize_t ret;
> +	int want = 0, got = 0;
> +	CEPH_DEFINE_RW_CONTEXT(rw_ctx, 0);
> +
> +	dout("splice_read %p %llx.%llx %llu~%zu trying to get caps on %p\n",
> +	     inode, ceph_vinop(inode), *ppos, len, inode);
> +
> +	if (ceph_inode_is_shutdown(inode))
> +		return -ESTALE;
> +
> +	if ((in->f_flags & O_DIRECT) ||
> +	    ceph_has_inline_data(ci) ||
> +	    (fi->flags & CEPH_F_SYNC))
> +		return direct_splice_read(in, ppos, pipe, len, flags);
> +
> +	ceph_start_io_read(inode);
> +
> +	want = CEPH_CAP_FILE_CACHE;
> +	if (fi->fmode & CEPH_FILE_MODE_LAZY)
> +		want |= CEPH_CAP_FILE_LAZYIO;
> +
> +	ret = ceph_get_caps(in, CEPH_CAP_FILE_RD, want, -1, &got);
> +	if (ret < 0) {
> +		ceph_end_io_read(inode);
> +		return ret;
> +	}
> +
> +	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) == 0) {
> +		dout("splice_read/sync %p %llx.%llx %llu~%zu got cap refs on %s\n",
> +		     inode, ceph_vinop(inode), *ppos, len,
> +		     ceph_cap_string(got));
> +
> +		ceph_end_io_read(inode);
> +		return direct_splice_read(in, ppos, pipe, len, flags);

Shouldn't we release cap ref before returning here ?

Thanks

- Xiubo


> +	}
> +
> +	dout("splice_read %p %llx.%llx %llu~%zu got cap refs on %s\n",
> +	     inode, ceph_vinop(inode), *ppos, len, ceph_cap_string(got));
> +
> +	rw_ctx.caps = got;
> +	ceph_add_rw_context(fi, &rw_ctx);
> +	ret = filemap_splice_read(in, ppos, pipe, len, flags);
> +	ceph_del_rw_context(fi, &rw_ctx);
> +
> +	dout("splice_read %p %llx.%llx dropping cap refs on %s = %zd\n",
> +	     inode, ceph_vinop(inode), ceph_cap_string(got), ret);
> +	ceph_put_cap_refs(ci, got);
> +
> +	ceph_end_io_read(inode);
> +	return ret;
> +}
> +
>   /*
>    * Take cap references to avoid releasing caps to MDS mid-write.
>    *
> @@ -2593,7 +2657,7 @@ const struct file_operations ceph_file_fops = {
>   	.lock = ceph_lock,
>   	.setlease = simple_nosetlease,
>   	.flock = ceph_flock,
> -	.splice_read = generic_file_splice_read,
> +	.splice_read = ceph_splice_read,
>   	.splice_write = iter_file_splice_write,
>   	.unlocked_ioctl = ceph_ioctl,
>   	.compat_ioctl = compat_ptr_ioctl,
>

