Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0861A6DAFC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjDGPev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjDGPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:34:41 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A06A5D5;
        Fri,  7 Apr 2023 08:34:38 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C6B64100006;
        Fri,  7 Apr 2023 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680881677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D2Wdjko2vA/SMrvlsYQ/Ry1S7hpAQ7U5YkaaIz6cUuc=;
        b=fn8h7+IEzDznrfjQOvUfEH16tLHE9gDE8fxoXz2qEfjZcdJcLzzNQtX0KNawvdyA7OpZEQ
        wcl7V3ZEEbmmXtyyFNe7iO1Kvw5ix9GNripEeat05KnY1zROw1AQmIRKQviN7coVHxwqCQ
        jPp/3KqmnDj9UgirLMAYaZau67njqRFkzVHScdVbCFmtxk7QyU9lcCa5+ufXpy0JtcPks8
        0p5X8petEfVMk7ZHnrk2Qxi1lb6hHXVRQH1ps6EXgBccVqPe3UmNiZ2d6BMc8dHChytCl1
        Pqgbxty4EAfzXmkB32l+fWwnxKHbPgkuhtXE3ee405BYbevPgVAK0cZ4mY0KgA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 2/2] ARM: dts: mvebu: add device tree for IIJ SA-W2
 appliance
In-Reply-To: <7d4a218d-8b8a-5a1d-eff8-e154bfde69be@gmail.com>
References: <20230223132502.2045-1-musashino.open@gmail.com>
 <20230223132502.2045-2-musashino.open@gmail.com>
 <Y/d7gjqQCKKXMHqj@lunn.ch>
 <7d4a218d-8b8a-5a1d-eff8-e154bfde69be@gmail.com>
Date:   Fri, 07 Apr 2023 17:34:34 +0200
Message-ID: <87jzyn3dv9.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello INAGAKI Hiroshi,

do you plan to send a v2 soon based on the reviews you got ?

Or if you already sent it, I missed it, in this case could you resend it
with me in CC ?

Thanks,

Gregory

> Hi Andrew,
>
> thank you for your reviews and detailed descriptions.
>
> On 2023/02/23 23:43, Andrew Lunn wrote:
>>> +		pcie {
>>> +			status = "okay";
>>> +
>>> +			pcie@1,0 {
>>> +				status = "okay";
>>> +
>>> +				/* Atheros AR9287 */
>>> +				wifi@0,0 {
>>> +					compatible = "pci168c,002e";
>>> +					reg = <0000 0 0 0 0>;
>>> +				};
>>> +			};
>>> +
>>> +			pcie@3,0 {
>>> +				status = "okay";
>>> +
>>> +				/* Qualcomm Atheros QCA9880 */
>>> +				wifi@0,0 {
>>> +					compatible = "qcom,ath10k";
>>> +					reg = <0000 0 0 0 0>;
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>> These are not wrong, but they are also not needed. PCI devices should
>> be discovered by enumeration, and you don't have any additional
>> properties here, or phandles pointing to these nodes.
>>
>> I assume these are COTS wifi modules? By listing them here you are
>> restricting some flexibility. The OEM could for example swap the
>> modules around, and Linux would not care, but the DT would then be
>> wrong. Or you could have a device with a different module because it
>> is cheaper, and again, Linux would not care, but the DT would be
>> wrong.
>
> Got it. SA-W2 is not designed to allow users to swap cards under 
> normal use, but certainly things like you said can happen...
> I'll remove "wifi" nodes.
>
>  > I assume these are COTS wifi modules?
>
> Yes, those are the modules manufactured by Silex Technology, Inc. [1][2].
>
> [1]: https://www.silex.jp/products/wireless-module/sxpcegn.html
> [2]: https://www.silex.jp/products/wireless-module/sxpceac.html
>
>>
>>> +&usb0 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&pmx_usb_pins>;
>>> +	status = "okay";
>>> +	#address-cells = <1>;
>>> +	#size-cells = <0>;
>>> +
>>> +	/* SMSC USB2514B */
>>> +	hub@1 {
>>> +		compatible = "usb424,2514";
>>> +		reg = <1>;
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		hub_port1: port@1 {
>>> +			reg = <1>;
>>> +			#trigger-source-cells = <0>;
>>> +		};
>>> +
>>> +		hub_port2: port@2 {
>>> +			reg = <2>;
>>> +			#trigger-source-cells = <0>;
>>> +		};
>>> +	};
>>> +};
>> Same comment as PCI. However, it is likely that the USB hub is
>> actually on the board, not a module, so it is a lot less likely to
>> change.
>
> Yes, that USB hub is on the PCB and wired to the SoC directly. But 
> I'll keep it in mind...
>
>>
>> As i said, they are not wrong, so you don't need to remove them.
>>
>> 	Andrew
>>
>
> Regards,
> Hiroshi

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
