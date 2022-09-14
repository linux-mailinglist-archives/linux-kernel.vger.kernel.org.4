Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64F5B7E38
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiINBWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINBWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:22:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D03465569
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:22:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y136so13397466pfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8pthCcK4jG3vrxG+7tQd1Ypnq2mnuX5fGGmfYEPodjU=;
        b=goP0v/yerXKW7dO8jzHJkPydFkbjpdb7PQKRz60UjAot09GL6b2GT3wTMuzJL7om2o
         LVg1J7MuSaRPuAGoqJjoV7flThwQOK+ixfA5d0Ni13+mmH6RT2oN6iE4OcYFd/c1u1E4
         LuZBHLnTzVpI19daniRBL3Uzzs2h4k8E0KHDZdE2vBAX4x9J2P4UI7NXJpbQiCLBokg4
         GnotX7xXpY21DJAVG1bqSiuql8nrSQX/3rrNox6iEp/JZAEI71gxj7qccPijG4gQnvih
         fzfP214Po6xYYDMYhz7/THnv0oe96Hh8/1zmUF1UvZB/MbTMkgACq2NribPooocU8Hon
         ieXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8pthCcK4jG3vrxG+7tQd1Ypnq2mnuX5fGGmfYEPodjU=;
        b=3I59D3LNl+FK8fbdxZKv+NJ2UqSv+4bR2i7sOvDHRYWgFHcyLXYhpEOCYusI1ZhhF1
         5YJ48sLP+oNVsCzSbKy/7lg6gxT4Mc8c/uXz3kFyNBdSXPpb8C1zGb4Tt+fZJEqt3PzG
         15tD1dNacpnjt7GQ08/qMj5JUqJRAF7+biGU3wHdxegPo5cJGS0+jPZnrwUNmD7/Et+e
         IfqEo7gwouFWkuaj9XiS2eQPVgqiqEDMMtEe0bppbNNJ6xBST1NCeDQbep8QabNkoA/w
         hXoZp4JjchrqW6UCIFk6FZHlOIjA7pCGJTTViVwQiZYemOIVNcDfQgLFhFjStYNAu05U
         oIag==
X-Gm-Message-State: ACgBeo3lOOaaLvGmXgcRkUoC/NC2k3czsVIkYlXw3x424drL2GRU44AW
        UhdFnM/k3YdoBqWNMOVvoPA=
X-Google-Smtp-Source: AA6agR5y8ixwIGn1ubkGgkSSUaCuOTEUlMERxsv6vvuY3RvBfqwHR86KNetzOkFRc1PHxBKXS6P5OQ==
X-Received: by 2002:a63:784f:0:b0:42b:4c9d:79ee with SMTP id t76-20020a63784f000000b0042b4c9d79eemr29216026pgc.65.1663118564073;
        Tue, 13 Sep 2022 18:22:44 -0700 (PDT)
Received: from octofox.metropolis (c-24-130-93-68.hsd1.ca.comcast.net. [24.130.93.68])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090341c800b00172751a2fa4sm9143536ple.80.2022.09.13.18.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 18:22:43 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 01/12] xtensa: clean up ELF_PLAT_INIT macro
Date:   Tue, 13 Sep 2022 18:22:30 -0700
Message-Id: <20220914012230.2733872-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap _r in parentheses in the macro body.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/elf.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/include/asm/elf.h b/arch/xtensa/include/asm/elf.h
index 909a6ab4f22b..9c21897c6992 100644
--- a/arch/xtensa/include/asm/elf.h
+++ b/arch/xtensa/include/asm/elf.h
@@ -153,10 +153,15 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
  */
 
 #define ELF_PLAT_INIT(_r, load_addr) \
-	do { _r->areg[0]=0; /*_r->areg[1]=0;*/ _r->areg[2]=0;  _r->areg[3]=0;  \
-	     _r->areg[4]=0;  _r->areg[5]=0;    _r->areg[6]=0;  _r->areg[7]=0;  \
-	     _r->areg[8]=0;  _r->areg[9]=0;    _r->areg[10]=0; _r->areg[11]=0; \
-	     _r->areg[12]=0; _r->areg[13]=0;   _r->areg[14]=0; _r->areg[15]=0; \
+	do { \
+		(_r)->areg[0]  = 0; /*(_r)->areg[1] = 0;*/ \
+		(_r)->areg[2]  = 0; (_r)->areg[3]  = 0; \
+		(_r)->areg[4]  = 0; (_r)->areg[5]  = 0; \
+		(_r)->areg[6]  = 0; (_r)->areg[7]  = 0; \
+		(_r)->areg[8]  = 0; (_r)->areg[9]  = 0; \
+		(_r)->areg[10] = 0; (_r)->areg[11] = 0; \
+		(_r)->areg[12] = 0; (_r)->areg[13] = 0; \
+		(_r)->areg[14] = 0; (_r)->areg[15] = 0; \
 	} while (0)
 
 typedef struct {
-- 
2.30.2

