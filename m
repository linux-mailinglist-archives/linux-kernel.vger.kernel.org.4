Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DCB675B40
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjATRZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjATRZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:25:50 -0500
Received: from out-99.mta0.migadu.com (out-99.mta0.migadu.com [IPv6:2001:41d0:1004:224b::63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D352A839D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:25:48 -0800 (PST)
Message-ID: <d0c1a4a6-b6b3-846c-e0c3-849e59ed732d@ansari.sh>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674235546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIAmzFt7Ixq5beVbwBrKV3kz9OMeEkNUhyaVCEyiNzk=;
        b=HBn4/zEb87oRD6JM0x5tAyRqwZxTWK+CQlnXlJmNEv0/MZETK76uDEJS9aIJJQolwbkdCs
        Vp84jzg2WE4kv+xRmXv1hbRFhP5RWbn+PEo1osQvwzBbPEztphSvr6yBj6DXrw5Bg8w8pz
        5tIbVhaLmYwwmGhGBMN8et4liu+nL+s=
Date:   Fri, 20 Jan 2023 17:25:45 +0000
MIME-Version: 1.0
Subject: Re: [RFC PATCH] drm/simpledrm: Allow physical width and height
 configuration via DT
Content-Language: en-US
To:     Janne Grunau <janne@jannau.net>
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230118184817.608551-1-rayyan@ansari.sh>
 <20230119100104.GE3576@jannau.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rayyan Ansari <rayyan@ansari.sh>
In-Reply-To: <20230119100104.GE3576@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 10:01, Janne Grunau wrote:
> Hej,
> 
> adding devicetree@vger.kernel.org and asahi@lists.linux.dev to cc:, the
> former for the obvious devictree/bindings related questions,
> asahi for the prospect of supporting high DPI displays during early boot
> and in u-boot.
> 
> On 2023-01-18 18:48:17 +0000, Rayyan Ansari wrote:
>> Hello,
>> The following draft patch adds support for configuring the
>> height-mm and width-mm DRM properties in the simpledrm driver
>> via devicetree.
>> This is useful to get proper scaling in UIs such as Phosh.
>> An example of using this property is this, taken from my local tree:
>>
>> 		framebuffer0: framebuffer@3200000 {
>> 			compatible = "simple-framebuffer";
>> 			reg = <0x3200000 0x800000>;
>> 			format = "a8r8g8b8";
>> 			width = <720>;
>> 			height = <1280>;
>> 			stride = <(720 * 4)>;
>> 			width-mm = /bits/ 16 <58>;
>> 			height-mm = /bits/ 16 <103>;
>>
>> 			clocks = <&mmcc MDSS_AHB_CLK>,
>> 				 <&mmcc MDSS_AXI_CLK>,
>> 				 <&mmcc MDSS_BYTE0_CLK>,
>> 				 <&mmcc MDSS_MDP_CLK>,
>> 				 <&mmcc MDSS_PCLK0_CLK>,
>> 				 <&mmcc MDSS_VSYNC_CLK>;
>> 			power-domains = <&mmcc MDSS_GDSC>;
>> 		};
>>
>> I have tested this on my Lumia 735, and it does indeed
>> allow Phosh to scale correctly on the screen.
>>
>> However, I would like to get some feedback before I write the
>> documentation.
>> - What data type should be used?
>> 	The width_mm and height_mm properties of the drm_display_mode
>> 	struct are defined as u16. I have also made the devicetree
>> 	properties as the u16 type, but this requires specifying
>> 	"/bits/ 16" before the value. Should u32 be used instead to get
>> 	rid of this? If so, how could the conversion from u32->u16 be
>> 	handled?
> 
> u32 is the appropriate type. The device tree describes the hardware and
> not the data types used in a "random" linux driver/subsystem. 65m is
> probably enough for all practical purposes but u32 is the better choice.
> Documentation/devicetree/bindings/display/panel/panel-common.yaml
> already specifies "height-mm" and "width-mm" and all device tree files
> using this binding code the properties as u32.
> 

Okay, will change.

> We probably do not want add height and width properties to the
> simple-framebuffer node directly. At least for the static case I would
> expect that it duplicates information already present in a panel node.
> For that case parsing the panel dimensions via a phandle reference to
> that panel node would be preferred.

In my case, there is currently no panel driver. The interface I 
mentioned (Phosh) is running on the simpledrm driver.
Here is my Lumia running this interface:
https://wiki.postmarketos.org/images/c/c3/Lumia_735_Phosh.png

> 
> I'm not sure if it worth considering the dynamic case. The bootloader
> may be able to provide dimensions of HDMI, DP, ...  connected displays
> from the EDID. In that case "height-mm" and "width-mm" properties would
> make sense.
> 
> The existing panel drivers seem to ignore the u32 -> u16 conversion
> problem.
> 
>> - Style?
>> 	I have split the arguments to the DRM_MODE_INIT macro across
>> 	multiple lines to increase readability. I'm not sure if this
>> 	is the correct style though.
> 
> I think the code would be more readable if width_mm and height_mm would
> be calculated outside of DRM_MODE_INIT if they are zero.
> 
>> - Anything else?
>> 	This is my first time writing code for a Linux driver, so I
>> 	would be grateful if you have any suggestions for improvements.
> 
> Documentation/devicetree/bindings/display/simple-framebuffer.yaml needs
> to be updates to list and document the properties added to the node.
> 
>> ---
>>   drivers/gpu/drm/tiny/simpledrm.c | 49 +++++++++++++++++++++++++++-----
>>   1 file changed, 42 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
>> index 162eb44dcba8..92109f870b35 100644
>> --- a/drivers/gpu/drm/tiny/simpledrm.c
>> +++ b/drivers/gpu/drm/tiny/simpledrm.c
>> @@ -116,6 +116,15 @@ simplefb_get_format_pd(struct drm_device *dev,
>>   	return simplefb_get_validated_format(dev, pd->format);
>>   }
>>   
>> +static void
>> +simplefb_read_u16_of_optional(struct drm_device *dev, struct device_node *of_node,
>> +		     const char *name, u16 *value)
>> +{
>> +	int ret = of_property_read_u16(of_node, name, value);
>> +	if (ret)
>> +		value = 0;
>> +}
>> +
>>   static int
>>   simplefb_read_u32_of(struct drm_device *dev, struct device_node *of_node,
>>   		     const char *name, u32 *value)
>> @@ -184,6 +193,21 @@ simplefb_get_format_of(struct drm_device *dev, struct device_node *of_node)
>>   	return simplefb_get_validated_format(dev, format);
>>   }
>>   
>> +static u16
>> +simplefb_get_width_mm_of(struct drm_device *dev, struct device_node *of_node)
>> +{
>> +	u16 width_mm;
>> +	simplefb_read_u16_of_optional(dev, of_node, "width-mm", &width_mm);
>> +	return width_mm;
>> +}
>> +
>> +static u16
>> +simplefb_get_height_mm_of(struct drm_device *dev, struct device_node *of_node)
>> +{
>> +	u16 height_mm;
>> +	simplefb_read_u16_of_optional(dev, of_node, "height-mm", &height_mm);
>> +	return height_mm;
>> +}
> 
> I don't think it makes sense to have these two mostly identical wrapper
> functions. Please pass the name of the property as parameter. It could
> make sense to have a function to both height and width. I think we
> should ignore both height and width if one fails to parse or is 0.
> That could of course also be done in simpledrm_mode() for example like:
> 
> |	if (!width_mm || !height_mm) {
> |		width_mm = DRM_MODE_RES_MM(width, 96ul);
> |		height_mm = DRM_MODE_RES_MM(height, 96ul);
> |	}
> 

I based this on the way the pixel height and width is fetched from DT 
(simplefb_get_width_of and simplefb_get_height_of) but changing it to 
one function makes sense.

>>   /*
>>    * Simple Framebuffer device
>>    */
>> @@ -599,16 +623,24 @@ static const struct drm_mode_config_funcs simpledrm_mode_config_funcs = {
>>    */
>>   
>>   static struct drm_display_mode simpledrm_mode(unsigned int width,
>> -					      unsigned int height)
>> +					      unsigned int height,
>> +					      u16 width_mm,
>> +					      u16 height_mm)
>>   {
>>   	/*
>> -	 * Assume a monitor resolution of 96 dpi to
>> -	 * get a somewhat reasonable screen size.
>> +	 * Assume a monitor resolution of 96 dpi if physical
>> +	 * dimensions are not specified to get a somewhat reasonable
>> +	 * screen size.
>>   	 */
>> +
>>   	const struct drm_display_mode mode = {
>> -		DRM_MODE_INIT(60, width, height,
>> -			      DRM_MODE_RES_MM(width, 96ul),
>> -			      DRM_MODE_RES_MM(height, 96ul))
>> +		DRM_MODE_INIT(
>> +			60,
>> +			width,
>> +			height,
>> +			(width_mm ? width_mm : DRM_MODE_RES_MM(width, 96ul)),
>> +			(height_mm ? height_mm : DRM_MODE_RES_MM(height, 96ul))
>> +			)
>>   	};
>>   
>>   	return mode;
>> @@ -622,6 +654,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>   	struct simpledrm_device *sdev;
>>   	struct drm_device *dev;
>>   	int width, height, stride;
>> +	u16 width_mm, height_mm;
> 
> these need to be initialized to 0 otherwise they may end up used
> unitialized if pd is not NULL.
> 

Noted.

>>   	const struct drm_format_info *format;
>>   	struct resource *res, *mem;
>>   	void __iomem *screen_base;
>> @@ -676,6 +709,8 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>   		format = simplefb_get_format_of(dev, of_node);
>>   		if (IS_ERR(format))
>>   			return ERR_CAST(format);
>> +		width_mm = simplefb_get_width_mm_of(dev, of_node);
>> +		height_mm = simplefb_get_height_mm_of(dev, of_node);
>>   	} else {
>>   		drm_err(dev, "no simplefb configuration found\n");
>>   		return ERR_PTR(-ENODEV);
>> @@ -686,7 +721,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>   			return ERR_PTR(-EINVAL);
>>   	}
>>   
>> -	sdev->mode = simpledrm_mode(width, height);
>> +	sdev->mode = simpledrm_mode(width, height, width_mm, height_mm);
>>   	sdev->format = format;
>>   	sdev->pitch = stride;
> 
> Janne

Thanks for the feedback! I'll write the documentation and improve on the 
points mentioned to make this mainline-ready.

-- 
Rayyan Ansari
https://ansari.sh

