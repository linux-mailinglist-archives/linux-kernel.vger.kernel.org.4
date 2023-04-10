Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318FF6DCC60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDJUyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDJUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:53:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0128DE6F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g5so8916390wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681160023; x=1683752023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkQUnOWLA+V2iTlaapxkS0DuXVJow8vrvqyKzHmwuBE=;
        b=mSw0zD5otsKK5tmRq1nzEby61f1faooSdycceSRUQVSbqwQtQ3QNrRcjZiruaVhTX1
         01z0EFsycSofwCc38R6wZMtBEmoO7U5lrSgky/sBpvvget+6owZTp3TaT9grVrgYEJxe
         3IFHUkU/yH0MnYIux9ZZElCzeEEF7gId0w05Qshto+uJElSmGN/miERwnchMIKeSSDwb
         2jADe8x34PHeZfU50+CCeeCYv5rTqPxvMnpPmPgrgFsO8MFdU9hSujx45zKX+kMvCVrE
         dcJO2yuj8TD54nLGr8CpsZU02rvzY812iXt2q1vbZ4uCsX8NNW9mJ0zqF7mtQnfBiooT
         jKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160023; x=1683752023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkQUnOWLA+V2iTlaapxkS0DuXVJow8vrvqyKzHmwuBE=;
        b=HW7W5ZREAbd8B9U/OJ4auLwe1kKfvh+xOMU3jk100mbo01HHNHVNM2ekQQfu6KrLBc
         KiIjl7wznfjuAvGgY5ZWw6AQ/rBSnkztUqWvJtiVD1ND8rH35iQEZwADtCU0qaukYi8J
         zrZnlcc9k683y1sI23lG7FHL/OPw/2EmrYlicBLIkQ7jrMpm0D5xzL9xr///giBjz3+l
         tZ1KVLka7O2s7AsyHd+tkLwUrb3AKaNMn54yjeoajwyE9zxGvMvFs+FktngjuVukK25a
         h/x1ppl4a8schioFRvqMdm8NZYoGC9GV9uX48Qs0iyYUyhGMuVlBqbxDPpe46ommtdpJ
         Z0zg==
X-Gm-Message-State: AAQBX9frshONTzKMPM2a5RJQnhEbrXSzUJZnkG86MTZGLpi7AX5hsweq
        +LDRdXiVjBBIQZ4COS55H3uEPw==
X-Google-Smtp-Source: AKy350bg2a4lxEjB/SUZECrf0UoKpqThrQonwo7vjEvFnpkEwzrg+Jh/9wFjd/+2RSeBjkpV2n70Tg==
X-Received: by 2002:adf:e885:0:b0:2e4:506c:6483 with SMTP id d5-20020adfe885000000b002e4506c6483mr343276wrm.48.1681160023519;
        Mon, 10 Apr 2023 13:53:43 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm11966789wrs.16.2023.04.10.13.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:53:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Sujith Thomas <sujith.thomas@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 7/7] thermal/drivers/intel_menlow: Make additionnal sysfs information optional
Date:   Mon, 10 Apr 2023 22:53:05 +0200
Message-Id: <20230410205305.1649678-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Menlon thermal driver creates specific files in the thermal zone
sysfs class. It is specific to Menlon and these entries look debug
code. It is probable these are not needed.

Let's make the code optional and disable it by default.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/intel/intel_menlow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
index d720add918ff..d46dacea1b4d 100644
--- a/drivers/thermal/intel/intel_menlow.c
+++ b/drivers/thermal/intel/intel_menlow.c
@@ -374,6 +374,9 @@ static int intel_menlow_add_one_attribute(char *name, umode_t mode, void *show,
 	struct intel_menlow_attribute *attr;
 	int result;
 
+	if (!IS_ENABLED(CONFIG_THERMAL_SYSFS_OBSOLETE_SINGULARITY))
+		return 0;
+	
 	attr = kzalloc(sizeof(struct intel_menlow_attribute), GFP_KERNEL);
 	if (!attr)
 		return -ENOMEM;
-- 
2.34.1

