Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2146AB148
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 16:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCEPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 10:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCEPzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 10:55:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2182D9EEC;
        Sun,  5 Mar 2023 07:55:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o12so28942506edb.9;
        Sun, 05 Mar 2023 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678031744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8tWyAMGZ9oNnO6MaDlfAzhjOrEHhW3egZBtHNsY44PA=;
        b=Ce36vqCKWcwFkYNVTPYRc/SQY+0EFvmzsb19b25IygBklciKVdIqpxZCd2RH8JAmxd
         QMn54NcvvTsTC2SLIhRC8Rt2X2+QSvnDupIEdnWvo5q0TdzzZ7/nt0N9TROvttPhsett
         KwoC9QjWkGumFuMkdV0ADnXLsH++9r8HrZ2uD+ha5/IDYDve5qCccq+PXCT5yxBNWf0u
         Cqv3xTXr/bkYGdCWn3PPmL3yJQ99AeCeRwetojPWA045HX2ZLFO1IXhvfgAS33JtGA1q
         hoUoj5ak7NPbNepFWSwM1vO2oagyS88pnk1wq65TY8FMDEPnF6coiB5EK88e2aTlqgIj
         jWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678031744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tWyAMGZ9oNnO6MaDlfAzhjOrEHhW3egZBtHNsY44PA=;
        b=3YCDs99w1a8DZAd2NNhYnK9eikgoEXErc0Yc1ayN218qGn2OL49Q9BGkwzBrvH+2+0
         QzG0lw7mZImL0h3RNjgtPDL9CMjHfvsZmy7dWfXka/mjwMbp7KjPLzAMbnBugI+2gvx7
         ym0Uav/NdeSEkTz7iHJ4my3rE9GBUHsnEH/PWNYFI27ynCBj43G0t3hjPEJU4w0g+0TJ
         YqlKMZ2zNtkpyM3bv7FLM3HMzA4IYV0appx6bkQ+2OGfbVi964X/QYQgZrR4YN/Ej697
         7Lc5QyhqfAsGenjxqn1UBNhQLIN8nAQkFOPOkeMlcVf0WyzIwS0Nz41uoXc7IaokYxEL
         ajwQ==
X-Gm-Message-State: AO0yUKWWp7BgaDp/xVySlb0Umkw2cEJZX9jfihBYi3wh9TU0rP3y9A5W
        cnBtej2OQlKQu3Jvd26VGP2Ul83ZjIHZxQ==
X-Google-Smtp-Source: AK7set/yj5qArqrfKso5UQqopPT3Qt/OnJt/ofjVPqa7D4KmtdobwIJR+290Hiathn6GlQIKOyjsMA==
X-Received: by 2002:a17:907:a808:b0:8aa:c35b:a34b with SMTP id vo8-20020a170907a80800b008aac35ba34bmr8291948ejc.20.1678031744220;
        Sun, 05 Mar 2023 07:55:44 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id pv16-20020a170907209000b009079442dd11sm3357332ejb.154.2023.03.05.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 07:55:43 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v4 0/3] Improve trace/ring_buffer.c
Date:   Sun,  5 Mar 2023 16:55:29 +0100
Message-Id: <20230305155532.5549-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This series improves ring_buffer.c by changing the type of some
static functions to void or bool and uses try_cmpxchg instead of
cmpxchg (*ptr, old, new) == old where appropriate.

v2: Convert only loops with cmpxchg.
v3: Rearrange variable declarations.
v4: Change ret in rb_get_reader_page.
    Rearrange variable declarations.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>

Uros Bizjak (3):
  ring_buffer: Change some static functions to void
  ring_buffer: Change some static functions to bool
  ring_buffer: Use try_cmpxchg instead of cmpxchg

 kernel/trace/ring_buffer.c | 77 +++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 43 deletions(-)

-- 
2.39.2

