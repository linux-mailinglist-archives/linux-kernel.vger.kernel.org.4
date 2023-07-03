Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF8746424
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjGCUc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjGCUcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:32:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55777E6A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688416308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1fKWi0rYo77j8u4gN98bhniw2sqFFBsM4GubtoeVvlU=;
        b=ZscVa/6exvjMn0LSLhMYrU+zyJ4xk4st528R+8hz6xbBKVCXR5E/HpQqXzLgvRQtEjeaLi
        PQAj09APG/Us5jSZVQ5uQIzaYDokAfrM4c/xJ4VmNtZoDaOKH08VSZQ2g9zg+w11DfGsii
        bxMFJvWq4WxvKDuCdaZ/j8xfFDhCeLY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-N8STedmtPC-UbcEDsMOQ2Q-1; Mon, 03 Jul 2023 16:31:47 -0400
X-MC-Unique: N8STedmtPC-UbcEDsMOQ2Q-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1b89e3715acso10000665ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 13:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688416306; x=1691008306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fKWi0rYo77j8u4gN98bhniw2sqFFBsM4GubtoeVvlU=;
        b=BVib0hIQV8nUm81MlKMd76YIriHm3AX+Zc3iOarVfnO/YVLAIapUc5PTfN1Ts32ARC
         UYONJg1gpZSy+J3eZJ8ZGKtacfAAIH4fonAAKNtqHuDhN/ZoFlB+zkUIIh5b7yZU+54H
         gmPefndMYHkyYfWmCkoMKNoLJnBq53wmxFNcEt36iZWX1NRnA+/WBBV72Eh5NvYmSIju
         xGCFhXOR/XaxtaoBTcpeUSah0tAr+UpRBfj7kk1kLIWiaiSOvT/hTWH3Eys0R5DLbHxk
         ZssytCmtLT34S2719ZBrDpQUYcBN474EuoAhdLUme4NRXnCD1DRDGKhXgx76EXxopvWd
         99yg==
X-Gm-Message-State: ABy/qLY+PBJFFwmNtEa2eQfTjDfarVfiQYj9Vl/wBHiNO+HkbyhRPI9I
        7x1GFecpO/ROmoBpDOxdQTQBCMLW3l1Jjv0fayzKHY36aCwlTuGsqxps6W37Xw6DMphQIdiBel1
        iVsN5OqUqEVyYqxrRwTyZFCDSgmnDgTMGWw/9rMOq
X-Received: by 2002:a17:902:d702:b0:1b8:901d:cfa8 with SMTP id w2-20020a170902d70200b001b8901dcfa8mr4873910ply.18.1688416306273;
        Mon, 03 Jul 2023 13:31:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF+x8Z808wiN59SjHWxqDqEaiR/a3Y6nlWknym38PVY3j6FGLfLmxVbustdLNJmZyEo8OAMYcVEK8zNWcuYTP8=
X-Received: by 2002:a17:902:d702:b0:1b8:901d:cfa8 with SMTP id
 w2-20020a170902d70200b001b8901dcfa8mr4873897ply.18.1688416306008; Mon, 03 Jul
 2023 13:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230620033859.997-1-lidong@vivo.com>
In-Reply-To: <20230620033859.997-1-lidong@vivo.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 3 Jul 2023 22:31:34 +0200
Message-ID: <CAHc6FU71+Y2CT=04cbgtxp5p8jPYU5RK0tcz8wR4jyLdQw6h4A@mail.gmail.com>
Subject: Re: [PATCH] fs: Fix bug in gfs2_freeze_func that can cause deadlock
To:     Li Dong <lidong@vivo.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        "open list:GFS2 FILE SYSTEM" <cluster-devel@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Dong,

On Tue, Jun 20, 2023 at 5:47=E2=80=AFAM Li Dong <lidong@vivo.com> wrote:
> Function gfs2_freeze_func causes a deadlock=EF=BC=8Cbecause sd_freeze_mut=
ex was
> not released when return
>
> Signed-off-by: Li Dong <lidong@vivo.com>
> ---
>  fs/gfs2/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -741,8 +741,10 @@ void gfs2_freeze_func(struct work_struct *work)
>         set_bit(SDF_FROZEN, &sdp->sd_flags);
>
>         error =3D gfs2_do_thaw(sdp);
> -       if (error)
> +       if (error) {
> +               mutex_unlock(&sdp->sd_freeze_mutex);
>                 goto out;
> +       }

thank you for this bug report. I have chosen to fold this fix into
commit "gfs2: Rework freeze / thaw logic" and clean up
gfs2_freeze_func() a little along the way; see the current for-next
branch.

Thanks,
Andreas

>         clear_bit(SDF_FROZEN, &sdp->sd_flags);
>
> --
> 2.31.1.windows.1

