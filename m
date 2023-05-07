Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76EC6F97F0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjEGJOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 05:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjEGJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:14:01 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27AC18DC9;
        Sun,  7 May 2023 02:13:45 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 952FBCECCF;
        Sun,  7 May 2023 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683450781; bh=i6MUY07ZK9aW+SSGpZnVlsq92bvXpLa0zV//65KE6Q4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=jUnIRj2bvZzcpmqU388i/CJpLh5Ul932Kl9UyU2ykbyRLUkyhrRpMOxUf7NB3tx9a
         sGOOjMZDmq0yBLei6hO0kN60rfIb4G8dVrwkfK8MJPlh25GeS7O/De9Jd6tz+kAJPW
         16pakdWQXxOUW7rU2JCIaBaIivgy0X3CJUyLNvWA=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 07 May 2023 11:12:18 +0200
Subject: [PATCH 1/6] soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v1-1-3e24e2724f01@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=i6MUY07ZK9aW+SSGpZnVlsq92bvXpLa0zV//65KE6Q4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkV2uXNsyOTr0Fd1werpTcyV2+17F9vo/cxSUxi
 kgvyaM2K7yJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFdrlwAKCRBy2EO4nU3X
 VvE/D/9UjaK3G0QJaYUD8DHa3KGYor5qczjYAkRVxMGHm0T9h6ydke9VFQhJ78gPrmoExDEnwpA
 a35r5HA2Mh7ciTZPv+5dJU8mS/j33+Au3V4JeIy2i8O5sNIbKKmgbyY/Rp5UMgdeuSE1/nH0GvS
 eMHaA5TmGLObD3MuoUEElmW6fO2v7tCBBP8c6OK/bQlJzMOYVj5bv+4fJlGilFmw0jcOxPEe6oK
 3Q/BVIUqtaYy1CFZjGFtKFc9mKLQulRlb3jeMGVcsEsT0t2Uos/txlsO5LtrXmrMP/Be4+e7qLO
 HJMfTvguo+7J1On4m2MspvTJwDDzNAjIpsvf38rIQn9MPSUJQtInbzGkEkU7EqWMTCzBeb8fFtc
 2qiGirtKFOWJ92ywhXw1GIVsyv6KAplISE7dcduyEu4cajWZ/o4pUaPDhOBp6/Rx8ajWBQlPDNG
 rCSy9xHoj2VAHwSkz0vNUY0rMbT/vq0igzyh5WcZAQmoND/Kn4r9CZfynjObeFhnoaiSEI5qHIr
 Qy/C1a6rXWdHRWl6aceHsE1BPNr6wp99UdHBCt5ae8LfcYkuEShifaaLWi2b9q9MKeLNfruW/5/
 SPupv/ICXH/RVSW0U7HUIdCs1Bo8oi/4vm6e1ZRaAem92YBCmsFsrSO/XgTxq1DciFUavtFeQY5
 oj3WpnCnF/uIFjw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're using these two macros to read a value from a register, we
need to use the FIELD_GET instead of the FIELD_PREP macro, otherwise
we're getting wrong values.

So instead of:

  [    3.111779] ocmem fdd00000.sram: 2 ports, 1 regions, 512 macros, not interleaved

we now get the correct value of:

  [    3.129672] ocmem fdd00000.sram: 2 ports, 1 regions, 2 macros, not interleaved

Fixes: 88c1e9404f1d ("soc: qcom: add OCMEM driver")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/ocmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index 199fe9872035..c3e78411c637 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -76,8 +76,8 @@ struct ocmem {
 #define OCMEM_REG_GFX_MPU_START			0x00001004
 #define OCMEM_REG_GFX_MPU_END			0x00001008
 
-#define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_PREP(0x0000000f, (val))
-#define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_PREP(0x00003f00, (val))
+#define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_GET(0x0000000f, (val))
+#define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_GET(0x00003f00, (val))
 
 #define OCMEM_HW_PROFILE_LAST_REGN_HALFSIZE	0x00010000
 #define OCMEM_HW_PROFILE_INTERLEAVING		0x00020000

-- 
2.40.1

