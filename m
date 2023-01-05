Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C95665E95F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjAEKyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjAEKyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:54:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C134C724;
        Thu,  5 Jan 2023 02:54:22 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s9so3699127wru.13;
        Thu, 05 Jan 2023 02:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdHeHF4mTbDvrlFZGioHAvpse64q4uNez3wi8r/aN44=;
        b=fOxOeudJ7qAy0oYQORrvEOu/JM0hFJeJ7YQDLVMxcniHQrkD783Ur7EDAe6AYxPcDc
         oPudqEezkneoTporSI8hTHexd73DDS4IGDNLVgcmSK/fWTNRH6YzPPp2Lqip/Rdlans7
         hSLGK/EDE9a1CRKpdFYv38u/op+ZrUej1uw4uyAMtED5fPDt0fMkkh5UxWPqGuv8pcFO
         cqe0mB3KDGgyfJ72VlWs53M1NmELpcnC2LNzEolrhCnepUZuL60lnidKj22MDQe+k3Fp
         Gm15xfPAqsSTlqgkMR0kfMEqKoCI2u8tvAuL5Fq8ZKZmE4fsdxqsLCuOHyJWrg2eOWB2
         5kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdHeHF4mTbDvrlFZGioHAvpse64q4uNez3wi8r/aN44=;
        b=nU8kdjIHP+6OggleH+BkPPFR1ccn9LHRsO2lCGTEygZSDJEpaQmD9qfLwT7Rc9+X/m
         ooZrKvEmzmFPYd4Qp94Nvy3U9eXXdgutvWqW3+wXvdfR9+1F/KhBJTnZIq+yr7o/ZPJ4
         w9KeeKDTNWjCxvcCRW5dK6f2nzi4s0xK+XtQbike6jXFtx6hzF2F6ThlLXoo3vjpJJKu
         wpes9mCcEjd2b4zeWyyamnJ6nPi53Mchqft2vhXzxPOaop5Hc4M/YQc8t4JMl78WWFAk
         iS882WGGfThUIwf0AtWXG1t6Gy7Vy0StOnNRFDTKR6b7CNatc71WQgeHTM7Jmk8dcj7Z
         qbGg==
X-Gm-Message-State: AFqh2kplXhXf8vw1mV9EcYsJ3odOQBA7SHqCGA8/gRVhFP2bzwTaiB3T
        wkYUAfI26YYzvMkcu5CVsTQ=
X-Google-Smtp-Source: AMrXdXulo2y4fgRl+GrzA5Y5zlgpQoKtceGrfDdFonoUQamJ9TJsbsT8UIXFlKRhC0HVHq6Y0mdMZg==
X-Received: by 2002:a5d:5b17:0:b0:2a3:50c5:9c29 with SMTP id bx23-20020a5d5b17000000b002a350c59c29mr3734303wrb.14.1672916061080;
        Thu, 05 Jan 2023 02:54:21 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d14-20020adfa40e000000b0029d9ed7e707sm8256321wra.44.2023.01.05.02.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 02:54:20 -0800 (PST)
Date:   Thu, 5 Jan 2023 13:53:42 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alex Elder <elder@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: dcc: Signedness bug in config_reset_write()
Message-ID: <Y7asNqoIapctHmbI@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ret" variable needs to be signed for the error handling to work.

Fixes: 4cbe60cf5ad6 ("soc: qcom: dcc: Add driver support for Data Capture and Compare unit(DCC)")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/soc/qcom/dcc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
index d4101f79cb5d..1e2cbefc1655 100644
--- a/drivers/soc/qcom/dcc.c
+++ b/drivers/soc/qcom/dcc.c
@@ -808,8 +808,9 @@ static ssize_t config_reset_write(struct file *filp,
 				  const char __user *user_buf, size_t count,
 				  loff_t *ppos)
 {
-	unsigned int val, ret;
+	unsigned int val;
 	struct dcc_drvdata *drvdata = filp->private_data;
+	int ret;
 
 	ret = kstrtouint_from_user(user_buf, count, 0, &val);
 	if (ret < 0)
-- 
2.35.1

