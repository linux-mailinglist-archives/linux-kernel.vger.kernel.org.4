Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB77162B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjE3Nzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjE3Nze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:55:34 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25EE8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:55:32 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6261367d2f1so13984546d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1685454932; x=1688046932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSS96BQmp/orj0veigjn/MG+4No9KgOkSEIBHXDxWNk=;
        b=nQyentgTue7+lWz00xktFPfo45ahUAyYxIrD7TRCr5XvjtrprXD6x3GejfX+F64zmP
         wFgszkowqam8yjAXwH5pjAVuIrNDnqCZwPTlkeUutU3qxRrR6/Ga707aT4xP2uQp/Xxr
         ZIM3rkMiN0uibjTZNA9YpOgPkFCQXG4i1Mi0u3z35yBzfkjbHF1XobjD+XlLyr6oQfQ6
         +5jlpLgzKkUT3N7E3GQVVeTkluZ2zyNWKUVwsvPlUWmRtZs5ijliG6NNzeamTqXqQwwo
         Xf1POkN9OlG8jSHzmkbQ2vkj73TRM84ZlPkqLMFA832QZuNKszAA57sq8qgjsr2h9IPL
         /fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685454932; x=1688046932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSS96BQmp/orj0veigjn/MG+4No9KgOkSEIBHXDxWNk=;
        b=ftK0TNjXkOCAnyra6N/dHmCrH/dWb8kLOwIiIktqURiRQKwszZ6yTFdUX1vFml0ej3
         UXh2kTeAWVn5MVgStbmDDulcEWnbEby3c9grVCBDuBwCqL+3NEUGTgggEd5esWxUZxCr
         2uEA/XU+41+1/rRbvS9re8e6T/f4EnjCCRthH7wphTJbVPJxZ42hc4oYLqLSZm5Uhhap
         CFhGp7aANn85iW0Y3kAXCgs/conXsfgmdTNITERxQ8qkCT4E4+Oj6EiFiZPO7dY6Eado
         AgBmtQxEzdj2jgxzke8jp/rcxcmcHphCCB+eyb/u7q7wwP0qLMi2BExjQZFKudkil5gt
         Z3JQ==
X-Gm-Message-State: AC+VfDw71j416QvwzOiR5WI1d4wuQMVd7h9msuaVrnp93pWft0SO2b/C
        OkpPq8K+6waAV6Ne59fdzz3iYQ==
X-Google-Smtp-Source: ACHHUZ4HGmG9UVJRljVDJw5k+9dXUnZxA01/wBQn72HUyv0GiGCkKl5WWl/q8SD7cwN90DQ8akUSNg==
X-Received: by 2002:a05:6214:529a:b0:621:48be:baa8 with SMTP id kj26-20020a056214529a00b0062148bebaa8mr1866832qvb.48.1685454931816;
        Tue, 30 May 2023 06:55:31 -0700 (PDT)
Received: from vinz16.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id u6-20020ae9c006000000b0074d4cf8f9fcsm527809qkk.107.2023.05.30.06.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:55:31 -0700 (PDT)
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
Subject: [PATCH v5 2/2] sched/deadline: Update GRUB description in the documentation
Date:   Tue, 30 May 2023 09:55:26 -0400
Message-Id: <20230530135526.2385378-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530135526.2385378-1-vineeth@bitbyteword.org>
References: <20230530135526.2385378-1-vineeth@bitbyteword.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 9d9be52f221a..9fe4846079bb 100644
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

