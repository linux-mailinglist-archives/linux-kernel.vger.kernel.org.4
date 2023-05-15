Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69E8702267
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbjEODcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbjEODbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:31:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5721BF3;
        Sun, 14 May 2023 20:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73CC161E42;
        Mon, 15 May 2023 03:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F339C433D2;
        Mon, 15 May 2023 03:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121366;
        bh=TG5ju3S+RNtGFqAhtk0STPkps5Zp0Kz8CKHNO8GPt2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCoe9rO1Z//mdd6cjobpHtOJ3Lu1csvpo8MQkTHlVgb/nQXVnkJEF0LEdNp00JBJm
         mKmotyktKmblyGdZ+oYCNLxeJcguVIoB24/I949z9Jd10iWGwK6iUoTM+wHA6QWgD1
         z/z/FYz4CovtRFi8+lBUBgBt+DhCHMIAdqzU3qiKPbmznnKvjd+JQbTqw0dANU7N7E
         nlXbu55I88cd/KcfHzC+MNEcFp5QyDso91PskTAybA36b3Yz7ayQvPp2UyDU06P+gB
         x5kzb1QdmvSlGI/t6FTiZtIh1DOllRvFaoY5wJ1DreL34XmnxSKAZmD6SOiJmt4bSE
         fcNRtKpQNyhLw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] soc: qcom: icc-bwmon: fix incorrect error code passed to dev_err_probe()
Date:   Sun, 14 May 2023 20:33:05 -0700
Message-Id: <168412158454.1260758.1921647245584791908.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230513111747.132532-1-krzysztof.kozlowski@linaro.org>
References: <20230513111747.132532-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 May 2023 13:17:47 +0200, Krzysztof Kozlowski wrote:
> Pass to dev_err_probe() PTR_ERR from actual dev_pm_opp_find_bw_floor()
> call which failed, instead of previous ret which at this point is 0.
> Failure of dev_pm_opp_find_bw_floor() would result in prematurely ending
> the probe with success.
> 
> Fixes smatch warnings:
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: icc-bwmon: fix incorrect error code passed to dev_err_probe()
      commit: 3530167c6fe8001de6c026a3058eaca4c8a5329f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
