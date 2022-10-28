Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB116112E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJ1NfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiJ1Neu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:34:50 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8163E12AAE;
        Fri, 28 Oct 2022 06:34:41 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id A100D100635;
        Fri, 28 Oct 2022 13:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666964079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzFISnOJoxeZRNek4kJWueyVz+SxWc263Mc65Fe+C0k=;
        b=dmtU8EPwtQLf5a73mPMAmG02+P5UgUFSWCKWMng8FvxNEks4Kb6588A1MTDodk4404mVUb
        skCBCNy8tKeQB0VdwdL9tLIxxKtGrOKCy2gaRm1FqzqTjddxh1t0P1sZDxbvwu6i/qu/qO
        L2boYyviSzI09jdkAg85R1xN6bwTcO0=
Received: from webmail.hosting.de (unknown [134.0.26.148])
        by mxbox3.masterlogin.de (Postfix) with ESMTPA id 11A78360392;
        Fri, 28 Oct 2022 13:34:39 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 28 Oct 2022 15:34:38 +0200
From:   "Frank Wunderlich (linux)" <linux@fw-web.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC v2 7/7] arm64: dts: mt7986: add Bananapi R3
In-Reply-To: <64daf96b-b2b5-6f02-91aa-58d19083ee01@collabora.com>
References: <20221026093650.110290-1-linux@fw-web.de>
 <20221026093650.110290-8-linux@fw-web.de>
 <64daf96b-b2b5-6f02-91aa-58d19083ee01@collabora.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <022c1168b9ca2f6a3ca8a60a1379dee6@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 6f306042-60dc-4209-a341-0b506d1c4009
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

looked now on the keys and regulators comments...

Am 2022-10-28 11:19, schrieb AngeloGioacchino Del Regno:
> Il 26/10/22 11:36, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files.de>
>> +&mmc0 {
>> +	//sdcard
> 
> C-style comments please

i drop it completely if still using the way of an separate sd dts.

>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		factory-key {
> 
> I'd say that this is not "factory-key" but "reset-key"?
> 
>> +			label = "reset";
>> +			linux,code = <KEY_RESTART>;
>> +			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
>> +		};

i kept definition similar to mt7622-bpi-r64,in shematic it is defined as 
"reset/factory default" and openwrt wants to use it for "factory" 
function (afair booting some kind of rescue-system for reflashing 
nand/nor). basicly it is a gpio connected to different reset-lines 
(including m.2 slot where it has some side-effects in my board-version).

>> +	};
>> +
>> +	reg_1p8v: regulator-1p8v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "fixed-1.8V";
> 
> This is "avdd18", isn't it?

no it is the 1.8VD used for emmc.

>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
> 
> All these regulators have a vin-supply: please fill it in.
> Moreover, in the schematics, I can also see other LDOs: 0.9VD (input 
> +12VD),
> AVDD12 (input 1.8VD), DDRV_VPP (input 3.3VD)...

i have not looked for which the others are defined in shematic only 
added the ones i need to get the board running.

> Of course, this means that you have one more 1.8V regulator, called 
> 1.8vd.

this is the right one

>> +	};
>> +
>> +	reg_3p3v: regulator-3p3v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "fixed-3.3V";
> 
> regulator-name = "3.3vd";
> 
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
> 
> vin-supply = <&dcin>; (dcin: regulator-12vd { ... })
> 
>> +	};
>> +
>> +	reg_5v: regulator-5v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "fixed-5V";
> 
> regulator-name  = "fixed-5p1";

why this regulator name and not regulator-name = "5.1vd"; here (or 5vd)?

>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
> 
> Schematics say "+5V: 5.1V/3A", so this is not 5000000.
> 
>> +		regulator-boot-on;
>> +		regulator-always-on;
> 
> 
> vin-supply = <&dcin>;

basicly i will change the regulator to this:
/* dcin above gpio-keys to preserve alphabetic order - or should i name 
it reg_dcin to have all regulators together? but dcin should be always 
above the others which breaks ordering */

	dcin: regulator-12vd {
		compatible = "regulator-fixed";
		regulator-name = "12vd";
		regulator-min-microvolt = <12000000>;
		regulator-max-microvolt = <12000000>;
		regulator-boot-on;
		regulator-always-on;
	};

/* as far as i see in my shematic all regulators here are powered from 
+12v */
	reg_1p8v: regulator-1p8v {
		compatible = "regulator-fixed";
		regulator-name = "1.8vd";
		regulator-min-microvolt = <1800000>;
		regulator-max-microvolt = <1800000>;
		regulator-boot-on;
		regulator-always-on;
		vin-supply = <&dcin>;
	};

	reg_3p3v: regulator-3p3v {
		compatible = "regulator-fixed";
		regulator-name = "3.3vd";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		regulator-boot-on;
		regulator-always-on;
		vin-supply = <&dcin>;
	};

	reg_5v: regulator-5v {
		compatible = "regulator-fixed";
		regulator-name  = "fixed-5p1";
		regulator-min-microvolt = <5100000>;
		regulator-max-microvolt = <5100000>;
		regulator-boot-on;
		regulator-always-on;
		vin-supply = <&dcin>;
	};

using a different naming sheme for reg_5v (regulator-name) does not 
makes sense to me.

regards Frank
