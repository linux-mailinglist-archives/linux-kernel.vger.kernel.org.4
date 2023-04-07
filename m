Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40EA6DB41C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjDGTVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjDGTVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:21:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03704976F;
        Fri,  7 Apr 2023 12:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9607464FE8;
        Fri,  7 Apr 2023 19:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A16C4339C;
        Fri,  7 Apr 2023 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680895258;
        bh=pySzrUVLgH2rgQjZMYipTzrfWw3I4woWaqG1zm9Rj14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+3YNvXiMLSUWUXNTjK4K+u5FBo6c3AhnkfZmX9/D+Ct8cWUQBI/v4TMkQLtMMJmU
         FDzZTtv4J7rBjrLJxZQQS9/xXSPsTJMSOaMkU3KLrjLtYoZ/z4OwW7PPQBfl6vEUgy
         0eqC3bR7TTBHtKITB4a3DsADjzbHJiXaXYiDNGTRKos+zmm3X/YJuI/FjttNuFSCtq
         0R3+nRke11eiueiWG9gUcl13s16s52sD4JuFuSfNODMkj0zarJnqxjNjBuIO1IDzph
         Uc7hEl63DcK9ZiQDGc2f3oSBStRlQs7pqyy9v353teIvIaYgxUvuwl4u1QyNMJdzKP
         oXx70ps2RRkIg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/6] Add dedicated Qcom ICE driver
Date:   Fri,  7 Apr 2023 12:23:46 -0700
Message-Id: <168089531816.2739604.14046921843203355234.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407105029.2274111-1-abel.vesa@linaro.org>
References: <20230407105029.2274111-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 13:50:23 +0300, Abel Vesa wrote:
> As both SDCC and UFS drivers use the ICE with duplicated implementation,
> while none of the currently supported platforms make use concomitantly
> of the same ICE IP block instance, the new SM8550 allows both UFS and
> SDCC to do so. In order to support such scenario, there is a need for
> a unified implementation and a devicetree node to be shared between
> both types of storage devices. So lets drop the duplicate implementation
> of the ICE from both SDCC and UFS and make it a dedicated (soc) driver.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: crypto: Add Qualcomm Inline Crypto Engine
      commit: f6ff91a47ac57cb1118d94020302617b6b22c0d1
[3/6] soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
      commit: 2afbf43a4aec6e31dac7835e65d52c867f2be400
[6/6] arm64: dts: qcom: sm8550: Add the Inline Crypto Engine node
      commit: b8630c48b43fcf77039c04a1d30153e283cf41b4


Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
