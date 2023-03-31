Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1875C6D1BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjCaJS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjCaJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:18:37 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709C19BA;
        Fri, 31 Mar 2023 02:18:34 -0700 (PDT)
Received: from [127.0.0.1] (144-178-202-138.static.ef-service.nl [144.178.202.138])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 803F5CC392;
        Fri, 31 Mar 2023 09:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1680254310; bh=NNum4T/G6VJ9cgvUWJ3xhPYUW9hku5cPIzHSMA/iY4Q=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=a3c2aCQkcSm3Xg+pI3kfTnoO+47F52Yu/ldPqA7cb2JkstP99JC1nPYN8AkYdOauN
         KywT+DULi3dnIiboZ2YEld6kdWoOFlud8v85Z5GhBsTC2F1LX4ePD4RM1Lzcm4hL/Q
         DH8BmQoprwUyYwXIuKrZOfoech1cJmk15kTpl6b4=
Date:   Fri, 31 Mar 2023 11:18:29 +0200
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Sakari Ailus <sakari.ailus@iki.fi>
CC:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/3] media: dt-bindings: ov2685: convert to dtschema
User-Agent: K-9 Mail for Android
In-Reply-To: <ZCacNEbg8cJo0VAm@valkosipuli.retiisi.eu>
References: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz> <20230129-ov2685-improvements-v4-2-e71985c5c848@z3ntu.xyz> <ZCacNEbg8cJo0VAm@valkosipuli.retiisi.eu>
Message-ID: <9AF47749-12CB-40D5-A300-170A35390CFD@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Sakari,

Sakari Ailus <sakari=2Eailus@iki=2Efi> schreef op 31 maart 2023 10:39:16 C=
EST:
>Hi Luca,
>
>Thanks for the patch=2E
>
>On Thu, Mar 23, 2023 at 06:57:50PM +0100, Luca Weiss wrote:
>> Convert the text-based dt-bindings to yaml=2E
>>=20
>> Changes from original txt:
>> * Take wording for various properties from other yaml bindings, this
>>   removes e=2Eg=2E volt amount from schema since it isn't really releva=
nt
>>   and the datasheet is a better source=2E
>> * Don't make reset-gpios a required property since it can be tied to
>>   DOVDD instead=2E
>>=20
>> Reviewed-by: Krzysztof Kozlowski <krzysztof=2Ekozlowski@linaro=2Eorg>
>> Signed-off-by: Luca Weiss <luca@z3ntu=2Exyz>
>> ---
>>  =2E=2E=2E/devicetree/bindings/media/i2c/ov2685=2Etxt       |  41 -----=
----
>>  =2E=2E=2E/devicetree/bindings/media/i2c/ovti,ov2685=2Eyaml | 101 +++++=
++++++++++++++++
>>  MAINTAINERS                                        |   1 +
>>  3 files changed, 102 insertions(+), 41 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/media/i2c/ov2685=2Etxt b=
/Documentation/devicetree/bindings/media/i2c/ov2685=2Etxt
>> deleted file mode 100644
>> index 625c4a8c0d53d=2E=2E0000000000000
>> --- a/Documentation/devicetree/bindings/media/i2c/ov2685=2Etxt
>> +++ /dev/null
>> @@ -1,41 +0,0 @@
>> -* Omnivision OV2685 MIPI CSI-2 sensor
>> -
>> -Required Properties:
>> -- compatible: shall be "ovti,ov2685"
>> -- clocks: reference to the xvclk input clock
>> -- clock-names: shall be "xvclk"
>> -- avdd-supply: Analog voltage supply, 2=2E8 volts
>> -- dovdd-supply: Digital I/O voltage supply, 1=2E8 volts
>> -- dvdd-supply: Digital core voltage supply, 1=2E8 volts
>> -- reset-gpios: Low active reset gpio
>> -
>> -The device node shall contain one 'port' child node with an
>> -'endpoint' subnode for its digital output video port,
>> -in accordance with the video interface bindings defined in
>> -Documentation/devicetree/bindings/media/video-interfaces=2Etxt=2E
>> -The endpoint optional property 'data-lanes' shall be "<1>"=2E
>> -
>> -Example:
>> -&i2c7 {
>> -	ov2685: camera-sensor@3c {
>> -		compatible =3D "ovti,ov2685";
>> -		reg =3D <0x3c>;
>> -		pinctrl-names =3D "default";
>> -		pinctrl-0 =3D <&clk_24m_cam>;
>> -
>> -		clocks =3D <&cru SCLK_TESTCLKOUT1>;
>> -		clock-names =3D "xvclk";
>> -
>> -		avdd-supply =3D <&pp2800_cam>;
>> -		dovdd-supply =3D <&pp1800>;
>> -		dvdd-supply =3D <&pp1800>;
>> -		reset-gpios =3D <&gpio2 3 GPIO_ACTIVE_LOW>;
>> -
>> -		port {
>> -			ucam_out: endpoint {
>> -				remote-endpoint =3D <&mipi_in_ucam>;
>> -				data-lanes =3D <1>;
>> -			};
>> -		};
>> -	};
>> -};
>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov2685=2E=
yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov2685=2Eyaml
>> new file mode 100644
>> index 0000000000000=2E=2E2ac0ca8a0413b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov2685=2Eyaml
>> @@ -0,0 +1,101 @@
>> +# SPDX-License-Identifier: (GPL-2=2E0 OR BSD-2-Clause)
>> +%YAML 1=2E2
>> +---
>> +$id: http://devicetree=2Eorg/schemas/media/i2c/ovti,ov2685=2Eyaml#
>> +$schema: http://devicetree=2Eorg/meta-schemas/core=2Eyaml#
>> +
>> +title: OmniVision OV2685 Image Sensor
>> +
>> +maintainers:
>> +  - Shunqian Zheng <zhengsq@rock-chips=2Ecom>
>> +
>> +properties:
>> +  compatible:
>> +    const: ovti,ov2685
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: XVCLK clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xvclk
>> +
>> +  dvdd-supply:
>> +    description: Digital Domain Power Supply
>> +
>> +  avdd-supply:
>> +    description: Analog Domain Power Supply
>> +
>> +  dovdd-supply:
>> +    description: I/O Domain Power Supply
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description: Reset Pin GPIO Control (active low)
>> +
>> +  port:
>> +    description: MIPI CSI-2 transmitter port
>> +    $ref: /schemas/graph=2Eyaml#/$defs/port-base
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      endpoint:
>> +        $ref: /schemas/media/video-interfaces=2Eyaml#
>> +        unevaluatedProperties: false
>> +
>> +        properties:
>> +          data-lanes:
>> +            maxItems: 1
>
>This should be 2 --- the sensor supports two lanes (even if the driver
>doesn't)=2E

Right, for some reason the product brief mentions that it features "a sing=
le-lane MIPI interface" but the datasheet I have writes that it has a 2-lan=
e MIPI serial output, so I guess it does support two lanes?

>
>I can address this when applying if that's ok=2E

That would be nice, thanks!

Regards
Luca

>
>> +
>> +        required:
>> +          - data-lanes
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - dvdd-supply
>> +  - avdd-supply
>> +  - dovdd-supply
>> +  - port
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rk3399-cru=2Eh>
>> +    #include <dt-bindings/gpio/gpio=2Eh>
>> +
>> +    i2c {
>> +        #address-cells =3D <1>;
>> +        #size-cells =3D <0>;
>> +
>> +        ov2685: camera-sensor@3c {
>> +            compatible =3D "ovti,ov2685";
>> +            reg =3D <0x3c>;
>> +            pinctrl-names =3D "default";
>> +            pinctrl-0 =3D <&clk_24m_cam>;
>> +
>> +            clocks =3D <&cru SCLK_TESTCLKOUT1>;
>> +            clock-names =3D "xvclk";
>> +
>> +            avdd-supply =3D <&pp2800_cam>;
>> +            dovdd-supply =3D <&pp1800>;
>> +            dvdd-supply =3D <&pp1800>;
>> +            reset-gpios =3D <&gpio2 3 GPIO_ACTIVE_LOW>;
>> +
>> +            port {
>> +                ucam_out: endpoint {
>> +                    remote-endpoint =3D <&mipi_in_ucam>;
>> +                    data-lanes =3D <1>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +
>> +=2E=2E=2E
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8ea325040f355=2E=2E5904f47756fe1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15410,6 +15410,7 @@ M:	Shunqian Zheng <zhengsq@rock-chips=2Ecom>
>>  L:	linux-media@vger=2Ekernel=2Eorg
>>  S:	Maintained
>>  T:	git git://linuxtv=2Eorg/media_tree=2Egit
>> +F:	Documentation/devicetree/bindings/media/i2c/ovti,ov2685=2Eyaml
>>  F:	drivers/media/i2c/ov2685=2Ec
>> =20
>>  OMNIVISION OV2740 SENSOR DRIVER
>>=20
>
