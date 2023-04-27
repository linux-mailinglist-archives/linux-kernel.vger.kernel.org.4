Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CEC6F06F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbjD0OH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243728AbjD0OHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:07:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8935F4696
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:07:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f55ffdbaedso5466732f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682604434; x=1685196434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g++Jpz8si5Cxxyn4mP4hOUSvklGO5An+E7k8VLQcOJE=;
        b=NL4snAwmCqzvp7UbxQjE675qWSOTHU+8K7kahlPvCSIyKhWKDiAruAwrfHGtQF7OAj
         zOE1mqPdXxgtl/0wydUAQAL4kTY08XKoXm5d91rwqEyFD/UIMSrpQT2IfabHVaF64B7a
         WJS/JMfB6MwhARgLxWac9TCMREXWZGzVtMKtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682604434; x=1685196434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g++Jpz8si5Cxxyn4mP4hOUSvklGO5An+E7k8VLQcOJE=;
        b=ilEwjamZ+ofGP6P2JUvnmfjL+NhUBy/IL4zCRtZ/AFm9TiQ90NsL6Cd96Ap8T3MS9V
         RVZNdK7EINzuabUFyvjSBKZgX2XGb6rVyta0qVaFcDpqc6QfTbP1YOR3CXzf9jMYdJIK
         YGL/6AwNQ+WDqXQ0mbSi78AMkSGpaRnLzznqPkP0VYfp6st17q12WvVILxHU8XkSY7GA
         tr0dBrqaVrD1L0c/TuC0qBfcJN76sFEZsR686WEjeJu/w0GvrMe0m+ttsHRqkScIvIN3
         jyCZIZAd/RYUIXHJMFksdff+bQ/6xRZswhjWysdLIRDEqas+E7YEeZ+zb3CC4Wj9ngRz
         B/ag==
X-Gm-Message-State: AC+VfDwNs3Gkr9qkku9zmTKdflxBKutiqC5A7zFniQQeeeCHetc+gGXJ
        bpE4RbOhCNgXjM+SVjshICyVww==
X-Google-Smtp-Source: ACHHUZ5a/MAV7sj8ArZSXjSnbLQCCNHNJ29kn4QMtWeG1FmmD5w1ebkcBDl9+2wjdEm2+9Khgj7Ixw==
X-Received: by 2002:a5d:6901:0:b0:2ce:aa2d:c625 with SMTP id t1-20020a5d6901000000b002ceaa2dc625mr1497792wru.22.1682604433815;
        Thu, 27 Apr 2023 07:07:13 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:a66d:4f2c:7ce5:e8ea])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f17300c7dcsm21285075wml.48.2023.04.27.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:07:13 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        kpsingh@kernel.org, xukuohai@huaweicloud.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH 0/2] Ftrace direct call samples improvements
Date:   Thu, 27 Apr 2023 16:06:58 +0200
Message-ID: <20230427140700.625241-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a subset of [1] that didn't go through the arm64 tree.

- The first patch fixes a small bug when a direct call sample is loaded on x86
- The second patch adds arm64 support to all direct calls samples

They are sent together because the second one depends on the first one.

This series applies cleanly on Linus's master branch. It needs the first two
patches of [1] which, at the time of writing, don't seem to have made it to the
trace/linux-trace tree but I suppose they could be pulled from Linus's master

1: https://lore.kernel.org/bpf/20230405180250.2046566-1-revest@chromium.org/

Florent Revest (2):
  samples: ftrace: Save required argument registers in sample
    trampolines
  arm64: ftrace: Add direct call trampoline samples support

 arch/arm64/Kconfig                          |  2 ++
 samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c | 40 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 24 +++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 40 +++++++++++++++++----
 samples/ftrace/ftrace-direct.c              | 24 +++++++++++++
 6 files changed, 158 insertions(+), 6 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

