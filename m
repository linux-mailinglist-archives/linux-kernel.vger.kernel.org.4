Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD247712A42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbjEZQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbjEZQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:10:56 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607901A2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:10:52 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-75b0f2ce4b7so60489985a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1685117451; x=1687709451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgIUzMFd0Wu4Ol9oHyv7Wf8bNpCQi48RTzTuWdj5viQ=;
        b=bMK3rSXUcwt/oyxOni/E1+aDrCvO8uQNH3a669+1l1G1buZyt4hmjxrxaQ9zyDYq0q
         3OJqmCIi9C1NJDTgt2RukX+DYxLTdJWJdhwAApMmf4CeM5Vx9uhxTahqdBdTePQrJzjU
         4vCLt5ttYoIYkO2vEX/QgG9TlpwKR28aP0Dp2qZoc2lDpu8Sy06WNbYOWQIpceVB+gEi
         iMcr68y4vy+xc2rr38ckDu2WusHEOJ/s+Q/b0eJQazEANf6QSgI1SLgsqBHQEte+1e7T
         aWL4cSYlBdmgq6Ud75RLBbQXE8icxar8Km59ZZ+MqZINkNY4Rp9/CuYOOH9qzmd4CxSq
         4bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685117451; x=1687709451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgIUzMFd0Wu4Ol9oHyv7Wf8bNpCQi48RTzTuWdj5viQ=;
        b=FGX2MO5nSGDxMpC6M/iDTBNh2q9W6Rh2tgNm054RAz74Xo6OUz1ZihZJY6/qk44Elo
         riJoKVZki6hCb0s5Bi3xV8Lvfasf8LfvwCw/tKqulb+9c0A8cRcUPkqX0JkbZT3qKgko
         fD1H+kIaC6/9oW64MUXzMZjvInwSy5jdJMIYpH/Vd3aH5CxFZ1VtvaBHbFfDp/ZYWEKB
         /DXKM/lC7CvZkGwcadeLktp69Ack/xX/fabfvhFSw7QE4mnxVQfcagMKRK8mMWV6jsPW
         F2QoHhjxYIdKvBIo3PHUOlQ9qtgdxr0MBJR5FOsDVA1jmVnRgBe+1EPjzpBPdI/qbjNC
         9RmQ==
X-Gm-Message-State: AC+VfDwk2HB1iZvpcuUzXAAXmN/1Hf+7rt1K3Q5Ipy6R5AfjlSiz1Rbr
        gkChU96NUJGAIRtuXTrHrwHAhQ==
X-Google-Smtp-Source: ACHHUZ4+9YD+0XkjiRj7Leu8WRGwVaahM3SelZvLtApMojXLJADrIKSe/xMOJp+1TvDqXUmUNiZVfA==
X-Received: by 2002:a05:6214:c8d:b0:61b:5cba:5820 with SMTP id r13-20020a0562140c8d00b0061b5cba5820mr1886177qvr.50.1685117451360;
        Fri, 26 May 2023 09:10:51 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id l12-20020a056214028c00b0061b608dc4c1sm1303256qvv.94.2023.05.26.09.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 09:10:51 -0700 (PDT)
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
Date:   Fri, 26 May 2023 12:10:45 -0400
Message-Id: <20230526161045.2283530-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526145519.2282062-2-vineeth@bitbyteword.org>
References: <20230526145519.2282062-2-vineeth@bitbyteword.org>
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
+           dq = -(max{ Ui, (Umax - Uinact - Uextra) } / Umax) dt
 
  where:
 
-- 
2.40.1

