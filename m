Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411C45EEE24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiI2G4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiI2G4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:56:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5004A1280E9;
        Wed, 28 Sep 2022 23:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02C9FB82366;
        Thu, 29 Sep 2022 06:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8579C433D6;
        Thu, 29 Sep 2022 06:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664434578;
        bh=8e2sx4sQPbmcCfkfJZv9gfdi3Q8n+Bkj9pgn/A7YiZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TSgbnwKq72Id9ST9hbR1VtFJGKIhK+YONZnUSnj9J+vejAIzOGmarwEhF7s7QX3Br
         xw3eqND/J1866/wjjcinVifPvOOrmdg54rgqrh0JTjYlKTQWaSNmRirPHRjIazl4tC
         uf4VuBMZRtwjRJZ2kKtfomrTCTnpad6s8reFCl7WhdHz0lr1nQ/RWiOKzMY0SuNqkY
         oZg7gTqX8ffTSyvDGjpd0O7QEFdqLH9BhP4/QJ7vByPjnl+wlXlZS2p76M+ZVnL6RD
         7C08I9pJ7k7FWQCZVMm+Ct4ODwwDfpBlNVjd0RVSSmxDlPgzk3YJksaF6kp5AHdUIT
         SjP03RkWV7rrg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odnT6-0006OQ-Lv; Thu, 29 Sep 2022 08:56:24 +0200
Date:   Thu, 29 Sep 2022 08:56:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] phy: qcom-qmp-pcie: drop bogus register update
Message-ID: <YzVBmJ5EtZzkm4cD@hovoldconsulting.com>
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-7-johan+linaro@kernel.org>
 <2bc50ea4-ec29-cacc-216b-1c21d2d2f0bc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bc50ea4-ec29-cacc-216b-1c21d2d2f0bc@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:10:02PM +0300, Dmitry Baryshkov wrote:
> On 28/09/2022 18:28, Johan Hovold wrote:
> > Since commit 0d58280cf1e6 ("phy: Update PHY power control sequence") the
> > PHY is powered on before configuring the registers and only the MSM8996
> > PCIe PHY, which includes the POWER_DOWN_CONTROL register in its PCS
> > initialisation table, may possibly require a second update afterwards.
> > 
> > To make things worse, the POWER_DOWN_CONTROL register lies at a
> > different offset on more recent SoCs so that the second update, which
> > still used a hard-coded offset, would write to an unrelated register
> > (e.g. a revision-id register on SC8280XP).
> > 
> > As the MSM8996 PCIe PHY is now handled by a separate driver, simply drop
> > the bogus register update.
> > 
> > Fixes: e4d8b05ad5f9 ("phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB") added support
> 
> I'm not sure about the particular fixes tag. Backporting from the split 
> driver into old qmp driver would be a complete pain.

That a separate issue. The fixes tag point at the commit introducing the
bug. And I didn't add a stable tag on purpose.

> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Johan
