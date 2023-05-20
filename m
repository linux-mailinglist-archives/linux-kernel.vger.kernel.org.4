Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000E770A753
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjETKw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjETKwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:52:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B51B4;
        Sat, 20 May 2023 03:52:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f9cfa7eddso68465166b.2;
        Sat, 20 May 2023 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684579923; x=1687171923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhtViK1PMUyIQXuHNPCVbSL8wrPfXdIq5SU+kR35W14=;
        b=qRAoL73wuZfvD/D79Zwy4nK/7V4sBHozM5Azw+gGa/WMYT+Bis+LiHc4z1NUYPEmED
         BUNIrD9dPUM28i5bhW1p3OgNGTAJkC65VTTDXSpwZf1M5pyDZks7yC4+wE0l+nemm5k3
         gaoD9bCZ65Jf/nc2iQgf/xD+z9v40k7V1XUtKGMrjPAn3VPzHybOIhTUs7ZL2wzN/Omw
         l8gWMKptNH9BJjUsDireXd0HPu37vpzZMLNRCXRBHgB7hRQkDlgZRr5wY3bMve9M35tA
         UnOryRS6+FInea2b1B2Qr3TaXz/2+4NhPCVBSJurDoQxzCr75lWZwj9jQRTFX3n2egX/
         NH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684579923; x=1687171923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhtViK1PMUyIQXuHNPCVbSL8wrPfXdIq5SU+kR35W14=;
        b=mEE+/cj5RoLQ4MVYgRmxoQcYwM4rioTY90Lz1m79DLvGui02I+Fpq1SKawWej2o3VU
         3wFuL+UDwNICdtYekvfaUUwjMu0373qMEfQgKtQDIzx3McQZVL8uuNyz3vcrNIJnBVm6
         qm5JAD+fSltfJHIjKQ3wua+13zJ4LKQhCJalg8nsSHrvezOLNlwnmqZIZHzbLWYg0rgy
         66bZ55gvr9g0MeMNwCiw7e2un4v3WXQzNH3xSiTNRNo0reTbfGFn8FWkwm4ON0tZDpnl
         tlt+TI9Rf1tz8DQoEc75QNMKorlAr3LGtanwjbPRLaXQODjgwOlysMBpM58VrtwzXhtK
         XG8A==
X-Gm-Message-State: AC+VfDxzo3jS51zh2maTUNdriJBxjIyM2+O9J0AVMyyX/37XgLYbku7i
        Pyj342jl4L/VnlH7SVco7W4e2opVaN/pQel2zsU=
X-Google-Smtp-Source: ACHHUZ7o9dfRUtirv4/SqzhyYSmDrgMlNXUTIHjGKuZ7slq7gORFA5OFaLcUFx4z7AGKyxV3XgqZPEJr7aaPX8bO7dk=
X-Received: by 2002:a17:907:e88:b0:94f:2efa:a3eb with SMTP id
 ho8-20020a1709070e8800b0094f2efaa3ebmr5654897ejc.33.1684579922440; Sat, 20
 May 2023 03:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <355e9a7d351b32ad897251b6f81b5886fcdc6766.1684571393.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <355e9a7d351b32ad897251b6f81b5886fcdc6766.1684571393.git.christophe.jaillet@wanadoo.fr>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sat, 20 May 2023 18:51:50 +0800
Message-ID: <CAD=hENdwa-_LsQNUmd44ZCtidGOyAsdDpngAjpSZyAj78yfFUQ@mail.gmail.com>
Subject: Re: [PATCH net] forcedeth: Fix an error handling path in nv_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Rain River <rain.1986.08.12@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ayaz Abdulla <aabdulla@nvidia.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 4:30=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If an error occures after calling nv_mgmt_acquire_sema(), it should be
> undone with a corresponding nv_mgmt_release_sema() call.
>
> Add it in the error handling path of the probe as already done in the
> remove function.
>
> Fixes: cac1c52c3621 ("forcedeth: mgmt unit interface")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks.
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Zhu Yanjun
> ---
> I don't think that the Fixes tag is really accurate, but
> nv_mgmt_release_sema() was introduced here. And cac1c52c3621 is already o=
ld
> so should be good enough.
> ---
>  drivers/net/ethernet/nvidia/forcedeth.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethern=
et/nvidia/forcedeth.c
> index 0605d1ee490d..7a549b834e97 100644
> --- a/drivers/net/ethernet/nvidia/forcedeth.c
> +++ b/drivers/net/ethernet/nvidia/forcedeth.c
> @@ -6138,6 +6138,7 @@ static int nv_probe(struct pci_dev *pci_dev, const =
struct pci_device_id *id)
>         return 0;
>
>  out_error:
> +       nv_mgmt_release_sema(dev);
>         if (phystate_orig)
>                 writel(phystate|NVREG_ADAPTCTL_RUNNING, base + NvRegAdapt=
erControl);
>  out_freering:
> --
> 2.34.1
>
