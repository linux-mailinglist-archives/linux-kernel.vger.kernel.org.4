Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15907733489
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbjFPPSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242043AbjFPPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:18:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAFA30FF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:18:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-65311774e52so753610b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686928699; x=1689520699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjK5uSBUBCtKUiHKGw2fDzcH80L9Te7xYyX5HYmSKZk=;
        b=Gazntjz7fU9vAVPqqzRdDRac27cecBITu2YvqyJ/AerXxYtOfZN2wz718g7xcI3NJj
         iGK8DZvU6z1+Z3BId6izQhVmrGv1ygnshSs9Q09cAXjmSoRXh1OzSNajVzmt9kbmlqwM
         zgNgQpgihqEhJaCqPN565bpB2w/NQFTyfXs2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686928699; x=1689520699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjK5uSBUBCtKUiHKGw2fDzcH80L9Te7xYyX5HYmSKZk=;
        b=JlcVbiUm9BUg2eGVgfY/QGapnU1ts8E1V1rx9Cn491XHbWt2Wq6EUEH65KjjjQtbz1
         zb/7l3HE2ggfZvKMyFSWD7pBb3o3iu7xOngL6H8l3S4k2/LpT+s7SqMbv2WcOZIgcOc0
         PdP6DdD7UibQdVTvKk9vAVxMmhgTRmDxG94Pcp+pCFF/nbvC900NLcvtIsX43KGVmr9j
         BR6XqJNCbMDwCx+t6suKShWs1rTK2n4k/gqiFTbbiSXnGLIbhFZWxWq4tkU8gFiyAaBR
         IjU405hXEASSKrCTLPjz/xGnm6JNnl/IbXban/m48Xze8zDjHl2bt1+6QWIwBmrlqHQW
         EpTg==
X-Gm-Message-State: AC+VfDynz7KvPLf4oSkDJtXrs2qLphzePm631nzTXSg4ymP39+QA1d/Q
        6mcmSYXdmOI/NyCMm6K8oK9JPg==
X-Google-Smtp-Source: ACHHUZ4BIE6TbLK8kpe1owsqwPPBjFMHGvq1+gRfy4HufbUwKn/5NGiepHfgtjSj1AGPlndAamWF0w==
X-Received: by 2002:a05:6a21:7890:b0:11f:1aa2:666b with SMTP id bf16-20020a056a21789000b0011f1aa2666bmr1412485pzc.32.1686928698728;
        Fri, 16 Jun 2023 08:18:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:3cfa:2bcd:1a5:27ce])
        by smtp.gmail.com with ESMTPSA id a12-20020aa780cc000000b0063d24fcc2besm4593656pfn.125.2023.06.16.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:18:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     andersson@kernel.org
Cc:     amit.pundir@linaro.org, Will Deacon <will@kernel.org>,
        sumit.semwal@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: firmware: qcom,scm: Document that SCM can be dma-coherent
Date:   Fri, 16 Jun 2023 08:14:38 -0700
Message-ID: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trogdor devices use firmware backed by TF-A instead of Qualcomm's
normal TZ. On TF-A we end up mapping memory as cacheable. Specifically,
you can see in Trogdor's TF-A code [1] in qti_sip_mem_assign() that we
call qti_mmap_add_dynamic_region() with MT_RO_DATA. This translates
down to MT_MEMORY instead of MT_NON_CACHEABLE or MT_DEVICE.

Let's allow devices like trogdor to be described properly by allowing
"dma-coherent" in the SCM node.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Bindings change new for v2.

 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 367d04ad1923..83381f3a1341 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -71,6 +71,8 @@ properties:
     minItems: 1
     maxItems: 3
 
+  dma-coherent: true
+
   interconnects:
     maxItems: 1
 
-- 
2.41.0.162.gfafddb0af9-goog

