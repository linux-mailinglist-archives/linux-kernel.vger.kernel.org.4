Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC66636CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiKWWA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiKWWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:00:48 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01B8D22B3;
        Wed, 23 Nov 2022 14:00:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id io19so17834364plb.8;
        Wed, 23 Nov 2022 14:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXbYCWAazP8Rlo+89yrukrtECb7VrmIBkt89IozX0fU=;
        b=eN4qa0dgakMb89FiOJcmppQA9R27nJ2M8GONgsAIJeeABkpe3vtI+yMe0QfegXQfEW
         vq3EkanMwsmovPwuB18kM9JdrsLtd33wH1AUsyFEWhqo9Fgo4rgTVtHNKsaM/4thorpJ
         sacvOtctU2rDg7ijk8gir/bOwTow6vMSatQoK2azZpsgPE4Cjv44MAQgx2Sa5wSmof0J
         zo7FL52Lz27TyUiS7iicQsG7NEuqR5+P/WKW05SluI+2Z/o8DT2TFHiqp4UXNLHT6iQK
         CT9zEELznMNB76sOJB7UpQhchO0uIuxerYmc+WkaQQcKcvyx57lGcdjrPxhi5b747cUX
         m/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXbYCWAazP8Rlo+89yrukrtECb7VrmIBkt89IozX0fU=;
        b=4zdXLCxsiQAhn+LxDQjZ7DqQanckVBnuTDopXBtaix11wC5PAnFmeHrSUYUChnZ2hL
         TDIDERR3VdFg9m0Zbj0i6s3MDwGEhoXcEmmJCvmQuEpq3TtB9TZZSbZ1mmEjx95ZhNoJ
         QfKd/kSIcQ3K+XtSNDVSXBpTN3aR3g8+3JtLl9orJ7Q43bBQTiSTooarjfhekHFrNjf3
         qz7F0XEwQ/y67HVNgsQ2cKORc7hGkJEyVtlslgXHwYbHRoqoRW/G5R1hcxXAYlRi2cIF
         Rg4Gg70tKPttnbiGoX7cPYWTR5vEg8o5qAi+dsJd6IKBfAKQbvUm4omgCxpvA9HH/z1i
         Iumg==
X-Gm-Message-State: ANoB5pnj0kMcpM+WMPpQUydo/YQhff3DtV/kIxOCIRE0fz/E0MvNucjt
        B2Ebs4u+owAmZslah45hrMGvQcWHQqW46Q==
X-Google-Smtp-Source: AA0mqf7nENTn2xQopQDGO+H2umIDOUgSROuCxMWem9r3XyQWsBAQ6SEGHZXQYjS3p00Zu7/8qgzTXQ==
X-Received: by 2002:a17:902:bd42:b0:188:ca57:8945 with SMTP id b2-20020a170902bd4200b00188ca578945mr10792005plx.116.1669240847279;
        Wed, 23 Nov 2022 14:00:47 -0800 (PST)
Received: from localhost ([220.116.249.144])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b0017f8094a52asm14696662pld.29.2022.11.23.14.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:00:46 -0800 (PST)
Date:   Thu, 24 Nov 2022 07:00:44 +0900
From:   Paran Lee <p4ranlee@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, austindh.kim@gmail.com,
        pmnxis@gmail.com
Subject: [PATCH v2] scripts: add rust in scripts/Makefile.package
Message-ID: <20221123220044.GA6513@DESKTOP-NK4TH6S.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rust argument at TAR_CONTENT in
scripts/Makefile.package script with alphabetical order.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 scripts/Makefile.package | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 8bbcced67c22..2a90139ecbe1 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -30,8 +30,8 @@ KBUILD_PKG_ROOTCMD ?="fakeroot -u"
 export KDEB_SOURCENAME
 # Include only those top-level files that are needed by make, plus the GPL copy
 TAR_CONTENT := Documentation LICENSES arch block certs crypto drivers fs \
-               include init io_uring ipc kernel lib mm net samples scripts \
-               security sound tools usr virt \
+               include init io_uring ipc kernel lib mm net rust \
+               samples scripts security sound tools usr virt \
                .config .scmversion Makefile \
                Kbuild Kconfig COPYING $(wildcard localversion*)
 MKSPEC     := $(srctree)/scripts/package/mkspec
-- 
2.25.1

