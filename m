Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F8473B827
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjFWMvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjFWMvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:51:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211862129
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:50:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-312824aa384so588237f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687524646; x=1690116646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38ZFJVWNUQQxQWdNSjPpbRwE1qGpIOrtYRqEuWvZ+/4=;
        b=YpUOOjwzMFvEIZShfWlC9G9X4m1UFxwzymvN/G9VN0jT4MLBCkY3Un7MS1sVdNyjO3
         ZnZ16AZ8/G0Kol6CIDuaRN8Hu1LxMgVUivI44reoX4CsufuAeF6NdNkeqsVKpIGaXcI+
         pP3u1e8sDjuDocGR2ijci7yNo71tlVtq+p6roarJbXC/qoudVknl6dMP/jkw1LuwhX4c
         dZqX5Tmsxn3fKGdIwtSY2PLzrHGQxLcCdP6luhbbYYry2XTfheNw6g8xugqZMAXQq3E4
         HuRXlqwemtH45ekuFJWNkeoZdwcW89TaHkvdcGRGMPr44pvXqtkm8nxreHrqKXe9ACdW
         TLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524646; x=1690116646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38ZFJVWNUQQxQWdNSjPpbRwE1qGpIOrtYRqEuWvZ+/4=;
        b=Bqal2ArEcylt+k/OAGpu5LxzASm+uzwxhLYcrGRMazYaywSUjaXIsmvJrM/FCNBw/S
         5tJjOynQp8NEcQW5nHsWMuIG09xT+hwH5PQumzw+g8a+HV+E6oeLeJcjUUr715F/1WdQ
         KOW4Zca7BUGrXF+RnyXyIkL2k6OFaQpUO55+YXxxO4V+fOFVXP0o87AqFEPEH9KBahaN
         DZMCUxZvkbsfSO1uPu/UbHibdAA5IAiOxEhK586CtfA/C+hF53SH8S6xg/EaYgdPLtQV
         FA988wQcE0K6ej+YG1JikutRE0qP7Tl1hU7OAgk+zPfcvfkZYOyDMjbvRiA5jrVXz4z6
         Nodw==
X-Gm-Message-State: AC+VfDwD2+Cfykh6sD6ev0Sl0JgY7YplfB4h61APauqtfEOvwZnO0f6C
        2zQV46vkNvh+TPyvatfXeCvVyw==
X-Google-Smtp-Source: ACHHUZ4Vmgs4jLypOn8hl1JUDcNuGhBdib1XRFYXWUSNxlTfqNBHVVFvIVw3AWZtFCRqT6WcTBQdVQ==
X-Received: by 2002:a5d:404f:0:b0:30f:c1ac:9249 with SMTP id w15-20020a5d404f000000b0030fc1ac9249mr13513756wrp.51.1687524646558;
        Fri, 23 Jun 2023 05:50:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b002fae7408544sm9455350wrs.108.2023.06.23.05.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:50:46 -0700 (PDT)
From:   neil.armstrong@linaro.org
Subject: [PATCH v2 0/4] interconnect: qcom: rpmh: sm8550: mask to send as
 vote
Date:   Fri, 23 Jun 2023 14:50:41 +0200
Message-Id: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-0-709474b151cc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGVlWQC/52OQQ6CMBBFr0K6dkwpKQFX3sOwGOoIE6El00I0h
 LtbPYJ/9/7i/b+rSMIU1aXYldDGkYPPYE6FciP6gYDvmZXRptJ12UIKCzuIc2OthnWJSQhnYJ9
 IXPCeXIIZ4xO2kAjaGtHoytrSNiore4wEvaB3Y5b6dZpyuQg9+PX7cOsyjxxTkPfv0lZ+2z/Xt
 xI01DmV04i2NdeJPUo4BxlUdxzHB4ZKyyX+AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mike Tipton <mdtipton@codeaurora.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=dHlYALK7LZK9JGD1GTv8PH7HVFxRRCXWRUuHCV2V1AE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklZUjcy8hCaoLpedyJOAMD1KNd/U0sIl7+rBl6/L1
 kwC3bMWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJWVIwAKCRB33NvayMhJ0T0DEA
 CUBYXFjABUSSNfXkbhRd6ZUxLRmT8sVvHDnlBGaMc1HnJTlZq9VCvg+o/xbI8LBT3F2RLIC/OvF92w
 Qikg5QnjV5qREQUOoc1QY1iH1wd2PsFVMsxJNvx3HcmMRLEoK7RFo9P5qeVnszgjq2uSK9J10e2kjF
 jNC1qhfmqEvyma1Td5E4lscNtq646V7JCHk8G55VGUp+MnBy3d+9+PHk8fVKdaZUEAAc8XfzchoB8p
 QckZsVoIVdMTW55QWEipRDPd2tc8NzC1pVFKgxWIxBK1/TKuQ+uh372XQbEWLFHKGz767KTXd4I+0r
 7ENEjTc7qJtG+t1x576F1dsCaa3ACsCEkV4ZdmM6kiRb0oNpXsPliOsfn0vizrWbdNvM3zxjl1C3nE
 f57l47tvJLgnwEG3YSt+n0nilAgY7X2h47eeyonqLbg5YF+UuhVl20e33oZGJVNpGV3cY38NjI/0Vq
 0zjjW2mNjqLw4VSFpOXUozQK2gISHYZ1qbbHf8zcfq9laVr59pUf+oPqnFvBxVVMcX21LoNAHZGn72
 PoWsjpBQ/Ugj1YtxmAv3X9JgBdvabCnr+Bq9FNlP+vy6irA83VF5/VYEgby6dBA793iHFJ5AajROKX
 O7rEOLOGNYElmY2JiaN6h3KCZ0DAJohyQG8k/not+Ie+zul1WcJPMZJpZ77A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the SM8550 SoC, some nodes requires a specific bit mark
instead of a bandwidth when voting.

Add an enable_mask variable to be used instead of bandwidth.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Took downstream patch for patch 1
- Added konrad's reviewed tag
- Added changes for sm8450 and sa8775p
- Link to v1: https://lore.kernel.org/r/20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-0-66663c0aa592@linaro.org

---
Mike Tipton (1):
      interconnect: qcom: Add support for mask-based BCMs

Neil Armstrong (3):
      interconnect: qcom: sm8450: add enable_mask for bcm nodes
      interconnect: qcom: sm8550: add enable_mask for bcm nodes
      interconnect: qcom: sa8775p: add enable_mask for bcm nodes

 drivers/interconnect/qcom/bcm-voter.c |  5 +++++
 drivers/interconnect/qcom/icc-rpmh.h  |  2 ++
 drivers/interconnect/qcom/sa8775p.c   |  1 +
 drivers/interconnect/qcom/sm8450.c    |  9 +++++++++
 drivers/interconnect/qcom/sm8550.c    | 17 +++++++++++++++++
 5 files changed, 34 insertions(+)
---
base-commit: 47045630bc409ce6606d97b790895210dd1d517d
change-id: 20230619-topic-sm8550-upstream-interconnect-mask-vote-96aa20355158

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

