Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC7A60B915
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiJXUCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiJXUBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:01:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B772324E410
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:22:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bs21so1613822wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cTRya7BWPcqsR7OtszqL7KchFavr9g3TQZiRi/8988=;
        b=bGBaY2g3DIx/8hN0JHcD0TSN7Cpg0DthUSR9UhTbI2bCgNeTHiMw6mcP0Y+qmezrXx
         oVhpnBDu7LPbNPgQDkEoau1+okRNRNBSvdRInQrBleUZ/rlVAEBAxMeuwIMsA2WiyooH
         c+jwwWtZTdq/Z6kh2GP5lPoNiRku3hx1+gkKo5vkQgUSwhtzNIwCq3fRecW3BvfG4v3V
         ui5JcfOo0f3c9au75ma9f2rZqthRhTqUaVI8ca6ODWd0sMgYbvsJ2wej/aaf0oxQSOgs
         BYJDEIqoUcI/e3t4dgxdCC9Yumymc2Dw7VHTaqMEfn/13Axv/+dHEWogGDaV0MN/nbwd
         +Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cTRya7BWPcqsR7OtszqL7KchFavr9g3TQZiRi/8988=;
        b=N9K+Dx4EqS9RV2HeH+p4cUtC863I60ElFZR927UMJQvo3p+h8S+PVRFLDWEzaizona
         FgkHJHw1v2ew4abnXsdZ0APqj4mlmxJh95k4fpra4/7cilHPLf6KmT1GR0HU2Im+8DJa
         hIPmdsj74sOtHDf8NbBlPr8XbuFV7DvrrMzmgtvfISxzw47IFiv3Naaq1IOPxN6KLwhW
         nUF2oI8vxTzJZOD+to1fIm8rJbIALvbzj5QDN1y1CIH1C1Sq296GVtzWk0fttM3/I5iR
         TfIFfuhaHv30cpwG+QTl9wl59MTEcFi/qk+JKhldEk0TAt3gG8jgBbpE9PYSyAXPrZ1d
         6vyQ==
X-Gm-Message-State: ACrzQf2fS4CWAiJtjyladljxTE45Kgcg1/pOFW8O6THPos3qxVvkXVrI
        iX0QLgrd4UFXm5BHcnp64VnwbLhiMA==
X-Google-Smtp-Source: AMsMyM7phEjSOHENdC39JCV36gTWfESdUZdOrwSSNunj4EMVMPrhsvQC9432ZKEasvXqxFOKlgFmgQ==
X-Received: by 2002:adf:f4ce:0:b0:236:6578:48b2 with SMTP id h14-20020adff4ce000000b00236657848b2mr7343482wrp.181.1666634891401;
        Mon, 24 Oct 2022 11:08:11 -0700 (PDT)
Received: from p183 ([46.53.250.110])
        by smtp.gmail.com with ESMTPSA id h6-20020adfa4c6000000b002206203ed3dsm330262wrb.29.2022.10.24.11.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:08:10 -0700 (PDT)
Date:   Mon, 24 Oct 2022 21:08:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: fixup uptime test
Message-ID: <Y1bUiT7VRXlXPQa1@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall(3) returns -1 and sets errno on error, unlike "syscall"
instruction.

Systems which have <= 32/64 CPUs are unaffected. Test won't bounce
to all CPUs before completing if there are more of them.

Fixes: 1f5bd0547654 ("proc: selftests: test /proc/uptime")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-uptime-002.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/proc/proc-uptime-002.c
+++ b/tools/testing/selftests/proc/proc-uptime-002.c
@@ -17,6 +17,7 @@
 // while shifting across CPUs.
 #undef NDEBUG
 #include <assert.h>
+#include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <stdlib.h>
@@ -54,7 +55,7 @@ int main(void)
 		len += sizeof(unsigned long);
 		free(m);
 		m = malloc(len);
-	} while (sys_sched_getaffinity(0, len, m) == -EINVAL);
+	} while (sys_sched_getaffinity(0, len, m) == -1 && errno == EINVAL);
 
 	fd = open("/proc/uptime", O_RDONLY);
 	assert(fd >= 0);
