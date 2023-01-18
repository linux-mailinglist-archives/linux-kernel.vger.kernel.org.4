Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA19E672937
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjARUXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjARUXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:23:42 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E235D91E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:23:40 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vm8so197131ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7ygh0J7KEHHboyD4LVUdzwenmNBGdT5Fep7mOK/62k=;
        b=YQWH9e0IWtfRphBxBJP11yHpKqk+5NLgiUf+ZJb39bL6BtSi3WxGNKPLWUPXk/s+d9
         D+igmFt49cI/pmTyX1FBayb0wdnd4BvdDOd6aFYT0vpO90hfeFJDumGu1x/aE0LafL4F
         js2mQRgDmoGwjoICJ98TTbtJqStlwHApVeiHIKk6+LnwFZtGONpjQCDLe1ZLKZMABVOG
         5gz0FI7b9N5u4IFn5BT46k4/daxcmuNa/fT+/dJI3XChKw7c9glb0qvhvwoUwTIvPs5/
         9QXnFCSjCT92XleOeZGjqB+q5cFcJOvptnzoFZhPw1G+ckFTi6XYAB7JJOKbT8XyZTGy
         PfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7ygh0J7KEHHboyD4LVUdzwenmNBGdT5Fep7mOK/62k=;
        b=sBGHsFrs/If6zBdm7MBaVXiUwopFKaG6KkC0aJO1BswjuHddwYsrM1tN2B7sTdMo+n
         JUAGK6YfPAkPtEXf4pLb8yEiSOmXMw6okUY6iBuWwITLdnX2zVH7bkPQTk1azQ2GcoD/
         LpIChVNVI+bNAZA2On5LT5Jmmb/ozYykDWQ0YOENwGBY+PVDARL2tVcwnOSKgrn8JA8L
         BwpdvvXnpFrNzZXiP9bwvLhcEM/pyVB3P6UYlB5o4GY+iqZBF+jzJ0ynYJT+OSg43ZlI
         8GD0FgwVeFMLiV3aL3Am2UArHtkJ1+u9bvubvu8ljOVdrUGKV66s3XVC+Tz3QL6CNgVb
         C2zg==
X-Gm-Message-State: AFqh2krVMlPg7nxy4fTKsNQZ3o6QEmIi0p7UPbOf1L0H/lAv/mS7Zk7G
        zJLk7wNyjJq81XphOfdbVg4=
X-Google-Smtp-Source: AMrXdXsEan2QlNe1yfOts3N3sqMyGbVsRrtFvhKXOKm85zfbYdsXEAjwEMO4GB0kJHQFdZvhw86LIw==
X-Received: by 2002:a17:906:c409:b0:863:73ee:bb67 with SMTP id u9-20020a170906c40900b0086373eebb67mr8620229ejz.73.1674073419361;
        Wed, 18 Jan 2023 12:23:39 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090633cf00b008711cab8875sm4093029eja.216.2023.01.18.12.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:23:38 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/pvclock: improve atomic update of last_value in pvclock_clocksource_read
Date:   Wed, 18 Jan 2023 21:23:30 +0100
Message-Id: <20230118202330.3740-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Improve atomic update of last_value in pvclock_clocksource_read:

- Atomic update can be skipped if the "last_value" is already
  equal to "ret".

- The detection of atomic update failure is not correct. The value,
  returned by atomic64_cmpxchg should be compared to the old value
  from the location to be updated. If these two are the same, then
  atomic update succeeded and "last_value" location is updated to
  "ret" in an atomic way. Otherwise, the atomic update failed and
  it should be retried with the value from "last_value" - exactly
  what atomic64_try_cmpxchg does in a correct and more optimal way.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/pvclock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index eda37df016f0..5a2a517dd61b 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -102,10 +102,9 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 	 */
 	last = atomic64_read(&last_value);
 	do {
-		if (ret < last)
+		if (ret <= last)
 			return last;
-		last = atomic64_cmpxchg(&last_value, last, ret);
-	} while (unlikely(last != ret));
+	} while (!atomic64_try_cmpxchg(&last_value, &last, ret));
 
 	return ret;
 }
-- 
2.39.0

