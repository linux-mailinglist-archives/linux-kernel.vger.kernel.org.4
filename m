Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7FC6BF8CF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCRICs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCRICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E521955
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679126513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpwvsmW/EIvjt3XpmgOB2tOjIn+1scWXRJYbQwzYCy4=;
        b=BPBjds4YinuZDo8EPPMSfJU1wZZDqbaNuxkPaE+U8vELYHOFCibdDiU4cb5EzNPnBker7e
        +rW3LgR8A7kSfu/8p/ZFrC/un98RLjDz2ffF2kM4zWoJapuwWoc35c0vr5T1bhi9bG9m8E
        qXmt8kWEue84aEhlVVS0tJu3ETjJT7w=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-G9jQ3qYsMrCKPnPQz9lzRQ-1; Sat, 18 Mar 2023 04:01:52 -0400
X-MC-Unique: G9jQ3qYsMrCKPnPQz9lzRQ-1
Received: by mail-ot1-f69.google.com with SMTP id e2-20020a9d5602000000b00694299f6ea9so3276239oti.19
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpwvsmW/EIvjt3XpmgOB2tOjIn+1scWXRJYbQwzYCy4=;
        b=3RwAMVV9QoRo1XNjIYfiLQsdBTtu9sz3TU7AgqWinvalnJnQh7oqqY7MN5Zmr40Ak5
         LXQ770dtt9BAQvzMIbISjbVNTCh0bC+97keFdRStLwWVwry1mGRUlnDczfBLzmkTVpzB
         QhWognS1IUYqF4Kx/6mWUzkTIndPh4S8bcJxH/bAxbvPHpSY44gZMsApF12W1u+pTe5q
         S7wq5cx6K1YbCjOax1qbeyt5JFr67yoVIk/kBjFx7XdmtOrl1MxdcA6aZV6cWgpLB0Cl
         27sgwuXQcfcfy3930sqiMnn4QSFEIPt+JxpkQVthfW7erNFshBuc0EfVX+gotmHR38zC
         dmbA==
X-Gm-Message-State: AO0yUKXko8SwG1FWhFT1S6sZSKzZzcJqsLM+ZqvaixGGCv2Rk8CQlPwd
        FlFeM0WdUak/kz2mzlcnnNT7vzsyLtvo8oBin2z6JISttbINadLsgsWHNiHAdqAHINex0vQOtXe
        TYenp7mpNrQN8MNxH1hFWoEjR
X-Received: by 2002:a54:4105:0:b0:386:a6cb:82ed with SMTP id l5-20020a544105000000b00386a6cb82edmr5217854oic.33.1679126511679;
        Sat, 18 Mar 2023 01:01:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set/JkYinclH5dcLs6EHBhSKruKldE5cS9Bd8lNlJcC0BBckJockV5iTHiGLJSuRSCGUw//8tvQ==
X-Received: by 2002:a54:4105:0:b0:386:a6cb:82ed with SMTP id l5-20020a544105000000b00386a6cb82edmr5217850oic.33.1679126511452;
        Sat, 18 Mar 2023 01:01:51 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d4803000000b0069dc250cb24sm1824462otf.3.2023.03.18.01.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:01:51 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/6] riscv/cmpxchg: Deduplicate arch_xchg() macros
Date:   Sat, 18 Mar 2023 05:01:00 -0300
Message-Id: <20230318080059.1109286-7-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230318080059.1109286-1-leobras@redhat.com>
References: <20230318080059.1109286-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every arch_xchg define (_relaxed, _acquire, _release, vanilla) contain it's
own define for creating tmp variables and calling the correct internal
macro for the desired version.

Those defines are mostly the same code, so there is no need to keep the 4
copies.

Create a helper define to avoid code duplication.

(This did not cause any change in generated asm)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 23da4d8e6f0c8..d13da2286c82a 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -43,41 +43,33 @@
 #define __xchg_relaxed(ptr, new, size)					\
 	___xchg(ptr, new, size, "", "", "")
 
-#define arch_xchg_relaxed(ptr, x)					\
+#define _arch_xchg(order, ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
+	(__typeof__(*(ptr))) __xchg ## order((ptr),			\
+						_x_, sizeof(*(ptr)));	\
 })
 
+#define arch_xchg_relaxed(ptr, x)					\
+	_arch_xchg(_relaxed, ptr, x)
+
 #define __xchg_acquire(ptr, new, size)					\
 	___xchg(ptr, new, size, "", "", RISCV_ACQUIRE_BARRIER)
 
 #define arch_xchg_acquire(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(_acquire, ptr, x)
 
 #define __xchg_release(ptr, new, size)					\
 	___xchg(ptr, new, size, "", RISCV_RELEASE_BARRIER, "")
 
 #define arch_xchg_release(ptr, x)					\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg_release((ptr),			\
-					    _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(_release, ptr, x)
 
 #define __xchg(ptr, new, size)						\
 	___xchg(ptr, new, size, ".aqrl", "", "")
 
 #define arch_xchg(ptr, x)						\
-({									\
-	__typeof__(*(ptr)) _x_ = (x);					\
-	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
-})
+	_arch_xchg(, ptr, x)
 
 #define xchg32(ptr, x)							\
 ({									\
-- 
2.40.0

