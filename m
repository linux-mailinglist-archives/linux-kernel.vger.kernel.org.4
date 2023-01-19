Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC7673015
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjASERl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjASEAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:00:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF55B37B45;
        Wed, 18 Jan 2023 19:57:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ADAF6CE1FE3;
        Thu, 19 Jan 2023 03:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1FCC433D2;
        Thu, 19 Jan 2023 03:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674099871;
        bh=bQlbGQrc9yJs59rSSNPWzyJ0ckGvabW8Cu5jr8y+/ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAJmhT/IYErYc/2eD4WDCv1guLTKHz0vsbdz7pYIWI0c/Y99CGOf2UDc3PZde9NAC
         yKBUDQNx6p7GxouNl757s7yNfdVkOn+DHDMt87gzwrw1WVyjzsrshqR7MymCoitlzc
         WYNGUa9GqM1IoxKs2Tx7gBPeMMzp2OG1ozToXegZqZR2hIF+VA/TUcI7fBC07zc6FJ
         parXx6BtV9ezFhgGxNesRBwJYxCrprl/f0irO1wbqnPnLGC+8Vlm9ytgn4suRU9kx4
         TSE7WOYqwsRUNMn0CYeh/56U2xyMb1j3xmMcp2yUexTZbn4k97dq7vXUYRYW41BETb
         yPlN+fGtsJ6fw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_sibis@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>
Cc:     regressions@leemhuis.info, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, will@kernel.org,
        robin.murphy@arm.com, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        robh+dt@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH V4 00/11] Fix XPU violation during modem metadata authentication
Date:   Wed, 18 Jan 2023 21:44:28 -0600
Message-Id: <167409986459.3039214.14669304455685242733.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230117085840.32356-1-quic_sibis@quicinc.com>
References: <20230117085840.32356-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 14:28:29 +0530, Sibi Sankar wrote:
> The memory region allocated using dma_alloc_attr with no kernel mapping
> attribute set would still be a part of the linear kernel map. Any access
> to this region by the application processor after assigning it to the
> remote Q6 will result in a XPU violation. Fix this by replacing the
> dynamically allocated memory region with a no-map carveout and unmap the
> modem metadata memory region before passing control to the remote Q6.
> The addition of the carveout and memunmap is required only on SoCs that
> mandate memory protection before transferring control to Q6, hence the
> driver falls back to dynamic memory allocation in the absence of the
> modem metadata carveout.
> 
> [...]

Applied, thanks!

[01/11] dt-bindings: remoteproc: qcom,q6v5: Move MSM8996 to schema
        commit: bdea142295ffd76aaec2a90a36ba09ad19660686
[02/11] dt-bindings: remoteproc: qcom,msm8996-mss-pil: Update memory region
        commit: 9b3024247b2ddea6880fa77b638c870ddbdb6bba
[03/11] dt-bindings: remoteproc: qcom,sc7180-mss-pil: Update memory-region
        commit: 95864f27330674c970c84b81ae791182de150b0f
[04/11] dt-bindings: remoteproc: qcom,sc7280-mss-pil: Update memory-region
        commit: eb48137d783b4c845c7b081e32a73666326dcbb3
[05/11] Revert "remoteproc: qcom_q6v5_mss: map/unmap metadata region before/after use"
        commit: a899d542b687c9b04ccbd9eefabc829ba5fef791
[06/11] remoteproc: qcom_q6v5_mss: Use a carveout to authenticate modem headers
        commit: 57f72170a2b2a362c35bb9407fc844eac5afdec1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
