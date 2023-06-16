Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4817330BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbjFPMFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345178AbjFPMFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:05:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBAF30DD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:05:40 -0700 (PDT)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1E4433F10B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917139;
        bh=m7ySH3JrcTV8+yw7ueBFG47cxZsJ9e+MajPgheIKd1w=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=sgvBiES5LemzjKmE5arXKRcu7Tc5bUYOste+4GM84XMboqjj399vY+XAcF+GxVqLr
         J+YhN/FibZAZUhdkseItgGZNB74pE+o9t5A1zcfycYX693rh1/o3FEUO3vtohA+2gj
         nR/MiSi480xNUKe0zUl6e7TJ5aOFeKJAIpDpn1y4khNo17oF0GhXVeSP4rcQ8J5Dfx
         fO4p2VvrUTT0GA966CJ5h8efNMnbqq6hlWRABd+W42PBKcrmRU3P+0oQttw8UhZHkU
         CQLIuLC0SCH4EqQ/BMgCwPjJOxJYswOuti07KghoNB3bUZxCUaBCJxhZAGRLxryCdD
         F/h6C/LSKDUQw==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4edb90ccaadso481873e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917138; x=1689509138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7ySH3JrcTV8+yw7ueBFG47cxZsJ9e+MajPgheIKd1w=;
        b=cWj0QZBY6AQgtiUle8nXhpLla55tHHskll5+y9zU6kKtdvVvaC9Q4YeGdcUC+t2zTH
         cZp0/5aXIbLmP+8xBwyYYhSQ2/x8PKkeCKl5dO0MTEnn8MHmjws1EHAlg9qZvONP6PNq
         QB7WNkfl5tX94AndBYBoVu5FNJ2VKaPHgBndrfH3/KpcXGPTK9Coufv8cJIQvCDARfGO
         Fihz8xKwELW7bKR/br7kG2F6ze72XoHVOBft2Qrvtuh+tP9xsxUWFElV9dKGBkBfhBQy
         E+Ru7gw2A5/w7JsJe9tMLMH98TsVkxM14EFcLZCvMQrphmk+0ZnnPhGPZPWTeE4JOTus
         uG2g==
X-Gm-Message-State: AC+VfDyeL5kQt3sdiXdi1aHTb4s51BEaiv7ILhz9ZSrTI7MAiIU93raI
        jk0NtSrQK8yUQUfyQv50waUZtxs8S4EAezwuf+G/eB3/AJ24dilqmAONerOi2i1amB5iiQLFgyb
        pjih4T0MYSVtUiG97yJcZZ1bbhwQ43dKjt03YnwjBfw==
X-Received: by 2002:ac2:5f9b:0:b0:4f3:78c2:2a6d with SMTP id r27-20020ac25f9b000000b004f378c22a6dmr1288645lfe.3.1686917138629;
        Fri, 16 Jun 2023 05:05:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ75fXyeKCuznl3pidwrqckduT+X32ZYDJY7P5oHI98szTnf3jjwPSD9DqOJGAXHWnqzY1XyWA==
X-Received: by 2002:ac2:5f9b:0:b0:4f3:78c2:2a6d with SMTP id r27-20020ac25f9b000000b004f378c22a6dmr1288629lfe.3.1686917138336;
        Fri, 16 Jun 2023 05:05:38 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id c25-20020a05600c0ad900b003f18b942338sm2068082wmr.3.2023.06.16.05.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:05:37 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, juerg.haefliger@canonical.com,
        u.kleine-koenig@pengutronix.de
Subject: [PATCH] fbdev: metronomefb: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:05:29 +0200
Message-Id: <20230616120529.1028798-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/video/fbdev/metronomefb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index bbdbf463f0c8..4e50882d080c 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -778,3 +778,5 @@ MODULE_PARM_DESC(user_wfm_size, "Set custom waveform size");
 MODULE_DESCRIPTION("fbdev driver for Metronome controller");
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE("metronome.wbf");
-- 
2.37.2

