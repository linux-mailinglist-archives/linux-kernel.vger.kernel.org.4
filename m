Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EAC70B5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjEVHFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjEVHEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:04:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9641BC1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:01:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d426e63baso2496141b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684738903; x=1687330903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYNeVJrKOL7MnfIWnZtzWr+y0jbkK7//uDkqtArY+/I=;
        b=L2xb/K9Gl2wTLOgGLKgCeOOadn9mcb9mYkDZ/jTml6bfllu+Ci/lPKGRi96KKEECnJ
         c8wuCuHsqAqH2CQAT4R6RkQAdWOHueqieAR8/Lgo+w7V6MWOgGhJYQ0pc8Pc/jE02OOm
         +2yJ/pgSVnknd4HJ1Vro0U8u3RbL5udWQHTMaMpYP1gRFNTvLrVr/6GW4CfEGEEbz0ag
         gFWUACaDCpwkfJ7tSuFYTlc4yjGEY4uXy2AzAFE+S/aY/7E72qGXRSdV2tkVpOQWopgo
         VjkwL1ADzY9+yfE2kh/LdT/hvyeb/rbrWID+Xd6F8E9hLLUmok8UXKEqIARxKM1JZ7cf
         bH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738903; x=1687330903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYNeVJrKOL7MnfIWnZtzWr+y0jbkK7//uDkqtArY+/I=;
        b=WRyQCd1FpahBLH7727eUpocIQ2MPIdMVTFOcqlIppCDQVotBYwaTGfPaWiWBXVNML2
         J5hcL9GlVnyxuUa8a6ktgcrIUcyjdEekzY2KCFn5w9GsJ1d9lBsObxXuJym9ema2yy6H
         ZtLQUv7oKt27dokWgsEXoTsI+OA9nop8tAf3oeN66DWM5CYhyLUjIqGl0W0LljvGy/Hx
         XGW/3xAG8Fkrnd7tJLTkOUGe7aNYArJ6jhfgrw0PLm+YnR3tZjAhvU+8F0THo2QCmjpr
         qEs3daHd5tv5mLhgLbi8Osc6UMz6PHlrBaJ7i41EYiSpZ9Gq4YcWEsFcMDEqLNfbldom
         0uKA==
X-Gm-Message-State: AC+VfDye4whawnUFSupfOUGnfa/7/DbiE8h0a0csVm2vtZXjIc1ybjyb
        LLkyqgsLFF9hzqXFVaKr2SZIRxM+LiDM6KFRIuY=
X-Google-Smtp-Source: ACHHUZ4I2WbOlKYOgzusUIffYUqfzhoqarV0DqN2Qs8ysF7zrJxV4MnqZfQF+rRfmw9+kt+ngQ4/Vw==
X-Received: by 2002:a05:6a20:c886:b0:106:5dff:5dc6 with SMTP id hb6-20020a056a20c88600b001065dff5dc6mr9467949pzb.16.1684738903209;
        Mon, 22 May 2023 00:01:43 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d27-20020a630e1b000000b0052cbd854927sm3687505pgl.18.2023.05.22.00.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:01:42 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Glauber Costa <glommer@parallels.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v2 0/4] sock: Improve condition on sockmem pressure
Date:   Mon, 22 May 2023 15:01:18 +0800
Message-Id: <20230522070122.6727-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the memcg's status is also accounted into the socket's
memory pressure to alleviate the memcg's memstall. But there are
still cases that can be improved. Please check the patches for
detailed info.

v2:
  - Splited into several patches and modified commit log for
    better readability.
  - Make memcg's pressure consideration function-wide in
    __sk_mem_raise_allocated().

v1: https://lore.kernel.org/netdev/20230506085903.96133-1-wuyun.abel@bytedance.com/

Abel Wu (4):
  sock: Always take memcg pressure into consideration
  sock: Fix misuse of sk_under_memory_pressure()
  sock: Consider memcg pressure when raising sockmem
  sock: Remove redundant cond of memcg pressure

 include/net/sock.h | 11 +++++++----
 net/core/sock.c    | 32 +++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 13 deletions(-)

-- 
2.37.3

