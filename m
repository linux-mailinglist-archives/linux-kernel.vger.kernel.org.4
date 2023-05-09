Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AAE6FC2CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjEIJbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjEIJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7AFDDB7
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683624621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWUbYFjjx+ICPyEkXBm8kY/O+ZEJSV1Cd7/THSNoG6A=;
        b=OzzOzD9R/nsWp7BgfqcXoRKZjk2cWbldBVlEeoiYjhfQRKsEMfqoIBKc4XX/fVFzBvlZ1i
        Jd/3uTc3ncNtt/Kj8HD2jWmeudXg5tJnAYJ0zqrRMDfuN/AD2wI6py84eEHBlp9V+dvuj7
        K++FLOq8jcxrYN9L+cneZFPSY295Fd8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-YpeMDPkCPcKJXewb5db98w-1; Tue, 09 May 2023 05:30:20 -0400
X-MC-Unique: YpeMDPkCPcKJXewb5db98w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7579edafe0eso264685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683624620; x=1686216620;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWUbYFjjx+ICPyEkXBm8kY/O+ZEJSV1Cd7/THSNoG6A=;
        b=Lv08FIzhZVrY7gp6MdAVJe+K4ZaTvqYKxWBNYMzzY7DE/6uB4Z/YcZNHS77++nyAzu
         fQlx8Q7grslFsOXfjq/1pPa5bMhcEhLwVwigX/jx/MgKAIM8T5I4+A1GvSlDcAnnyM0a
         cZS+EAfb02hxx8bzDjyJRYnj3VlFefaGslJbqichlrk5UK/o2GuTLibIxhhiDp+f78Fg
         V1D5H3AmMV6/H+rJ8nqDy5A8BcGfs4tBDMBDxh6ZxKMUFJVeTAUrpHz7mBU53jakWmDK
         zMrrafZWE6hwOhsy/nGNi8vKEoVxdZv/+Hx2QUpY+TIURN5vVIUC3bWMlyfvZ7hzQ5Kj
         X8PQ==
X-Gm-Message-State: AC+VfDzSBs6Fpp4Kqper0BBO4FEymVqVLGcFJm9l8wnDbx5yoEHdVCq4
        tDPLAB9CA8nOLP21NUkYTYqHEnfVZuTLxWitl2qDGTCh0xUB2Y3CsGHllwjSEu9D+zOKnK/2MST
        QVEiCzfpC03KE5NigdaftxcG0
X-Received: by 2002:a05:622a:1896:b0:3ef:4839:2632 with SMTP id v22-20020a05622a189600b003ef48392632mr19423889qtc.0.1683624619829;
        Tue, 09 May 2023 02:30:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7IdngGu4W6HDlzDwmPcGS8eug7c+TlJ/S1IhOJKt48LSsfRPPnQ/xdS5LfvIaZhGdLosuPSw==
X-Received: by 2002:a05:622a:1896:b0:3ef:4839:2632 with SMTP id v22-20020a05622a189600b003ef48392632mr19423868qtc.0.1683624619516;
        Tue, 09 May 2023 02:30:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-255-65.dyn.eolo.it. [146.241.255.65])
        by smtp.gmail.com with ESMTPSA id c18-20020a05620a11b200b0074fafbea974sm3159641qkk.2.2023.05.09.02.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 02:30:19 -0700 (PDT)
Message-ID: <c77b8989fa4a1424a159fdd4450109a239babaa1.camel@redhat.com>
Subject: Re: [PATCH] net: ethernet: mtk_eth_soc: log clock enable errors
From:   Paolo Abeni <pabeni@redhat.com>
To:     Lorenz Brun <lorenz@brun.one>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Tue, 09 May 2023 11:30:15 +0200
In-Reply-To: <20230507214035.3266438-1-lorenz@brun.one>
References: <20230507214035.3266438-1-lorenz@brun.one>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-05-07 at 23:40 +0200, Lorenz Brun wrote:
> Currently errors in clk_prepare_enable are silently swallowed.
> Add a log stating which clock failed to be enabled and what the error
> code was.
>=20
> Signed-off-by: Lorenz Brun <lorenz@brun.one>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.c
> index e14050e17862..ca66a573cfcb 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3445,8 +3445,10 @@ static int mtk_clk_enable(struct mtk_eth *eth)
> =20
>  	for (clk =3D 0; clk < MTK_CLK_MAX ; clk++) {
>  		ret =3D clk_prepare_enable(eth->clks[clk]);
> -		if (ret)
> +		if (ret) {
> +			dev_err(eth->dev, "enabling clock %s failed with error %d\n", mtk_clk=
s_source_name[clk], ret);

I'm sorry for nit-picking, but this lines really exceed any reasonable
max len. Please reformat the above as:

			dev_err(eth->dev, "enabling clock %s failed with error %d\n",
				mtk_clks_source_name[clk], ret);

Thanks!

Paolo

