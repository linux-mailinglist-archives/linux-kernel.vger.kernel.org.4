Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E426F7F16
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjEEI3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjEEI2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:28:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2631A108;
        Fri,  5 May 2023 01:27:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115e652eeso18046022b3a.0;
        Fri, 05 May 2023 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683275237; x=1685867237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKvN7geuhhJ2stT3rAD0Yt4sWpwWIwnPYILFwrgVg/U=;
        b=Q1O8Lp9a8ptI9nGFpEO8CXYd1ndEB/FbiZLzIEAJ/pyZE36uwUcYyjEB6O84iN6Kb/
         TM/Aqp1fLwJnliDOk8MSSoZklriLDpQ8b8uZn7rLU+nHURABRGbesT6ls8mrxKdYozzW
         5PkVUplYz2YURGav5u4MR3T/ZafMJfm0ydsocHipgp/5ndIbiiPu/MwbU/zEHkQMzk43
         iM5Roc/ifsGUKgjPjDemqHs1CraXUxarnlPvKHKVviuSyOd6r2nyHtl/j5JTx7bEKbu2
         jhngfJbRDMHpSKGVz/xssn5YZeWdXFUXpz5asNFIpUxEDyLwaPV8NeMVyVGkGayGM3EF
         VASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683275237; x=1685867237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKvN7geuhhJ2stT3rAD0Yt4sWpwWIwnPYILFwrgVg/U=;
        b=XmFx0aarGfXroQ+bY5jHQVMY5nqHmOYXc0+AJyk/MGgi8G/L//20eklRbp1c4JNjFI
         O1M+rHLrPE+hPP6xg4BuuGHqkM3dKpKfX+2L++t4rBqfeG1FPVDeXTAvwVlsjCzjqopP
         21yTf0pudn8FJOU0sUB3ZjAw0+WUylM6jD4pHjNa8oS3ZPAkO+cu9LkM3zFqX/UUR0zn
         89FsughmOh4FHzZaThJbJLp/Ya+Cp74UO7pY1N8vNv+zIeoFC4hQk2XOTueqUmTgOgT0
         ef5aUDV185clhGGQEpnwrRdssqOul7HY5sI8T1i2gg9PbPjv5ygtiRlhnR4s9dEYNcvq
         p+Cg==
X-Gm-Message-State: AC+VfDw8O45U5lSYJu61gU0/W47fgYcQ2gS13/d3ZTB+6VvSEF40ITo9
        GTGsLewiFyUSkQxH/yCOpTRVNOroETY=
X-Google-Smtp-Source: ACHHUZ7L1WHN/CWnZkhqB6i1fxuogxxXg5VcNKai0rkaNihMnH7Aiuh1188dxbx34p2sNdCA2vj5AQ==
X-Received: by 2002:a05:6a00:2ea9:b0:63b:8963:d952 with SMTP id fd41-20020a056a002ea900b0063b8963d952mr1105209pfb.17.1683275236993;
        Fri, 05 May 2023 01:27:16 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id f9-20020aa782c9000000b0063b6d68f4bcsm1055555pfn.41.2023.05.05.01.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 01:27:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 086D410627E; Fri,  5 May 2023 15:27:12 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/3] MAINTAINERS: Drop DC395x list and site
Date:   Fri,  5 May 2023 15:27:02 +0700
Message-Id: <20230505082704.16228-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230505082704.16228-1-bagasdotme@gmail.com>
References: <20230505082704.16228-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=bagasdotme@gmail.com; h=from:subject; bh=p4xxzP6mlIqb3ICg78D48pZGWd+6owQowDBg9/9kLA0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkhe69PDe9jf/ZC5d3x48lMC2wu2f6f9cOtLuOi1sZY3 tAwrtNOHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIMhOG/+Fx+UlBuxcYl+9O /2AnuuOIko+GddcrkTxD5/MnVx61mM/w3y+Ndf5S8/fi/9zq88rtPxtULnE/+GVzk/j1ox8M11p t4AMA
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

Emails to DC395x list bounce (550 error) and visiting the site returns
404 page.

Drop both twibble.org links, replacing the list with linux-scsi list.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f3053b..35de3289a8af04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5692,10 +5692,8 @@ DC395x SCSI driver
 M:	Oliver Neukum <oliver@neukum.org>
 M:	Ali Akcaagac <aliakc@web.de>
 M:	Jamie Lenehan <lenehan@twibble.org>
-L:	dc395x@twibble.org
+L:	linux-scsi@vger.kernel.org
 S:	Maintained
-W:	http://twibble.org/dist/dc395x/
-W:	http://lists.twibble.org/mailman/listinfo/dc395x/
 F:	Documentation/scsi/dc395x.rst
 F:	drivers/scsi/dc395x.*
 
-- 
An old man doll... just what I always wanted! - Clara

