Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ABC6E8D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjDTIsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjDTIrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:47:49 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3E040CE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:47:41 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C1FB244279
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681980457;
        bh=RdaT2Pf0VFYL4LUkKTTIwRSg1FtfHR7MN47zcz2wKyA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=M6X/IL+6C0IANJOtuZiH/AkpBzXPe6+yAYR8X76F5aXjpBjwe5dAQElbLxK8RqCfb
         cp/DrNaM/O9cudEqraiOh+vNee0jH6mV1B5uigBiNV9zVNG7l8onGbey7B5maUGrhT
         5ZvZo9flkWVG0/Nv1G0QtyQzbuW9+aVv8ZhSQkxzHW2ITlrCgkzkhZtd3Six8DvfGT
         ImuN4eRN0UuqdwX+oqKKUkWH58pC4UBz/TkXYLIs5FW86QK48CvU7cUy/Y3BgiFVT5
         0XfHDXKgAAPVyEHnKB+KyZQ94cNtP60WeHmwZAcbSxtJtaR3lCTP03elKfqH7JTUkA
         ypJh4JiMpDBLA==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-505149e1a4eso2021302a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681980457; x=1684572457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdaT2Pf0VFYL4LUkKTTIwRSg1FtfHR7MN47zcz2wKyA=;
        b=gM48OX4HlLpsM1zLM09W4QEc4eAsoqxkyr99FTXxiAmAAS9n+YKQSZvLiCuFoeELGj
         292OaxM4wZQD1Yd1oYa6wkED3hwoRv2dvg9PUOkMikagkMO1YYdWMQ03PPDdJ77RVlui
         iPGN6eDddwhMnKFnpRQXUuD3krHy89e5S55AMDvx2YCAE8ukhsoqcf36f3/sJNJozG2m
         XJQfy+bHzIZEfFYLnsyCd+y7jR/2h3UhDjGay33q8nEE0IZEIhtx37CJCwWsPBW1z89A
         /KlmWFcEH+lR7+4kvxObXHeKg5xqupxl9YMcNJ4c7T/4cZGyrKPhZk2Rlh+1Vmf/60h0
         rWvw==
X-Gm-Message-State: AAQBX9faYBVpqhitXHOAq3Wg4sInWzcKcZpEIb8IGm4HPv5PK5Ls/ur/
        ov44aL2tRtkm2bOxwol39ixOFu19UOU9TrS1cnvr6Ugap2kAiAB0bXjmCQSQCYVQS+nFnEZYa/U
        FXZo9f5xLLhMM3J7OFgJTSE4J+MZB090WWEXoKKZzaA==
X-Received: by 2002:a05:6402:12c2:b0:506:a44c:e213 with SMTP id k2-20020a05640212c200b00506a44ce213mr594665edx.20.1681980457113;
        Thu, 20 Apr 2023 01:47:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350b5BYuHyFkiztfhJggGt3MxEYfSJc8HG66vflrM6qKXJUleuivEjOAyu1+2XykBik1RY7QhZw==
X-Received: by 2002:a05:6402:12c2:b0:506:a44c:e213 with SMTP id k2-20020a05640212c200b00506a44ce213mr594650edx.20.1681980456869;
        Thu, 20 Apr 2023 01:47:36 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7c39a000000b005068053b53dsm500964edq.73.2023.04.20.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 01:47:36 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     pbonzini@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Sean Christopherson <seanjc@google.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND 1/2] KVM: SVM: free sev_*asid_bitmap init if SEV init fails
Date:   Thu, 20 Apr 2023 10:47:16 +0200
Message-Id: <20230420084717.111024-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420084717.111024-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230420084717.111024-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If misc_cg_set_capacity() fails for some reason then we have
a memleak for sev_reclaim_asid_bitmap/sev_asid_bitmap. It's
not a case right now, because misc_cg_set_capacity() just can't
fail and check inside it is always successful.

But let's fix that for code consistency.

Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 arch/x86/kvm/svm/sev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c25aeb550cd9..a42536a0681a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2213,8 +2213,13 @@ void __init sev_hardware_setup(void)
 	}
 
 	sev_asid_count = max_sev_asid - min_sev_asid + 1;
-	if (misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count))
+	if (misc_cg_set_capacity(MISC_CG_RES_SEV, sev_asid_count)) {
+		bitmap_free(sev_reclaim_asid_bitmap);
+		sev_reclaim_asid_bitmap = NULL;
+		bitmap_free(sev_asid_bitmap);
+		sev_asid_bitmap = NULL;
 		goto out;
+	}
 
 	pr_info("SEV supported: %u ASIDs\n", sev_asid_count);
 	sev_supported = true;
-- 
2.34.1

