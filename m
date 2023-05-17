Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF8D705FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjEQF6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjEQF6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE126A1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684303052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+qfUPr0uKNy+sb2n0bJkiBPdjAbSKuNDFcmJ6hILOM=;
        b=D4W6A+YGDTw3e3dCgJpzyPq24G0isFgkTEjlG+8xslBc32kZeJW6ntoEMkqiS8/M6uQOYs
        g3UawQpI0Ju0+UVtPb12pt/IHwUiIn7lKgSD/MRsq+ATAdHx1EtUfa9vd/zTGpiXpTv2xw
        jS/ytikcTPR7b/GWyGXa1LTYZx0pjxQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-PKbfavVnPU6jztJIORP7WQ-1; Wed, 17 May 2023 01:57:31 -0400
X-MC-Unique: PKbfavVnPU6jztJIORP7WQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4edbdd8268bso276786e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684303050; x=1686895050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+qfUPr0uKNy+sb2n0bJkiBPdjAbSKuNDFcmJ6hILOM=;
        b=W7k2EJJEXJj5n6fKaeiUrNedp7oVOFY7WI5oYx0hqqXKXK1EwEz/Hg9bpDnOGf5YKY
         kDNXU5oFR6DxCKdgeKd9QeBDzYAppMKLhT4zFTV4r6zWVGIrYGITZc3SZF09vEK/iHxR
         h8Lxv5Cc4I/LafT2oIYpupFF7vURUm1sV2DgKaVxc/VpZueio7/SW+PNTlZADXx9Czhk
         vaVEXW+zCIiPZHQoPDywq335ktuzPzkDhXkgAXSI1rkFqPGKB4GDRhCo/n5pdUzkXFs+
         wGJBRXkQpLZnxhYuy07h+IfYzcoZERoiD/s4vRKu3APMVXlTgWypkTmM6jjQXaKzPr6L
         6j7g==
X-Gm-Message-State: AC+VfDzj8c968/zsmw05REcdAi3gjWQvZyRbEdcy3lwJgTjpoLPciyWP
        BYxEkZ42hdtcWTe4F4s5z28Ns4/Zw+OrGa/+254OQYdbfa0sEr1pkMT02ILKs70Kw5N7xWvZI/W
        y8UppXTCXhgEO6dYcavZJ1uw8gbAbgMuLJC6wU6k8
X-Received: by 2002:ac2:48a7:0:b0:4ed:bfcf:3109 with SMTP id u7-20020ac248a7000000b004edbfcf3109mr7522459lfg.56.1684303050261;
        Tue, 16 May 2023 22:57:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ljgjund9d0mLXFRAK8YCXSNJ/xM9q4oHcAJsFnVKMrNlFDXUWPH93HOgXxpZrLm3DBx3i14I2expvGHz3AfU=
X-Received: by 2002:ac2:48a7:0:b0:4ed:bfcf:3109 with SMTP id
 u7-20020ac248a7000000b004edbfcf3109mr7522452lfg.56.1684303049974; Tue, 16 May
 2023 22:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230511175451.282096-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230511175451.282096-1-krzysztof.kozlowski@linaro.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 17 May 2023 13:57:19 +0800
Message-ID: <CACGkMEsbhMSqVrXZtm_ynHFVsaX4jRt+9sAN7yLCE4kjy3jZhg@mail.gmail.com>
Subject: Re: [RESEND PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Fri, May 12, 2023 at 1:54=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Statically allocated array of pointers to hwmon_channel_info can be made
> const for safety.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/s=
net_hwmon.c
> index 42c87387a0f1..af531a339082 100644
> --- a/drivers/vdpa/solidrun/snet_hwmon.c
> +++ b/drivers/vdpa/solidrun/snet_hwmon.c
> @@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops =3D {
>         .read_string =3D snet_hwmon_read_string
>  };
>
> -static const struct hwmon_channel_info *snet_hwmon_info[] =3D {
> +static const struct hwmon_channel_info * const snet_hwmon_info[] =3D {
>         HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CR=
IT | HWMON_T_LABEL,
>                            HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
>         HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
> --
> 2.34.1
>

