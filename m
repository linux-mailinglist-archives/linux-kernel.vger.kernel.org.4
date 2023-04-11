Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F0E6DDD66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDKON6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDKONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A938E43
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681222391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgWHYZJKqiNl4gOA+tqLLIKQpJrOHM98+Ie5Z3qvOjs=;
        b=GJXStNcRzRJjTE+zjbWmyEG2ETu3oR5LZj4vSx37RTIEFPbALix50kniRpB4GMh8ynUKvb
        1eik24o1nPsQrl2rDGhJwBLQeT6t0RU8CQs+N7AT9V3LlM/g1rxYMFdZRLcmFelt9VjrN1
        yfQLjiBv8I4s9juaJMx+4pumDGIHwrc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-Y1znqvIbM0CqzwEAgjJJvw-1; Tue, 11 Apr 2023 10:13:08 -0400
X-MC-Unique: Y1znqvIbM0CqzwEAgjJJvw-1
Received: by mail-lf1-f70.google.com with SMTP id k1-20020a192d01000000b004cc7af49b05so3163788lfj.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgWHYZJKqiNl4gOA+tqLLIKQpJrOHM98+Ie5Z3qvOjs=;
        b=OCJu7pQ2Mafrp85zJn7lVDlYVvS/y8O7wDTTum/LU0Eq7hybdxALZXNHHJEYCMgRwb
         jr26B1DW1E/Qksb3yUaJpS+RIXoHChxgnD9KNhzSGs4HrGYXtNvbe5+0nLgiuR5APVLr
         68NbDeoZNgdHDapVi9ow4Rfvq5Oxjs0099eZqxBkD3R7HBUjcWVciI9+xbMNA/5VVwHP
         q8D4L6+fB/76RHmro4ilLb+yeXcpZE0NLPRIXnGbx+yrH+NCWOuOw098uEieaq9RjSFO
         N0ljy/PQRqcY6mWqIQhI5LYwgh+0Ip47bW+jORl4I8N7arEbhj5afyMwjrp+R6ACfAPB
         FIgw==
X-Gm-Message-State: AAQBX9dqxczWbHeIUM74bIeAcRkJ+1L7AWK1hPIHh158ANW7D9TyWrIV
        vWQ6dqwlumdBUOTJoMyAae/1UERB1Msb3h/nwGmFGlCL8eU9LxYKdxMcOUnk/dMzUM0eLtOjrqu
        Vvd7ls0Py29YFgNwfDgke0Da/3cJXObql88R4SUCJ
X-Received: by 2002:ac2:54b9:0:b0:4ec:8e1e:60c7 with SMTP id w25-20020ac254b9000000b004ec8e1e60c7mr1447470lfk.4.1681222382989;
        Tue, 11 Apr 2023 07:13:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZJNvA1En0899YIptSvqorm8IgX6qDO8OV/Q4M08zulGPBKcyK2yEfUe2F2T6iaJY/jr6uhrRqFH9MWQjDNWMg=
X-Received: by 2002:ac2:54b9:0:b0:4ec:8e1e:60c7 with SMTP id
 w25-20020ac254b9000000b004ec8e1e60c7mr1447459lfk.4.1681222382653; Tue, 11 Apr
 2023 07:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220924073957.4140388-1-ruanjinjie@huawei.com>
In-Reply-To: <20220924073957.4140388-1-ruanjinjie@huawei.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 11 Apr 2023 16:12:51 +0200
Message-ID: <CACO55tuDx0khsqgv6MBBnwKtcB-UwVLQYEfFah4f0WhOLHd0-A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/nouveau/disp: make gv100_disp_core_mthd_base static
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     bskeggs@redhat.com, lyude@redhat.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@redhat.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Sat, Sep 24, 2022 at 10:00=E2=80=AFAM ruanjinjie <ruanjinjie@huawei.com>=
 wrote:
>
> The symbol is not used outside of the file, so mark it static.
>
> Fixes the following warning:
>
> ./drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c:591:1: warning:
> symbol 'gv100_disp_core_mthd_base' was not declared. Should it be static?
>
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/disp/gv100.c
> index 6b9d49270fa7..347c12a1fcb7 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
> @@ -587,7 +587,7 @@ gv100_disp_curs =3D {
>         .user =3D 73,
>  };
>
> -const struct nvkm_disp_mthd_list
> +static const struct nvkm_disp_mthd_list
>  gv100_disp_core_mthd_base =3D {
>         .mthd =3D 0x0000,
>         .addr =3D 0x000000,
> --
> 2.25.1
>

