Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E111B62D589
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiKQIw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbiKQIwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:52:43 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B048C6829F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:52:41 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 6so1400175pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u5ZdxqLv7HQK8nNoE6HlHV0fkVi/45Uuow/P2MWmtkU=;
        b=GA0th6H11AE4Gyblch3W3Oi6D5GxbxQNCi6AUntl5IjE0xb/EOYYyC19tmK4OoAnEA
         9RUt2JnkVW3qjVjlHFwRBHwwS7zsNNFAbgcoAu1ayPZl6qvTG2LayGqcu/sSWBsBox6E
         Xv6RzNZMXeihMUTKjMwaqyyeA0S7iTCpaQyAqaz3gDS6hiI/GihS/VfVhLFDsjQodkFm
         EWb4Ikk40HtbbResvvhQfe6CdlMlsiKGTej/DEPl+yUP/HOdpP04g4AtvY3qlCzKCwrW
         DSTphIC1/xHyIR44zcquSVUelaH/Z9QubvLxg/GTF4zDcpbOyB/sFJjsQF++EUwbIUyw
         YuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5ZdxqLv7HQK8nNoE6HlHV0fkVi/45Uuow/P2MWmtkU=;
        b=ssk/Gvjp00tzImnnclyW0TKjGorHqAPhjc7QcM7CLr0NSBLD43scCz5xrmK71lDH9C
         hymBPk0YCKCFAcaL9g5BP/7mEr48Gkk5iN0gzlue7vyKEX150HJdThbVPBnzhredRSU8
         Sxb5+L0F3XX2FUvCxH4xPDlYkWVCEak0bBT14N0wkNWQrtyBxecY7oQKsZPx8p7EG6Uc
         m2pSOC9hNj8P2bphpsx3EqKuNU4+lURfLZeTlEfMEZjgTHnLr+Y31TtoOJUnZFvXj3Tt
         uZlXPStTxZV37VcMVi8fo9gSeKRPmEUmcj+ICUt1Zcq3bCSjgAAW7UbyyB7lXMDojBDU
         1sgQ==
X-Gm-Message-State: ANoB5pkzLoOOsPNbIjy+tNVgbxVp3JQhRAuTkfw3V/b8PLmw9SyHp8zz
        0ru+05nOPEWbIwk7EBIDOGDSRP2CW/t50+J/5MwKJrUMx9KriQ==
X-Google-Smtp-Source: AA0mqf74taM60VucLO6UhRVokRC/lFgJCX0Gz5ze6KBcBSOOkaQGYYOhvbR1eFaXvfVN1GQa1S7Typhiyk8WNpmV1Ek=
X-Received: by 2002:a05:6a00:c5:b0:56b:a4f6:e030 with SMTP id
 e5-20020a056a0000c500b0056ba4f6e030mr1977961pfj.85.1668675161134; Thu, 17 Nov
 2022 00:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20221111093702.80975-1-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20221111093702.80975-1-zhangjiachen.jaycee@bytedance.com>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Date:   Thu, 17 Nov 2022 16:52:29 +0800
Message-ID: <CAFQAk7isS3AgkU_nMum8=iqy8NgLdGN5USq4gk_TE8SUzRr4tQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: initialize attr_version of new fuse inodes by fc->attr_version
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 5:37 PM Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> The FUSE_READDIRPLUS request reply handler fuse_direntplus_link() might
> call fuse_iget() to initialize a new fuse_inode and change its attributes.
> But as the new fi->attr_version is always initialized with 0, even if the
> attr_version of the FUSE_READDIRPLUS request has become staled, staled attr
> may still be set to the new fuse_inode. This may cause file size
> inconsistency even when a filesystem backend is mounted with a single FUSE
> mountpoint.
>
> This commit fixes the issue by initializing new fuse_inode attr_versions by
> the global fc->attr_version. This may introduce more FUSE_GETATTR but can
> avoid weird attributes rollback being seen by users.
>
> Fixes: 19332138887c ("fuse: initialize attr_version of new fuse inodes by fc->attr_version")

Ping..., and the Fixes tag should be:

Fixes: fbee36b92abc ("fuse: fix uninitialized field in fuse_inode")

Best regards,
Jiachen

> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  fs/fuse/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 6b3beda16c1b..145ded6b55af 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -71,6 +71,7 @@ struct fuse_forget_link *fuse_alloc_forget(void)
>  static struct inode *fuse_alloc_inode(struct super_block *sb)
>  {
>         struct fuse_inode *fi;
> +       struct fuse_conn *fc = get_fuse_conn_super(sb);
>
>         fi = alloc_inode_sb(sb, fuse_inode_cachep, GFP_KERNEL);
>         if (!fi)
> @@ -80,7 +81,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
>         fi->inval_mask = 0;
>         fi->nodeid = 0;
>         fi->nlookup = 0;
> -       fi->attr_version = 0;
> +       fi->attr_version = fuse_get_attr_version(fc);
>         fi->orig_ino = 0;
>         fi->state = 0;
>         mutex_init(&fi->mutex);
> --
> 2.20.1
>
