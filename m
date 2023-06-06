Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2A724465
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbjFFN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjFFN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:29:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5690;
        Tue,  6 Jun 2023 06:29:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6532671ccc7so5113972b3a.2;
        Tue, 06 Jun 2023 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686058169; x=1688650169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SI0b4P3I9+60f/UCoHnIQQcWOpJpZ2k6ic4EQz/5KSo=;
        b=mLOuy8Ernr9ulMFsisqVK3v4AXX4veGbmFf4Ct3mtOxGu+OYHMBs0iPOPZcwC68my8
         mRfcslKCkn8syXfhb1D7RF2dImmYfesKbcChbn1EbJ9tpCXKmT+MALYI3EoM7TMdDK4m
         uSUpj+bJVdhkdXdf9k1lTsBvXAG0efKyYl03Pjk53PqnrNFY6AIedrrau1cJYbNNMCGH
         BAa97bPHSbbeRGWhD+aKrGDZUf/nxTqUX94ABk5cZzo4oFU6mioP4wk4NQhjxJ+b4/wE
         1FOMtuP0xb8uWpKj3TUNGnMQpj3W0ebJvLMX5svLGZPl/gDhDkCumqf3t/8h/DIsj+V6
         AdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058169; x=1688650169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI0b4P3I9+60f/UCoHnIQQcWOpJpZ2k6ic4EQz/5KSo=;
        b=iZ5MUEHiq0tj2D4h8YqR6QvlBmpJUk098t/xW4dQ7jmaMw0Pu+HhAWpye5NRMLTIds
         CFvKthVxEo9vG1EDBjAh0WICW4TBTJn1NPUD/Wrwc4rCjyzP+/H/tQRwoeFDN7brveLw
         cjNxT+6QJdnuY0eOEdpiH5k74J82O4neCOo7GLsZKKgqnxywZwI3uEt/BXnZex2xw5DN
         61KFGylnOriBC6fHtXmdU05Fy+BmH9QQZngQ1P+TpBl3sParSf3pqj1xmKc2xmPqmNSt
         kv1CS5B23z4PtKeSxPNtjEXAdFay4/aAu0zTtkl99YqNfCOQlcMWNYbq9pyp9qUAYt4r
         3Zmg==
X-Gm-Message-State: AC+VfDxlwYQveQ2HK1pL3saM2QTKll3LSNPM+Dd5N7k99CTwF1oiSvkQ
        FCKPUz4yRQ6ATfXVvkHT4HE=
X-Google-Smtp-Source: ACHHUZ5h7h3dktfa+nsT8G9VO4WH2ZJRqEtX9W7/9S1MMO02w9hxQAC5ejRZCvpVlIPDcE2w8Ng3tg==
X-Received: by 2002:a05:6a00:ad5:b0:649:93a7:571b with SMTP id c21-20020a056a000ad500b0064993a7571bmr2700821pfl.13.1686058168888;
        Tue, 06 Jun 2023 06:29:28 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id j7-20020aa783c7000000b00652364169d9sm6798175pfn.192.2023.06.06.06.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:29:28 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D9D4E106A3A; Tue,  6 Jun 2023 20:29:25 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zaibo Xu <xuzaibo@huawei.com>
Cc:     Linux Accelerators <linux-accelerators@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: uacce: Add doc title
Date:   Tue,  6 Jun 2023 20:29:11 +0700
Message-ID: <20230606132911.37137-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=bagasdotme@gmail.com; h=from:subject; bh=kWDRbexCOx46ujAnzbYoAxrFy0QxCcZqXVWhj+nSHM0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCn1JstnKnPxPeL4fXbNZr23ehOEFcU2y5yM4Xn77gXX9 o+NHgfyOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRCe2MDAvmlelrsuZyKM4t DlrIek2wZY7eQdUP8xhNGKb+vLR920GGv9J8M3i+h24OLcrbtX7nMyU53QlXZrBmHUm0mXH68LR z/zkB
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't page title on Uacce documentation, which causes all of its
sections to be listed in table of contents for miscellaneous devices as
separate titles (since there is only section headings).

Add the proper title.

Fixes: aa017ab97a223d ("uacce: Add documents for uacce")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/misc-devices/uacce.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/misc-devices/uacce.rst b/Documentation/misc-devices/uacce.rst
index 1db412e9b1a380..8c536b84167cbf 100644
--- a/Documentation/misc-devices/uacce.rst
+++ b/Documentation/misc-devices/uacce.rst
@@ -1,5 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+========================================================
+Unified/User-space-access-intended Accelerator Framework
+========================================================
+
 Introduction of Uacce
 ---------------------
 

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
-- 
An old man doll... just what I always wanted! - Clara

