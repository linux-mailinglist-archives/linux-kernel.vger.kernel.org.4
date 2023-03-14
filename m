Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38666B9EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCNSpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjCNSpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:45:46 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899B3A401E;
        Tue, 14 Mar 2023 11:45:12 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D374BD2500;
        Tue, 14 Mar 2023 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1678818788; bh=fHJza5nGl0uG6ilnr4LPPY4PLgKrXqdkOF8SQ67N1kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZsiIufmMaKi3c7O3QK6sepAvzFn03uUdr3CKUT3VoXSwt4PKJlOVdFJSG6mYnRtKl
         z6YxTjTZmVCR6xEsuDpr+/pK5lVUqEkqLk0ZCDzaXNeV3mC74pia+ELIIICuR5k8vM
         IVjGYv/sDCA2ppaCyYavz41aREDHVP4LdFyBJuMc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        phone-devel@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH] media: dt-bindings: ov2685: convert to dtschema
Date:   Tue, 14 Mar 2023 19:33:06 +0100
Message-ID: <5654018.DvuYhMxLoT@z3ntu.xyz>
In-Reply-To: <ZBBh9Euor7R24euV@valkosipuli.retiisi.eu>
References: <20230206-ov2685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz>
 <2665862.mvXUDI8C0e@z3ntu.xyz> <ZBBh9Euor7R24euV@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 14. M=E4rz 2023 13:00:52 CET Sakari Ailus wrote:
> Hi Luca,
>=20
> On Thu, Feb 09, 2023 at 05:46:48PM +0100, Luca Weiss wrote:
> > +CC Helen Koike
> >=20
> > On Montag, 6. Februar 2023 22:50:08 CET Rob Herring wrote:
> > > On Mon, 06 Feb 2023 21:23:16 +0100, Luca Weiss wrote:
> > > > Convert the text-based dt-bindings to yaml.
> > > >=20
> > > > Changes from original txt:
> > > > * Take wording for various properties from other yaml bindings, this
> > > >=20
> > > >   removes e.g. volt amount from schema since it isn't really releva=
nt
> > > >   and the datasheet is a better source.
> > > >=20
> > > > * Don't make reset-gpios a required property since it can be tied to
> > > >=20
> > > >   DOVDD instead.
> > > >=20
> > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > ---
> > > >=20
> > > >  .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
> > > >  .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101
> > > >  +++++++++++++++++++++ MAINTAINERS
> > > > =20
> > > >  |   1 +
> > > > =20
> > > >  3 files changed, 102 insertions(+), 41 deletions(-)
> > >=20
> > > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_ch=
eck'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >=20
> > > yamllint warnings/errors:
> > >=20
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/
> > > medi a/rockchip-isp1.example.dtb: camera@3c: 'clocks' is a required
> > > property From schema:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/
> > > med
> > > ia/i2c/ovti,ov2685.yaml
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/
> > > med
> > > ia/rockchip-isp1.example.dtb: camera@3c: 'clock-names' is a required
> > > property From schema:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/
> > > med
> > > ia/i2c/ovti,ov2685.yaml
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/
> > > med
> > > ia/rockchip-isp1.example.dtb: camera@3c: 'dvdd-supply' is a required
> > > property From schema:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/
> > > med
> > > ia/i2c/ovti,ov2685.yaml
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/
> > > med
> > > ia/rockchip-isp1.example.dtb: camera@3c: 'avdd-supply' is a required
> > > property From schema:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/
> > > med
> > > ia/i2c/ovti,ov2685.yaml
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/
> > > med
> > > ia/rockchip-isp1.example.dtb: camera@3c: 'dovdd-supply' is a required
> > > property From schema:
> > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindin=
gs/
> > > med
> > > ia/i2c/ovti,ov2685.yaml
> >=20
> > Looks like rockchip-isp1.yaml uses very incomplete sensor examples in
> > their
> > binding example, which sort of makes sense since those bindings are
> > showing
> > the rockchip isp bindings and contain the bare minimum to show how a
> > sensor is connected in dt.
> >=20
> > Not sure how to solve this - ov2685 is also one of three sensors that a=
re
> > used very abbreviated there.
>=20
> Could these regulators be simply made optional?

Sure, from driver side it would just get dummy regulators instead.

Still the clocks are also missing in this rockchip example. Any suggestion=
=20
what to do about those?

Honestly I don't want to spend too much time on some ISP docs that I don't=
=20
really care about, would be nice if the maintainers of that could do that...

Regards
Luca



