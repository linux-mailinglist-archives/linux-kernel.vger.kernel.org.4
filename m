Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1E6B5895
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCKFTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCKFSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:18:31 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5B1408A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1678511826; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=MAJxP/Y7VUsT1dmXNCicZJV93o5qJ8SDgA9HaeF2w7v9KKUMMdg/i+PQZQm1Q7L9GGTGRuBw2nk/NVFwWEuIAnBawoQNuUf6zXs+UeQlqew3SwY+25X8sJi8qFBJVLoEXg5wO4cOWgDmSIhOpDcyMnDd2pt/We22PaQPp4OVBnc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1678511826; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=654fJPoPkkA2Ofkz6DC3Gzmc98pclBqXOnVUTQHbzA0=; 
        b=GJFfUXgpRMqjveAbQW/lz0dr4Mi0CXy80LMyCXE7axJL3mmgtXGJik72b35VIQHOsZeAggF4rW9f6nUtXZg22GkyDZQxNz+7yqu+HnreM0wJOXLBwDaM+qlZ3mTN8L4ITz/8KNCFdG3ajiy6oPgMgos86znhG577qgQ+17/MZ0E=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1678511826;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=654fJPoPkkA2Ofkz6DC3Gzmc98pclBqXOnVUTQHbzA0=;
        b=UUpxXdenkeKVtU8SYlGtn2SWUiFlo1ccTlbh5Kz61WbptrGqZy3S2WQTO1qxP1ij
        kwvlLTLm4W8FIqwy+/ZeQQOhXKgJUzPmv9e+PX2YzzRrkUfZ+g4Y7ll+ohWs7MUaCNM
        p9s1udkWTMfCFlxEqsUON/hPjCqk8i4+JNzZ0CRU=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1678511814182525.992911523984; Sat, 11 Mar 2023 10:46:54 +0530 (IST)
Date:   Sat, 11 Mar 2023 10:46:54 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Ivan Orlov" <ivan.orlov0322@gmail.com>
Cc:     "ericvh" <ericvh@gmail.com>, "lucho" <lucho@ionkov.net>,
        "asmadeus" <asmadeus@codewreck.org>,
        "linux_oss" <linux_oss@crudebyte.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+cb1d16facb3cc90de5fb" 
        <syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com>,
        "v9fs-developer" <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <186cf19b619.4777c80c154603.5258165448157616593@siddh.me>
In-Reply-To: <20230310202619.433269-1-ivan.orlov0322@gmail.com>
References: <20230310202619.433269-1-ivan.orlov0322@gmail.com>
Subject: Re: [PATCH] 9P FS: Fix wild-memory-access write in v9fs_get_acl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 01:56:19 +0530, Ivan Orlov wrote:
> KASAN reported the following issue:
> [...]
> 
> Calling '__v9fs_get_acl' method in 'v9fs_get_acl' creates the
> following chain of function calls:
> 
> __v9fs_get_acl
>       v9fs_fid_get_acl
>               v9fs_fid_xattr_get
>                       p9_client_xattrwalk
> 
> Function p9_client_xattrwalk accepts a pointer to u64-typed
> variable attr_size and puts some u64 value into it. However,
> after the executing the p9_client_xattrwalk, in some circumstances
> we assign the value of u64-typed variable 'attr_size' to the
> variable 'retval', which we will return. However, the type of
> 'retval' is ssize_t, and if the value of attr_size is larger
> than SSIZE_MAX, we will face the signed type overflow. If the
> overflow occurs, the result of v9fs_fid_xattr_get may be
> negative, but not classified as an error. When we try to allocate
> an acl with 'broken' size we receive an error, but don't process
> it. When we try to free this acl, we face the 'wild-memory-access'
> error (because it wasn't allocated).
> 
> This patch will modify the condition in the 'v9fs_fid_xattr_get'
> function, so it will return an error if the 'attr_size' is larger
> than SSIZE_MAX.
> 
> Reported-by: syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=fbbef66d9e4d096242f3617de5d14d12705b4659
> Signed-off-by: Ivan Orlov ivan.orlov0322@gmail.com>

You should also test with Syzkaller if it gave a reproducer.
Check the following docs to know about it:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

> ---
>  fs/9p/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index 50f7f3f6b55e..d6f7450107a8 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -35,7 +35,7 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
>  		return retval;
>  	}
>  	if (attr_size > buffer_size) {
> -		if (!buffer_size) /* request to get the attr_size */
> +		if (!buffer_size && attr_size <= (u64) SSIZE_MAX) /* request to get the attr_size */
>  			retval = attr_size;
>  		else
>  			retval = -ERANGE;

You should use EOVERFLOW for overflow error. Make a new conditional
instead of using AND. Also, the explicit u64 cast for SSIZE_MAX can
be dropped for better readability.

Thanks,
Siddh

> -- 
> 2.34.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
