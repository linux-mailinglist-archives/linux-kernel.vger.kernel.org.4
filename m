Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15675FFA20
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiJONEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 09:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJONEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 09:04:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7D13E23
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:04:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so11451983wrr.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3o8F6Hzv4+9QpbVUjQpNY/Hm0jPjQUR08yEruJJQK4=;
        b=OShDUJrY8x7Bxem/6fuook3QozFgTgEl8mMG4Okk1cfdPk7azgJuv4+IcnEgv6XHtw
         uKxUvazHxrkQIQYqYLerac0YhNXrKHmXlqwPQ1eGFfwLRYctRe47JyLrU8ZPMhdZ9X40
         h4eOJsP4bGaRn86Jx4QRRIxxXsrRj5gPR2Xo6ag5d+1bjPflMp6jpipzvinWXUdp7UOS
         puOoeR8iszX+9KXCt/HQRdVdy6qVF2PNmtnWiJR09JzfG+LCJt0d57fNVaJw3O6fv2h8
         7s96Y1LmG7fRYZ8522UGKBxS5OTQeFAFimm0jam2ZFvtZNg3q94XhwSVLKWHLYZJv7vU
         R0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3o8F6Hzv4+9QpbVUjQpNY/Hm0jPjQUR08yEruJJQK4=;
        b=WNGJ4Rvd3R925RBnOyiwz1AdfYCNT5Dx6BRn8WwZbimRoDdbydKIGJLsdFaCuscuNz
         aAt6fGCEwbNEqoh15aQadESecBFAN6AjMhA9EPJ47Q3QhdX0oZpWjgvLKnYoNN8VZ1Hm
         KCGhpIQ8nUoOJEOgAOYbjWmDANvKAJHsOXGQRlROxpjbiWypYzqbMTX0fcp3ub28VaqH
         s6zzyOdQtA9qfB19smt6rybhPKGPiD1C2JRp9Nt3O3jA/d1fpzN9BIZECHbGZapI/PGt
         fF8Hyfz3WhqbYJj3ijAnrBFcTRpDrpQ3hK1/a4gwiu8HfAvYoY+divd++OKCFFzBDtIW
         FALQ==
X-Gm-Message-State: ACrzQf3ziBLp+66/Z5uJZn/SQzEjhLovz2SWvGsmpJ2JRPnyOOyNFpSG
        0rn4JCGmjef6U/nBNjmy9b/odQ==
X-Google-Smtp-Source: AMsMyM4OwfgcZW3sXYikL2tTVO9UnDpI9FTAMRqzkDGimWpLZ6Ul88Ul+OIv3x8gFDs5mLczPY/ARg==
X-Received: by 2002:a05:6000:144d:b0:231:5786:f763 with SMTP id v13-20020a056000144d00b002315786f763mr1441807wrx.313.1665839081533;
        Sat, 15 Oct 2022 06:04:41 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id r12-20020adff10c000000b00225239d9265sm4151282wro.74.2022.10.15.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 06:04:41 -0700 (PDT)
From:   Fabien Parent <fabien.parent@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Fabien Parent <fabien.parent@linaro.org>
Subject: [PATCH v2 2/3] cpufreq: qcom: fix writes in read-only memory region
Date:   Sat, 15 Oct 2022 15:04:23 +0200
Message-Id: <20221015130424.1923706-2-fabien.parent@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221015130424.1923706-1-fabien.parent@linaro.org>
References: <20221015130424.1923706-1-fabien.parent@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes a kernel oops because of a write in some read-only memory:

	[    9.068287] Unable to handle kernel write to read-only memory at virtual address ffff800009240ad8
	..snip..
	[    9.138790] Internal error: Oops: 9600004f [#1] PREEMPT SMP
	..snip..
	[    9.269161] Call trace:
	[    9.276271]  __memcpy+0x5c/0x230
	[    9.278531]  snprintf+0x58/0x80
	[    9.282002]  qcom_cpufreq_msm8939_name_version+0xb4/0x190
	[    9.284869]  qcom_cpufreq_probe+0xc8/0x39c
	..snip..

The following line defines a pointer that point to a char buffer stored
in read-only memory:

	char *pvs_name = "speedXX-pvsXX-vXX";

This pointer is meant to hold a template "speedXX-pvsXX-vXX" where the
XX values get overridden by the qcom_cpufreq_krait_name_version function. Since
the template is actually stored in read-only memory, when the function
executes the following call we get an oops:

	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
		 speed, pvs, pvs_ver);

To fix this issue, we instead store the template name onto the stack by
using the following syntax:

	char pvs_name_buffer[] = "speedXX-pvsXX-vXX";

Because the `pvs_name` needs to be able to be assigned to NULL, the
template buffer is stored in the pvs_name_buffer and not under the
pvs_name variable.

Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
Signed-off-by: Fabien Parent <fabien.parent@linaro.org>
---

v2:
 * Added missing "Fixes" tag
 * Rebased to not depend on another non-bug fix patch

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3bd38acde4b9..82e0339d7722 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -265,7 +265,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
-	char *pvs_name = "speedXX-pvsXX-vXX";
+	char pvs_name_buffer[] = "speedXX-pvsXX-vXX";
+	char *pvs_name = pvs_name_buffer;
 	unsigned cpu;
 	const struct of_device_id *match;
 	int ret;
-- 
2.37.2

