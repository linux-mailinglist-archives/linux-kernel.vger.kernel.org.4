Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB035BD56A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIST4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIST4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:56:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783546DAF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:56:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so3009515pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ssLW3dQ3xc0Fl+071JBbbZVKqOeptuuJZEn+QOUu0sw=;
        b=GMtOnGTRKPwez2FHpi2qRG9AiD5Q/eDP2JDuzZvopYHeHtNHB8x+Rcx4s+45xQ9Gao
         3fbXooWo7EMKFZjtN5fv7dFBw+wk/8r891PrgsNF+eUAhkRQl2L90clHgXv68CL8q+hJ
         f2mIM95BfYJdBJ4x1S5sTlnQoN5YLxdK27JQ7d0D+3ZbtSCl7arP94aBZV/hXOWWE/Xp
         v5GZoJhZPvVvE4E5goVdbE+mCUi3N0ag4sXSfUu/+t3REwAKNPgpq2Ym1/31JYjrR4Z9
         v4ww1eYRscdjOTeqORnJLLTNRfk+RrKCcTH+5nawRxku2POFjrQfbr8/qJqCeEvKv9hV
         1Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ssLW3dQ3xc0Fl+071JBbbZVKqOeptuuJZEn+QOUu0sw=;
        b=CYopNKXCygIu7IxF3MKQAvH2mIcM4zRBnJKKV9iOnGjzywzvLIv46JNcphtD/nXwPu
         qA+dsaJHl/CNVpONilmT5EdMB76wFtRpQ2uVc1QRi2x2mJYI8MeWdQtwJFWj0qWVsCQW
         U7qsprG+ASXNIm4Ca4aDZ5b+QnxRCPsvUvfc4HNSk9AH147w34I7cDVyGkGe8Ae2qa+O
         EhBHfJM06Zp3jf2LHIeNbmltsiHQtzoTEI8qU4spCZ26SDHwaelxiqDEHMnL+rp2S7PJ
         n8G+huUy5JHS093/x+HQBFqwiB2hFyOwxh+4cNrB9hWj8k7+Xh3t7xLhL3fzWfyZJLnA
         +Zgg==
X-Gm-Message-State: ACrzQf0eZmha+go0lLy/1JtGj4033rMkPQYoS3u8+zr0ihk7Dvamsq/q
        PilB55H0tvCuuKqMQD6li5mATtKYl0K/gQ==
X-Google-Smtp-Source: AMsMyM5mSPg4SLFhzWzJlL9YF63jk64sbMZAil7KlR8SlBrq7wCZ4+L0X+SNvmYKCamsJaLgpum3aA==
X-Received: by 2002:a17:902:7b90:b0:178:a983:5983 with SMTP id w16-20020a1709027b9000b00178a9835983mr1324050pll.135.1663617387915;
        Mon, 19 Sep 2022 12:56:27 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id a14-20020a17090a688e00b002032bda9a5dsm7071454pjd.41.2022.09.19.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:56:27 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v6 0/4] dt-bindings: qcom-qce: Convert bindings to yaml & related changes 
Date:   Tue, 20 Sep 2022 01:26:14 +0530
Message-Id: <20220919195618.926227-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v5:
=================
- v5 can be seen here: https://lore.kernel.org/lkml/20211110105922.217895-1-bhupesh.sharma@linaro.org/
- As per Bjorn's suggestion on irc, broke down the patchset into 4
  separate patchsets, one each for the following areas to allow easier
  review and handling from the respective maintainer(s):
	'arm-msm', 'crypto', 'dma' and 'devicetree' 
  This patchset is directed for the 'devicetree' tree / area.
- Addressed Rob's, Vladimir's and Bjorn's review comments and Acks received on
  v5.
- Added Tested-by from Jordan received on the v5.
- Dropped '[PATCH v5 09/22] dt-bindings: qcom-qce: Move 'clocks' to optional properties'
  from this series as per Bjorn's suggestions.

Changes since v4:
=================
- v4 for sm8250 can be seen here: https://lore.kernel.org/linux-arm-msm/20211013105541.68045-1-bhupesh.sharma@linaro.org/
- v1 for sm8150 qce enablement can be seen here: https://lore.kernel.org/linux-arm-msm/20211013165823.88123-1-bhupesh.sharma@linaro.org/
- Merged the sm8150 and sm8250 enablement patches in the same patchset,
  as per suggestions from Bjorn.
- Dropped a couple of patches from v4, as these have been picked by
  Bjorn already via his tree.
- Addressed review comments from Vladimir, Thara and Rob.
- Collect Reviewed-by from Rob and Thara on some of the patches from the
  v4 patchset.

Changes since v3:
=================
- v3 can be seen here: https://lore.kernel.org/linux-arm-msm/20210519143700.27392-1-bhupesh.sharma@linaro.org/
- Dropped a couple of patches from v3, on basis of the review comments:
   ~ [PATCH 13/17] crypto: qce: core: Make clocks optional
   ~ [PATCH 15/17] crypto: qce: Convert the device found dev_dbg() to dev_info()
- Addressed review comments from Thara, Rob and Stephan Gerhold.
- Collect Reviewed-by from Rob and Thara on some of the patches from the
  v3 patchset.

Changes since v2:
=================
- v2 can be seen here: https://lore.kernel.org/dmaengine/20210505213731.538612-1-bhupesh.sharma@linaro.org/
- Drop a couple of patches from v1, which tried to address the defered
  probing of qce driver in case bam dma driver is not yet probed.
  Replace it instead with a single (simpler) patch [PATCH 16/17].
- Convert bam dma and qce crypto dt-bindings to YAML.
- Addressed review comments from Thara, Bjorn, Vinod and Rob.

Changes since v1:
=================
- v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20210310052503.3618486-1-bhupesh.sharma@linaro.org/ 
- v1 did not work well as reported earlier by Dmitry, so v2 contains the following
  changes/fixes:
  ~ Enable the interconnect path b/w BAM DMA and main memory first
    before trying to access the BAM DMA registers.
  ~ Enable the interconnect path b/w qce crytpo and main memory first
    before trying to access the qce crypto registers.
  ~ Make sure to document the required and optional properties for both
    BAM DMA and qce crypto drivers.
  ~ Add a few debug related print messages in case the qce crypto driver
    passes or fails to probe.
  ~ Convert the qce crypto driver probe to a defered one in case the BAM DMA
    or the interconnect driver(s) (needed on specific Qualcomm parts) are not
    yet probed.

Qualcomm crypto engine (qce) is available on several Snapdragon SoCs.
The qce block supports hardware accelerated algorithms for encryption
and authentication. It also provides support for aes, des, 3des
encryption algorithms and sha1, sha256, hmac(sha1), hmac(sha256)
authentication algorithms.

Cc: thara.gopinath@gmail.com
Cc: robh@kernel.org
Cc: andersson@kernel.org
Cc: krzysztof.kozlowski@linaro.org
Tested-by: Jordan Crouse <jorcrous@amazon.com>

Bhupesh Sharma (4):
  dt-bindings: qcom-qce: Convert bindings to yaml
  dt-bindings: qcom-qce: Add 'interconnects' and 'interconnect-names'
  dt-bindings: qcom-qce: Add 'iommus' to optional properties
  dt-bindings: qcom-qce: Add new SoC compatible strings in dt-binding
    doc

 .../devicetree/bindings/crypto/qcom-qce.txt   | 25 -----
 .../devicetree/bindings/crypto/qcom-qce.yaml  | 93 +++++++++++++++++++
 2 files changed, 93 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.yaml

-- 
2.37.1

