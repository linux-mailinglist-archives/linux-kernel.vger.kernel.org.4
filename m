Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19DE662228
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbjAIJxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbjAIJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:51:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF8D13CD4;
        Mon,  9 Jan 2023 01:51:20 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so12235355pjq.1;
        Mon, 09 Jan 2023 01:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2CjRZgj5w+03CooppV2h5YZRADlzHN7ByIiZ7SsR6s=;
        b=MG55Mifdwpxh8MVPJdLjs2cTl9ualnfbSIBDen/T3cWwkgvZSgZ7pgVg9Jm4QgDyxT
         oqikm+3W+0EfEJoZKu4GVgLDFiBaDB1E5pF1xhuL7w8b2uLz+VAeOzDHyg9/Ya3mEMcV
         gXfDsiX5JY2VyjEUlu0+h1rowuBQOyqAHKYJ834/s+x4oX/+42PndXvYlQUtHnGzAIPP
         BDCdlCPPrbvQ1cfx7tDUZbRGZqgL0QycBRbAl9FR/t1By4ofs95RhZ7w9Sz0YobX+fwF
         SRGWlwkXe9JuAfyAQ4Cgpy9Of4CTz+1TVj8u+sNNMok8UHz3gHuFSv5Ja4TRKrIGxwFx
         7Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2CjRZgj5w+03CooppV2h5YZRADlzHN7ByIiZ7SsR6s=;
        b=iyQUhOF16dcuFMHw5UOpjlRD+YS4QSGD7ULWBi3uWdAFE+jF+RwLAqyb2ISlMKzSGy
         W3gOqt51pnz5f5Zw4uSbnujcraqGq2E+DBd2UCdIta/jT9XIzB0GJJWbd4Az33I0+KGr
         Txj0ryV+/5IccOPcsoWwbFoAF2AM9Oq48wafGWmQY6GA+T+7HvKma5SHTdL2ElTPXu0t
         dopmn0P6eOnnYh+uo8f42Ai1vi8y4cWeKMRy3KlVG8fvEIBe4+bsls22e4xa3aYJv3vU
         ARMWiGPsS1mjQ1F8AtfixRLsEuHfvVK9TC+M8C2N2Hlorz75CeEZOVX3iCzXK0/wAqxW
         1WdA==
X-Gm-Message-State: AFqh2kq+4Cb7+uo30KpNU71UmMFRz+f+E9i0bzzNWN+Gzl5Axr8Ln7FE
        66oGI2VLGBisYfTfDJOkRfA=
X-Google-Smtp-Source: AMrXdXt95xNzXFrT8/Ac8yI6E7YW5RTTJCc0zk7UJy5Exzl8ssTKQEib+yA/ks97qFSEN/iWIiJheA==
X-Received: by 2002:a17:90b:35c7:b0:226:17f9:8025 with SMTP id nb7-20020a17090b35c700b0022617f98025mr43532509pjb.40.1673257879452;
        Mon, 09 Jan 2023 01:51:19 -0800 (PST)
Received: from debian.me (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id lj12-20020a17090b344c00b002190eabb890sm7047881pjb.25.2023.01.09.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:51:18 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B8817104BBE; Mon,  9 Jan 2023 16:51:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 6/8] Documentation: kvx: Promote title headings
Date:   Mon,  9 Jan 2023 16:51:06 +0700
Message-Id: <20230109095108.21229-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109095108.21229-1-bagasdotme@gmail.com>
References: <874jt7fqxt.fsf@meer.lwn.net>
 <20230109095108.21229-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2735; i=bagasdotme@gmail.com; h=from:subject; bh=yMsDrHoSWinbqsJdqdRDs7EJeO2eIKc6AFgy0XYKjUY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMm7H3dP3SI8c+YZdvfiSxa7zEQEZKYVN/+1iKsSuaqTFN8t /cK3o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABN5JsrIMEvOOVDmz/Kn1SLiFv91V0 jqi/tX82Rse+XwlP1+ZeKcOkaGe4VW/qVBOg9mtF4xFT3wodZ7w8rQgB+/NiiVSv0tiFfhAgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation contains headings which all marked up using the same
heading level, which cause doc sections to also appear in index TOC
alongside doc titles.

Promote title headings while expanding their title text to be more
descriptive.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kvx/kvx-exceptions.rst | 6 ++++--
 Documentation/kvx/kvx-iommu.rst      | 4 ++--
 Documentation/kvx/kvx-mmu.rst        | 5 +++--
 Documentation/kvx/kvx-smp.rst        | 5 +++--
 Documentation/kvx/kvx.rst            | 1 +
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/kvx/kvx-exceptions.rst b/Documentation/kvx/kvx-exceptions.rst
index bd485efd2362c1..15692f14b9219d 100644
--- a/Documentation/kvx/kvx-exceptions.rst
+++ b/Documentation/kvx/kvx-exceptions.rst
@@ -1,5 +1,7 @@
-Exceptions
-==========
+=========================
+Exception handling in kvx
+=========================
+
 On kvx, handlers are set using $ev (exception vector) register which
 specifies a base address.
 An offset is added to $ev upon exception and the result is used as
diff --git a/Documentation/kvx/kvx-iommu.rst b/Documentation/kvx/kvx-iommu.rst
index c97035ba624c22..5e84dc12adb437 100644
--- a/Documentation/kvx/kvx-iommu.rst
+++ b/Documentation/kvx/kvx-iommu.rst
@@ -1,5 +1,5 @@
-IOMMU
-=====
+IOMMU in kvx
+============
 
 General Overview
 ----------------
diff --git a/Documentation/kvx/kvx-mmu.rst b/Documentation/kvx/kvx-mmu.rst
index faa6bda2c39959..05b9bc111e02db 100644
--- a/Documentation/kvx/kvx-mmu.rst
+++ b/Documentation/kvx/kvx-mmu.rst
@@ -1,5 +1,6 @@
-MMU
-===
+==========================
+kvx Memory Management Unit
+==========================
 
 Virtual addresses are on 41 bits for kvx when using 64-bit mode.
 To differentiate kernel from user space, we use the high order bit
diff --git a/Documentation/kvx/kvx-smp.rst b/Documentation/kvx/kvx-smp.rst
index 1b69d77db8cdaf..f170bc48ea5f7f 100644
--- a/Documentation/kvx/kvx-smp.rst
+++ b/Documentation/kvx/kvx-smp.rst
@@ -1,5 +1,6 @@
-SMP
-===
+===============================================
+Symmetric Multiprocessing Implementation in kvx
+===============================================
 
 On kvx, 5 clusters are organized as groups of 16 processors + 1
 secure core (RM) for each cluster. These 17 processors are L1$ coherent
diff --git a/Documentation/kvx/kvx.rst b/Documentation/kvx/kvx.rst
index 8982d10f2678df..4aac7fce4e3d01 100644
--- a/Documentation/kvx/kvx.rst
+++ b/Documentation/kvx/kvx.rst
@@ -1,3 +1,4 @@
+=======================
 kvx Core Implementation
 =======================
 
-- 
An old man doll... just what I always wanted! - Clara

