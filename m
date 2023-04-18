Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94F6E64FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjDRMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjDRMxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D30314F40
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681822280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FQ5WvFSlNP/FSMCJFsRwFCN1W/qvxRj1T4AlLX107I=;
        b=i+GCli/ZYmZukfjQ+E/yZlXn7ABKIOQ+/8Mu09Y6CXeJclpIS8hrmltFsNhx98Gos1yspV
        PQ1NC5pzhW06rGEZA2kE3dHzG0EFayUiEvpgGPR7iqThEF2K54z3Zzc8Tx4UDgM9cW7oSb
        hAydF6k4IjyEW6qfYsFPmwG2uZFt3mk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-_CuVpI_kOJ-ieY9ZFlIfxQ-1; Tue, 18 Apr 2023 08:51:19 -0400
X-MC-Unique: _CuVpI_kOJ-ieY9ZFlIfxQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1a52e73af00so15696905ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681822278; x=1684414278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FQ5WvFSlNP/FSMCJFsRwFCN1W/qvxRj1T4AlLX107I=;
        b=EqW4HOAqdOWayGCd3dc3fuyD/NrePBC+NJpXGUT7bnqQd3dGMFkWSucpPyDm0l0CLi
         lkBRHrDq5lFP9UFVlTTf6xQCiYo6SkPg4E9U+B4TMPG/SfHSZ35DorEmkA/4mhIvS7gK
         TM4c73JISnzqWdCLG00KAIflY9jizQNQclAcOg0qI3ZSIp2j+wV3kiOFYSKJYBrdKsF5
         cOloC6jHN3y9AKyRaSO3HaMhkn4VcJZvTxc5vzPWkm2wNLU7+iMoiDEpZ4UqfzsMLEcI
         yQirFfqMFa8azFdms2mBCsbmJ5j7LdPEGskHhb3+pXPEEWQGR9Yh1cHdAP3yVZSo+3Ll
         M3tA==
X-Gm-Message-State: AAQBX9dJvoNHshBUO/pVkEFIhrkHNQvYIwkiAxbeODwq29FeTjIJccOq
        uJlgkEfGGDvohNnRi9iU9wQP/cOjl0WgL5/pgsODifPQsqN7WzhZcD6AUtG5ie5yLsx/fHi+YnQ
        ILazbC+37MPw+jXQk4sobGPSj5fwDx/r4vxRbqb2o
X-Received: by 2002:a17:902:e1cd:b0:1a2:1fd0:226c with SMTP id t13-20020a170902e1cd00b001a21fd0226cmr719817pla.8.1681822278319;
        Tue, 18 Apr 2023 05:51:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350YqokUIE8shBPlXsyt52/Qsmk7T772mS5utILkVKfAaVUVlU/X2DsS4DP4/uPjlAIOFuF+rubUQ3cedwhC1UjM=
X-Received: by 2002:a17:902:e1cd:b0:1a2:1fd0:226c with SMTP id
 t13-20020a170902e1cd00b001a21fd0226cmr719813pla.8.1681822278011; Tue, 18 Apr
 2023 05:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de> <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <5800e1f5-8681-e140-fef0-8b2c3b4b6efa@web.de>
In-Reply-To: <5800e1f5-8681-e140-fef0-8b2c3b4b6efa@web.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 18 Apr 2023 14:51:05 +0200
Message-ID: <CAHc6FU4RekTwC9jH-H898PCyufrE59NYqZWy_V3p7R7dOCaTDA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Move a variable assignment behind a null pointer
 check in inode_go_dump()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On Thu, Apr 13, 2023 at 9:23=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
> Date: Thu, 13 Apr 2023 20:54:30 +0200
>
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Cinode_go_dump=E2=80=9D.
>
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable =E2=80=9Cinode=E2=80=9D behind the null pointer check.
>
> This issue was detected by using the Coccinelle software.
>
> Fixes: 27a2660f1ef944724956d92e8a312b6da0936fae ("gfs2: Dump nrpages for =
inodes and their glocks")

Okay, that's a worthwhile cleanup. It doesn't actually fix a bug, so
I'm not going to add a Fixes tag, though.

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/gfs2/glops.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index b65950e76be5..6e33c8058059 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -535,12 +535,13 @@ static void inode_go_dump(struct seq_file *seq, str=
uct gfs2_glock *gl,
>                           const char *fs_id_buf)
>  {
>         struct gfs2_inode *ip =3D gl->gl_object;
> -       struct inode *inode =3D &ip->i_inode;
> +       struct inode *inode;
>         unsigned long nrpages;
>
>         if (ip =3D=3D NULL)
>                 return;
>
> +       inode =3D &ip->i_inode;
>         xa_lock_irq(&inode->i_data.i_pages);
>         nrpages =3D inode->i_data.nrpages;
>         xa_unlock_irq(&inode->i_data.i_pages);
> --
> 2.40.0
>

Thanks,
Andreas

