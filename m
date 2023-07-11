Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB95974E690
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGKFy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGKFy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:54:27 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE98195;
        Mon, 10 Jul 2023 22:54:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55adfa61199so3907808a12.2;
        Mon, 10 Jul 2023 22:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689054866; x=1691646866;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idZkGEwcPYLun83FvCWg1+YIM8kK5l5ERo4f+wG74Mg=;
        b=HQwHGoa78JiuFxic1UOWoF4nOBLTkWpMPxaXiSl9HqXqhdDq8bAVLKru2unBN83PRe
         UyOUlDsYnDmajU8wW4W31hACqoY7aTew0iIrjpgaHtXANS6KlbQTgZpJnIm6aW1KYg+S
         +RsWKdKgEhsFdxXZN+jzwoIbCFIahSnblVmfBsjlJq2ATua4hZCE+f7+j6Kwbiq2FHGQ
         YPE7LbHZTIf7ob/LTSeceUX8z2128LyTBleXujZoRVTNGGs/L15hIgcOIaxksEZoBxPE
         v7gUOfYh/dmIO5UY5CiQ26/fg6vQ5r89psWQl+AG/cbIqvKqsIbsK2eb2Rn9aLOkgQRX
         /uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689054866; x=1691646866;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idZkGEwcPYLun83FvCWg1+YIM8kK5l5ERo4f+wG74Mg=;
        b=UYhCLXJF/BJVmmEIbc4T+3lWJnborvVEABzua4ynsT0/CP6OL24jtavZbRERrO/xW3
         0mvXa9sxSIGTldVWG8QOYARH6vN8ZZ+XVhj+b3JnHfX3Ym185d74BYK/xXpFgvTAKBh3
         ARca6DKuFiUr4w8uIbMP4Ngpx6uJJMWdRQr4XutzZJLj8cUho2rXxD3qtJE7NXml8+or
         ed9pU1CNbWCfhWZddQJttFsmzO0wkgeTlqFzBLF4ncNCss5KoA50h+ocrvHgH8ZH15zt
         y/cVE5yFmYRPQUtgGxbad5S6AwVqGPNNJLL84b1/79FuRQnPjqQVI3ubcvoCfUO5D/Wj
         WcxQ==
X-Gm-Message-State: ABy/qLZ54QA+a+l6zlS9fLNxwFwl2HbORCt3c4SBM7hJ2R5ZLSdtYBqr
        imQFY3ACMWyWp40fppRTdFidDvne+Yo=
X-Google-Smtp-Source: APBJJlEJLPtbp4fsWDZRTf3W9Klzf3jvgD67qLUPDgN4/MFBx7XBk2/Aq0a4Ko/5udg1PjsoluxDjg==
X-Received: by 2002:a17:902:d342:b0:1b5:32f2:5af with SMTP id l2-20020a170902d34200b001b532f205afmr13144327plk.59.1689054866176;
        Mon, 10 Jul 2023 22:54:26 -0700 (PDT)
Received: from j293.lan ([2400:4051:ea3:5910:5676:1078:8b85:c18f])
        by smtp.gmail.com with ESMTPSA id bd5-20020a170902830500b001b8761c739csm878053plb.271.2023.07.10.22.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 22:54:25 -0700 (PDT)
From:   Kazuki Hashimoto <kazukih0205@gmail.com>
Subject: [PATCH 0/2] s2idle fixes for systems without cpuidle
Date:   Tue, 11 Jul 2023 14:54:20 +0900
Message-Id: <20230711-cpuidle-v1-0-f391224b3140@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIzurGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcwNL3eSC0syUnFRdi2RTEzNLcwuLNHNzJaDqgqLUtMwKsEnRsbW1ABb
 YuWBZAAAA
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hector Martin <marcan@marcan.st>,
        Kazuki Hashimoto <kazukih0205@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689054863; l=762;
 i=kazukih0205@gmail.com; s=20230709; h=from:subject:message-id;
 bh=j5NYA/cWUwU8zPrqAOAmXhuilLtRqKNLjK9L23BUYFw=;
 b=jWlB3vckae5Vtnn/+aYOfDXmupSLN1kDF7eO4gCcG/u5EKWpbYNOqTimDReNI0fbI3emDFrn5
 LBnJETOVREfAQ7lz1NykrjDT0z21TxnjrdRhTZ8YG22ycLuxJ+3tM/X
X-Developer-Key: i=kazukih0205@gmail.com; a=ed25519;
 pk=r8m5wVK5lljix+hYnqXRT/GsxNkTADqXGmhdl7kykYY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V2:
Redo implementation following input from Hector Martin

Changes in V3:
Rewrite commit message following input from Rafael J. Wysocki

---
Kazuki Hashimoto (2):
      cpuidle: Don't pass any values to cpuidle_not_available
      PM: s2idle: Fully prevent the system from entering s2idle when cpuidle isn't supported

 drivers/cpuidle/cpuidle.c |  6 ++++--
 include/linux/cpuidle.h   |  6 ++----
 kernel/power/main.c       | 12 +++++++++---
 kernel/power/suspend.c    |  5 +++++
 kernel/sched/idle.c       |  2 +-
 5 files changed, 21 insertions(+), 10 deletions(-)
---
base-commit: 8fc3b8f082cc2f5faa6eae315b938bc5e79c332e
change-id: 20230709-cpuidle-8c5469788f77

Best regards,
-- 
Kazuki Hashimoto <kazukih0205@gmail.com>

