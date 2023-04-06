Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3596DA59B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbjDFWMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjDFWMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:12:31 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B1A5FF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:12:30 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id m6so29408659qvq.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680819149; x=1683411149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f510guQXqFwIfREWkiywrIxQX82C636wyP2+R7tPw+E=;
        b=LIgIS9tP1SFqPGMUMtnUYFwUABfdiHh5i0+i2nO/SVSbCb/mqLpKIrOUksNXK6zNjn
         W5D/TBunrvCdvpb+SQsSIuo12hWlv+NAU9diKXXxzL+GYc4UmB2JXTZtutjKUkQQ2qG6
         ddRyX6tGASM6krpFS4GuPtouxAVjhUhusEIl5KHmIB1WLVq/slxTcFdYNY6t59zALUpd
         0QeA49yArv1NPcm3QE8vC4ZBCNA13pFMVvNJ2sQu25eRsH/+RNoYcPNilK+rQPmfMq4K
         f16hiDPbGh7yCFuRr3UvobWJt9IsUUVW9i7W6cFqhsMvDpox1yIgR1u/FnTo8ahaKMH4
         tgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819149; x=1683411149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f510guQXqFwIfREWkiywrIxQX82C636wyP2+R7tPw+E=;
        b=L+8h99vnpPf7xgMO+UnDeD5fFpa59BTQ/xKcXZkzajxYcSTZ58udrVKCEXi0kwb9G9
         bpuc7K6veEQ75JUa+hXidGIOPnEZXDfKdkRbQiG3BrhS3XwbfF56lrrfEt2ajYlRAr6f
         nFwww6qqA7GN8h499u8kGJdoZAf0PTdWAnRbfigYSCVOuWmm1w4urBiGU8lFuFEDPxlO
         +yM90/GzBlFocFSF1SQuyxSMUsITT84MXEk7Rjm4HDEXU9CjxRT+7yk88uOc7IsKVgGK
         p6yVv4vgrTj9Mc+dZLKSrXegUQiTyAbEmpxXB2OITQm6SQ5Zbc87xW/Uco0yocpRlhqK
         JlgQ==
X-Gm-Message-State: AAQBX9e0b40MPgm4PeCCyv0Sh+PiHY1dt0FnNWBDxtUiCfX5pWq2rt6j
        OAmahzUMkfE2NVipCdV79jY3fimRqKX15w==
X-Google-Smtp-Source: AKy350bWIUS/6WE3de9sGDOmVXl2T8vcyJDRE7fc/lYicVZN6lzTykR/KA4HgCpqb0BsFzKJzTQ0JA==
X-Received: by 2002:a05:6214:f69:b0:5a2:abf1:7d33 with SMTP id iy9-20020a0562140f6900b005a2abf17d33mr1292335qvb.50.1680819148906;
        Thu, 06 Apr 2023 15:12:28 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ks15-20020a056214310f00b005dd8b9345e2sm816353qvb.122.2023.04.06.15.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:12:28 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Subject: [PATCH RESEND 1/3] scripts/gdb: timerlist: use range instead of xrange
Date:   Thu,  6 Apr 2023 15:12:15 -0700
Message-Id: <20230406221217.1585486-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406221217.1585486-1-f.fainelli@gmail.com>
References: <20230406221217.1585486-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amjad Ouled-Ameur <aouledameur@baylibre.com>

xrange has been renamed to range in Python 3. Therefore,
timerlist currently fails with NameError exception:

Python Exception <class 'NameError'> name 'xrange' is not defined.

Use range instead of xrange.

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 scripts/gdb/linux/timerlist.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 071d0dd5a634..fac951236dc4 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -73,7 +73,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
     ts = cpus.per_cpu(tick_sched_ptr, cpu)
 
     text = "cpu: {}\n".format(cpu)
-    for i in xrange(max_clock_bases):
+    for i in range(max_clock_bases):
         text += " clock {}:\n".format(i)
         text += print_base(cpu_base['clock_base'][i])
 
-- 
2.34.1

