Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B1681BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjA3UiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjA3UiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:38:03 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2549611E94;
        Mon, 30 Jan 2023 12:38:01 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B0BCBCD4B3;
        Mon, 30 Jan 2023 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675111049; bh=2qV9dfXM46OwroENm+8sv9Dhvr1XeFyMNu+TGHJGkaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VoN//kqdI6qlbf71JIccQ2JXLTU8w051w13B1OD5VakomkZXq7LTVZZGnDOUqEBcA
         rYMlHpJ5ITqOHhBcLNZb3jqy9yirDvYKlVlS0JhwJcy0ZU/5FCrfKeBxvf7R5dMJz7
         1DUFKzzKa3s+b9YP2p2vQwJHNj1O7abh4ysx+VrE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: correct qfprom node reg
Date:   Mon, 30 Jan 2023 21:37:29 +0100
Message-ID: <2401830.jE0xQCEvom@z3ntu.xyz>
In-Reply-To: <568ebb75-5cb2-af97-bfae-c1e1e6174a45@linaro.org>
References: <20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz>
 <1886214.taCxCBeP46@g550jk> <568ebb75-5cb2-af97-bfae-c1e1e6174a45@linaro.org>
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

On Montag, 30. J=E4nner 2023 19:42:51 CET Konrad Dybcio wrote:
> On 30.01.2023 19:36, Luca Weiss wrote:
> > On Montag, 30. J=E4nner 2023 19:30:04 CET Konrad Dybcio wrote:
> >> On 30.01.2023 19:20, luca@z3ntu.xyz wrote:
> >>> From: Craig Tatlor <ctatlor97@gmail.com>
> >>>=20
> >>> The qfprom actually starts at 0xfc4b8000 instead of 0xfc4bc000 as
> >>> defined previously. Adjust the tsens offsets accordingly.
> >>>=20
> >>> [luca@z3ntu.xyz: extract to standalone patch]
> >>>=20
> >>> Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and
> >>> qfprom nodes") Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> >>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> >>> ---
> >>=20
> >> Isn't this a raw vs ecc-corrected values problem?
> >=20
> > Not quite sure what you mean.
>=20
> The QFPROM is split into two parts: one where raw values
> are stored, and the other one where ECC-corrected copies
> of them reside. Usually it's at offset of 0x4000. We should
> generally be using the ECC-corrected ones, because.. well..
> they are ECC-corrected.. You may want to check if the
> fuse you're adding reads the same value at +0x4000.

Yeah that actually seems to work...

But downstream's using this +0x4000 only for tsens it seems

   <0xfc4bc000 0x1000> as "tsens_eeprom_physical"

qcom,clock-krait-8974 is using this:

    <0xfc4b80b0 0x08> as "efuse"

Also seems HDMI driver is using a mix for HDCP stuff

  drivers/video/msm/mdss/mdss_hdmi_util.h:

    /* QFPROM Registers for HDMI/HDCP */
    #define QFPROM_RAW_FEAT_CONFIG_ROW0_LSB  (0x000000F8)
    #define QFPROM_RAW_FEAT_CONFIG_ROW0_MSB  (0x000000FC)
    #define HDCP_KSV_LSB                     (0x000060D8)
    #define HDCP_KSV_MSB                     (0x000060DC)

Any clue why Qualcomm used it this way in downstream? I'd rather not deviat=
e=20
too much if not for a good reason...

Regards
Luca


>=20
> Konrad
>=20
> > The original intention behind this patch is to allow to use the pvs fuse
> > at
> > (now) 0xb0 which was inaccessible with the former definition.
> >=20
> >     pvs: pvs@b0 {
> >    =20
> >         reg =3D <0xb0 0x8>;
> >    =20
> >     };
> >=20
> > Regards
> > Luca
> >=20
> >> Konrad
> >>=20
> >>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 12 ++++++------
> >>>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>>=20
> >>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
> >>> b/arch/arm/boot/dts/qcom-msm8974.dtsi index 8d216a3c0851..922d235c6065
> >>> 100644
> >>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> >>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> >>> @@ -1132,16 +1132,16 @@ restart@fc4ab000 {
> >>>=20
> >>>  			reg =3D <0xfc4ab000 0x4>;
> >>>  	=09
> >>>  		};
> >>>=20
> >>> -		qfprom: qfprom@fc4bc000 {
> >>> +		qfprom: qfprom@fc4b8000 {
> >>>=20
> >>>  			compatible =3D "qcom,msm8974-qfprom",
> >=20
> > "qcom,qfprom";
> >=20
> >>> -			reg =3D <0xfc4bc000 0x1000>;
> >>> +			reg =3D <0xfc4b8000 0x7000>;
> >>>=20
> >>>  			#address-cells =3D <1>;
> >>>  			#size-cells =3D <1>;
> >>>=20
> >>> -			tsens_calib: calib@d0 {
> >>> -				reg =3D <0xd0 0x18>;
> >>> +			tsens_calib: calib@40d0 {
> >>> +				reg =3D <0x40d0 0x18>;
> >>>=20
> >>>  			};
> >>>=20
> >>> -			tsens_backup: backup@440 {
> >>> -				reg =3D <0x440 0x10>;
> >>> +			tsens_backup: backup@4440 {
> >>> +				reg =3D <0x4440 0x10>;
> >>>=20
> >>>  			};
> >>>  	=09
> >>>  		};
> >>>=20
> >>> ---
> >>> base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
> >>> change-id: 20230130-msm8974-qfprom-619c0e8f26eb
> >>>=20
> >>> Best regards,




