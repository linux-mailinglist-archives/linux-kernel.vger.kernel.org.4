Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A84A691341
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBIWZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIWZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:25:42 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51696B371;
        Thu,  9 Feb 2023 14:25:38 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1F3A81BF205;
        Thu,  9 Feb 2023 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675981537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcdNOhsW9avligQs+Hpb3Qm6IJ+uElOFmCgas7ATq54=;
        b=hO9RZkaDrAvCCNu1D0mpJDLcYdyrcHLI40QsLw8pwWUc5oSCIgnpjlsVtp28qc/De6SwF8
        qBUWMElx9biwfTXO2noTQgxSCYjnSD55Eo8VDx+Gq4Z2wHexy7jpmB/b0xa7zevfx34tLi
        LZEYQQyX4kMbcyPwJacejjUh7qMyqES+Yxruqqe9ogXYu7sRyepVo1krgqegs8NPRg8gHD
        rO8kgaHJtcHCb1ZIe8XZvAhmspukH0o9DQzr3tCVb4cSPhf0zl1H0A3SR9HlBr060C0afn
        iwQpl4PPTFEMZhtIyQ+JTAANYhKC6OVTS9sZ54rt8dxiEr+ZMOBa93roB0bchg==
Date:   Thu, 9 Feb 2023 23:25:34 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/22] rtc: pm8xxx: add support for setting
 time using nvmem
Message-ID: <167598144775.1655758.2122287458672785227.b4-ty@bootlin.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202155448.6715-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Feb 2023 16:54:26 +0100, Johan Hovold wrote:
> This series adds support for setting the RTC time on Qualcomm platforms
> where the PMIC RTC time registers are read-only by instead storing an
> offset in some other non-volatile memory. This is used to enable the RTC
> in the SC8280XP Compute Reference Design (CRD) and Lenovo Thinkpad X13s
> laptop.
> 
> The RTCs in many Qualcomm devices are effectively broken due to the time
> registers being read-only. Instead some other non-volatile memory can be
> used to store and offset which a driver can take into account. On
> machines like the X13s, the UEFI firmware (and Windows) use a UEFI
> variable for storing such an offset, but not all Qualcomm systems use
> UEFI.
> 
> [...]

Applied, thanks!

[01/22] rtc: pm8xxx: fix set-alarm race
        commit: c88db0eff9722fc2b6c4d172a50471d20e08ecc6
[02/22] rtc: pm8xxx: drop spmi error messages
        commit: eb245631836b4843199d7176d1597759dda4ee9e
[03/22] rtc: pm8xxx: use regmap_update_bits()
        commit: 182c23bbfea3713206b0da3fbbb7350e197a92dd
[04/22] rtc: pm8xxx: drop bogus locking
        commit: 8d273f33fd090a2c270c67b6ac7fa03f5a7eee3f
[05/22] rtc: pm8xxx: return IRQ_NONE on errors
        commit: cb9bb7b2364bb5f4f51226ce1f9ec6ffda618f0a
[06/22] rtc: pm8xxx: drop unused register defines
        commit: f081b74c1c748a7da972c782c2f974f239a9b51f
[07/22] rtc: pm8xxx: use unaligned le32 helpers
        commit: 79dd75661e4284169768859012a4bf6898cef758
[08/22] rtc: pm8xxx: clean up time and alarm debugging
        commit: c996956fcc5b7756eb04615cc36618acaa85caa9
[09/22] rtc: pm8xxx: rename struct device pointer
        commit: a375510efeda0dfbad205cd1de8b57f63d0779c9
[10/22] rtc: pm8xxx: rename alarm irq variable
        commit: 4727b58fc84daf6d7097ac3528a6517456a5e110
[11/22] rtc: pm8xxx: clean up comments
        commit: 3c3326394ba420608d0665aef846b2268c9c9629
[12/22] rtc: pm8xxx: use u32 for timestamps
        commit: 35d9c472925748a1cb1f5b6cc8ae71cf8138e30f
[13/22] rtc: pm8xxx: refactor read_time()
        commit: da862c3df6add928e2f51d6cadec128a9a1940f3
[14/22] rtc: pm8xxx: clean up local declarations
        commit: 9e5a799138042ac8276e6744c548b0411f371600
[15/22] rtc: pm8xxx: drop error messages
        commit: c94fb939e65155bc889e62396f83ef4317d643ac

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
