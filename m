Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E216B5AF0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCKLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjCKLQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:16:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4B58C960
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:12 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cn21so535620edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ii5x/Q+JtDY3RQJyVxBKzIOeCRWyExkm9YhpbbdrbmE=;
        b=j/5MoepSDsQf9wzHX9Q+DN5qGfZKFOp6ro5TkCXoVjU+nBP06h2lHLeWmavj9sDwTh
         7gv60EHqlQpJnsMPJYzgblxY/481pFHJtsgkrdG8ehdXqO56/8DnHGE9gfjeiHaT092K
         lseVBUzoJyVOEAByxjxwp4/0Qnuf8MUGDRHvPHpYdgix26pk1OAbZAjXZEAiR1QEyKrZ
         0AL/+PKSIEZOSuWHygTz0ZoDaKi0x7C9uUm/aBJUj+ela2wffdRQnVQPt2zHaoD5oPrj
         qWEDK+buTmHAzJtXsGkcWl0VQaPZ78dIsfIUU0vd6JJkLSbSTrU24uBTPm+QaUQWUcV6
         Zu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ii5x/Q+JtDY3RQJyVxBKzIOeCRWyExkm9YhpbbdrbmE=;
        b=lYp1VCsCZUtZ43vSaEjwNML8CLauo6tBr5g30ZWJyvx1H5oaTIZ8bVVig78mw9WzmV
         LpiYrFHi0dLQh7SmkqBSYVdez+VbJPM9dz6xi3SC9icjlEDCHdnK25SqLqdcbflL9m54
         NG6fhc4I53l39Od59FfVArwYoVJJ+Saw9DnZ+FaWyHPoWvw1a7rowX+9FSSEYiTj/5Pd
         CXB67qBmxy5uNyZUi82VWfVWC5eZ/fAakhAcvWGSWLSlYbty2+6Wu9h897B5a/EYY6Zy
         wZKjIl7VYsCiiGMd4RY3ehBBJCV8BISDIVMbn51hasiPGInZG5sxr8yeQq2b12Hs9HSO
         Z7yg==
X-Gm-Message-State: AO0yUKVX3SxrgcQWj73+Im68M4hg685lGIWEOPp6SfgPoD1BgkXdEHRk
        vjzSnuqLpqI1+BiUdVg15TEdVg==
X-Google-Smtp-Source: AK7set+vTbLLS6UrZSQKDhTEr5i2GL37TKhcaz1X9MdNgwjIEfT2ez7VQidkZv39srr2rWZLT7KDSg==
X-Received: by 2002:aa7:c493:0:b0:4ae:eb0f:892e with SMTP id m19-20020aa7c493000000b004aeeb0f892emr23230349edq.20.1678533279881;
        Sat, 11 Mar 2023 03:14:39 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id hv12-20020a17090760cc00b008b17cc28d3dsm990803ejc.20.2023.03.11.03.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:14:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] hwspinlock: omap: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 12:14:38 +0100
Message-Id: <20230311111438.251422-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/hwspinlock/omap_hwspinlock.c:164:34: error: ‘omap_hwspinlock_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwspinlock/omap_hwspinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 1fb3a2550e29..dfe82952671b 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -174,7 +174,7 @@ static struct platform_driver omap_hwspinlock_driver = {
 	.remove		= omap_hwspinlock_remove,
 	.driver		= {
 		.name	= "omap_hwspinlock",
-		.of_match_table = of_match_ptr(omap_hwspinlock_of_match),
+		.of_match_table = omap_hwspinlock_of_match,
 	},
 };
 
-- 
2.34.1

