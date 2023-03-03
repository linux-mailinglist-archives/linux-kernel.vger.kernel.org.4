Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191AF6A9971
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCCOde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCCOdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657EFF21
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677853965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5nYf8A+BlasX0vgFSOQ1j0UiJy81PWvKt/xuNhftYo8=;
        b=fpH4OvK1FdnaDCghBg/vNHHQS/g30VpWrrIyWALSs12/BHjiIVUxBvVf4oJP9iuA3c2vNw
        huXXjPuiJsh2uzNlkWcd4fSUWFNIbNzpEpy13wfJhMMWfiLInnnH6HgxDpr7YT79CymeLA
        YZpPx6MqjOY7TZydA4eMUaFwcju96Zs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-nxOvm6KCPlS3jkB4IukXVw-1; Fri, 03 Mar 2023 09:32:44 -0500
X-MC-Unique: nxOvm6KCPlS3jkB4IukXVw-1
Received: by mail-lj1-f200.google.com with SMTP id d15-20020a05651c088f00b002934e8e57e2so674882ljq.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677853962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nYf8A+BlasX0vgFSOQ1j0UiJy81PWvKt/xuNhftYo8=;
        b=XEh2xWR+idE0UUZK9I1+usN9kE3Nasrf8+1ijljf358OemdPtUHD3CUmZ1QDiQLbQ0
         SMXydNOr7MzJKKrPChrCMad3qk3RXB4Jl8yJCax+bXCEwqycO6o/lxPcybBcvcBexHgj
         rFsCXwYbIORDf1Jz8TPVnGFWbSSg6xpCQ3QDGtn588POFvUs5mrJ9rxIxD6iBS3uwAyO
         GC+0ICk69Ht6If3D7DIYFvZHb3nlDKpXmcpITfVDPPgyYa/QeYMNQHobfhGHP+fTrT+w
         jyMXCKD+bLxjGxzr2QhDsv4ImihD6nw4wS8Gq28ADhHpJh8vMpL8MkHOc7xpELdDDlaF
         5ucQ==
X-Gm-Message-State: AO0yUKWq3jq5ebc2NVALQbP/HMc4t9AL3WYfUXs5l2HgkdvbAAN/mGSZ
        YtTxacG8I3MQiHDcdHbPWFUoleWsTLBvAXpXnBFRdbviyooKIIhN3xnTfJEmEPyvnJynISIZtqi
        2NzhquSs097JYJFATw9E1FgU/joRPBVYGx7K6EBqk
X-Received: by 2002:a2e:a269:0:b0:295:ab47:119b with SMTP id k9-20020a2ea269000000b00295ab47119bmr615928ljm.8.1677853962142;
        Fri, 03 Mar 2023 06:32:42 -0800 (PST)
X-Google-Smtp-Source: AK7set+DWS1/VMrWujeY8/SZOejIjQIqPNDKSiIgeHe0gYYaAUjs2lN9GALNmJeAifGyEzRnf0RmfAQRi/xYJQ2egSY=
X-Received: by 2002:a2e:a269:0:b0:295:ab47:119b with SMTP id
 k9-20020a2ea269000000b00295ab47119bmr615911ljm.8.1677853961896; Fri, 03 Mar
 2023 06:32:41 -0800 (PST)
MIME-Version: 1.0
References: <20230302124819.686469-1-trix@redhat.com>
In-Reply-To: <20230302124819.686469-1-trix@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 3 Mar 2023 15:32:29 +0100
Message-ID: <CACO55tuUzrxMio5ANBr46N+x4_=KqyC6Smt4hA=30xSZ-gqNRw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/nvfw/acr: set wpr_generic_header_dump
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     bskeggs@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, gsamaiya@nvidia.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

will push in a moment

On Thu, Mar 2, 2023 at 1:48 PM Tom Rix <trix@redhat.com> wrote:
>
> gcc with W=3D1 reports
> drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c:49:1: error: no previous
>   prototype for =E2=80=98wpr_generic_header_dump=E2=80=99 [-Werror=3Dmiss=
ing-prototypes]
>    49 | wpr_generic_header_dump(struct nvkm_subdev *subdev,
>       | ^~~~~~~~~~~~~~~~~~~~~~~
>
> wpr_generic_header_dump is only used in acr.c, so it should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c b/drivers/gpu/drm/no=
uveau/nvkm/nvfw/acr.c
> index 83a9c48bc58c..7ac90c495737 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
> @@ -45,7 +45,7 @@ wpr_header_v1_dump(struct nvkm_subdev *subdev, const st=
ruct wpr_header_v1 *hdr)
>         nvkm_debug(subdev, "\tstatus        : %d\n", hdr->status);
>  }
>
> -void
> +static void
>  wpr_generic_header_dump(struct nvkm_subdev *subdev, const struct wpr_gen=
eric_header *hdr)
>  {
>         nvkm_debug(subdev, "wprGenericHeader\n");
> --
> 2.27.0
>

