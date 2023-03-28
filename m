Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AC46CBDE5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjC1Lfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjC1Lfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:35:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D435BBD;
        Tue, 28 Mar 2023 04:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13F48616E1;
        Tue, 28 Mar 2023 11:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00DCC4339B;
        Tue, 28 Mar 2023 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680003339;
        bh=EVYhKptsbY/fUtII/R3Rxzc/AKD8pNXREsDk4jICzrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PccUEc5q+Zf/8w83+CglGcqMIkR1K8jd23nJpwAanyYniq9CP+sCmTtGp0dMhHpJj
         fLMh4a0ufTWGGJuZUuNh7GzvmxsyxSTby8X1j++jj2E6Knl7YsGdvMpOLXvj+mfD0P
         nzXKnyXZk0URAq1k2vZPUDcpGXUSLm81pNPscgp4q8ToKI9uYcGEHn4CjhOG07o+9e
         Pm1tjpL6aFutsePpCEUKj2b/iXNHiNh4kz9dcUJqhI7a3S52iwGkbB4m3WiZWHA3Ip
         k3WmxsZ05doOEvZCp4DDpV8XUwsRlPF9bhlYuSsfn01s6G32m80cmGQsE83pj3vIkL
         c8+BHiTlPeepw==
Date:   Tue, 28 Mar 2023 13:35:36 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v4 0/2] spi: loongson: add bus driver for the loongson spi
Message-ID: <20230328113536.ldxpvx3hibezcqtb@intel.intel>
References: <20230328112210.23089-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328112210.23089-1-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yinbo,

before submitting the patches for review... can you please run
checkpatch.pl on them?

Thanks,
Andi

On Tue, Mar 28, 2023 at 07:22:08PM +0800, Yinbo Zhu wrote:
> Loongson platform support spi hardware controller and this series patch
> was to add spi driver and binding support.
> 
> Change in v2:
> 		1. This [PATCH v2 1/2] dt-bindings patch need depend on clk patch:
> 	 	   https://
> 		   lore.kernel.org/all/20230307115022.12846-1-zhuyinbo@loongson.cn/
> 		2. Remove the clock-names in spi yaml file.
> 		3. Add "loongson,ls7a-spi" compatible in spi yaml file.
> 		4. Add an || COMPILE_TEST and drop && PCI then add some CONFIG_PCI
> 		   macro to limit some pci code.
> 		5. Make the spi driver top code comment block that use C++ style.
> 		6. Drop spi->max_speed_hz.
> 		7. Add a spin_lock for loongson_spi_setup.
> 		8. Add a timeout and cpu_relax() in loongson_spi_write_read_8bit.
> 		9. Add spi_transfer_one and drop transfer and rework entire spi
> 		   driver that include some necessary changes.
> 		10. Use module_init replace subsys_initcall.
> 		11. About PM interface that I don't find any issue so I don't add
> 		    any changes.
> Change in v3:
> 		1. This [PATCH v3 1/2] dt-bindings patch need depend on clk patch:
> 		   https://
> 		   lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
> 		2. Drop the unused blank line in loongson,ls-spi.yaml file.
> 		3. Replace clock minItems with clock maxItems in yaml file.
> 		4. Separate spi driver into platform module, pci module and core
> 		   module.
> 		5. Replace DIV_ROUND_UP with DIV_ROUND_UP_ULL to fix compile error
> 		   "undefined reference to `__aeabi_uldivmod'" and  "__udivdi3 undefined"
> 		   that reported by test robot.
> 		6. Remove the spin lock.
> 		7. Clear the loongson_spi->hz and loongson_spi->mode in setup to fixup
> 		   the issue that multiple spi device transfer that maybe cause spi was
> 		   be misconfigured.
> Change in v4:
> 		1. This [PATCH v4 1/2] dt-bindings patch need depend on clk patch:
> 		   https://
> 		   lore.kernel.org/all/20230323025229.2971-1-zhuyinbo@loongson.cn/
> 		2. Add "#include <linux/io.h>" in spi-loongson-core.c for fix the compile
> 		   issue which devm_ioremap no declaration.
> 		3. Add "EXPORT_SYMBOL_GPL(loongson_spi_dev_pm_ops)" in
> 		   spi-loongson-core.c for fix the compile issue which
> 		   loongson_spi_dev_pm_ops undefined.
> 
> Yinbo Zhu (2):
>   dt-bindings: spi: add loongson spi
>   spi: loongson: add bus driver for the loongson spi controller
> 
>  .../bindings/spi/loongson,ls-spi.yaml         |  43 +++
>  MAINTAINERS                                   |  10 +
>  drivers/spi/Kconfig                           |  31 ++
>  drivers/spi/Makefile                          |   3 +
>  drivers/spi/spi-loongson-core.c               | 304 ++++++++++++++++++
>  drivers/spi/spi-loongson-pci.c                |  89 +++++
>  drivers/spi/spi-loongson-plat.c               |  66 ++++
>  drivers/spi/spi-loongson.h                    |  41 +++
>  8 files changed, 587 insertions(+)
> 
> -- 
> 2.20.1
> 
