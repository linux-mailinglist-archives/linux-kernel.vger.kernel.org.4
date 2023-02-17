Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5DE69A953
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBQKrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjBQKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:46:46 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6C1644C1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:43 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bx13so681500ljb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoiQaMMXwDXYQsRgtWV4mTA63/tUIiHdh1PBizMV2mE=;
        b=q/Tk77C78rdYacg8u6jmhO6XQ8QhPm8IuVF1gXA7/t4slxvyDOUATh9eTr9WZMm3x2
         JmGB+dCuADdZBX+izzyPfR146hCh1b71sq1JvooAFIydPEPgS9iXxf0GtEQ7P+kqZaUF
         21B1ZDShbKjGjRGZot8kZIvdJ8VQTvkUnnabYiA1306obHAW1kHoMi7PhrMPrjSNl2Ws
         53okno+fyjuKh7nSSxEOsjmUCM0rqbjVGxi4CraLS9bTSjNp1iq2eHTOpDbuiVCft3yx
         PnSK+P9r2F9cXP9VXD2dcKmDpNCg+npqD2aLi63AF7nQdyIr10fY1j/JoXZND53rhA3e
         EeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoiQaMMXwDXYQsRgtWV4mTA63/tUIiHdh1PBizMV2mE=;
        b=DDQgqVwa8ZkFJiYxSTRTO7fhaqsQM0w2f7EiKk0xwm45Dq0RH/5/DWTHNNdVnNj6Mo
         RDx6K5lgJBngGqqkr+y6f0GTHnuGXaySi5VYzcguO507iBijCt0P5939DwDldMGlhxS5
         adg1EJAX7DdTtu1qZk4xRPXxJlQ6Szs8Ax+oNmyDsrlnFi8Bphcov1qfLMOm7R6L8bDB
         72yBRRBZlQXnZSjP6hYUBiq2iPwLvpeUJV6U57v8FDhwmnrxD2fP+rXAsGFWDXqqIWsy
         78no2TetJaq5U5+NvESNlE3zJPfwnkiOKvQvmhRTpAcugzCI4TYv3lKvzl/E74KdBmmy
         /wHg==
X-Gm-Message-State: AO0yUKUbLv3kQeIXo9ISqMwYeBUzWlN3BusBQnvImnpjjhzQergiCDbg
        9WO0eHXYBkOvhhGz0668fVmgOQ==
X-Google-Smtp-Source: AK7set/EAFPURO6z3yLtlqei7ycpiwltwi+qBdgt5h0ULlyGLdM5suUx9fQ4ik/VgJvJdnj3X7FhQQ==
X-Received: by 2002:a05:651c:1991:b0:293:4477:5df with SMTP id bx17-20020a05651c199100b00293447705dfmr132480ljb.37.1676630801874;
        Fri, 17 Feb 2023 02:46:41 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651221ad00b004b53eb60e3csm645940lft.256.2023.02.17.02.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:46:41 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 11:46:28 +0100
Subject: [PATCH v5 07/10] interconnect: qcom: icc-rpm: Allow negative
 num_bus_clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-icc-fixes-v5-v5-7-c9a550f9fdb9@linaro.org>
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
In-Reply-To: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676630791; l=1103;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=0zGQQ3Z8BxpWRbcjEih3N3lnw1JS4c/rutJ4C0HFNWc=;
 b=m8qeHutvzcJ9ghyjAS6EUExhare4+FDIPLNFYVJDwolT4L6g5zbqa4u9OUFWtbvi9sW/+x6qgHQm
 eu8r8e7JCKUQ7SUDaEv8aS/POTgMNM7b2GDVLDh5epXKrW7mS/eU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some rare cases, buses will not have *any* bus-scaling clocks,
which is "fine", as the voting can be done through RPM provided that
the necessary QoS clocks are enabled. Allow specifying a negative (-1)
number of clocks to make the driver accept such cases, without having
to add a lot of boilerplate to all existing ICC drivers for SoCs with
SMD RPM.

FWIW this value was previously being assigned to a >>signed<< integer
as well.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 729573f0d9fe..9dd631964b8c 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -96,7 +96,7 @@ struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	const char * const *bus_clocks;
-	size_t num_bus_clocks;
+	int num_bus_clocks;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
 	bool has_bus_pd;

-- 
2.39.1

