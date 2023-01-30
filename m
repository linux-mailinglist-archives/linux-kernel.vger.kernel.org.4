Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE740681962
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbjA3Shb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbjA3Sgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:36:36 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5F513D6C;
        Mon, 30 Jan 2023 10:36:22 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 705A3CD5B1;
        Mon, 30 Jan 2023 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675103780; bh=w7+XQVClETXGlfL757dC4kjjZ78YoUiBNlAl+eRVAD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bzTQoAHp/z69+jSIf9SrDybNnMQQWbWkbdUIQk/Q+iUUwgpKs3bO96N/sILAGW3EB
         tPEaZoJCwp3fVxaWwUnRJ6koXJh639cxKs5UNP34wyUYcoHVrHu8hoZgxBHI5vXoaH
         RCpblWn8pYkhC4cQVsa+A4oLF3fiOjzM1QQG1sDg=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: correct qfprom node reg
Date:   Mon, 30 Jan 2023 19:36:19 +0100
Message-ID: <1886214.taCxCBeP46@g550jk>
In-Reply-To: <3112b531-45df-672c-c0a7-aefbdcceb727@linaro.org>
References: <20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz>
 <3112b531-45df-672c-c0a7-aefbdcceb727@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 30. J=E4nner 2023 19:30:04 CET Konrad Dybcio wrote:
> On 30.01.2023 19:20, luca@z3ntu.xyz wrote:
> > From: Craig Tatlor <ctatlor97@gmail.com>
> >=20
> > The qfprom actually starts at 0xfc4b8000 instead of 0xfc4bc000 as
> > defined previously. Adjust the tsens offsets accordingly.
> >=20
> > [luca@z3ntu.xyz: extract to standalone patch]
> >=20
> > Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and
> > qfprom nodes") Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
>=20
> Isn't this a raw vs ecc-corrected values problem?

Not quite sure what you mean.

The original intention behind this patch is to allow to use the pvs fuse at=
=20
(now) 0xb0 which was inaccessible with the former definition.

    pvs: pvs@b0 {
        reg =3D <0xb0 0x8>;
    };

Regards
Luca

>=20
> Konrad
>=20
> >  arch/arm/boot/dts/qcom-msm8974.dtsi | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > b/arch/arm/boot/dts/qcom-msm8974.dtsi index 8d216a3c0851..922d235c6065
> > 100644
> > --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > @@ -1132,16 +1132,16 @@ restart@fc4ab000 {
> >=20
> >  			reg =3D <0xfc4ab000 0x4>;
> >  	=09
> >  		};
> >=20
> > -		qfprom: qfprom@fc4bc000 {
> > +		qfprom: qfprom@fc4b8000 {
> >=20
> >  			compatible =3D "qcom,msm8974-qfprom",=20
"qcom,qfprom";
> >=20
> > -			reg =3D <0xfc4bc000 0x1000>;
> > +			reg =3D <0xfc4b8000 0x7000>;
> >=20
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> >=20
> > -			tsens_calib: calib@d0 {
> > -				reg =3D <0xd0 0x18>;
> > +			tsens_calib: calib@40d0 {
> > +				reg =3D <0x40d0 0x18>;
> >=20
> >  			};
> >=20
> > -			tsens_backup: backup@440 {
> > -				reg =3D <0x440 0x10>;
> > +			tsens_backup: backup@4440 {
> > +				reg =3D <0x4440 0x10>;
> >=20
> >  			};
> >  	=09
> >  		};
> >=20
> > ---
> > base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
> > change-id: 20230130-msm8974-qfprom-619c0e8f26eb
> >=20
> > Best regards,




