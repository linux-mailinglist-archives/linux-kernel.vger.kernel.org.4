Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD296FDAED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbjEJJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbjEJJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:39:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4E422A;
        Wed, 10 May 2023 02:39:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24de3a8bfcfso6676289a91.1;
        Wed, 10 May 2023 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683711589; x=1686303589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMvk/yJ9Ztc5I/rIEaDIj5l97963wi6uopL4aQkb6yY=;
        b=S5QBHK3KhGGzEGhFSKb86oVdUfuPuQ8acnDGPiLD6GlgFPsSlkvLbXr9TjRvM6zngE
         WnsopU+90NLK5ponMzp7i1UFIS9WqDFoKuWV4iGcMfnhgJy8EoNB4tCh72uamPb3ItPv
         jFwvtgiic/1kj4ruj+QQFfuXBbwUR7Tkaaw1l8J1kWreA3NL+nnP3KzjF4eKF0XNk2W7
         Rz4cr+jaoUxEogKDfzEQR3tWrUOL0X6oF6Bxm2014e813SXoHpXX+eYHUZX7+BI9uK5i
         VXmRYqqHABN91awT2jt2S15csaujCdaVxP5aFEetX60rFbg9T0e2r5Accnx39xXxhIry
         z9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683711589; x=1686303589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMvk/yJ9Ztc5I/rIEaDIj5l97963wi6uopL4aQkb6yY=;
        b=VXpnHaKNWIUWYQks/mwfFGIib7bu1HA9bebmt6nlTqOYg02LHUMPvqtp7Jf2M0mNtP
         Cr/Jcg2d3zVD2+lonUpM9DfwUgY/JIAZN6hKpt1aVgGY+x0lLqKdWH+tXZ8lH0eRjW1V
         LtuLiwnLO60ZUCjs9KNRlqeV12CEuHUVJ2ts1JyFn22C7vfyxuri4QkbofB0pV+hhUyM
         GTLCOUXpzBMnF9wNMV1SenCuxxJgcUubvF4RV2Cvga88eSJ/Ja47p3YiWd6H9URJh3+m
         PWWisnPuwWY/OHdrQrlTp2aVCI6LbonZt4T9duYRVqHwXqQBJTTg2h/iMdpQUvIwGGbm
         9WsA==
X-Gm-Message-State: AC+VfDwvT1Xd1lhgF/6b+WMhTwlVM+waNH2QqWMoTx90X0SRg81kwCmv
        u5+6nvoyN95VXgrYSDtopw8=
X-Google-Smtp-Source: ACHHUZ7/pJ5iKFW1gtkDQyricf57yut+qiP3Nh+xTYPw5FujIY6L6cObgGTjBatkHGTeJjcLygghBg==
X-Received: by 2002:a17:902:b18a:b0:1a2:98b1:1ee3 with SMTP id s10-20020a170902b18a00b001a298b11ee3mr16269110plr.12.1683711589291;
        Wed, 10 May 2023 02:39:49 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-71.three.co.id. [180.214.232.71])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b001a80ad9c599sm3273831plb.294.2023.05.10.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 02:39:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EF79B10688D; Wed, 10 May 2023 16:39:44 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 3/3] Documentation: scsi: dc395x: Reword original driver attribution
Date:   Wed, 10 May 2023 16:39:33 +0700
Message-Id: <20230510093933.19985-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510093933.19985-1-bagasdotme@gmail.com>
References: <20230510093933.19985-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334; i=bagasdotme@gmail.com; h=from:subject; bh=gGRYebnn2/spyEd/CK1GKcx94mEICbH99NKg8eQtQb8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCnRaaEv/PQqZc2MiuZKtbro3zU8Xcl3OPMi910fmdXmJ 7ljD9R1lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCK2sxn+u2xPKSq8KLKz4qj6 dbuje4rmN+xNMLyTy8p1N1A04HTGG4Z/ikrbAzmbUux9sl9Of7eOW8qkuGhHYVuJrEeg6aXLW97 zAQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel isn't in 2.6.x anymore, but rather the major version
has advanced much (currently 6.x). Reword the attribution.

Also, replace 404'ed 2.4 driver link with web.archive.org snapshot [1].

Link: https://web.archive.org/web/20140129181343/http://www.garloff.de/kurt/linux/dc395/ [1]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/scsi/dc395x.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/scsi/dc395x.rst b/Documentation/scsi/dc395x.rst
index c413b629809bcd..8b06d8fc7a9c42 100644
--- a/Documentation/scsi/dc395x.rst
+++ b/Documentation/scsi/dc395x.rst
@@ -11,10 +11,8 @@ be safe to use. Testing with hard disks has not been done to any
 great degree and caution should be exercised if you want to attempt
 to use this driver with hard disks.
 
-This is a 2.5 only driver. For a 2.4 driver please see the original
-driver (which this driver started from) at
-http://www.garloff.de/kurt/linux/dc395/
-
+This driver is evolved from `the original 2.4 driver
+<https://web.archive.org/web/20140129181343/http://www.garloff.de/kurt/linux/dc395/>`_.
 Problems, questions and patches should be submitted to the `Linux SCSI
 mailing list <linux-scsi@vger.kernel.org>`_.
 
-- 
An old man doll... just what I always wanted! - Clara

