Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE9D6F879C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjEERbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjEERbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:31:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57CE1A1F1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:31:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f193ca059bso13909305e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683307874; x=1685899874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R88W/MsLhp/0NL5NeVi4LXMj0r/Vf48QsjmcL+kmlyQ=;
        b=DPiEEnWfbn7ckQyPjyDlULKRh9dJjv+GQ4atmaoe7clzBaXVyhNOhOdT+2gPAkxoIw
         7gQ03OHdUbJ5xOEMdtULkckaNMkF+FRYKV1X/Diimu2YS+RVC1Pex+Iw3uxuI4X6ehdl
         O0xgXDgw5tR9ZyqBk/6UujKh8BoCb/jwWzr5LNTBoBd6HI8tINwTQY2F4YhSPzQYY0DE
         x+bncsomV7ZhZvQV4gJAZDPl2KIHurJTLbYT4xfL7yowy1gM70Oxb+xeLOUglPUFV42X
         9XubP6qAC3+I2yQfsKPVtVY9CLYp+fJ/+oUkYA4W0DKSA6ieSsy0EnremMqhesfMHiBf
         UMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307874; x=1685899874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R88W/MsLhp/0NL5NeVi4LXMj0r/Vf48QsjmcL+kmlyQ=;
        b=JYja1lemlAiRalTfn5r7QdimXp8ykzP+c1yUG/tRmzzfF3lbEXggLdA9nDSGXPnPLR
         7MhYnP6YtgyuWUftBadKQ79hskbR7viZhj0jtZuW77mZ2q2GSq9kqoKR7o3x0JJPt5Dl
         BDD1uX0Re937DImLcJKkX01fcKVzhu73qD08MRMR4ttOswc2H5gcDzB6uEPWckq3A7C3
         xkPpiYpZffQM+z9QnLhv9DbMaZX0dx8nqab03ec8i497vqXW5TMDQuj80lnjckuZtiUe
         HQ3x9G2+rRvLGf6oxO9Swqy3qBMXBETqAVcdaThSy2w/bu44k7WmjLKQrwFF5VXupPjb
         +frQ==
X-Gm-Message-State: AC+VfDzInrF4Pb2neWK2gmDj4f/Yyj5d6jFyJLuWCI8g7r14BPAt5qSD
        /07L33tzhN++5cnzIGwYlRzjY/nzlCF8iho1QbA=
X-Google-Smtp-Source: ACHHUZ4whgdo/RENRnIVSm+7sYZPG8thfRpLMhsFcNRIV66nqszXsRWG7/OcrlktRY0AylG/JxOenA==
X-Received: by 2002:a5d:4101:0:b0:306:2c43:7255 with SMTP id l1-20020a5d4101000000b003062c437255mr2094516wrp.35.1683307873831;
        Fri, 05 May 2023 10:31:13 -0700 (PDT)
Received: from lmecxl1178.lme.st.com (lfbn-nan-1-1169-52.w86-212.abo.wanadoo.fr. [86.212.112.52])
        by smtp.gmail.com with ESMTPSA id a15-20020adff7cf000000b002f6176cc6desm2971170wrq.110.2023.05.05.10.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:31:13 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v6 4/4] firmware: arm_scmi: optee: use optee system invocation
Date:   Fri,  5 May 2023 19:30:12 +0200
Message-Id: <20230505173012.881083-4-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230505173012.881083-1-etienne.carriere@linaro.org>
References: <20230505173012.881083-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes SCMI optee transport to call tee_client_system_session()
to request optee driver to provision an entry context in OP-TEE
for processing OP-TEE messages. This prevents possible deadlock
in case OP-TEE threads are all consumed while these may be waiting
for a clock or regulator to be enable which SCMI OP-TEE service which
requires a free thread context to execute.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v5:
- Applied Sudeep's review tag

Changes since v4:
- Updated to new API function tee_client_system_session() introduced
  in patch v5 2/3.

No change since v3

Changes since v2:
- Fixed syntax issues (missing ';' chars), reported by kernel test robot.

Changes since v1:
- Updated to use new tee API functions tee_client_request_system_context()
  and tee_client_release_system_context().
---
 drivers/firmware/arm_scmi/optee.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index e123de6e8c67..25bfb465484d 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -440,6 +440,10 @@ static int scmi_optee_chan_setup(struct scmi_chan_info *cinfo, struct device *de
 	if (ret)
 		goto err_free_shm;
 
+	ret = tee_client_system_session(scmi_optee_private->tee_ctx, channel->tee_session);
+	if (ret)
+		dev_warn(dev, "Could not switch to system session, do best effort\n");
+
 	ret = get_channel(channel);
 	if (ret)
 		goto err_close_sess;
-- 
2.25.1

