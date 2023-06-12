Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C0C72BC58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjFLJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjFLJ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:28:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908B10E4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:22:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1bb2fc9c6so45875411fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686561770; x=1689153770;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTvM0/5vYqFmgppa/MMz+hr4WB15JyIjORxI7h9qATo=;
        b=GeCL+/WRC3EfrnMon1p1PCiCuyFVzX9x7WthmyC/Ruz1+m4OvGajbC9/Y9CYDbcpTX
         Rw8JwFxS2Nr0BkA2ZUmdLrM0lzARzmL43Tm54tSQLrw7pPpCws7QJ8v20ZzMt9n5Nxcj
         UQTUjtFKFmW8jKQTYhbXA6PcfkK4B2m774HFYna9pZjRzhNge3SbNiYBGHySkrez9igr
         /dKXzAcyVPhke5zkD+j6zfhaY6jTZSgNpuShH5wIX5wVA2Bhnh8DOWrZD34JwSDpIas2
         VsIotkLp6CIzCGjiboToPPzLr5gltmD/4L8H4zu06vu/j/J0dxT947PRP7XpE8TwKwhT
         9QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561770; x=1689153770;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTvM0/5vYqFmgppa/MMz+hr4WB15JyIjORxI7h9qATo=;
        b=BFEGdqTb8W2esGX3+2nwLkgaCZyUFJvnEu6bFprVDVwmcggPm2HB1gxGgGegADV3rO
         o7UI6YhAhTpQuRRJAybNLQXCGfeTqLGipcEozdtJ5Cb2CgKAgsy1Hfg38SHzAV7i6Tdi
         tQO+zxmxwC8erFwAof+Qqqp0FAdvjCr2OKNoPX904przPUY9Z/Htjp1QUZqTm0arBoHT
         1Zri9jn9mi0am1suqmwH5LcMQvosBfRxHqq+q5EC3uoRgA80IpNyA6yfEKjHFx5qp4HR
         q87cnvYfqvMxs8cbd8DB9PPbCX4ENO3SEnur3zLy+giauEXaYxp3IAJd8p3nQS0eVGfr
         yFEQ==
X-Gm-Message-State: AC+VfDzKplOQB7DQ5NdTwJaCjeyACqedZpMi+fqOMqaAEt1kWjwxivLi
        yqHkgE8/4B9cZBsXrNG//EGiVQ==
X-Google-Smtp-Source: ACHHUZ5Z+V8cQafKOz5Cr73JvFUQl05szR2u8gB+bYAcq/6g9GJPkN0q7O4uX2phCNSa3N0EHNcWtw==
X-Received: by 2002:a2e:6e18:0:b0:2b1:c751:e570 with SMTP id j24-20020a2e6e18000000b002b1c751e570mr2130729ljc.16.1686561769925;
        Mon, 12 Jun 2023 02:22:49 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id o20-20020a2e7314000000b002adc2fe3fc8sm1681722ljc.4.2023.06.12.02.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:22:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Add read-only RCG2 ops
Date:   Mon, 12 Jun 2023 11:22:46 +0200
Message-Id: <20230612-topic-rcg2_ro-v1-0-e7d824aeb628@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAObjhmQC/x2N0QqDMAwAf0XyvEBbp2P7lSEj1kwD0kqqQxD/f
 cHHOzjugMIqXOBVHaD8kyI5GfhbBXGiNDLKYAzBhdq1PuCaF4mocQwfzejvjSP3aHmgJ1jTU2H
 slVKcrErbPJtclL+yX5N3d55/mjhjVnQAAAA=
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686561768; l=839;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/h98EN6JKaTYaVlWW6LQ86vKe1OCNxNPv9lvrLNJD4w=;
 b=qCrTsOUc8uZm9QUtNrVCmalVL3bsLS0l8bPe1BSawTzzy4MTKgtJQQjVH41LJvErdLIiWToHS
 zOOzY6nPjxmAx1/oSGHu5mo/3/W95qyCXqb842GeStOILFlz5VH5p/8
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the clocks are managed by remote cores and we're not supposed
to alter their parameters. Monitoring them may still be useful, e.g.
for getting the correct rates of their children. This series attempts
to solve this problem without compromising on either of them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      clk: qcom: rcg2: Introduce read-only RCG2 ops
      clk: qcom: gcc-msm8996: Use read-only RCG ops for RPM bus clocks

 drivers/clk/qcom/clk-rcg.h     | 1 +
 drivers/clk/qcom/clk-rcg2.c    | 8 ++++++++
 drivers/clk/qcom/gcc-msm8996.c | 6 +++---
 3 files changed, 12 insertions(+), 3 deletions(-)
---
base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
change-id: 20230612-topic-rcg2_ro-1450a076eda9

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

