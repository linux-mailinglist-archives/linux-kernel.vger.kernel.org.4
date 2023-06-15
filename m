Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D44731AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344794AbjFOOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbjFOOAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743E51FC3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA3962D90
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986DCC433C9;
        Thu, 15 Jun 2023 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686837614;
        bh=yOOmuIlxsTQGZrvkn2nP3FlmzUaDWdh8RIvYrXPnuNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTfpa5TpxCS32dYljp6gKMlezcnV1st8bEU5W3uoqeFP6BefTuP7txQzmYqMWEUMS
         BY3sQG3+bjXPnKSn6Nko1WHvpL2/M5HkZO1Z+BVswkIv1N9ijnrYNZOUpi3kc8S7IS
         13pugm3Yf80JSxXuytXtyyvIL5fJa1FTNkDae1CUrNUHp7l5KBvWS99Emv5yk9dCPv
         76VDk1ba1u+uhFQCNdVz6wxi/EFjWRg9tECHBX/Au0Hy+yb82aDMvFoUelnXD3o7op
         qzA10GwU2yd+C3xfssNYwjOwo0RufP8TrrODA5O5fxugrRnZb6TjFAsQoA6cpA7j5g
         JDEYP0nYLK4mg==
Date:   Thu, 15 Jun 2023 15:00:10 +0100
From:   Lee Jones <lee@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: rsmu: turn rsmu-{core,i2c,spi} into
 single-object modules
Message-ID: <20230615140010.GE3635807@google.com>
References: <20230604042557.900590-1-masahiroy@kernel.org>
 <20230604042557.900590-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230604042557.900590-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Jun 2023, Masahiro Yamada wrote:

> With the previous fix, these modules are built from a single C file.
> 
> Rename the source files so they match the module names.

Should this be part of the previous patch?

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  drivers/mfd/Makefile                     | 3 ---
>  drivers/mfd/{rsmu_core.c => rsmu-core.c} | 0
>  drivers/mfd/{rsmu_i2c.c => rsmu-i2c.c}   | 0
>  drivers/mfd/{rsmu_spi.c => rsmu-spi.c}   | 0
>  4 files changed, 3 deletions(-)
>  rename drivers/mfd/{rsmu_core.c => rsmu-core.c} (100%)
>  rename drivers/mfd/{rsmu_i2c.c => rsmu-i2c.c} (100%)
>  rename drivers/mfd/{rsmu_spi.c => rsmu-spi.c} (100%)
> 
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 2a0e80f941a1..0fe213858974 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -271,9 +271,6 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
>  obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
>  obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
>  
> -rsmu-core-objs			:= rsmu_core.o
> -rsmu-i2c-objs			:= rsmu_i2c.o
> -rsmu-spi-objs			:= rsmu_spi.o
>  obj-$(CONFIG_MFD_RSMU_CORE)	+= rsmu-core.o
>  obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
>  obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
> diff --git a/drivers/mfd/rsmu_core.c b/drivers/mfd/rsmu-core.c
> similarity index 100%
> rename from drivers/mfd/rsmu_core.c
> rename to drivers/mfd/rsmu-core.c
> diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu-i2c.c
> similarity index 100%
> rename from drivers/mfd/rsmu_i2c.c
> rename to drivers/mfd/rsmu-i2c.c
> diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu-spi.c
> similarity index 100%
> rename from drivers/mfd/rsmu_spi.c
> rename to drivers/mfd/rsmu-spi.c
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
