Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2A573B9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjFWORi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFWORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:17:36 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5215810D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:17:35 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5700e993f37so28044107b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687529854; x=1690121854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hhPkJzJTd1tk8nJo88vfLnrAVm4JBHHpgdE5qdxJHA=;
        b=LNozVzhCbSjgK8QTuH49h55WiUJoCjZy0D33+zUE9dDF7wc7ieiv0SmLbJTUcs6Xa7
         LAkGvoxSgTddrvTVKN4V40ovLXTmYMdlzvIIo8tZp0GX998dZ7IBzFeDc2wB9LM7iA5V
         p39rRnK/x3F8WL0G+48PQH7QLEdKoqR6bqk39KBcoYVPfyLUaKnfEs9P6XIlg3h2uLNf
         Ur+ikyWH4mXuQgaP+6rs5yYNf4bwmqzm9XRIp4FYfjS76VCYkcA8jQnZOHD+LZ+wZTfd
         D/dgbRZerAIBW5Tp7ufy9Pni3Gq7V7NRgdOAon0dch4lG2ZnzOKaMkFcfO/krp5+co5f
         xyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529854; x=1690121854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hhPkJzJTd1tk8nJo88vfLnrAVm4JBHHpgdE5qdxJHA=;
        b=FESkzlHqsE0RtE1Y9QlMY7d9V/ZxGhMB0B4jdeFQJAPMh7fgfX7p1gtQHt/MBlCzD0
         LFxwda39We/ab66/LFnawLnPHvuslgfKaiISy0hVzvfb4FCYywvf8k0MMYPbaYLB5GOA
         fLKBC93E7Aj8uSGb/6jy+ivUjJ16G3eR4n48eiXSVRyT/7AxGS4Es61HB7EkUcQoGN9C
         0LUznrdD67rVMmYQ4wrdU1k2esUI1vGaguMRVhPDizTAHfZmvWq4DIvLnxfyUn973Anr
         3Q/dBYgfdpA2R106dZ+YH5J83tuWrPcDVMyMuiV3+jIt1u+QWFYv7vTipT7s6H2MbVF+
         AgCA==
X-Gm-Message-State: AC+VfDyjmIixbUBHhEONnnZynpZroPZObIkGu1pmvDfsxrs+2dER0Z0r
        LLLLUXwr6ed5wfhh3Si/gL9Nsu1zSx+4UBcTU+et
X-Google-Smtp-Source: ACHHUZ6ZbJpKQzkZkI3KtRTLbfkDnIPkJqOK8+fHrsLk/UY4YrqCF84sgVtX5DewxoKzKKdFtizpnaI1EEDOAtOEC1Y=
X-Received: by 2002:a81:a08f:0:b0:56c:f0c7:7d72 with SMTP id
 x137-20020a81a08f000000b0056cf0c77d72mr26595008ywg.4.1687529854506; Fri, 23
 Jun 2023 07:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230621144507.55591-1-jlayton@kernel.org> <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-77-jlayton@kernel.org>
In-Reply-To: <20230621144735.55953-77-jlayton@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Jun 2023 10:17:23 -0400
Message-ID: <CAHC9VhRC-aj2P0oLJX-dX49A4Z-En=v=9=brUqCC0tEgiSbZ9A@mail.gmail.com>
Subject: Re: [PATCH 78/79] selinux: switch to new ctime accessors
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:49=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index bad1f6b685fd..d3908baddb30 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1197,7 +1197,7 @@ static struct inode *sel_make_inode(struct super_bl=
ock *sb, int mode)
>
>         if (ret) {
>                 ret->i_mode =3D mode;
> -               ret->i_atime =3D ret->i_mtime =3D ret->i_ctime =3D curren=
t_time(ret);
> +               ret->i_atime =3D ret->i_mtime =3D inode_ctime_set_current=
(ret);

Same issue as in 77/79.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
