Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59AC6C91D8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 01:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCZAYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 20:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZAYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 20:24:49 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54340AF26;
        Sat, 25 Mar 2023 17:24:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h31so3193411pgl.6;
        Sat, 25 Mar 2023 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679790288;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4Q2NTyLoojITNxzc3JyEzySGYWN7cs2pVbyR9zoqIw=;
        b=qzyWdRSdhiQM/cam+FXnSoSF0DrRFqJjX9PthUX0ZBm2rGntAGgD+P6pOqSRrFp1Jl
         EgLokpTROoamXQVww48fghUUuL7SMZvVrVzwtejcJMftaSCqvu27g0MrBlUNYcRpabE4
         mW7nh8aqt2L1PxU2VcrCUuUfpz2XF8vLsT6DrV1abL72ECakbdzg3fJYakRGEt6fuAdl
         1jt/CjxanXFLh+ZufrZ6VMB2wYi4NOIEu8jnKHik2X/MSiky0WWqczTz+ChrP85Q802Q
         la5UzdeFLuFnRQo2byucmsLgOy0COK0n+uqsRX20DUGSjHhleB374JOmBADtC+jbGHVm
         Wlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679790288;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4Q2NTyLoojITNxzc3JyEzySGYWN7cs2pVbyR9zoqIw=;
        b=ImiJkBZ3Kpo1EUKi2gg6DAniQECAXHOhOlp5JGDRqTSOZHFCqfL973pCYMlSemh/AN
         EyQ0qTIGWZvldvi6SQIdjAgJrl/2eJjMq+qTzCgB2eKSQDUM24ikewH+qXzuiKFob2V5
         loM+tIRIDy8EQKWK2H1ipFl1cEr84wEC5HdZxebmr4rjGN3vp9TR4hdX+bDag3YHtaCV
         6lFNd2B4l3kaJxrsd+ryex4xa38r1RZ9V1Y4azBbrNq8eEhPQ9cwHEIF2I10gCt1aBtl
         olcCdPZBF3Iy6HBWyORM6A15rLPybKygBWuui2IHZhijM3RIjQL0nsLTsX/u8CV5bFB4
         9GFQ==
X-Gm-Message-State: AAQBX9f4zlULvvmyQcf3REgr4cOruhPLiu7+e8ImLUSVStBuzIgjRDci
        Rs9DmoLiRHwIKbOWwNs4Fl4=
X-Google-Smtp-Source: AKy350blDB7yT8bEf7Yw6Lf59U5uoiiHGxIsRG5zhG3POgNjQkWpfksTqVOV0fNKYwsagKz8I2bHlQ==
X-Received: by 2002:aa7:8bc2:0:b0:623:2bba:dd9 with SMTP id s2-20020aa78bc2000000b006232bba0dd9mr7090071pfd.14.1679790282959;
        Sat, 25 Mar 2023 17:24:42 -0700 (PDT)
Received: from localhost.localdomain ([154.220.3.115])
        by smtp.gmail.com with ESMTPSA id j13-20020aa78dcd000000b0062809b2cb05sm10673889pfr.155.2023.03.25.17.24.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2023 17:24:42 -0700 (PDT)
From:   zhouzhouyi@gmail.com
To:     paulmck@kernel.org, rcu@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lance@osuosl.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] rcu: torture: ppc: Remove duplicated argument --enable-kvm
Date:   Sun, 26 Mar 2023 08:24:34 +0800
Message-Id: <1679790274-1309-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

The argument --enable-kvm is duplicated because qemu_args
in kvm-test-1-run.sh has already give this.
          
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Dear RCU and PPC developers

I discover this possible minor flaw when I am performing RCU torture
test in PPC VM of of Open Source Lab of Oregon State University.

But I can't test my patch because I am in a VM.

Thanks for your time

Cheers ;-)
Zhouyi                                           
--    
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index b52d5069563c..48b9147e8c91 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -250,7 +250,7 @@ identify_qemu_args () {
 		echo -machine virt,gic-version=host -cpu host
 		;;
 	qemu-system-ppc64)
-		echo -enable-kvm -M pseries -nodefaults
+		echo -M pseries -nodefaults
 		echo -device spapr-vscsi
 		if test -n "$TORTURE_QEMU_INTERACTIVE" -a -n "$TORTURE_QEMU_MAC"
 		then
-- 
2.34.1

