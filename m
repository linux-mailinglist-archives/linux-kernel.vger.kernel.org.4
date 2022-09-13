Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF3E5B6A65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiIMJMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiIMJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:12:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA5E57247
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:12:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q63so10732957pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=T1+v0d/bxtpbeCpIjM7V3ktpjxkQkVAXdQmTNVJDAEM=;
        b=phX5QoGvrNy8xpfI2gGMivSlFzgn3B5KbixZo5B8ab4PmEcHRaJI5Xn//4ecpyMkvS
         TDb5xDOb7i8TR/v2wL5OfewuXvO5oZzLiSVmui3RyPBzT/LaG8LOWgD6knLib2JpwciC
         YWznC/Ri0Wg75EEX3UL4/nQ1/H3FH+ey1fVYGwGtr+QH3qwfKs9Q2LTjy3GowQsqVK1X
         pdSeaTID5rLESOBz491DeR4F2B1NwlqfqJhpU0BBQ77N7ST9pr5mpUu3qpHMs+0H+Peo
         eOWN37qPRjeta1YAHD8sywB9ByVvp0V042QT9YtnygbO3GzDX/2sPzU8x7CNJ3SeCHY2
         Eh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=T1+v0d/bxtpbeCpIjM7V3ktpjxkQkVAXdQmTNVJDAEM=;
        b=qrptjiJ/W1KO1PwVf8ef+b6s/MatEBVTA4+77n95E7yUlXGZ1zRkQb8nZzQH03zhzy
         kSwc3Fp2PadkaH+Sj8a4C8USmEqEt/jC6tyShxQPFj+wO2zogYfqqucQEwmVizGIf1dw
         puViy4aDaAI5xKPXL1lEWWSOSc9vZa/Lg+RvAsT7VZHkfHDOFQ0lLW9n+m8XvmlPbR8x
         34J0nRGTJwipdFdGWjUeybGnBjZjy74fSjxDiklul3e03CvvNv/i9TjRpfNJYUEhauW5
         5YRsbZntVlyQl8zY+pPPJYjAeQc0TfSKu6T3tzUSqBll3YyGCfho/18y8kZKklv66R69
         OJ6A==
X-Gm-Message-State: ACgBeo2rfY/NzC8ik9qqTuupo4NdtUbjdrFpxKlVyztVBRKZPeRhM+E7
        fJPXod2eVCkqt1EUxejpQg==
X-Google-Smtp-Source: AA6agR5vqxeVAERvE5UY3Z9wKqtcjV3CopPOxGu5qgq+1b8ZMvv336BLhUadurdXvgHg2vM52RgT2A==
X-Received: by 2002:aa7:8397:0:b0:535:933b:54c with SMTP id u23-20020aa78397000000b00535933b054cmr31422247pfm.38.1663060347431;
        Tue, 13 Sep 2022 02:12:27 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902680a00b0015e8d4eb1d5sm7804661plk.31.2022.09.13.02.12.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:12:26 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 0/4] mm/damon: code simplifications and cleanups
Date:   Tue, 13 Sep 2022 17:11:23 +0800
Message-Id: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

This patchset contains some code simplifications and cleanups
for DAMON.

Kaixu Xia (4):
  mm/damon: simplify the parameter passing for 'prepare_access_checks'
  mm/damon/sysfs: simplify the variable 'pid' assignment operation
  mm/damon/core: simplify the kdamond stop mechanism by removing 'done'
  mm/damon/vaddr: indicate the target is invalid when 'nr_regions' is
    zero

 mm/damon/core.c  | 24 +++++++++---------------
 mm/damon/paddr.c |  5 ++---
 mm/damon/sysfs.c | 11 ++++-------
 mm/damon/vaddr.c |  9 ++++++---
 4 files changed, 21 insertions(+), 28 deletions(-)

-- 
2.27.0

