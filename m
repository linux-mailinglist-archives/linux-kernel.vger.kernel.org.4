Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB9609382
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiJWNQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiJWNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:16:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5644BD33
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:15:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3815CB80D67
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 13:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579C2C433C1;
        Sun, 23 Oct 2022 13:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666530942;
        bh=l2VMs1wtBNv3IfmWtfuAVs6FIli0QzUZPV7ZdHcYnYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmeIDUOJJVgGT7kWEpl4mH789y4aLu30gR8Futg5wnwjde2/zHsBsKRHIqJ+AzqXT
         H7vhLSW6B/xe8qWeVJbZOrrLDhNR8YfgIwv2G/hKXN1utmYP//Hfpxf4LP9Ta+qSeF
         nesF97lhmEdrl8lWPh34+i2Qko4tbL/UVGkFOfaotith2suEQkRmMk0LGX2+bdiuEx
         YiqdJyWZVBYIiG13qdmGZRbX9dAd/HHtORlnJG8JF/IMkVFlw1xmCLDyO2uNblJ8kJ
         BE/bTreoQGinJsUTvwIhi5FWeFmv2M2745Qr8ldRmNkj/R6eEo3Eby9Ubydn/WS5nc
         Rd7Wnkv+RrxrQ==
Date:   Sun, 23 Oct 2022 21:15:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 8/8] arm64: defconfig: enable i.mx 8m plus specific
 interconnect support
Message-ID: <20221023131536.GP125525@dragon>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
 <20220922162925.2368577-9-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922162925.2368577-9-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:29:25PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Build CONFIG_INTERCONNECT_IMX8MP as a kernel module without which one
> may get the following after boot:
> 
> [   15.728019] platform 32f10100.usb: deferred probe pending
> [   15.733471] platform 32f10108.usb: deferred probe pending
> [   15.738895] platform 381f0040.usb-phy: deferred probe pending
> [   15.744668] platform 382f0040.usb-phy: deferred probe pending
> [   15.750437] platform 33800000.pcie: deferred probe pending
> [   15.755944] platform 32ec0000.blk-ctrl: deferred probe pending
> [   15.761807] platform 38330000.blk-ctrl: deferred probe pending
> [   15.767673] platform 32f10000.blk-ctrl: deferred probe pending
> 
> And things like PCIe and/or USB stop working.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
