Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518873BAD2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjFWOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjFWOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:54:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C1B2685
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-25eb3db3004so374193a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532047; x=1690124047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tkRvpYlcyoK9imqc1ate1m5sVlg4jHXsaw8TRI3hm+Y=;
        b=pNfj/wN0cI6af54TYFrthm/1HRNs77xW4EAgvMmJO3TWM6W2aiYlRf24htNLrhhX+s
         4TYGS/6VgWYAPQKwE+SbrmDBqVcAdM6MC2NO0g0hzy0XLyAltrxghEqmjZwSFvQL4MNZ
         mtzKvwskRdIaYkeiy2NW8+Pcw1rFXX2uikdrFRXlEn4n8yNXIp2l0aN/nE2LIPAAFM4v
         uOiojhcfJtEv693efc2WFR8FlCeAp+sjKXj1V1eZKzLgQWZYd/rZoVOMVEUC8A6sIrib
         0vQRBIXJsYYWyLuFFoXlcxaQhuZIjk7Vr+ws6pyoWx17naEURkQlb9p+HBocgF5Ar59U
         Q8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532047; x=1690124047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkRvpYlcyoK9imqc1ate1m5sVlg4jHXsaw8TRI3hm+Y=;
        b=MgP/hNvbgA17g4nJrMZkVqFi6ofxmi9r1FU4svKnP5VONj8ESZGqQbbI4gPcJtc0ZF
         qt4SUYg1VAXVcjPWWYG+byrlkKixd7n+DKFUWw7FAYYbQrvxFHzwosv6GYY/y90O1nvM
         tUS0UlKGj5nwRlobpsGSAcN2SmFgH7SXObLLSnSNN3UtRijzCJSpX9aEevrmOrbcEdSe
         hPWQ/kQQtBy5Jl5NUMrjeIwgnXkfwA1NiOAR1ZQSMpzRKG9aBzoUn2uEJ6GytfRMqtjY
         WdLDOOCDlcFAu+RY/KwDsyVs706AWa2+uTIsOGJvQ1iBlX9UUrTRrDIN7cRTKZ86wr6/
         GbRQ==
X-Gm-Message-State: AC+VfDyXJrf2G6uW3ZWjCLTPmfgSxJilLIn2bk/zU+Jma2Q/c/VEwh+3
        VVCO0EFXYmYWKBIgAICsjM8=
X-Google-Smtp-Source: ACHHUZ6tCsQREz6DJGWZ0dyBdkBM3Hosl9LiladVcOh4jZ911Rs+pLtQc1wjBsN4txEcb8mgoJ7vOw==
X-Received: by 2002:a17:90a:690b:b0:25b:f4a5:7510 with SMTP id r11-20020a17090a690b00b0025bf4a57510mr14596787pjj.12.1687532047177;
        Fri, 23 Jun 2023 07:54:07 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id fa17-20020a17090af0d100b002565cd237cdsm3359624pjb.3.2023.06.23.07.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:54:06 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v7 0/8] refactor file signing program
Date:   Fri, 23 Jun 2023 20:23:50 +0530
Message-ID: <20230623145358.568971-1-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors the sign-file program.

Brief of changes in this patch series:

- Improve argument parsing logic.
- Add few more easy to remember arguments.
- Add support to sign bunch of modules at once.
- Improve the help message with examples.
- Few trivial checkpatch reported issue fixes.
- Divide the modules_install task into sub tasks

Version 7 changes:
- Change Makefile.modinst and divide the tasks further
- Don't do everything from one place.
- This whole thing is done to facilitate bulk signing of modules
- Greg suggsted this idea here:
https://lore.kernel.org/all/2023060155-mustard-mating-32b7@gregkh/
- Thanks for the inputs Greg
- v7-0008-kbuild-modinst-do-modules_install-step-by-step.patch is fairly
big and I'm sorry about it. I created all patches considering build
stability in mind, so this can't be broken into pieces else in the
intermediate commit build will break.

Version 6 changes:
- Fix commit messages as suggested by Greg and David.

Version 5 changes:
- Addressed review comments from David Howells.
- Fragmented the patches into further small units.
Link:
v4: https://lore.kernel.org/all/20230221170804.3267242-1-yesshedi@gmail.com/

Version 1 - Version 4 changes:
Did some back and forth changes. Getting familiar with patch submission
process, nothing significant happened.

Links:
v1: https://lore.kernel.org/all/dc852d8e-816a-0fb2-f50e-ff6c2aa11dd8@gmail.com/
v2: https://lore.kernel.org/all/20230213185019.56902-1-yesshedi@gmail.com/
v3: https://lore.kernel.org/all/20230213190034.57097-1-yesshedi@gmail.com/

Shreenidhi Shedi (8):
  sign-file: use getopt_long_only for parsing input args
  sign-file: inntroduce few new flags to make argument processing easy.
  sign-file: move file signing logic to its own function
  sign-file: add support to sign modules in bulk
  sign-file: improve help message
  sign-file: use const with a global string constant
  sign-file: fix do while styling issue
  kbuild: modinst: do modules_install step by step

 scripts/Makefile.compress |  53 +++++++
 scripts/Makefile.install  |  66 +++++++++
 scripts/Makefile.modinst  | 111 +--------------
 scripts/Makefile.sign     |  37 +++++
 scripts/sign-file.c       | 292 +++++++++++++++++++++++++++-----------
 scripts/signfile.sh       |  24 ++++
 6 files changed, 395 insertions(+), 188 deletions(-)
 create mode 100644 scripts/Makefile.compress
 create mode 100644 scripts/Makefile.install
 create mode 100644 scripts/Makefile.sign
 create mode 100755 scripts/signfile.sh

--
2.41.0

