Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3845749AAB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjGFLcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjGFLcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:32:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C7D199C;
        Thu,  6 Jul 2023 04:31:59 -0700 (PDT)
Received: from [IPv6:2a00:23c8:b70a:ae01:35d0:8e34:613c:c44e] (unknown [IPv6:2a00:23c8:b70a:ae01:35d0:8e34:613c:c44e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3139D6602242;
        Thu,  6 Jul 2023 12:31:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688643117;
        bh=vbQlxNw0xEqKNvHiDqAMddYkxm9j3O7CBi79bnRH9OA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=XufG4a28u8HEBpH5Bc44w6ttJ9HFg4VfUA7GIp7wQKH1dzHWlYNnGA2bT1m6yFA1M
         pfalPAwYQohuHaQ7tnI0cTShYTKrF4mAeeXm/SohNWOlSwUJhZFu3QOsqgILVD+T5K
         YopF3r68h43t3TpULniFd3PSMvcoeGZKHTC3dGgHvbwuAYFfgBYyAEDhMFmERUXELa
         LWYXdwhNyAvgqPXIf02q0S86Fmn1Vt0fOFJGIDCYHQgG9yjIkPb+KKq0FiDdM9ZWjO
         ImBXBlU6DmBB7HixR+hypF4SoQsHtPRd45z/w51EWifbNPlOPCDhyT78nbOXNoAy0J
         07Ac3r9PniF8Q==
Message-ID: <3efcb6215c19ff70e2b9ef8ed5bf48813c1499c9.camel@collabora.com>
Subject: Re: [RFT PATCH 2/3] arm64: dts: rockchip: correct audio-codec
 interrupt flag in Rock Pi 4B
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 12:31:55 +0100
In-Reply-To: <20230705064823.9210-2-krzysztof.kozlowski@linaro.org>
References: <20230705064823.9210-1-krzysztof.kozlowski@linaro.org>
         <20230705064823.9210-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, 2023-07-05 at 08:48 +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning: GPIO_ACTIVE_HIGH =3D 0 =3D IRQ_TYPE_NONE.
>=20
> Correct the interrupt flags, assuming the author of the code wanted same
> logical behavior behind the name "ACTIVE_xxx", this is:
> =C2=A0 ACTIVE_LOW=C2=A0 =3D> IRQ_TYPE_LEVEL_LOW
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

This works fine on my hardware. With that:

Tested-by: Christopher Obbard <chris.obbard@collabora.com>

> =C2=A0arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts b/ar=
ch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> index cec3b7b1b947..8a17c1eaae15 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> @@ -31,7 +31,7 @@ brcmf: wifi@1 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "brcm,bcm4329-fmac";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg =3D <1>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0interrupt-parent =3D <&gpio0>;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0interrupts =3D <RK_PA3 GPIO_ACTIVE_HIGH>;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0interrupts =3D <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0interrupt-names =3D "host-wake";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-names =3D "default";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pinctrl-0 =3D <&wifi_host_wake_l>;
