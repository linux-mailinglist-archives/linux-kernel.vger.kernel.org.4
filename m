Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724666E6AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjDRR0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjDRR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:26:34 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64283B46B;
        Tue, 18 Apr 2023 10:26:24 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id xd13so41241247ejb.4;
        Tue, 18 Apr 2023 10:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681838783; x=1684430783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5v6TG43Q6Ul3Yw2SrINn59iVDlotZEfKLLIy9ug6DTU=;
        b=l1ZWGR7z3U3fRc3JoV5vFVLukZ2/5uPJx/XLiXruTNlfeod+iK/GZBB2MNbPW3fn6b
         oXnHXPzwuBiKHpK6Nh41m/x7tjOzWfRL6kwYbRyvCj4HsVrCYXXZpXFavDXbjtnwtKHw
         b78lYkEYOCClmTdNmR70iKodXMdtd4/oo//67Lzk2lYQwSNUkwi3T88tlNdNcIFz851N
         9GR5bdLerrGrtxjNQMLuFQvPO6oXS8b9SPkfRyh3g03dJ1GqQI15NudKWiXtmcXtesLM
         zoEmQzDg8i4ZBxLTEX94T2HJBRKjPjPArDd7S3aIfkgLd+D8tG355MxojZClHJQ8rXrC
         FHlw==
X-Gm-Message-State: AAQBX9fhgjv4f4zcU1CPh2S4/IK4ZN8kQiAmFH1wALUL2NExO6JsXvow
        t28ZLUWHAy6gGi1BBGSEakmwcmhhSg5aAg==
X-Google-Smtp-Source: AKy350brxSJc/dhqblvXzlMmP/qxt6/dWWnpfUnLCUjfnoT3kZXls08JHtDG4ERRXK+1QQGvc7sK5g==
X-Received: by 2002:a17:907:77d5:b0:94e:f738:514f with SMTP id kz21-20020a17090777d500b0094ef738514fmr11584269ejc.13.1681838782686;
        Tue, 18 Apr 2023 10:26:22 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-204.dynamic.mnet-online.de. [62.216.205.204])
        by smtp.googlemail.com with ESMTPSA id j23-20020a1709066c1700b0095342bfb701sm63259ejr.16.2023.04.18.10.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:26:21 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/2] watchdog: fixes for menz069_wdt driver
Date:   Tue, 18 Apr 2023 19:25:29 +0200
Message-Id: <20230418172531.177349-1-jth@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing the Qemu emulation of the menz069_wdt watchdog core, I've found
two issues in the kernel driver.

On is a NULL pointer dereference, because the driver can't access it's
private data and one is a wrong register read resulting in incorrect timeout
values being set.

Johannes Thumshirn (2):
  watchdog: menz069_wdt: fix watchdog initialisation
  watchdog: menz069_wdt: fix timeout setting

 drivers/watchdog/menz69_wdt.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

-- 
2.39.2

