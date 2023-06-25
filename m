Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE5473D313
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 20:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjFYSv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 14:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 14:51:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D471BD;
        Sun, 25 Jun 2023 11:51:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666eb03457cso1009060b3a.1;
        Sun, 25 Jun 2023 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687719085; x=1690311085;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wkyFiQL0LMLlm6vDNBXN0hDgyxcnkHbsK3MjPnzklOk=;
        b=W28doUtd2dlijy0QGV6h/6J3SOjezt65kQ5VmAV4+ARGvRKrhQOuSDOufCHqQO9fpK
         m+MBGfEudzDl4LEpVGcn1vJvnD19hVKHXcsirCRGin7OZlPx9Jx1tJHMNOy/tYwUNyie
         6gkSeEYW2OrvONoUWYuvzezOkemdytGv+O/klCUqY19V7bYECgM/0GXcU+7jDxXrktq+
         KSmNpJXzKm/3tXqufDLSrhIyP1j0iK4gtNUE2GYbLo3sev4jJl9h//hgNlfz/RLWjH9B
         hMkrYjJPtCuHk2jQCuuI23e/QWIEJyD8b2enbsOxTLazi/5h/f445gluaFjgFmHQKAR1
         Q1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687719085; x=1690311085;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkyFiQL0LMLlm6vDNBXN0hDgyxcnkHbsK3MjPnzklOk=;
        b=ILF/r1YWVBG1QS+fZVVrroc1Eu/X7/9JSJjc9PgI3b63yUjmPb66YiLoR2ksWtf4rR
         XfqCmo+1plwcyJljmmdVJgmihB14rlPfz+8gTIUiDgDJJ6Lr6+lgFtS7XuULuKU01cNR
         12ZmkYp+r+3HSx6Cewl0Zb/ddjwLR2GBUSANbY0Yz3Bh7XsrwgpXNRes2lMhZGOIZbjr
         vw9e3OyfuoXODceUZoKubHowB86amPCMY70lrwLoH+o8+bO9kCwptUunVe1yqN7FTAx9
         Tm1q0z7vY4noah6ZLiiKYpegwJqV8p5DiswvjdT8pWpLnO3f62/1mmsGKL2OVEQNh2xi
         2Jug==
X-Gm-Message-State: AC+VfDzGkmU9hgKo6q7dSKL9rhNrQuSwPOwSslMtdMWZL3dNVZUPBEyK
        yWUDLxskyTSROmvySzrP3Mhgfxqe1OgaHOXEifPox0NJ
X-Google-Smtp-Source: ACHHUZ5pDGUQ1/TP44+VyU6tpJ5rYd3i7I3W0S8JTeBpxvCH04V63sAfyIBNewDVzh1nfY64NYD4glP1efsJtY8DllA=
X-Received: by 2002:a17:90a:fb52:b0:25b:b4c6:d13e with SMTP id
 iq18-20020a17090afb5200b0025bb4c6d13emr17872825pjb.8.1687719085091; Sun, 25
 Jun 2023 11:51:25 -0700 (PDT)
MIME-Version: 1.0
From:   Uros Milojkovic <uroshm@gmail.com>
Date:   Sun, 25 Jun 2023 14:51:13 -0400
Message-ID: <CAP=xWk67n_5jOvj7mM3KmxiaMn9Gm908MUU=Nrq9Tv1ASw4M2Q@mail.gmail.com>
Subject: [PATCH] staging: nvec: udelay to usleep_range
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch.pl alerted that usleep_range is preferred to udelay. This
change was made in nvec.c file.

Signed-off-by: umilojkovic <uroshm@gmail.com>
---
 drivers/staging/nvec/nvec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 2823cacde130..8bb3b691d1f5 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -627,7 +627,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
         break;
     case 2:        /* first byte after command */
         if (status == (I2C_SL_IRQ | RNW | RCVD)) {
-            udelay(33);
+            usleep_range(33, 200);
             if (nvec->rx->data[0] != 0x01) {
                 dev_err(nvec->dev,
                     "Read without prior read command\n");
@@ -714,7 +714,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
      * We experience less incomplete messages with this delay than without
      * it, but we don't know why. Help is appreciated.
      */
-    udelay(100);
+    usleep_range(100, 200);

     return IRQ_HANDLED;
 }
-- 
2.34.1
