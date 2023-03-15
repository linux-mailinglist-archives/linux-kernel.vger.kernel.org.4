Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCDC6BB407
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjCONMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjCONLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:11:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6054A0F05;
        Wed, 15 Mar 2023 06:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4055761CC2;
        Wed, 15 Mar 2023 13:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60608C433D2;
        Wed, 15 Mar 2023 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678885905;
        bh=dcBGLi1wW6jnTj/fwixp5E3Xpen6ogGKNLvgATa3kig=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OqRzvIbaAak/p/FtG/VdZY8XfHgfV0ORJWL8haAvhRShHVimN2u+FsNHM8vXhsgpm
         YZNoJkGsIzrip1dRNnsvrCsOshFXlZ20HmIBMPIX16LIFE5s7TPi01Hk+t+eA8AOf0
         vri96vuYagVindmyfVVB/5yqVyZn3WIDZDVlJAG8P8lWIjgOv7Pv0VMjxURrz2Uij6
         Lta9UomZOJVxEyDLH+XI+a3E5QaDwD/qp0ZlflevFt+Tj285KMKR9VQO7sSJ5B91en
         iNWpsVSLjc7sutem5us4a88P8exMXn6JJk33nHtand2dSPRNmmAZLbN2H21HrRkshc
         uxm60akwk3zDQ==
Message-ID: <30d2ab9a-c3d1-c9d9-3cc6-02ef7af8981a@kernel.org>
Date:   Wed, 15 Mar 2023 14:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
To:     phinex <phinex@realtek.com>, jdelvare@suse.com
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315121606.GA71707@threadripper>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230315121606.GA71707@threadripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 13:16, phinex wrote:
> Support thermal zone so that we can just rely on dts to describe a
> thermal zone and do the cooling operations.
> 
> You can define a comptible string "drivetemp,hdd-sensors" to enable

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed also DT list, which means this won't be tested by tools.

> this, such as
> 
> 	sata_port0: sata-port@0 {
> 		compatible = "drivetemp,hdd-sensors";
> 		#thermal-sensor-cells = <0>;
> 	}
> 
> Then define a thermal with this sensor to get it work.
> 
>                hdd_thermal: hdd-thermal {
>                        thermal-sensors = <&sata_port0>;
> 		}
> 
> In most of the SoC systems, using dts to handle cooling is common.
> This can eliminate the usage of user space application to check
> the value exported in hwmon and then through sysfs to cooling.
> 
> Signed-off-by: phinex <phinex@realtek.com>

Is phinex your full name or email alias?

> 
> ---
>  .../bindings/hwmon/drivetemp,hdd-sensors.yaml |  35 ++++++

Bindings are always separate.

>  drivers/hwmon/drivetemp.c                     | 102 +++++++++++++++++-
>  2 files changed, 133 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml b/Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml
> new file mode 100644
> index 000000000000..939d7a923e94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/drivetemp,hdd-sensors.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/drivetemp,hdd-sensors.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Drivetemp Temperature Monitor
> +
> +maintainers:
> +  - Phinex <phinex@realtek.com>
> +
> +description: |
> +  Drivetemp Temperature Monitor that support a single thermal zone
> +  This single thermal zone can support multiple hard drives,
> +  it uses maximal temperature of these hard drivers as its temp value.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - drivetemp,hdd-sensors

No such vendor prefix. Are you sure you are describing real hardware?

Also device specific part looks too generic. What device is it exactly?


Best regards,
Krzysztof

