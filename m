Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE2A6DC4BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDJI7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjDJI7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:59:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4132135
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:59:21 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517bd9b1589so329046a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681117161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+SGlHzs1teH/N6Up9WvKqFn1ILr9s+l0miVs+IwrMQ=;
        b=eZZtAYFFTjiEkTiR8vZBXESKZMi2XGeNqPQ8tEmnMq0rVM29F0wlvi9l9YtDvfcgVO
         EMtZgHsPSBD+9vmddsLS6zFkFFq8vP5p/aCAh3FGx0FBEDnSCz4zZXW1Ya36flY6d0QJ
         aN6D3KrwGRLbG7YEY0jh96wTkBKBz9WT3CCEYgKFp1D0/y2fn6ExBjtaZmjIwlRgcNKc
         +W3Wyj4LABPpkrPy0kQZHNUzW004NqDDoQPgAVHt/ZbH3h6rBG/cSSwFx4WMV41iTBud
         V5YXEgG8JgiTxluBT6xqHSgZqw3lf3t8dlaqsRYLjNp1r3dqnmjFv2gJqaATrgBx1ZRF
         x7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+SGlHzs1teH/N6Up9WvKqFn1ILr9s+l0miVs+IwrMQ=;
        b=HS4FbL4Mm+2YfruGwKBCHVldfV8Hh2FGoALpiTvAAtNc54iLXCu0VeDcru/9rQ65HH
         ALG+MS3FzTK+qi2AA5nV32ecItm5PhaBXxuc3RB0JGA0suOjSG4hmvvHo/Ea1kM1zdI5
         5WEVegESpEovkaSdfMcEcc3mcMzglkVaGfuooi9KPh242MH8mI5lx3lo0B66Qil1mcKx
         +Bz/RiV7CIzzWP+/rpMXH2xvktBA/W7mO9FYlMKJ1L8iair8UUsJWUW63fe6Uk/7PeXr
         cWTjtNXoQe9Hnd+4xxcHWRxlWZ7sgWb+2Jfrwuoeiuek8ghmJlatiLZ+MbGO82r7Mv/g
         Nqow==
X-Gm-Message-State: AAQBX9esDBOANMSYM4+v3OnbfGpKEcNryL3YqqlqKWPXGrjwPri4yvq5
        swBqXGFXORglUexTK+yARz86dA==
X-Google-Smtp-Source: AKy350ZTlBWN6lA5EaT1mWXAvUTpNMvID1mtM5OAyi9bP68VWROpmT01Bnwv83nKnw+b3aU/lLRV0w==
X-Received: by 2002:a62:6546:0:b0:627:f9ac:8a33 with SMTP id z67-20020a626546000000b00627f9ac8a33mr8746125pfb.13.1681117161097;
        Mon, 10 Apr 2023 01:59:21 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b0058bacd6c4e8sm7279526pfm.207.2023.04.10.01.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 01:59:20 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhouchengming@bytedance.com, zhoufeng.zf@bytedance.com
Subject: [PATCH v3 0/2] Fix failure to access u32* argument of tracked function
Date:   Mon, 10 Apr 2023 16:59:06 +0800
Message-Id: <20230410085908.98493-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

When access traced function arguments with type is u32*, bpf verifier failed.
Because u32 have typedef, needs to skip modifier. Add btf_type_is_modifier in
is_int_ptr. Add a selftest to check it.

Feng Zhou (2):
  bpf/btf: Fix is_int_ptr()
  selftests/bpf: Add test to access u32 ptr argument in tracing program

Changelog:
v2->v3: Addressed comments from jirka
- Fix an issue that caused other test items to fail
Details in here:
https://lore.kernel.org/all/20230407084608.62296-1-zhoufeng.zf@bytedance.com/

v1->v2: Addressed comments from Martin KaFai Lau
- Add a selftest.
- use btf_type_skip_modifiers.
Some details in here:
https://lore.kernel.org/all/20221012125815.76120-1-zhouchengming@bytedance.com/

 kernel/bpf/btf.c                                    |  8 ++------
 net/bpf/test_run.c                                  |  8 +++++++-
 .../testing/selftests/bpf/verifier/btf_ctx_access.c | 13 +++++++++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.20.1

