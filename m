Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0135E5811
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIVBcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIVBcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:32:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7E59F0FE;
        Wed, 21 Sep 2022 18:32:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso588354pjm.5;
        Wed, 21 Sep 2022 18:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=f/4HKARNmzVmkSfnU23KZQtCIICUOOHXgp/I5QaOMBU=;
        b=UfslFXpiSKl3jhkwDzQb0DfcOeuyx97p4rBeMs9jVh7MdHIuyaE6mdZbuwpL1DoAlC
         /VuWCjUCvfEYOtXk3rq/2epCNgeI/AvNN/fdODwVlgT+eXMTPwWN1aoGYeAboOwpsBtl
         VtpkuIblKHvbJabx2ThxeBuC2VgQms5DVEvmr27j7SFUqL6Iye+meRB6yom7hZSgYrPP
         hS2bmNjLkADagdLpyoYcuQJ6K46cxbtrZgdt427lx40p9wRKF3xrJ5uRGvFGWtwgtHVC
         P5BHVS7KxWyRnOJBH1M0M9dc1piD1t/mEiP2lFlP7eANXYKaT1Jmm1ea1QrNHsdyJOHQ
         wSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=f/4HKARNmzVmkSfnU23KZQtCIICUOOHXgp/I5QaOMBU=;
        b=Qcgb78QFIHpdIdzZ/H6Z11nRQYE5glA7YbmTCGjVET3sQ9kfTadV7xpcDbCO6LjFwx
         oBCQjomcfO5XMwQuuHQpYCq0N/j/VjHdDxHtXaiuM6OyWc0cpc6xDEzFQEB2KIf6W4Vz
         ahe56Wrb5hIHMjyDYhFKO6uejpl4snq4fign3jd1sUNzmalPCRaSPGOWxEjIAAlZu1Ha
         LYc5L5K64Reb5wSYtHrtCNgutNPjQ4lchuk8Q0CqEQbtt8MTjh3CJh7olmAANHenjrdF
         o/rWdQLw7elGiil1CBKECjj7IAs40RJ7sVpYIVXmGYaHW9dQGtT0QFfeBsWm8aSq0dEN
         fApQ==
X-Gm-Message-State: ACrzQf2Ga+jtxtAli3hNRpXDqJ4s7dECZDEzh1AaeXtZO8nq7HGlAYs2
        rKFowgqqKrgwko+wFp2SpEs1zwDCy6Q=
X-Google-Smtp-Source: AMsMyM6OVCKOcGIm4Hc91RK7iebJhLQUadYEEyK1wX+gAV8eFXTy4dlU7R520ea2g6N9zq2E53EL2A==
X-Received: by 2002:a17:902:db0b:b0:178:1599:531d with SMTP id m11-20020a170902db0b00b001781599531dmr876177plx.36.1663810355593;
        Wed, 21 Sep 2022 18:32:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e2-20020aa79802000000b00551fa0e2b2dsm2852285pfl.206.2022.09.21.18.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:32:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf lock: use strscpy() is more robust and safer
Date:   Thu, 22 Sep 2022 01:32:31 +0000
Message-Id: <20220922013231.232933-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 52a6a10a610c..b6837b7df110 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -949,7 +949,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 			if (offset)
 				scnprintf(buf, size, "%s+%#lx", sym->name, offset);
 			else
-				strlcpy(buf, sym->name, size);
+				strscpy(buf, sym->name, size);
 			return 0;
 		}
 
-- 
2.25.1
