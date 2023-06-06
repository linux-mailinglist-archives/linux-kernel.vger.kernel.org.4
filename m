Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731BF724AD0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbjFFSHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbjFFSHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:07:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63210DB;
        Tue,  6 Jun 2023 11:07:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977d4a1cf0eso429979866b.1;
        Tue, 06 Jun 2023 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686074861; x=1688666861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcodIvnCDuCUHJZrEIIAkw7Oo5izqF9wl/3fm5lPRac=;
        b=sESGsiiUo2nUkaTrr6tzzaTd0fR5rL5+v5Oc60br+8qcb+VOhXLy2UQD9y74S1Y+0L
         xOuhrIzh1TBUbRd22H4pC1J+cpQNjV+fcIoKGCV5ZpVnOwC4GLEAgB/ESCSqppFOZKSZ
         4Rn2rPnS8Ctdwyd74sfjznhyF/C7VqvVFvQ5D43BM6CjRNCujY7VrfOdx1DwgUri2d96
         nkA8pALJz99heItc4Qegs9YW8EacL3okF1yncoF9NCO0KMM4lp5/WZoNs8UWQiBqQTO6
         MU8ovRMsii9Hxk4siU9NzdQuz55QIreIQ+2tL5Q79sWYL750sE4rchHABCD4MdKUjNny
         Fsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686074861; x=1688666861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcodIvnCDuCUHJZrEIIAkw7Oo5izqF9wl/3fm5lPRac=;
        b=hpH/aG2KoAT0KUkfBXbSuSnuiWpxJhGO1LnQfQkceCZc//718VN2O9b9TZkah5Czu8
         8W8cnP/cuR9es4tZHeE/jtp71DrsIP32Umy5gaUQNC5kjfxcwgpt/kc/JBk4hAaiFJMu
         IomvK+qdCyRvXhCH3bhvjpRNjvFdtmpbbOWANc6WXZMiEP3y+X1BNa9ozVYUL1RxKOHZ
         1iTlEXoWOr4+WX9AbWqYzRr0QVsBIR2chxWsIRJvm/2Ar8L00aiJAozV4JtAJL1fAws2
         Nd2QlYYbH3qVuvuq7xoXyZyeW3NopnZag6zEZcBz/nJ3/5lWiC0AgO1qZsLO0Zgd9MCY
         U3SA==
X-Gm-Message-State: AC+VfDzIYNH/+v3UUecA0ci73DcRItvlmnCy8QVv03S1Zge608/jTdg3
        4763XVt3SqKs9R7aTNt5IHM=
X-Google-Smtp-Source: ACHHUZ6QX2jKCXf6SjHD6DzXP8qqlg3jtAGK+Y81rGXrgN5+6xC+N2KThPN5PNlBOtYHKpiz6xNzHg==
X-Received: by 2002:a17:907:5c3:b0:92b:3c78:91fa with SMTP id wg3-20020a17090705c300b0092b3c7891famr2922694ejb.28.1686074860629;
        Tue, 06 Jun 2023 11:07:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:7ce9:cf23:e2e1:1e2e])
        by smtp.gmail.com with ESMTPSA id qc16-20020a170906d8b000b00965d294e633sm5840686ejb.58.2023.06.06.11.07.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Jun 2023 11:07:40 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     bagasdotme@gmail.com
Cc:     davem@davemloft.net, franziska.naepelt@gmail.com,
        franziska.naepelt@googlemail.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, tim.c.chen@linux.intel.com
Subject: [PATCH v2] crypto: crct10dif_common Add SPDX-License-Identifier tag
Date:   Tue,  6 Jun 2023 20:07:13 +0200
Message-Id: <20230606180713.99460-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <ZH8ntoGLJHQpZriL@debian.me>
References: <ZH8ntoGLJHQpZriL@debian.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:
- WARNING: Missing or malformed SPDX-License-Identifier tag

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
v2:
 - Remove GPL license boilerplate
---
 crypto/crct10dif_common.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/crypto/crct10dif_common.c b/crypto/crct10dif_common.c
index b2fab366f518..28a0cdde9449 100644
--- a/crypto/crct10dif_common.c
+++ b/crypto/crct10dif_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Cryptographic API.
  *
@@ -7,21 +8,6 @@
  * Written by Martin K. Petersen <martin.petersen@oracle.com>
  * Copyright (C) 2013 Intel Corporation
  * Author: Tim Chen <tim.c.chen@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- *
  */
 
 #include <linux/crc-t10dif.h>

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
-- 
2.39.2 (Apple Git-143)

