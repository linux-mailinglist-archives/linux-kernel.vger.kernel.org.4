Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD925F8C67
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJIQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJIQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:43:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA1225585;
        Sun,  9 Oct 2022 09:43:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E09260B07;
        Sun,  9 Oct 2022 16:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D224C433C1;
        Sun,  9 Oct 2022 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665333819;
        bh=aHScbMNxiiXqDL3eSMvA4Uekgq3/Jv0sZhK/lz3U5ho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jc6c3GMVcCINlQg+8X1i72pl9TdiiKGtVjzBDq55TqymDzPcridEG+oc9oGlyk4O+
         FrmxA7HMjx95U59+QSUF53gOJp1yDuaV8y/XGYFzWbAGS5ftFhoN0oT/+6dvlyiW7p
         zN0amNSiiW/G7eeMeHoRpHAHB+Ljum1oBQEB6HKv0u+x1sqlhPRigNoIVDjLBEW1+p
         5APOIed9mL8E9n+5EVKzHUC8LUYyf0Ebx9i55RQyAyyh0OQu8ZRFZB8a+LunnkcnHV
         Omyl3Hl5Kwn/38x2Vlgu+8uMYwXgTUFurIq1EXPI8wc6HsG4kqn/RArzKdLYUzTv5P
         EgVC9jNnUOf7Q==
Date:   Sun, 9 Oct 2022 17:44:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/3] iio: adc: add max11410 adc driver
Message-ID: <20221009174401.04eaeac7@jic23-huawei>
In-Reply-To: <20221003105903.229-1-Ibrahim.Tilki@analog.com>
References: <20221003105903.229-1-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 13:59:00 +0300
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Hi Krzysztof,
> 
> I had accidentally inclueded a different binding file in two previous patch, thus
> irq flags slipped my eyes, sorry for that.
> 
> Best Regards,
> Ibrahim
> 
> Note: No sign-off tag for David as he was unreachable when the initial patch was sent.

Series applied with one small tweak as per reply to patch 1.

Applied to the togreg branch of iio.git but that currently has an unstable mid merge window
base so I'll be rebasing on rc1 once available.

Hence for now, just pushed out as testing to see if 0-day can find anything we missed
in review.

Thanks,

Jonathan

> 
> Changelog:
> since v8:
>   - dtbinding: remove quotes around adc.yaml
>   - dtbinding: use defines for interrupt flags
> 
> since v7:
>   - add asm-generic/unaligned.h header (reported by kernel test robot)
>   - dtbinding: specify 2 items for interrupt-names
>   - dtbinding: reorder required block
> 
> since v6:
>   - don't require avdd supply if not needed
> 
> since v5:
>   - allow user to specify both interrupt pins
>   - keep irq info in max11410_state struct and use irq by name
>   - get irqs by fwnode_get_irq_byname
>   - don't allocate trigger when no irq supplied
>   - fix deadlock condition in write_raw
>   - minor style fixes
>   - fix devicetree binding errors reported by dt_binding_check
>   - convert module license to GPL as suggested by checkpatch
> 
> since v4:
>   - add in_voltage_filter2_notch_{center,en} attrs for sinc4 filter
>   - add ABI documentation for filter sysfs
>   - check interrupt-names property for configuring gpio of max11410
>   - remove hardwaregain property
>   - add scale_available property for channes using PGA
>   - separate vref regulator error -ENODEV from other errors
>   - don't register trigger if no irq specified
>   - style fixes
> 
> since v3:
>   - prefix defines with MAX11410_
>   - group vref regulators
>   - use builtin iio_validate_scan_mask_onehot
>   - validate iio trigger
>   - move scan data into state struct
>   - require vrefn regulator in DT if used by any channel
>   - don't require irq for triggered buffer
>   - remove filter sysfs attr and ABI documentation
>   - add in_voltage_filter[0-1]_notch_{center,en} attrs
> 
> since v2:
>   - remove bit position shifting, use field_prep instead
>   - reduce the amount of reg writes in max11410_configure_channel
>   - add error checking in max11410_parse_channels
>   - remove some unneeded blank lines and minor style fixes
>   - remove scan data assignment in max11410_trigger_handler
> 
> 
> 
> Ibrahim Tilki (3):
>   iio: adc: add max11410 adc driver
>   dt-bindings: iio: adc: add adi,max11410.yaml
>   Documentation: ABI: testing: add max11410 doc
> 
>  .../ABI/testing/sysfs-bus-iio-adc-max11410    |   13 +
>  .../bindings/iio/adc/adi,max11410.yaml        |  177 +++
>  drivers/iio/adc/Kconfig                       |   13 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/max11410.c                    | 1050 +++++++++++++++++
>  5 files changed, 1254 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
>  create mode 100644 drivers/iio/adc/max11410.c
> 

