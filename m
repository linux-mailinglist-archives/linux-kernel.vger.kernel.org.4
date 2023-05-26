Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B357128FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbjEZOzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjEZOzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:55:48 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E3E68
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:55:25 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6260d262b3fso1397546d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1685112925; x=1687704925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVYdErQmwOcZHGzqxcaNnogi2GW6TYxbftez0/A27pg=;
        b=EXO2d4pePptGSQJTPQP12sseD7KyidWglTMGmjALxwMUzagRCgPcowS0J3GN0A2sc3
         +P23X5/urWmlhsoPq/HyO0c75DwjQjfrxgNmXvqvklf/cTzPhCJ1WGMjk6SIWxFyt/De
         q6ODrIFzxlxVMavr00m1w/mjpDioOSpZUL718NiJKt+kImczkPEZfHwYXZXeSCrrJF5V
         FhVacFG6se8JdGKy+WUHMXtGt18MEaXVC0JtZLxdSe2rxZf9oEoa3Qe/uNPqL3qdq2PU
         gbEFuQGxzcXsuj926i+9mhX+qxRZ7nbYWqMnIOEWi5VSBochUGK/LMCFyqiRhWWHrHs5
         lhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685112925; x=1687704925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVYdErQmwOcZHGzqxcaNnogi2GW6TYxbftez0/A27pg=;
        b=ZUm4JnWhwgHcTk+VPBj9h6r6yz+53X188/eD42qQOlS/ntb0cS4IBaNy/R8qun7YNL
         BL8MRTQXV+/tui0/BNs62UFmBdY0yeqhB37ac/U9g0Uu41+pA5FgG9JC5ymi6Gt1zo7g
         2oC6cpUsuyFdNX6qQuSJnJ3SEJQi5TxpxlQRI6Yfkqj72mDEgorVatKfdRl44aS47Atk
         e6935j2P1ahUkyGt99dxZpB1GWlcCNFC6rjPWABKiZRdluvocacBt8KXATAsQQ1jcycD
         kWCq0aBnnc4BDd7g/1nZrOtMqAjWF0TmtpD9eo2WJInXYUVNAbm1vja0gwMBuTNxGTIr
         mjLw==
X-Gm-Message-State: AC+VfDxIg9SFWKfCzsR4OfpND17eko40rKQSt2gCdrmTYi+LV7nWl6MK
        384yJH5CYMhkdebAidmrcnh3LA==
X-Google-Smtp-Source: ACHHUZ4RYOwCRRUN62Y58DuX0b6rsS6FxA9MqxAQyhV0Tb/kYaUd6kp3+It5e9sjqUMGyE2QnsS2zg==
X-Received: by 2002:a05:6214:242c:b0:625:83ab:8a42 with SMTP id gy12-20020a056214242c00b0062583ab8a42mr2284081qvb.46.1685112924905;
        Fri, 26 May 2023 07:55:24 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id q5-20020a0cfa05000000b0061b73e331b2sm1271455qvn.30.2023.05.26.07.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:55:24 -0700 (PDT)
From:   Vineeth Pillai <vineeth@bitbyteword.org>
To:     luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Vineeth Pillai <vineeth@bitbyteword.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 2/2] sched/deadline: Update GRUB description in the documentation
Date:   Fri, 26 May 2023 10:55:19 -0400
Message-Id: <20230526145519.2282062-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526145519.2282062-1-vineeth@bitbyteword.org>
References: <20230526145519.2282062-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the details of GRUB to reflect the updated logic.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 Documentation/scheduler/sched-deadline.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9d9be52f221a..d9f9f10c2191 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -203,12 +203,15 @@ Deadline Task Scheduling
   - Total bandwidth (this_bw): this is the sum of all tasks "belonging" to the
     runqueue, including the tasks in Inactive state.
 
+  - Maximum usable bandwidth (max_bw): This is the maximum bandwidth usable by
+    deadline tasks and is currently set to the RT capacity.
+
 
  The algorithm reclaims the bandwidth of the tasks in Inactive state.
  It does so by decrementing the runtime of the executing task Ti at a pace equal
  to
 
-           dq = -max{ Ui / Umax, (1 - Uinact - Uextra) } dt
+           dq = -(max{ Ui, (1 - Uinact - Uextra) } / Umax) dt
 
  where:
 
-- 
2.40.1

