Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0066E640F9B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiLBU7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiLBU66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:58:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875EAEA5F0;
        Fri,  2 Dec 2022 12:58:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32601B8229F;
        Fri,  2 Dec 2022 20:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBD2C433B5;
        Fri,  2 Dec 2022 20:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014734;
        bh=OoCuIuTN9sVFI7SsOG8CnZ4zpormaQMMQinSSJAqCAI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=h/BfE3ntny1e8UG0H7NBvUuByyE9BNTwdxt0ZEtpWSCYXB2pEJbpxQGGRpSWf0cB7
         TPVCy2+wbeY1q/59YDd9TKMC2WYZr9IGCndl1r0M2PjRx3aU2qtKiBAFE/LtdGCuv/
         zlPX8tKTn+lGSQqZx9/nN5fN7VXt1xYLhd+S4hphtuoVByjKEH3oaqLM4FBfY0eziN
         6FbqVrdnjCKhMOSmcNrnrBFv9r6BL5XF0mfEg+S5H2BYaGgZvMl4NpTzwdtRhafEU+
         2JA+EWRjsReFVxCMvKFQAUDVYOuQ7tL5BCvtfMgaCG9lThy5SdusITphMbxbOdnDd3
         z2kVWoZnmDxDA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@somainline.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH 1/5] clk: qcom: krait-cc: fix wrong parent order for secondary mux
Date:   Fri,  2 Dec 2022 14:58:40 -0600
Message-Id: <167001472423.2721945.2708236422464747552.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221109005631.3189-1-ansuelsmth@gmail.com>
References: <20221109005631.3189-1-ansuelsmth@gmail.com>
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

On Wed, 9 Nov 2022 01:56:27 +0100, Christian Marangi wrote:
> The secondary mux parent order is swapped.
> This currently doesn't cause problems as the secondary mux is used for idle
> clk and as a safe clk source while reprogramming the hfpll.
> 
> Each mux have 2 or more output but he always have a safe source to
> switch while reprogramming the connected pll. We use a clk notifier to
> switch to the correct parent before clk core can apply the correct rate.
> The parent to switch is hardcoded in the mux struct.
> 
> [...]

Applied, thanks!

[1/5] clk: qcom: krait-cc: fix wrong parent order for secondary mux
      commit: 8e456411abcbf899c04740b9dbb3dcefcd61c946
[2/5] clk: qcom: krait-cc: also enable secondary mux and div clk
      commit: 18ae57b1e8abee6c453381470f6e18991d2901a8
[3/5] clk: qcom: krait-cc: handle secondary mux sourcing out of acpu_aux
      commit: e5dc1a4c01510da8438dddfdf4200b79d73990dc
[4/5] clk: qcom: krait-cc: convert to devm_clk_hw_register
      commit: 8ea9fb841a7e528bc8ae79d726ce951dcf7b46e2
[5/5] clk: qcom: krait-cc: convert to parent_data API
      commit: 56a655e1c41a86445cf2de656649ad93424b2a63

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
