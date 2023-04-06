Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78EF6D9C35
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbjDFPZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbjDFPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:25:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D5B83D0;
        Thu,  6 Apr 2023 08:25:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso6263410pjc.1;
        Thu, 06 Apr 2023 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680794752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUQ8oESSljl7LcAtOU7U3oSuoUb+Qt3q7y1CKScYoAA=;
        b=WD88FKkRX4rFSwhZfEY4r6JbYSxxhFuJdgQYG8191taXjOuzdbaAv15TvgXFuWjLKo
         r2HJrjK8lk0yB5e+GqzbJR/Vp8nlVS9oy3kgZQJltn7ouOWl1tj8U/D5IzK9i1tmzaqj
         YaTCf01GrRyAP50iuGliPIRrAQPCS0003gQkegNSSAJClOTkDMFM8BuosEcrqwuVplCC
         7a25ZMRfcVaZDvzPeT/OesCkJQRJ5GbnP3fVwU1URUfh8UKg1nv5lmxYHFNwfbpC6z2l
         nNX+Bo9BaaLbpSUvEbgjLeSMI4QYmR95hLJQ5ptduaGhMUyNPdFFrDe3JWuihlP7pj1c
         FCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUQ8oESSljl7LcAtOU7U3oSuoUb+Qt3q7y1CKScYoAA=;
        b=HLhNdPoQNyqAXMjnUw8Km/sb+hE20HMiTYloN7vA2YXCYW39YaSs3GV8NegqaC4fCI
         iInyP4lpuyUgDjIVhGuX19Wx7c53buhID1e/lrIgur6T9NAPGLCoeqwJPp1BuEbs6jmH
         rUaFmp27gTvZOIlo1qfzqGKkbUc8DZc2PaJHOL+Nu1/PGymPMNOYxP4BwHCR8PDCPnwg
         6AKeDyQKiQdO5Zugy99YtPNCuESXMcJUfphva+EGjbHxC43jCZXQUTmj04fWnt4SxewL
         CspOaUW3nYhYavE91xfMg1bQcAPNA0zBg+JKagEFGRNiIDpSTII9JeHzz/UwsUGzdOSb
         jMiw==
X-Gm-Message-State: AAQBX9elWzPQRrPd3IRPWmHo/o6ds8fnM2VnQ4Oy7JMvFUQUGS1scwhf
        EGEXLUhRNdjtuOp28O6ICVI=
X-Google-Smtp-Source: AKy350ak7+EF/GjUCKlsSzzMi0I8JNUOHruZCNeonk/ecOux13eEh9AhsOKdO9UQd6pHMtJRFHlKYQ==
X-Received: by 2002:a17:90a:47:b0:23d:3931:7b49 with SMTP id 7-20020a17090a004700b0023d39317b49mr11258888pjb.35.1680794752358;
        Thu, 06 Apr 2023 08:25:52 -0700 (PDT)
Received: from localhost.localdomain ([4.193.120.76])
        by smtp.gmail.com with ESMTPSA id k60-20020a17090a4cc200b0023f5c867f82sm3227904pjh.41.2023.04.06.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:25:51 -0700 (PDT)
From:   youling257 <youling257@gmail.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        terrelln@fb.com, torvalds@linux-foundation.org
Subject: [PATCH 6/6] kbuild: use git-archive for source package creation
Date:   Thu,  6 Apr 2023 23:25:40 +0800
Message-Id: <20230406152540.8207-1-youling257@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312200731.599706-7-masahiroy@kernel.org>
References: <20230312200731.599706-7-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cause build time a bit longer.
I use "time make targz-pkg -i -j8" build kernel, this patch will first create *.tar file, then create *.tar.gz file, build time a bit longer.
'./System.map' -> 'tar-install/boot/System.map-6.3.0-rc5-android-x86_64+'
'.config' -> 'tar-install/boot/config-6.3.0-rc5-android-x86_64+'
'./vmlinux' -> 'tar-install/boot/vmlinux-6.3.0-rc5-android-x86_64+'
'./arch/x86/boot/bzImage' -> 'tar-install/boot/vmlinuz-6.3.0-rc5-android-x86_64+'
  TAR     linux-6.3.0-rc5-android-x86_64+-x86.tar
  GZIP    linux-6.3.0-rc5-android-x86_64+-x86.tar.gz

real    0m37.991s
user    0m47.529s
sys     0m8.235s

Revert "kbuild: use git-archive for source package creation"
'./System.map' -> 'tar-install/boot/System.map-6.3.0-rc5-android-x86_64+'
'.config' -> 'tar-install/boot/config-6.3.0-rc5-android-x86_64+'
'./vmlinux' -> 'tar-install/boot/vmlinux-6.3.0-rc5-android-x86_64+'
'./arch/x86/boot/bzImage' -> 'tar-install/boot/vmlinuz-6.3.0-rc5-android-x86_64+'
  TAR     linux-6.3.0-rc5-android-x86_64+-x86.tar.gz

real    0m11.006s
user    0m21.079s
sys     0m7.830s

I don't like *.tar file, i will delete *.tar file when every time build kernel, i need *.tar.gz file, if one file is i needn't, i will delete it.
linux-6.3.0-rc5-android-x86_64+-x86.tar.gz file is i need, linux-6.3.0-rc5-android-x86_64+-x86.tar is i needn't.
