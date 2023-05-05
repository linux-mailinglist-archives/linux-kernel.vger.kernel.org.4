Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19CB6F7F14
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjEEI3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjEEI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:28:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4D19D7E;
        Fri,  5 May 2023 01:27:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaf91ae451so13505655ad.1;
        Fri, 05 May 2023 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683275237; x=1685867237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mG2sc9wYDLtXCv1Z997jO8Q7UbIkluJ8RfwLUnYFcWs=;
        b=JkU70bS1wgDa0LIQYLU3RMxuc292TFKgXTBQv7VjwC4Pj5f/rJD6WHE9QhxmOEkSs3
         kI2mLyeFS5S/8nesMnfGGb2bwYHpTDj4CCZmDvjp9zcxJHT83hwAspHHohpvzwg3ReEc
         Olp+0pFT6LD7OlekdWRfHf/uuPxNN/uUNI12OYP09Xzd9nb/uN4V66rCfUknG0NT9eGE
         rVQoAuIqwzPg7T7Si9f1oREAXoHGi0kssQDyUG/l8MwT3eRVAn49ChV7Nir3N0W/KYR9
         kKSbOP1ng1AzmWWEgqq6+0cXpamr4QQ7qfLKsHLQv4YxtkOLrWojw+kNOUEPYD8zrGlq
         Tq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683275237; x=1685867237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG2sc9wYDLtXCv1Z997jO8Q7UbIkluJ8RfwLUnYFcWs=;
        b=XBJXuEDJqHBGSjyeqgNPhzjNYZfR1RiAPO6gCFlW9o3ZeC1sxErXAI3KjUJ3hR6Xyo
         O3XtpvfeFdPF0lc6e6QIs+YcJ9V3D4muJsTIAt9vMZiI3wWXBMonJba6e82Mu9zuDS7p
         AQVbovQueBfH4R1TuiGYaERwwDbSqANSU9oy+X7QJKM+3aGEC/jkMB2WR5QedquE2nUZ
         Ma/euhRlS/p8/d/nzq5ukTcnyoIHCXTV0ugxe1HyzIQCEBvxUCJ3hKKigoE0PUIj53eZ
         znU7r5DzLU2rSOs42s5CRdTF/1f3ftUWEmx1clHZfTgC7cxZul0pJMAFfngxtt7LnsOW
         7ONQ==
X-Gm-Message-State: AC+VfDxu7CtHdm1mUj/kQn9wZ3NRibe3gMQML4sxaRWfJjXiascB0VMI
        nkGaDrdACITEfCRxmIQjFyOaVveRMEo=
X-Google-Smtp-Source: ACHHUZ6OHa40KVYj0XiMR8HeFrRCYDRkv1Np8zR78Gd6xHhtd+BO35jPmcNj2HOb/Bgt2WW3vencww==
X-Received: by 2002:a17:902:d509:b0:19e:ab29:1ec2 with SMTP id b9-20020a170902d50900b0019eab291ec2mr587394plg.65.1683275236785;
        Fri, 05 May 2023 01:27:16 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id iw5-20020a170903044500b001a64ed4621csm1081649plb.182.2023.05.05.01.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 01:27:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 337D610627F; Fri,  5 May 2023 15:27:12 +0700 (WIB)
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
Subject: [PATCH 2/3] Documentation: scsi: dc395x: Replace non-functional twibble.org list
Date:   Fri,  5 May 2023 15:27:03 +0700
Message-Id: <20230505082704.16228-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230505082704.16228-1-bagasdotme@gmail.com>
References: <20230505082704.16228-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=bagasdotme@gmail.com; h=from:subject; bh=Chb21dgeS65e00gjc5YnM1xptca/AXZCUk/KdO7719I=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkhe6+f9JF/fTJr61shDnbn3H+hr/5Mv32xSWX9120vh OxiZOfLdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAi9kmMDG9sQh9vN1K9UXvO MO9V4D0li54Pd56pL3NVCi98aO8t/prhr5S6bfgChxc3fL1jBT9s7ZzIMtHnlTOPA5e15twpy7a W8wEA
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

Now that the mailing list has been replaced in MAINTAINERS with
linux-scsi list, do the same in the documentation.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/scsi/dc395x.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/scsi/dc395x.rst b/Documentation/scsi/dc395x.rst
index d779e782b1cbe1..c413b629809bcd 100644
--- a/Documentation/scsi/dc395x.rst
+++ b/Documentation/scsi/dc395x.rst
@@ -15,9 +15,8 @@ This is a 2.5 only driver. For a 2.4 driver please see the original
 driver (which this driver started from) at
 http://www.garloff.de/kurt/linux/dc395/
 
-Problems, questions and patches should be submitted to the mailing
-list. Details on the list, including archives, are available at
-http://lists.twibble.org/mailman/listinfo/dc395x/
+Problems, questions and patches should be submitted to the `Linux SCSI
+mailing list <linux-scsi@vger.kernel.org>`_.
 
 Parameters
 ----------
-- 
An old man doll... just what I always wanted! - Clara

