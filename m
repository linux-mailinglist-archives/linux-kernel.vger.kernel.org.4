Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1322F601287
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiJQPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiJQPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:11:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE1FEB6;
        Mon, 17 Oct 2022 08:11:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m23so14328026lji.2;
        Mon, 17 Oct 2022 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zDrLfxf8/ad9Z1JXM2hFM1o6Mdjt4BD5BI5EnR/thXE=;
        b=gow5eA+rQN+SCTwwTLd8hiex1r3QxFYL6+h6m3uY6jGvZkRn5LEv9/98oseStVmWQO
         R/nN5iS6tyTQ1jaSVRbuFartqofqJDxCwyWsYcoNagd3mcRRoTKC4ygn8FdpjIv7ULAW
         xY1Y38M5mhPhi3exHvqngsS5zunS+rF6j6kPmnXeo2dxzurFb9VEu0RCHjuRpb0TzSSG
         /JfkKsriJ1QG5bBYISUTmd/oXOcxw9e8fzHmhfPY512wz+9xmrBBcWcEcX31YsDX7U5J
         CJ0OGbohhinRSu0n75qTRb0109XQMso6abA0mV5YCBssYCesh7iUPiKD/EOdCahVAJtg
         igXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDrLfxf8/ad9Z1JXM2hFM1o6Mdjt4BD5BI5EnR/thXE=;
        b=2QMps2UHptRrxfrzH6w+gHo8Kn/szjGnx0C5aq4EoRN6VfImQ5vGccA9PU0Hkt9y3/
         xYFzAlkxo/zC+Tm83A/yAnE83KapPNzqVEyu5bZnyXUc94sX+E2JSdb1vudTl/I97qr2
         VdUxreo7BXUeQVvZLU44kE+i0z6zVumzbb0Y34VbFybHquP97o3XHrwevSLJ2QWRjBGT
         ksigNZZYsloRsfzZ4wLPnR5KOYCjCVdIF/m1WFiv4nfOIP1NgHQMRq6IkPhFyaxUtgeo
         RT7yKFnnrW2m3ncJJPIpqLb3U33r/MBO4hXo6KOkcRM3W1lX3Npi3Y1Uvno6XbYeuW5V
         y51A==
X-Gm-Message-State: ACrzQf2WC2OTjsYi0IZtVq6uw/IowuYhY2BQnhumn5K95pKkbvCtQRbd
        lENX7jloEFlK4jHvc+ta8Gy+LvKxnhX3NA==
X-Google-Smtp-Source: AMsMyM4vOp+s79IL9g+P64HGxisS45rr5lQ5ibxhkBCpZpkLrLeb9PBkeFls1lb4CQcUC7ra24bwXQ==
X-Received: by 2002:a2e:9215:0:b0:26f:d8d1:af92 with SMTP id k21-20020a2e9215000000b0026fd8d1af92mr4458674ljg.370.1666018929023;
        Mon, 17 Oct 2022 08:02:09 -0700 (PDT)
Received: from shock.lan ([2001:2002:2f8:bfc5:11e3:17a5:f449:1926])
        by smtp.gmail.com with ESMTPSA id m12-20020a056512358c00b00497b198987bsm1463673lfr.26.2022.10.17.08.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 08:02:08 -0700 (PDT)
From:   Stefan Hansson <newbie13xd@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefan Hansson <newbie13xd@gmail.com>
Subject: [PATCH] kbuild: use POSIX-compatible grep option
Date:   Mon, 17 Oct 2022 17:01:14 +0200
Message-Id: <20221017150113.334571-1-newbie13xd@gmail.com>
X-Mailer: git-send-email 2.37.3
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

--file is a GNU extension to grep which is not available in all
implementations (such as BusyBox). Use the -f option instead which is
eqvuialent according to the GNU grep manpage[1] and is present in
POSIX[2].

 [1] https://www.gnu.org/software/grep/manual/grep.html
 [2] https://pubs.opengroup.org/onlinepubs/9699919799/

Signed-off-by: Stefan Hansson <newbie13xd@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c690361b393f..3513a6db66a2 100644
--- a/Makefile
+++ b/Makefile
@@ -1218,7 +1218,7 @@ quiet_cmd_ar_vmlinux.a = AR      $@
       cmd_ar_vmlinux.a = \
 	rm -f $@; \
 	$(AR) cDPrST $@ $(KBUILD_VMLINUX_OBJS); \
-	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -F --file=$(srctree)/scripts/head-object-list.txt)
+	$(AR) mPiT $$($(AR) t $@ | head -n1) $@ $$($(AR) t $@ | grep -Ff $(srctree)/scripts/head-object-list.txt)
 
 targets += vmlinux.a
 vmlinux.a: $(KBUILD_VMLINUX_OBJS) scripts/head-object-list.txt autoksyms_recursive FORCE
-- 
2.37.3

