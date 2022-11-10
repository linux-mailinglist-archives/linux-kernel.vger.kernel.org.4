Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4EA624C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiKJVJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKJVJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:09:04 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F59A1;
        Thu, 10 Nov 2022 13:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1668114537; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLRygKirSBoogtusAo9If0UlsP82kbcNW5DJvTB2yjI=;
        b=0nensPtFnH97lP55247EoOgXArEFvPu95xwsuDRfAUz/l/Frms0Zh+PCIzo+Uyx8fLSq0v
        lqGVxl0ovE2nNP6zFuHvkC+fxLM5UUTOgm879j/gC7ywh3g5IPlXluhl5k7lYOLhSoD/B5
        DwOUlgfVSru9g9ccpI1axf+nxZhmuk8=
Date:   Thu, 10 Nov 2022 21:08:47 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2] dt-bindings: Convert active-semi PMIC docs to YAML
 schemas
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        list@opendingux.net
Message-Id: <NEH5LR.URZKYH8VLESF1@crapouillou.net>
In-Reply-To: <02c45ae9-61a4-9fc5-4daf-8c4c9df9a4a0@linaro.org>
References: <20221105225803.39197-1-paul@crapouillou.net>
        <02c45ae9-61a4-9fc5-4daf-8c4c9df9a4a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Le dim. 6 nov. 2022 =E0 10:55:11 +0100, Krzysztof Kozlowski=20
<krzysztof.kozlowski@linaro.org> a =E9crit :
> On 05/11/2022 23:58, Paul Cercueil wrote:
>>  Create YAML bindings for the Active-semi PMICs and remove the old=20
>> text
>>  files.
>>=20
>>  The bindings aren't perfect, for instance I couldn't find good
>>  descriptions for the vendor properties in the "charger" node of the
>>  ACT8945A because I am not familiar with the hardware and these
>>  properties were not documented anywhere.
>>=20
>>  The YAML schemas are a bit different than what is described in the=20
>> old
>>  text files, because these were sometimes wrong or had missing
>>  information. This is the case for the ACT8600 documentation, which
>>  specified the valid node names for the regulators, while the driver=20
>> was
>>  expecting different names. This led to the current situation where=20
>> we
>>  have two different boards using different names for the regulators:
>>  - arch/mips/boot/dts/ingenic/ci20.dts uses the names documented in=20
>> the
>>    text file,
>>  - arch/mips/boot/dts/ingenic/gcw0.dts uses the names that the driver
>>    expects.
>>  In theory, the driver should be fixed to follow the documentation,=20
>> and
>>  accept both naming schemes. In practice though, when the PMIC node=20
>> was
>>  added to the ci20.dts board file, the names were already wrong in
>>  regards to what the driver expected, so it never really worked
>>  correctly and wasn't tested properly. Furthermore, in that board the
>>  consumers of the regulators aren't working for various other reasons
>>  (invalid GPIOs, etc.).
>>=20
>>  For that reason, for the ACT8600 bindings I decided to only use the=20
>> node
>>  names that the driver expects (and that gcw0.dts uses), instead of
>>  accepting both old and new names. A follow-up patch will update the=20
>> CI20
>>  board to use the new regulator names.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      v2:
>>      - Avoid | character in descriptions that can be single-line
>>      - Remove unevaluatedProperties when additionalProperties is=20
>> also present
>>      - Remove useless inner parentheses in regular expressions
>>      - Rename I2C nodes to just... i2c
>>      - Remove node handles
>>=20
>>      Note:
>>      I set Liam Girdwood and Mark Brown as the maintainers by=20
>> default, since
>>      it doesn't appear that anybody is managing the Active-semi=20
>> drivers, but
>>      if anybody steps up I can update it.
>=20
> It should not be Liam and Mark, but someone having/knowing this
> particular hardware.

Well, who would that be?

I do have a board with the ACT8600, but that's about it.

-Paul

>>=20
>>   .../bindings/regulator/act8865-regulator.txt  | 117 --------
>>   .../bindings/regulator/act8945a-regulator.txt | 113 --------
>>   .../regulator/active-semi,act8600.yaml        | 141 ++++++++++
>>   .../regulator/active-semi,act8846.yaml        | 207 ++++++++++++++
>>   .../regulator/active-semi,act8865.yaml        | 162 +++++++++++
>>   .../regulator/active-semi,act8945a.yaml       | 261=20
>> ++++++++++++++++++
>>   6 files changed, 771 insertions(+), 230 deletions(-)
>>   delete mode 100644=20
>> Documentation/devicetree/bindings/regulator/act8865-regulator.txt
>>   delete mode 100644=20
>> Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>>   create mode 100644=20
>> Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
>>   create mode 100644=20
>> Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
>>   create mode 100644=20
>> Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml
>>   create mode 100644=20
>> Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt=20
>> b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
>>  deleted file mode 100644
>>  index b9f58e480349..000000000000
>>  ---=20
>> a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
>>  +++ /dev/null
>>  @@ -1,117 +0,0 @@
>>  -ACT88xx regulators
>>  --------------------
>>  -
>>  -Required properties:
>>  -- compatible: "active-semi,act8846" or "active-semi,act8865" or=20
>> "active-semi,act8600"
>>  -- reg: I2C slave address
>>  -
>>  -Optional properties:
>>  -- system-power-controller: Telling whether or not this pmic is=20
>> controlling
>>  -  the system power. See=20
>> Documentation/devicetree/bindings/power/power-controller.txt .
>>  -- active-semi,vsel-high: Indicates the VSEL pin is high.
>>  -  If this property is missing, assume the VSEL pin is low(0).
>>  -
>>  -Optional input supply properties:
>>  -- for act8600:
>>  -  - vp1-supply: The input supply for DCDC_REG1
>>  -  - vp2-supply: The input supply for DCDC_REG2
>>  -  - vp3-supply: The input supply for DCDC_REG3
>>  -  - inl-supply: The input supply for LDO_REG5, LDO_REG6, LDO_REG7=20
>> and LDO_REG8
>>  -  SUDCDC_REG4, LDO_REG9 and LDO_REG10 do not have separate=20
>> supplies.
>>  -- for act8846:
>>  -  - vp1-supply: The input supply for REG1
>>  -  - vp2-supply: The input supply for REG2
>>  -  - vp3-supply: The input supply for REG3
>>  -  - vp4-supply: The input supply for REG4
>>  -  - inl1-supply: The input supply for REG5, REG6 and REG7
>>  -  - inl2-supply: The input supply for REG8 and LDO_REG9
>>  -  - inl3-supply: The input supply for REG10, REG11 and REG12
>>  -- for act8865:
>>  -  - vp1-supply: The input supply for DCDC_REG1
>>  -  - vp2-supply: The input supply for DCDC_REG2
>>  -  - vp3-supply: The input supply for DCDC_REG3
>>  -  - inl45-supply: The input supply for LDO_REG1 and LDO_REG2
>>  -  - inl67-supply: The input supply for LDO_REG3 and LDO_REG4
>>  -
>>  -Any standard regulator properties can be used to configure the=20
>> single regulator.
>>  -regulator-initial-mode, regulator-allowed-modes and regulator-mode=20
>> could be specified
>>  -for act8865 using mode values from=20
>> dt-bindings/regulator/active-semi,8865-regulator.h
>>  -file.
>>  -
>>  -The valid names for regulators are:
>>  -	- for act8846:
>>  -	REG1, REG2, REG3, REG4, REG5, REG6, REG7, REG8, REG9, REG10,=20
>> REG11, REG12
>>  -	- for act8865:
>>  -	DCDC_REG1, DCDC_REG2, DCDC_REG3, LDO_REG1, LDO_REG2, LDO_REG3,=20
>> LDO_REG4.
>>  -	- for act8600:
>>  -	DCDC_REG1, DCDC_REG2, DCDC_REG3, SUDCDC_REG4, LDO_REG5, LDO_REG6,=20
>> LDO_REG7,
>>  -	LDO_REG8, LDO_REG9, LDO_REG10,
>>  -
>>  -Example:
>>  ---------
>>  -
>>  -#include <dt-bindings/regulator/active-semi,8865-regulator.h>
>>  -
>>  -		i2c1: i2c@f0018000 {
>>  -			pmic: act8865@5b {
>>  -				compatible =3D "active-semi,act8865";
>>  -				reg =3D <0x5b>;
>>  -				active-semi,vsel-high;
>>  -
>>  -				regulators {
>>  -					vcc_1v8_reg: DCDC_REG1 {
>>  -						regulator-name =3D "VCC_1V8";
>>  -						regulator-min-microvolt =3D <1800000>;
>>  -						regulator-max-microvolt =3D <1800000>;
>>  -						regulator-always-on;
>>  -					};
>>  -
>>  -					vcc_1v2_reg: DCDC_REG2 {
>>  -						regulator-name =3D "VCC_1V2";
>>  -						regulator-min-microvolt =3D <1100000>;
>>  -						regulator-max-microvolt =3D <1300000>;
>>  -						regulator-always-on;
>>  -
>>  -						regulator-allowed-modes =3D <ACT8865_REGULATOR_MODE_FIXED>,
>>  -									  <ACT8865_REGULATOR_MODE_LOWPOWER>;
>>  -						regulator-initial-mode =3D <ACT8865_REGULATOR_MODE_FIXED>;
>>  -
>>  -						regulator-state-mem {
>>  -							regulator-on-in-suspend;
>>  -							regulator-suspend-min-microvolt =3D <1150000>;
>>  -							regulator-suspend-max-microvolt =3D <1150000>;
>>  -							regulator-changeable-in-suspend;
>>  -							regulator-mode =3D <ACT8865_REGULATOR_MODE_LOWPOWER>;
>>  -						};
>>  -					};
>>  -
>>  -					vcc_3v3_reg: DCDC_REG3 {
>>  -						regulator-name =3D "VCC_3V3";
>>  -						regulator-min-microvolt =3D <3300000>;
>>  -						regulator-max-microvolt =3D <3300000>;
>>  -						regulator-always-on;
>>  -					};
>>  -
>>  -					vddana_reg: LDO_REG1 {
>>  -						regulator-name =3D "VDDANA";
>>  -						regulator-min-microvolt =3D <3300000>;
>>  -						regulator-max-microvolt =3D <3300000>;
>>  -						regulator-always-on;
>>  -
>>  -						regulator-allowed-modes =3D <ACT8865_REGULATOR_MODE_NORMAL>,
>>  -									  <ACT8865_REGULATOR_MODE_LOWPOWER>;
>>  -						regulator-initial-mode =3D <ACT8865_REGULATOR_MODE_NORMAL>;
>>  -
>>  -						regulator-state-mem {
>>  -							regulator-off-in-suspend;
>>  -						};
>>  -					};
>>  -
>>  -					vddfuse_reg: LDO_REG2 {
>>  -						regulator-name =3D "FUSE_2V5";
>>  -						regulator-min-microvolt =3D <2500000>;
>>  -						regulator-max-microvolt =3D <2500000>;
>>  -					};
>>  -				};
>>  -			};
>>  -		};
>>  diff --git=20
>> a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt=20
>> b/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>>  deleted file mode 100644
>>  index 4017527619ab..000000000000
>>  ---=20
>> a/Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
>>  +++ /dev/null
>>  @@ -1,113 +0,0 @@
>>  -Device-Tree bindings for regulators of Active-semi ACT8945A=20
>> Multi-Function Device
>>  -
>>  -Required properties:
>>  - - compatible: "active-semi,act8945a", please refer to=20
>> ../mfd/act8945a.txt.
>>  -
>>  -Optional properties:
>>  -- active-semi,vsel-high: Indicates if the VSEL pin is set to=20
>> logic-high.
>>  -  If this property is missing, assume the VSEL pin is set to=20
>> logic-low.
>>  -
>>  -Optional input supply properties:
>>  -  - vp1-supply: The input supply for REG_DCDC1
>>  -  - vp2-supply: The input supply for REG_DCDC2
>>  -  - vp3-supply: The input supply for REG_DCDC3
>>  -  - inl45-supply: The input supply for REG_LDO1 and REG_LDO2
>>  -  - inl67-supply: The input supply for REG_LDO3 and REG_LDO4
>>  -
>>  -Any standard regulator properties can be used to configure the=20
>> single regulator.
>>  -regulator-initial-mode, regulator-allowed-modes and regulator-mode=20
>> could be
>>  -specified using mode values from=20
>> dt-bindings/regulator/active-semi,8945a-regulator.h
>>  -file.
>>  -
>>  -The valid names for regulators are:
>>  -	REG_DCDC1, REG_DCDC2, REG_DCDC3, REG_LDO1, REG_LDO2, REG_LDO3,=20
>> REG_LDO4.
>>  -
>>  -Example:
>>  -
>>  -#include <dt-bindings/regulator/active-semi,8945a-regulator.h>
>>  -
>>  -	pmic@5b {
>>  -		compatible =3D "active-semi,act8945a";
>>  -		reg =3D <0x5b>;
>>  -
>>  -		active-semi,vsel-high;
>>  -
>>  -		regulators {
>>  -			vdd_1v35_reg: REG_DCDC1 {
>>  -				regulator-name =3D "VDD_1V35";
>>  -				regulator-min-microvolt =3D <1350000>;
>>  -				regulator-max-microvolt =3D <1350000>;
>>  -				regulator-always-on;
>>  -
>>  -				regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_FIXED>,
>>  -							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
>>  -				regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_FIXED>;
>>  -
>>  -				regulator-state-mem {
>>  -					regulator-on-in-suspend;
>>  -					regulator-suspend-min-microvolt=3D<1400000>;
>>  -					regulator-suspend-max-microvolt=3D<1400000>;
>>  -					regulator-changeable-in-suspend;
>>  -					regulator-mode=3D<ACT8945A_REGULATOR_MODE_LOWPOWER>;
>>  -				};
>>  -			};
>>  -
>>  -			vdd_1v2_reg: REG_DCDC2 {
>>  -				regulator-name =3D "VDD_1V2";
>>  -				regulator-min-microvolt =3D <1100000>;
>>  -				regulator-max-microvolt =3D <1300000>;
>>  -				regulator-always-on;
>>  -
>>  -				regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_FIXED>,
>>  -							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
>>  -				regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_FIXED>;
>>  -
>>  -				regulator-state-mem {
>>  -					regulator-off-in-suspend;
>>  -				};
>>  -			};
>>  -
>>  -			vdd_3v3_reg: REG_DCDC3 {
>>  -				regulator-name =3D "VDD_3V3";
>>  -				regulator-min-microvolt =3D <3300000>;
>>  -				regulator-max-microvolt =3D <3300000>;
>>  -				regulator-always-on;
>>  -			};
>>  -
>>  -			vdd_fuse_reg: REG_LDO1 {
>>  -				regulator-name =3D "VDD_FUSE";
>>  -				regulator-min-microvolt =3D <2500000>;
>>  -				regulator-max-microvolt =3D <2500000>;
>>  -				regulator-always-on;
>>  -
>>  -				regulator-allowed-modes =3D <ACT8945A_REGULATOR_MODE_NORMAL>,
>>  -							  <ACT8945A_REGULATOR_MODE_LOWPOWER>;
>>  -				regulator-initial-mode =3D <ACT8945A_REGULATOR_MODE_NORMAL>;
>>  -
>>  -				regulator-state-mem {
>>  -					regulator-off-in-suspend;
>>  -				};
>>  -			};
>>  -
>>  -			vdd_3v3_lp_reg: REG_LDO2 {
>>  -				regulator-name =3D "VDD_3V3_LP";
>>  -				regulator-min-microvolt =3D <3300000>;
>>  -				regulator-max-microvolt =3D <3300000>;
>>  -				regulator-always-on;
>>  -			};
>>  -
>>  -			vdd_led_reg: REG_LDO3 {
>>  -				regulator-name =3D "VDD_LED";
>>  -				regulator-min-microvolt =3D <3300000>;
>>  -				regulator-max-microvolt =3D <3300000>;
>>  -				regulator-always-on;
>>  -			};
>>  -
>>  -			vdd_sdhc_1v8_reg: REG_LDO4 {
>>  -				regulator-name =3D "VDD_SDHC_1V8";
>>  -				regulator-min-microvolt =3D <1800000>;
>>  -				regulator-max-microvolt =3D <1800000>;
>>  -				regulator-always-on;
>>  -			};
>>  -		};
>>  -	};
>>  diff --git=20
>> a/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml=20
>> b/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
>>  new file mode 100644
>>  index 000000000000..ca0ac316dff2
>>  --- /dev/null
>>  +++=20
>> b/Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
>>  @@ -0,0 +1,141 @@
>>  +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>  +%YAML 1.2
>>  +---
>>  +$id:=20
>> http://devicetree.org/schemas/regulator/active-semi,act8600.yaml#
>>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>  +
>>  +title: Active-semi ACT8600 regulator
>>  +
>>  +maintainers:
>>  +  - Liam Girdwood <lgirdwood@gmail.com>
>>  +  - Mark Brown <broonie@kernel.org>
>>  +
>>  +properties:
>>  +  compatible:
>>  +    const: active-semi,act8600
>>  +
>>  +  reg:
>>  +    description: I2C address
>=20
> Drop description, it's obvious. The same in other files.
>=20
>>  +    maxItems: 1
>>  +
>>  +  system-power-controller:
>>  +    description:
>>  +      Indicates that the ACT8600 is responsible for powering OFF
>>  +      the system.
>>  +    type: boolean
>>  +
>=20
> (...)
>=20
>>  +examples:
>>  +  - |
>>  +    #include <dt-bindings/regulator/active-semi,8865-regulator.h>
>>  +
>>  +    i2c1 {
>>  +      #address-cells =3D <1>;
>>  +      #size-cells =3D <0>;
>>  +
>>  +      pmic: act8865@5b {
>>  +        compatible =3D "active-semi,act8865";
>>  +        reg =3D <0x5b>;
>>  +        active-semi,vsel-high;
>>  +
>>  +        regulators {
>>  +          vcc_1v8_reg: DCDC_REG1 {
>>  +            regulator-name =3D "VCC_1V8";
>>  +            regulator-min-microvolt =3D <1800000>;
>>  +            regulator-max-microvolt =3D <1800000>;
>>  +            regulator-always-on;
>>  +          };
>>  +
>>  +          vcc_1v2_reg: DCDC_REG2 {
>>  +            regulator-name =3D "VCC_1V2";
>>  +            regulator-min-microvolt =3D <1100000>;
>>  +            regulator-max-microvolt =3D <1300000>;
>>  +            regulator-always-on;
>>  +
>>  +            regulator-allowed-modes =3D=20
>> <ACT8865_REGULATOR_MODE_FIXED>,
>>  +                                     =20
>> <ACT8865_REGULATOR_MODE_LOWPOWER>;
>>  +            regulator-initial-mode =3D=20
>> <ACT8865_REGULATOR_MODE_FIXED>;
>>  +
>>  +            regulator-state-mem {
>>  +              regulator-on-in-suspend;
>>  +              regulator-suspend-min-microvolt =3D <1150000>;
>>  +              regulator-suspend-max-microvolt =3D <1150000>;
>>  +              regulator-changeable-in-suspend;
>>  +              regulator-mode =3D <ACT8865_REGULATOR_MODE_LOWPOWER>;
>>  +            };
>>  +          };
>>  +
>>  +          vcc_3v3_reg: DCDC_REG3 {
>>  +            regulator-name =3D "VCC_3V3";
>>  +            regulator-min-microvolt =3D <3300000>;
>>  +            regulator-max-microvolt =3D <3300000>;
>>  +            regulator-always-on;
>>  +          };
>>  +
>>  +          vddana_reg: LDO_REG1 {
>>  +            regulator-name =3D "VDDANA";
>>  +            regulator-min-microvolt =3D <3300000>;
>>  +            regulator-max-microvolt =3D <3300000>;
>>  +            regulator-always-on;
>>  +
>>  +            regulator-allowed-modes =3D=20
>> <ACT8865_REGULATOR_MODE_NORMAL>,
>>  +            <ACT8865_REGULATOR_MODE_LOWPOWER>;
>=20
> Align it with previous <.
>=20
>>  +            regulator-initial-mode =3D=20
>> <ACT8865_REGULATOR_MODE_NORMAL>;
>=20
>=20
> (...)
>=20
>>  +
>>  +        charger {
>>  +          compatible =3D "active-semi,act8945a-charger";
>>  +          pinctrl-names =3D "default";
>>  +          pinctrl-0 =3D <&pinctrl_charger_chglev=20
>> &pinctrl_charger_lbo &pinctrl_charger_irq>;
>>  +          interrupt-parent =3D <&pioA>;
>>  +          interrupts =3D <45 IRQ_TYPE_EDGE_RISING>;
>>  +
>>  +          active-semi,chglev-gpios =3D <&pioA 12 GPIO_ACTIVE_HIGH>;
>>  +          active-semi,lbo-gpios =3D <&pioA 72 GPIO_ACTIVE_LOW>;
>>  +          active-semi,input-voltage-threshold-microvolt =3D <6600>;
>>  +          active-semi,precondition-timeout =3D <40>;
>>  +          active-semi,total-timeout =3D <3>;
>>  +          status =3D "okay";
>=20
> Drop status
>=20
>>  +        };
>>  +      };
>>  +    };
>=20
> Best regards,
> Krzysztof
>=20


