Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C86474DED1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjGJUIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjGJUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:08:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBAB198;
        Mon, 10 Jul 2023 13:07:54 -0700 (PDT)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E7B66DA7;
        Mon, 10 Jul 2023 22:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689019622;
        bh=b6g3oIdEKQxnDikMS0wynyZDArLACBjT5ZIcmeg3v9w=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=U0tAI4vNt8LCiXM14focRttedaed7oUBa8A2iflHlEr9m+EGa98Fb6O48OKzLmi/5
         R7gmg0wgEOS5d2NKXe7a6ZJhxHnzj6L3suk9UwHyJKL1Mv9MkVrtRsw6j9gGUrop0U
         0BsRYBSaLrIN6VyZkdqzfaarHdfIbAntMYCPEUnc=
Message-ID: <018f882a-1dc0-c18e-b582-d6616668c720@ideasonboard.com>
Date:   Mon, 10 Jul 2023 21:07:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To:     Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Helen Koike <helen.koike@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230707210604.868002-1-robh@kernel.org>
 <20230710-unsold-simplify-5a339036ff38@spud>
 <CAL_JsqJOW7kxC4m8tCmNrD6pq5y73BjV236nb+ZHAhR4rDrNvw@mail.gmail.com>
Content-Language: en-US
From:   Dan Scally <dan.scally@ideasonboard.com>
Subject: Re: [PATCH] media: dt-bindings: Merge OV5695 into OV5693 binding
In-Reply-To: <CAL_JsqJOW7kxC4m8tCmNrD6pq5y73BjV236nb+ZHAhR4rDrNvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello both

On 10/07/2023 18:57, Rob Herring wrote:
> On Mon, Jul 10, 2023 at 11:45 AM Conor Dooley <conor@kernel.org> wrote:
>> On Fri, Jul 07, 2023 at 03:06:04PM -0600, Rob Herring wrote:
>>> The OV5695 binding is almost the same as the OV5693 binding. The only
>>> difference is 'clock-names' is defined for OV5695. However, the lack of
>>> clock-names is an omission as the Linux OV5693 driver expects the same
>>> 'xvclk' clock name.
>>>
>>> 'link-frequencies' is required by OV5693, but not OV5695. Just drop it
>>> from being required. Expressing it conditionally would be ugly. It
>>> shouldn't really be required either as the driver only supports 1
>>> frequency anyways.
>> I suppose the intent here is something like "the driver only supports 1
>> frequency and never bothers to read the property"?
> It does read it and fails if it doesn't match. I don't really think
> the driver should if there is only 1 freq. I don't know if it's that
> the hw only supports 1 frequency or a driver limitation. If the h/w,
> then the property is pointless.


It's a driver limitation. If someone needed to run a different link frequency they could add 
settings to the driver to configure the PLLs differently.

>
>
>> Either way,
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Cheers,
>> Conor.
>>
>>> The rockchip-isp1 binding example is missing required properties, so it
>>> has to be updated as well.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   .../devicetree/bindings/media/i2c/ov5695.txt  | 41 -------------------
>>>   .../bindings/media/i2c/ovti,ov5693.yaml       | 19 +++++----
>>>   .../bindings/media/rockchip-isp1.yaml         |  1 +
>>>   3 files changed, 13 insertions(+), 48 deletions(-)
>>>   delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5695.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/i2c/ov5695.txt b/Documentation/devicetree/bindings/media/i2c/ov5695.txt
>>> deleted file mode 100644
>>> index 640a63717d96..000000000000
>>> --- a/Documentation/devicetree/bindings/media/i2c/ov5695.txt
>>> +++ /dev/null
>>> @@ -1,41 +0,0 @@
>>> -* Omnivision OV5695 MIPI CSI-2 sensor
>>> -
>>> -Required Properties:
>>> -- compatible: shall be "ovti,ov5695"
>>> -- clocks: reference to the xvclk input clock
>>> -- clock-names: shall be "xvclk"
>>> -- avdd-supply: Analog voltage supply, 2.8 volts
>>> -- dovdd-supply: Digital I/O voltage supply, 1.8 volts
>>> -- dvdd-supply: Digital core voltage supply, 1.2 volts
>>> -- reset-gpios: Low active reset gpio
>>> -
>>> -The device node shall contain one 'port' child node with an
>>> -'endpoint' subnode for its digital output video port,
>>> -in accordance with the video interface bindings defined in
>>> -Documentation/devicetree/bindings/media/video-interfaces.txt.
>>> -The endpoint optional property 'data-lanes' shall be "<1 2>".
>>> -
>>> -Example:
>>> -&i2c7 {
>>> -     ov5695: camera-sensor@36 {
>>> -             compatible = "ovti,ov5695";
>>> -             reg = <0x36>;
>>> -             pinctrl-names = "default";
>>> -             pinctrl-0 = <&clk_24m_cam>;
>>> -
>>> -             clocks = <&cru SCLK_TESTCLKOUT1>;
>>> -             clock-names = "xvclk";
>>> -
>>> -             avdd-supply = <&pp2800_cam>;
>>> -             dovdd-supply = <&pp1800>;
>>> -             dvdd-supply = <&pp1250_cam>;
>>> -             reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
>>> -
>>> -             port {
>>> -                     wcam_out: endpoint {
>>> -                             remote-endpoint = <&mipi_in_wcam>;
>>> -                             data-lanes = <1 2>;
>>> -                     };
>>> -             };
>>> -     };
>>> -};
>>> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
>>> index 359dc08440a8..a3d73a87d797 100644
>>> --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
>>> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
>>> @@ -5,26 +5,29 @@
>>>   $id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
>>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>
>>> -title: Omnivision OV5693 CMOS Sensor
>>> +title: Omnivision OV5693/OV5695 CMOS Sensors
>>>
>>>   maintainers:
>>>     - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
>>>
>>>   description: |
>>> -  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
>>> -  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
>>> +  The Omnivision OV5693/OV5695 are high performance, 1/4-inch, 5 megapixel, CMOS
>>> +  image sensors that deliver 2592x1944 at 30fps. It provides full-frame,
>>>     sub-sampled, and windowed 10-bit MIPI images in various formats via the
>>>     Serial Camera Control Bus (SCCB) interface.
>>>
>>> -  OV5693 is controlled via I2C and two-wire Serial Camera Control Bus (SCCB).
>>> -  The sensor output is available via CSI-2 serial data output (up to 2-lane).
>>> +  OV5693/OV5695 are controlled via I2C and two-wire Serial Camera Control Bus
>>> +  (SCCB). The sensor output is available via CSI-2 serial data output (up to
>>> +  2-lane).
>>>
>>>   allOf:
>>>     - $ref: /schemas/media/video-interface-devices.yaml#
>>>
>>>   properties:
>>>     compatible:
>>> -    const: ovti,ov5693
>>> +    enum:
>>> +      - ovti,ov5693
>>> +      - ovti,ov5695
>>>
>>>     reg:
>>>       maxItems: 1
>>> @@ -34,6 +37,9 @@ properties:
>>>         System input clock (aka XVCLK). From 6 to 27 MHz.
>>>       maxItems: 1
>>>
>>> +  clock-names:
>>> +    const: xvclk
>>> +
>>>     dovdd-supply:
>>>       description:
>>>         Digital I/O voltage supply, 1.8V.
>>> @@ -72,7 +78,6 @@ properties:
>>>
>>>           required:
>>>             - data-lanes
>>> -          - link-frequencies
>>>
>>>   required:
>>>     - compatible
>>> diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
>>> index 0bad7e640148..e466dff8286d 100644
>>> --- a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
>>> +++ b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
>>> @@ -199,6 +199,7 @@ examples:
>>>               wcam: camera@36 {
>>>                   compatible = "ovti,ov5695";
>>>                   reg = <0x36>;
>>> +                clocks = <&cru SCLK_TESTCLKOUT1>;
>>>
>>>                   port {
>>>                       wcam_out: endpoint {
>>> --
>>> 2.40.1
>>>
