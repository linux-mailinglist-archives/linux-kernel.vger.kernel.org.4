Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0285A6C2057
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCTSvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCTSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:50:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A30729433
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:43:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ja10so13517126plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679337830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XL8sRzYiFd3zYk9D1PlS07YKcqDIg6/zQ6k4q+TUo+g=;
        b=bOXvA/FBXgr7OPRNNBWDZ4xX8/q5HOVdDkM4dU1VB2RtH03gyZLj9EgbrzZJtliGrQ
         /jFULMM8n/Ftb7ApHSZwjMLGBUDhJzSP5CPLrtv44N8ble1H4SduOhogrzKN+t2qxYBP
         PyyGwfCEaHOahOLjPeZZSx2yw3pzMXn5kJGOH6f10eQmIIWJQhhS9Uqd+PTrzZiVPPld
         imwG392QDVrgzr/RVfRl6e8A1bLJ5yE6m+B28KWlaPjRduLX1qcecK94raCdBLygjJeo
         mq8KOT09+hkZ6B8lQ88uU3/qfubOJiVWEB7QeMZVbps/0Wzl3Jvcvhl+rUaB/lWZ7gQv
         3J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XL8sRzYiFd3zYk9D1PlS07YKcqDIg6/zQ6k4q+TUo+g=;
        b=5fchieYaiwHxtymQIF159e5lP2q0ssCPPeJ0sHysLKhQu3wG72fJx0pSvJdfMBqTh8
         j7Qn9fxD56hdEhHyong+tX3a5YfkepK/+VObNM53eEHc8DDZB59GrhICnBREdyE8Sk/N
         j6kAI+k3ttz3uYXI60XRQ6BhN9KbvzyQKcHzaYehFWkf/8iFWi77uM7FDG1xuUnGKMvu
         N8wuhib1teU0Z3+uLXfNj/6xT8pSfYUKFIhq3oCaDlI1nOpELdEDUV6UoGzL7PrFmMrw
         t5wf13ewPujbHEWa8dBuu8OrnC5StAeddFiPbQHsadC8utto7ltrGlTPRnigF/M6H9d6
         jzjA==
X-Gm-Message-State: AO0yUKXkiAnCw+8HRZVwtnMzw/ofdWOiYkKLbJRBCyk2uRM7cPamHLVl
        1aPgPI/CDxMll4aVlWogASc=
X-Google-Smtp-Source: AK7set/tFkFuUQ2M/7ZF9t02xsSBzAaxLWzVtdSYH9Ei/BNDzra8eGau3Cd0FCdFsd2RfxF4fNCuFg==
X-Received: by 2002:a05:6a20:6982:b0:d4:5ae6:fbaf with SMTP id t2-20020a056a20698200b000d45ae6fbafmr27622451pzk.60.1679337829884;
        Mon, 20 Mar 2023 11:43:49 -0700 (PDT)
Received: from f37.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id bn10-20020a056a00324a00b005a84ef49c63sm6671755pfb.214.2023.03.20.11.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 11:43:49 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
X-Google-Original-From: Shreenidhi Shedi <sshedi@vmware.com>
To:     gregkh@linuxfoundation.org, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: [PATCH v5 0/7] refactor file signing program
Date:   Tue, 21 Mar 2023 00:13:38 +0530
Message-Id: <20230320184345.80166-1-sshedi@vmware.com>
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

This patch series refactors the sign-file program, like:

- Improve argument parsing logic.
- Add few more easy to remember arguments.
- Add support to sign bunch of modules at once.
- Improve the help message with examples.
- Few trivial checkpatch reported issue fixes.

Version 5 changes:
- Addressed review comments from David Howells.
- Framgmented the patches into further small units.
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
  sign-file: refactor argument parsing logic - 1
  sign-file: refactor argument parsing logic - 2
  sign-file: refactor argument parsing logic - 3
  sign-file: add support to sign modules in bulk
  sign-file: improve help message
  sign-file: use const with a global string constant
  sign-file: fix do while styling issue

 scripts/sign-file.c | 292 +++++++++++++++++++++++++++++++-------------
 1 file changed, 209 insertions(+), 83 deletions(-)

--
2.39.2
