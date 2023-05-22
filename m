Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E359170C2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjEVQIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjEVQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:08:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BFAB6;
        Mon, 22 May 2023 09:08:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso1259815b3a.2;
        Mon, 22 May 2023 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684771682; x=1687363682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OeP+B1gScMLY21VO6JStum8TjH65rS3eZqbyyJSsz8M=;
        b=LzyczJMt4H4N9i8we+GVkc/5i6X6cfp1h0iEctL4SKrhZ+c2YYrJQm0M1doX6uKxFK
         za3EW81MsgrK7Gyqw5JA/gzK8Xrq6611Gpe8z+/TAOUmnTLP0sgJLJY2/GaA+qGSKE5L
         nwfIuebnsPQR9vaBun1w1Afec9MCi8xLwhaPRznvr0ef+qUJx6F1jJihvGCsUoIrANI7
         gyOtxNdjAV+g1BG7aBDVD4uLhFK1QLg70YlPO2KLAQof9bBQuZOVtl/m24MwBZRIFezH
         bIK92z3a2brCS/7eYP7X45lP6UPUw3yBy4l3FDbbc4zNMExafyoaOpMxRtVXorRh+gID
         Molw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684771682; x=1687363682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OeP+B1gScMLY21VO6JStum8TjH65rS3eZqbyyJSsz8M=;
        b=YabSMmpUPmKvVOfi3HGgsmlsXnh4JP3ab8o8xjHcjSZSQVC0v4Wljue5C2QTqSTTG8
         IY7IpPglKRBhLciDFVURNYmwq6PZ2IJEbC8ZdlLTKWqltXgLsvsVAkGoY6292Lfl9w3y
         Fdoa1378RZFLYhBNxsywDTQxaD1fmT3o+9UOmoZxzpW8AkVEnfabe4Ux+aGaOJOLEzdp
         t2y6nhW5QWEmRLQmrqxv/BV3AunlI4oe6LMeCzgorswWCunYpuDtlwsVE1GQ12+l43pX
         AeQ0fHbfguErNtzXGV51SdngmHnQCV7DkHsKrMHLUqqrR+E8OvABkgxLHWqVyMdmGPdd
         xe9w==
X-Gm-Message-State: AC+VfDzR+0GfExkBYqZhpNm19Eb2sXuORN9XXjAqgJOS3RsopHh5REr8
        k4u2bCaned1r0EVoXMWn51o=
X-Google-Smtp-Source: ACHHUZ7VNi2gGkMlBN0kPTUWtW4HjFxOM+Pm/GzVWbMG6r3ekXquKuH+9yb/vbQ4hbnbkAuVjsP94w==
X-Received: by 2002:a05:6a21:99a8:b0:10c:3557:399a with SMTP id ve40-20020a056a2199a800b0010c3557399amr896261pzb.49.1684771682082;
        Mon, 22 May 2023 09:08:02 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-81-153.dynamic-ip.hinet.net. [36.228.81.153])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79215000000b0064858e255d1sm4345017pfo.65.2023.05.22.09.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:08:01 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: rpmpd: use correct __le32 type
Date:   Tue, 23 May 2023 00:07:56 +0800
Message-Id: <20230522160757.284165-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use cpu_to_le32 to cast constants to __le32 before comparing
them with __le32 type pd->key. This fixes the following sparse
warnings:

drivers/soc/qcom/rpmpd.c:895:31: sparse: warning: restricted __le32 degrades to integer
drivers/soc/qcom/rpmpd.c:896:15: sparse: warning: restricted __le32 degrades to integer

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/soc/qcom/rpmpd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index f8397dcb146c..99b017fd76b7 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -892,8 +892,8 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
 	pd->corner = state;
 
 	/* Always send updates for vfc and vfl */
-	if (!pd->enabled && pd->key != KEY_FLOOR_CORNER &&
-	    pd->key != KEY_FLOOR_LEVEL)
+	if (!pd->enabled && pd->key != cpu_to_le32(KEY_FLOOR_CORNER) &&
+	    pd->key != cpu_to_le32(KEY_FLOOR_LEVEL))
 		goto out;
 
 	ret = rpmpd_aggregate_corner(pd);
-- 
2.34.1

