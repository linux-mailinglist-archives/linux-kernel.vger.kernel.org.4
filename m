Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A414B6C3AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjCUTew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCUTep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:34:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F7520074
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z18so9234039pgj.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679427225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6yqwwGHiT07JiUUrp45GDD3AMqzX2ZKYw5EqqKqkzQ=;
        b=NLQMtZ9qo+uzRT6NHyOsA/WLXnbtKSf7jtqESSwtr5PiwUgfYkzACMopqfFSLBrzCD
         ARblYSc5IpWaa01h2jHMt8zf9XCA2RPe9plZP4I05fFzO4ixCiEb9jtMJ1H2UKUQOHmf
         LKaVcA+GjITLTA0bSJ1wXvKkdOL/S1Qig9/dLiXhChu4HzkW5vATOBZloM+oFPmlAQ1f
         HUZxABrvDKeuPncQcX2K4B6roTA4KXO2byhWupEhMh51NclVwGI7wIHfVAGpWDXgLlxu
         U6yU5rH5ouidABYX+IW+V4ASmtBMnPgiU5o9Ec+9u/fWGu4vFKPvZxngtSU8UHocssk9
         NJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6yqwwGHiT07JiUUrp45GDD3AMqzX2ZKYw5EqqKqkzQ=;
        b=Rc3Z1XzUw0wsKfYGVIGg9T2JVU16oS7DHEyfUUItlX/Olbwy4pLIH+smn6xkNPQHrD
         VIMhyuSnn6h9wmcEXuFnOM80lnIdKUfSjhyzN3x6lk3WJ8voB2FIK0BmAaUj25Tiguy9
         ezf3sYfA7sZp9FEvj5op1Oo6KlEguKP8SMZ2424BpsQ1vi03QkzliR5M14+LrxCqB46u
         1y+dk1hG9MpTI0q0McRdo29myQax53PvqZAwkQOi1dgbi5/7OndmaERtdbrn+5dM4UfZ
         svBRM0Bhi2BZIJdYLMw2MjBcEkv34ZnCSNJ8z4IBdbORMve08wLnpeKOP9opw8OQjkrQ
         oqyA==
X-Gm-Message-State: AO0yUKWAYCCuGZw7fTpxFxOWdtMEw26pdgUGWk9vnVz34tAnQNidCQ0O
        5U/eqApq86zKLpxz4tD/q2Y=
X-Google-Smtp-Source: AK7set9MPzfiOpDK1A4D+gLyJtB3DWTN5NBrMa46vpR3+HWYeZX+Pvst+sd3DYYSL8GrZd3Os7mkbw==
X-Received: by 2002:aa7:9dc1:0:b0:627:e69c:847c with SMTP id g1-20020aa79dc1000000b00627e69c847cmr905661pfq.16.1679427225224;
        Tue, 21 Mar 2023 12:33:45 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm8843044pfk.143.2023.03.21.12.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:33:44 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, sshedi@vmware.com, yesshedi@gmail.com
Subject: [PATCH v6 0/7] refactor file signing program
Date:   Wed, 22 Mar 2023 01:03:34 +0530
Message-Id: <20230321193341.87997-1-sshedi@vmware.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreenidhi Shedi <yesshedi@gmail.com>

This patch series refactors the sign-file program.

Brief of changes in this patch series:

- Improve argument parsing logic.
- Add few more easy to remember arguments.
- Add support to sign bunch of modules at once.
- Improve the help message with examples.
- Few trivial checkpatch reported issue fixes.

Version 6 changes:
- Fixed commit messages as suggested by Greg and David.

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

Shreenidhi Shedi (7):
  sign-file: use getopt_long_only for parsing input args
  sign-file: inntroduce few new flags to make argument processing easy.
  sign-file: move file signing logic to its own function
  sign-file: add support to sign modules in bulk
  sign-file: improve help message
  sign-file: use const with a global string constant
  sign-file: fix do while styling issue

 scripts/sign-file.c | 292 +++++++++++++++++++++++++++++++-------------
 1 file changed, 209 insertions(+), 83 deletions(-)

--
2.39.2
