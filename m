Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED971608D4B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 14:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJVM5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 08:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJVM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 08:57:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F2922B38C;
        Sat, 22 Oct 2022 05:57:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a13so15438604edj.0;
        Sat, 22 Oct 2022 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elZSYe3VbormSDAP7uv9H4cczBV3tZh4oUja1hlsR2Q=;
        b=GwyVQomAlS8vYmx2ITPLDkpqc3PV5qR/XCYkut01ioy6GM8244F3+2JhfruEja8STG
         FUSztCJZi6vCpT28wtHY4VLFqJTElNMYw8gmFACKtsgs8hNsaP4CeC1L5va3heoAMawY
         SZQQdpvzs6ttUtCyKkU9mgZeQQBpnGmVddREnT487+9nY14DZMItEgC6C/eetzdyiJMS
         LD9l7saXsjjxvmoImhjLZHoHkKaS53lees9iMDh/dR6/4Yif5xFvtlpsrxFUBZkWqYol
         SErJlRJyfQQT0Pln3duYpIpWTRLndBPOTkJclSJX0UH7ZjLWC2egs/F7wIix0YXHQ0ui
         RdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elZSYe3VbormSDAP7uv9H4cczBV3tZh4oUja1hlsR2Q=;
        b=UXYi6NbkvVJ0rVnY2ICIXYFfhm/0GOjEIEAW0e9Q3wOedgr6zDO5VOZmcFbVDMZbYu
         sUPsB5TY/32EDc71fuWt5gXVZfq8dENDv8z3PZJPe1Xxu4G4k6vr15lHGGheZ0II3glb
         2Jol4s2yDLvMr+pFOSncn4H1lqDJFPEWD0NxfolWqmQzmrLRRXob9RRkSe/VCQR7/yoo
         RoxiX0+ygpGjXPr/bFcStIHDNDU85ibmWrJM2hvktVXxr6czmRoSGdCBKSHUIzcp54YL
         H7Cozw1uu2OWoo0jPMxvmEauMFTF/CwcbHqr3Lgb0ImzzQGVyTmfl7mxRIzSMTsNiFRg
         CmuA==
X-Gm-Message-State: ACrzQf3fJ46NVgVvEti9IcK2wILh3H5Fn44ICYL93rgTFUJBpjm4G0VU
        95mEelmewR2aWKPfAvCUBD4=
X-Google-Smtp-Source: AMsMyM4B0jHt87VsmbrfC+qSz9CqM6sfozpwpf91yweEP6Fjk2wo+qqPUL683+TVj3rBql/pcsyZ6w==
X-Received: by 2002:a17:906:9bc3:b0:78d:816f:3743 with SMTP id de3-20020a1709069bc300b0078d816f3743mr20100171ejc.380.1666443431241;
        Sat, 22 Oct 2022 05:57:11 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id t29-20020a056402241d00b0045ce419ecffsm15173970eda.58.2022.10.22.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 05:57:10 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 2/3] thermal: qcom: tsens: fix wrong version id dbg_version_show
Date:   Sat, 22 Oct 2022 14:56:56 +0200
Message-Id: <20221022125657.22530-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221022125657.22530-1-ansuelsmth@gmail.com>
References: <20221022125657.22530-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For VER_0 the version was incorrectly reported as 0.1.0.

Fix that and correctly report the major version for this old tsens
revision.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index af688ce4d14d..467585c45d34 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -692,7 +692,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
 			return ret;
 		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
 	} else {
-		seq_puts(s, "0.1.0\n");
+		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
 	}
 
 	return 0;
-- 
2.37.2

