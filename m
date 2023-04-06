Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA86B6DA59D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbjDFWMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbjDFWMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:12:37 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21388AF29
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:12:36 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id ld14so233171qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680819154; x=1683411154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77xXDgdfCYlHmKQzw7for8TBSRkg3UrZB/xabG2Isl4=;
        b=LcKPGFVDy/mOCkEpIfP4CKdmezLCKFTavbhDx+mq+VC8uuI5iLWFjamnYvSNXc9wDR
         cJursipFPE4EKOuAJWkHFtVFAr15r/ORCAF4cBrZElkFoNLpEreEEvbT12UH7jeX7y+N
         Tt3uNRQOxRGpaU8G6YW9yMkr/0xfHUNBWbzCclK2yxaRXr8cLlIxut9rTaAwY7AL6rq4
         6Tu73eYm9fSfMNU1/cMOLiNBoFv07fXTmRBGL5b1Vox9dPxqDJwVa3+KAED1JiAw/ans
         kSG+2tPxs6xWUw14zBO+yomWFYsD98sJ0XLDW3WWELUFIKeJfcOJHztI5+7S3w8Cxx3Q
         oQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819154; x=1683411154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77xXDgdfCYlHmKQzw7for8TBSRkg3UrZB/xabG2Isl4=;
        b=ilKL8P0Pm7oHlnWFG4gmGHD+aNeGB9uf/jRJKdTBiJM88zN/3CFKjP8tnRba4+aTim
         0VmQOIByncI3dagZzurJSkHmC0Tl7UOj2GVcdg2wiLJqrVURKsxJTPYM6nYcfcUsvFTM
         Oc9DTmr4BmyAprXt03fD7yXPNYj7jc/yJEj0d/VgJr01znUy2wX21RWWjtZYWk+SNCsu
         05ZsdP/SaWpcZQ1M5GFKc+r3CIlu/CG9fDh/haCj2/u/9MNq9sMzgO9KDcXtMWqeWUky
         pLf4QtXmCLYQemUxIsgM4VSPZD+z6YQ4hrTuncXM6+zoWObr3935REU+8VbM8xyEj+fD
         pHug==
X-Gm-Message-State: AAQBX9cBL6jNMhuPaVRQDmWeOR/Fbw/nsYzyS3oShMKlzsvyUBiuMSUn
        eH3FprG5GkJm2Q0ueFhbGzBOKvnMmEf1rw==
X-Google-Smtp-Source: AKy350Yolh5LxtrNdbXDQVMBqw2lmnAT8hcdH5vHHOZ+Vo5QoNxyS227ZfcbL1URY0OjHP6rMNuWRw==
X-Received: by 2002:a05:6214:3016:b0:5ab:56d4:dc43 with SMTP id ke22-20020a056214301600b005ab56d4dc43mr1126556qvb.7.1680819154785;
        Thu, 06 Apr 2023 15:12:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ks15-20020a056214310f00b005dd8b9345e2sm816353qvb.122.2023.04.06.15.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:12:32 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Subject: [PATCH RESEND 3/3] scripts/gdb: timerlist: convert int chunks to str
Date:   Thu,  6 Apr 2023 15:12:17 -0700
Message-Id: <20230406221217.1585486-4-f.fainelli@gmail.com>
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

join() expects strings but integers are given.

Convert chunks list to strings before passing it to join()

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 scripts/gdb/linux/timerlist.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index d16909f8df35..98bb9a239283 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -172,7 +172,7 @@ def pr_cpumask(mask):
     if 0 < extra <= 4:
         chunks[0] = chunks[0][0]  # Cut off the first 0
 
-    return "".join(chunks)
+    return "".join(str(chunks))
 
 
 class LxTimerList(gdb.Command):
-- 
2.34.1

