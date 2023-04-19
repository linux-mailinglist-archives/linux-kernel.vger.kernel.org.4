Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7716E7EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjDSPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDSPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:54:34 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F5A97;
        Wed, 19 Apr 2023 08:54:32 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9C064C6E13;
        Wed, 19 Apr 2023 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681919670; bh=B8kuaxrbAOudg29ZKx0Ja65ggx/7tCW1jdSRrEzOEg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OOf2krUf0GDXjRktD6QuRvtJJ11p9hXbPfBUtkQjMk/ZQRgKptb5l2R9CC12R0lz7
         9JJsrSoQUUXFAswTxYZ69jw9RFrtfilFDmoOq6DA1yjJ4gbHXnAvcDJ6ooS+FYdzfg
         J+aWTWAdC2GzEK05IVBAyyuK62qU/evrKI6Y5cAw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/3] media: dt-bindings: ov2685: convert to dtschema
Date:   Wed, 19 Apr 2023 17:54:29 +0200
Message-ID: <2675347.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <CAL_JsqLB37Y-V-8uWPdnc_YaActtQUhJArv50Rz8K_CF5cbNhw@mail.gmail.com>
References: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz>
 <20230129-ov2685-improvements-v4-2-e71985c5c848@z3ntu.xyz>
 <CAL_JsqLB37Y-V-8uWPdnc_YaActtQUhJArv50Rz8K_CF5cbNhw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 19. April 2023 01:54:18 CEST Rob Herring wrote:
> On Thu, Mar 23, 2023 at 12:58=E2=80=AFPM Luca Weiss <luca@z3ntu.xyz> wrot=
e:
> > Convert the text-based dt-bindings to yaml.
> >=20
> > Changes from original txt:
> > * Take wording for various properties from other yaml bindings, this
> >=20
> >   removes e.g. volt amount from schema since it isn't really relevant
> >   and the datasheet is a better source.
> >=20
> > * Don't make reset-gpios a required property since it can be tied to
> >=20
> >   DOVDD instead.
> >=20
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >=20
> >  .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
> >  .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101
> >  +++++++++++++++++++++ MAINTAINERS                                     =
 =20
> >  |   1 +
> >  3 files changed, 102 insertions(+), 41 deletions(-)
>=20
> Now warning in linux-next:
>=20
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/media/rockc=
hip
> -isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
>         From schema:
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/media/i2c/o=
vti
> ,ov2685.yaml
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/media/i2c/o=
vt
> i,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is
> too short
>         From schema:
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/media/i2c/o=
vti
> ,ov2685.yaml

Right, since Sakari changed maxItems=3D1 to maxItems=3D2, now minItems is a=
lso 2=20
but it should be 1. I'll send a patch to fix this.

Regards
Luca


