Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3687062FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjEQIfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjEQIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:34:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF961AE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:33:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae58e4b295so922485ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684312431; x=1686904431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etvo+VyGjEU2AQxA2C1S1A5bJCkIQdAAfLUUAG8BZnM=;
        b=RpRbjra/e/jt1NCWzkWNlFGe3gWhcF6wkWDyEhgfD+tIjmJVmJWSg8FiIkX2gdEHgj
         9Taw7LtSaQUJlwPqTNWdn7HCaIhvQgWSBhLVb0WtugDC20ychq/6A3jVXPIm1r3f2i3r
         S52l6dqdutIp4tBbfBPc75CW6NZFASlE3QrlHYqomh7rHse8JgtQJBnoJ6NUJLvk5ff1
         ptsVsLXNs4MySEh4EYwYyVzZ/nwF3KmXHzOCXp0XF0XRQnnHwaXd1gjrY3P+YkvMIFsy
         RJRKtKOkms8WX6xrl3icBm/Fh9DUbsEd0/CUBm32hZpjkFHcsMbvhdjoRKpNwN5L/jo+
         MWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312431; x=1686904431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etvo+VyGjEU2AQxA2C1S1A5bJCkIQdAAfLUUAG8BZnM=;
        b=ievW9zRHHhwuXSklpRhuOlAsPyto5LGNMCFLOXJxwhLKqO+nY0ax7bS63XmgR+MxI3
         E/41/zcDQThFQc4bg2RjoT7UJ21DUOYOvCJvr9huiLJyM30HSzLPp7H+I7qicfy4551z
         i0XnZTDN+FPjc7XeTZ8CJutu2mS8BzUKEpqqV5rE4dSOk8H0bDzMf/crv2IQ6VmTshYP
         bfvCJZAoPEOR8FIhYpsBVOCh07M01rN60edHQVtepr+R8Wuzpffxk1ni0O7GF97G1Q3X
         VDCwxf6DOrhciqEljkdWjyfVxIhl92eOiqZRL/9i2u2tw4bs1vNpeOv4ppsBDsr/SFab
         H7Eg==
X-Gm-Message-State: AC+VfDwKoknbr9R+8r+3A4vN+ciWuXdUOYgZyt33UlEFqr0yHDSn+tTF
        D/0UQFUVxeElSOOn0rwKNyk=
X-Google-Smtp-Source: ACHHUZ5v65vWPc4zb5rWuQPamR+P019TJjEfRDj916ZjeKB3ZWgm36R4eOH04jv0s93GaFuQJzLDOg==
X-Received: by 2002:a17:902:a516:b0:1a6:b971:faf6 with SMTP id s22-20020a170902a51600b001a6b971faf6mr36859483plq.35.1684312431089;
        Wed, 17 May 2023 01:33:51 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id ay8-20020a1709028b8800b001a9a3b3f931sm16971629plb.99.2023.05.17.01.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 01:33:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0358510621C; Wed, 17 May 2023 15:33:46 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Jan Kara <jack@suse.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Eggert <eggert@twinsun.com>,
        Richard Fontana <rfontana@redhat.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 2/2] fs: udf: udftime: Replace LGPL boilerplate with SPDX identifier
Date:   Wed, 17 May 2023 15:33:44 +0700
Message-Id: <20230517083344.1090863-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517083344.1090863-1-bagasdotme@gmail.com>
References: <20230517083344.1090863-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752; i=bagasdotme@gmail.com; h=from:subject; bh=UJ6XIT5Gdt7tmMfL0VaooSzO04V4hztGoQKqQ7FF51w=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkpEzNKw38YmN6bvPd24kpT7dzjKxLvZLEHcbyOW3YtQ Pdbpqp6RykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYyYQkjwwmW+XyuwQ9r7Dav W8mp3DTDlWvdwZ8rvyuwTXXezJKukMvwz76aqbZsz9s4j4p471iX60buOrJ2RV8smu6GhBt7H5z GDAA=
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

Replace license boilerplate in udftime.c with SPDX identifier for
LGPL-2.0.

Cc: Paul Eggert <eggert@twinsun.com>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Pali Rohár <pali@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/udf/udftime.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
index fce4ad976c8c29..a337e6aad89edc 100644
--- a/fs/udf/udftime.c
+++ b/fs/udf/udftime.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.0-or-later
 /* Copyright (C) 1993, 1994, 1995, 1996, 1997 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
-   Contributed by Paul Eggert (eggert@twinsun.com).
-
-   The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
-
-   The GNU C Library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
-
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If not,
-   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
-   Boston, MA 02111-1307, USA.  */
+   Contributed by Paul Eggert (eggert@twinsun.com). */
 
 /*
  * dgb 10/02/98: ripped this from glibc source to help convert timestamps
-- 
An old man doll... just what I always wanted! - Clara

