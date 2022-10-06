Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1595F5E61
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJFB0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJFB0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:26:49 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0662F564E0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:26:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r18so497528pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 18:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=7K6g8wc+JL8tVoIXAnSDzXXNDF+K2QKgVxA1GlSH5So=;
        b=KDHyoudEb8cv3WCQfSnb7W5upFYOwYsHEcoCztQcI1xhy9PuaguBbF5scSWWyGnWNr
         Z501oJNFZiNpzFQ+zE0f+JPKpdG/DXFem13TJfazmp9LMY3XLTlnbt2z5woAN7jjb9J7
         4kcjEkIVQ5G26A4eJJJE6OI5PvWUgU1dbZ06gHZsVBO+lgjxSNPa8JZ0+3CP61Glhijb
         LEGyIxsLD8L41pmINq1LZMysyqC+Z/MQl9hemU1lnqPiXsSqUQv/aMKcDBi/jT77KIMT
         Ri8pvNUMM5fm37PD7329rFbVm1XToXzv11LhqLXHCrjIdlrBq7yvgl8BQ53Psm1G3Tm7
         y6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7K6g8wc+JL8tVoIXAnSDzXXNDF+K2QKgVxA1GlSH5So=;
        b=C6cZmOzwGdTlN9iEO+ekN011ekXex4cx0qEfea1nFvYet7JqUvd63u/VbZ1mFmfaMr
         ReqEoSV/MvM6l1AlcweBl6htW8Eh7xbzeXa1/lqHiYog4hF/N8EmCtuvU8DC58RSaA5h
         UpaRNQvvxQK98641f7GseUzppvml2LcMUUtdaaeUVnoC1AVxo1FXZZqEsWEcV4A6NUaH
         tRW/7iXM07FQKPrezHsUpcgXq/BQRmIuzcMXmCuDM8GEkZHTxxT03m9WnBnTXdZ9+e1G
         LgwoAjEyYFzHp7ZfQ1vNBuSQ0UegjvJunnFUwhjIeKK0GhrQnr9f7WcGoIP8l3XhbvML
         uQPw==
X-Gm-Message-State: ACrzQf36AmjA5ZUizu/bf7bVN26QC+mvGzQbgE0ny4TLEBuM/xo+FpVu
        S4Mba2ty4/26fR2ILgcrEkEYdg==
X-Google-Smtp-Source: AMsMyM7cxdeo1JmQob/bXBNlxz1yXDMTgCHS1UuV0kjxKuERy9JYAPsyQVs9A7XLozQ6qQM4xG5fiA==
X-Received: by 2002:a62:1684:0:b0:554:cade:6970 with SMTP id 126-20020a621684000000b00554cade6970mr2579969pfw.11.1665019608451;
        Wed, 05 Oct 2022 18:26:48 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b00205fafa6768sm1764507pjj.6.2022.10.05.18.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 18:26:48 -0700 (PDT)
Subject: [PATCH] ptrace: Mark PTRACE_{PEEK,POKE}USR as deprecated for new ports
Date:   Wed,  5 Oct 2022 18:24:32 -0700
Message-Id: <20221006012432.19008-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     oleg@redhat.com, linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Folks keep submitting implementations of these for RISC-V.  As far as I
understand they're not meant to be implemented in new ports, this adds a
comment to make that more explicit.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/uapi/linux/ptrace.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 195ae64a8c87..38201ebec276 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -11,14 +11,19 @@
 #define PTRACE_TRACEME		   0
 #define PTRACE_PEEKTEXT		   1
 #define PTRACE_PEEKDATA		   2
-#define PTRACE_PEEKUSR		   3
 #define PTRACE_POKETEXT		   4
 #define PTRACE_POKEDATA		   5
-#define PTRACE_POKEUSR		   6
 #define PTRACE_CONT		   7
 #define PTRACE_KILL		   8
 #define PTRACE_SINGLESTEP	   9
 
+/*
+ * These are deprecated for new ports in favor of PTRACE_{GET,SET}REGSET, which
+ * support accessing multiple CPU registers in a single syscall.
+ */
+#define PTRACE_PEEKUSR		   3
+#define PTRACE_POKEUSR		   6
+
 #define PTRACE_ATTACH		  16
 #define PTRACE_DETACH		  17
 
-- 
2.34.1

