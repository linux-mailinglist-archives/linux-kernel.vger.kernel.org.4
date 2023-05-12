Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DABF700C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbjELP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbjELP6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8522D26BF;
        Fri, 12 May 2023 08:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E5060B0D;
        Fri, 12 May 2023 15:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B23C433EF;
        Fri, 12 May 2023 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683907083;
        bh=FK7Hhby4JLOW4/fgG5Gk6nA2uWpoAGql5tWqRblv8eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSWPjv/GAP3zWbwvgdAm8+zU+A+AkJD/D+SJgAUBW9grkDR/WHgbaBuoHijj4XXKr
         Xpfeqh2ty0xgqjue9XZqKpSzFk9IdmUySOneoENbqmjn8Q7sSrcbaodvBq2NpHreyU
         UXX7gAgMfLuq0QlySgCkiCcfDaEqM/+/pgTx7xYI/Bnrt16tjMJNV9VrP5bszB2LOh
         SZVk1WKSduqoZByaPzr1KTkFukwHP1VzKwAQ63X6dfYZChqegjtCu7prw7qcQWCOax
         /q+GIQfl/BtvYcXsU6XNC7S3oTFZv7MSuLtGlJAq98/nIJFhg5xaiBM6eX9vyiSmbY
         ZlhohKSGtnjQQ==
Date:   Fri, 12 May 2023 08:58:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        manivannan.sadhasivam@linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] soc: qcom: Rename ice to qcom_ice to avoid module
 name conflict
Message-ID: <20230512155801.GA610@quark.localdomain>
References: <20230512123632.3024857-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512123632.3024857-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 03:36:32PM +0300, Abel Vesa wrote:
> The following error was reported when building x86_64 allmodconfig:
> 
> error: the following would cause module name conflict:
>   drivers/soc/qcom/ice.ko
>   drivers/net/ethernet/intel/ice/ice.ko
> 
> Seems the 'ice' module name is already used by some Intel ethernet
> driver, so lets rename the Qualcomm Inline Crypto Engine (ICE) from
> 'ice' to 'qcom_ice' to avoid any kind of errors/confusions.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v1:
>  * changed filename from qcom-ice.c to qcom_ice.c (with underscore)
>    to be in line with other Qcom SoC drivers.
> 
>  drivers/soc/qcom/Makefile              | 2 +-
>  drivers/soc/qcom/{ice.c => qcom_ice.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/soc/qcom/{ice.c => qcom_ice.c} (100%)

I'd also prefer that the filename stayed ice.c and just the module was renamed,
given that this is already in the drivers/soc/qcom/ directory.

- Eric
