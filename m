Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EFA6E1E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjDNIoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDNIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:44:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF67ED2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:44:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id my14-20020a17090b4c8e00b0024708e8e2ddso7080730pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681461841; x=1684053841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qT9vFhlt3TMl+TX1oNW68//w+Ro4Y14kvCsjAYOLicY=;
        b=B+7R6eL8tEV45YJ8qURuZTcAFO6pap6SIvfvp/eq19D2BSSl4UWWRWAGMzKreTMOKL
         C5MAKEjqrJsDDYYXBrG/AslOPZxoYfdi+3Ke59+g1cG9clX0NBtPMl6IOndYjFnOauBm
         wJ6gF88Izt/SehBLL6GSh16ToC5PSfM57jRMh5QDGbBj7EKH6AGdOtPLxNpIReyhDGza
         tHAyQOjDmWRsKsttD2F91A9WYE5B1cupkZ78fQZSZZcI2kCV8pDAePEuEvuwQGZzfi2w
         p4qR7lRS1cBcGcNHoQU7QSXW0Wn89ji6usyLXPF5+aQWQnqa4tpIh4qsipeph9mu8LRb
         YJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681461841; x=1684053841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qT9vFhlt3TMl+TX1oNW68//w+Ro4Y14kvCsjAYOLicY=;
        b=ZCu2wSRxluv7wnZ12OR7YwOB5L0e8e/yli/izF8hf6B/SpFh4vS+6fR4iVlxpf8+bM
         hSoI4a5lJ1jkLQ4pt7RbX+9NdrkEK2sABzhVVzxcPwKs3QzRlcVqqrhgkQPm61pnV4fB
         hP3s0EpHoowiF9BWDliU9clvd6HHtzodADA7QwNiOJ0LUwVv0rC7RBQDLBu45QflCdEd
         B/7ZDzrKHqygK/+z5l3eUUWdA0ITR1lfm1x61aTLYrkLz56HRUUDCzTGLQ8q6lZw5/kG
         fE8F3QvaVYDJd4LUmuCqU1x+Wy49n/VipX+NNANm7G71QMfTXBHJ3S3cxTzrl0ORx2nb
         QV6A==
X-Gm-Message-State: AAQBX9cLTAqlqOVeAMMB0NsVFbBtLwEmuhWIlk8yZ7AfpauZv7yrfFjO
        WtdS0cldZHeOC+0L/oUCV2OU
X-Google-Smtp-Source: AKy350bNAERFGkwBQHVVfdBaSsU9015qtbuqO1lXiDwoaRbQgHDumFlCZ+QTDrguD/Bxj4bhO23dGw==
X-Received: by 2002:a17:90a:cb98:b0:247:20e2:2060 with SMTP id a24-20020a17090acb9800b0024720e22060mr4843673pju.15.1681461840821;
        Fri, 14 Apr 2023 01:44:00 -0700 (PDT)
Received: from HX3YDL60GM.bytedance.net ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a530600b0024749e7321bsm120722pjh.6.2023.04.14.01.43.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Apr 2023 01:44:00 -0700 (PDT)
From:   "songrui.771" <songrui.771@bytedance.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        "songrui.771" <songrui.771@bytedance.com>
Subject: [PATCH v2] libbpf: correct the macro KERNEL_VERSION for old kernel
Date:   Fri, 14 Apr 2023 16:43:53 +0800
Message-Id: <20230414084353.36545-1-songrui.771@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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

The introduced header file linux/version.h in libbpf_probes.c may have a wrong macro KERNEL_VERSION for calculating LINUX_VERSION_CODE in some old kernel (Debian9,10). Below is a version info example from Debian 10.

release: 4.19.0-22-amd64
version: #1 SMP Debian 4.19.260-1 (2022-09-29)

The macro KERNEL_VERSION is defined to (((a) << 16) + ((b) << 8)) + (c)), which a, b, and c stand for major, minor and patch version. So in example here, the major is 4, minor is 19, patch is 260, the LINUX_VERSION(4, 19, 260) which is 267268 should be matched to LINUX_VERSION_CODE. However, the KERNEL_VERSION_CODE in linux/version.h is defined to 267263.

I noticed that the macro KERNEL_VERSION in linux/version.h of some new kernel is defined to (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c))). And KERNEL_VERSION(4, 19, 260) is equal to 267263 which is the right LINUX_VERSION_CODE.

The mismatched LINUX_VERSION_CODE which will cause failing to load kprobe BPF programs in the version check of BPF syscall.

The return value of get_kernel_version in libbpf_probes.c should be matched to LINUX_VERSION_CODE by correcting the macro KERNEL_VERSION.

Signed-off-by: songrui.771 <songrui.771@bytedance.com>
---
Changes since v1:
- reintroduce header file linux/version.h
- define a new macro LIBBPF_KERNEL_VERSION to get kernel version rather than KERNEL_VERSION
---
 tools/lib/bpf/libbpf_probes.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 4f3bc968ff8e..5b22a880c7e7 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -18,6 +18,10 @@
 #include "libbpf.h"
 #include "libbpf_internal.h"
 
+#ifndef LIBBPF_KERNEL_VERSION
+#define LIBBPF_KERNEL_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c)))
+#endif
+
 /* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
  * but Ubuntu provides /proc/version_signature file, as described at
  * https://ubuntu.com/kernel, with an example contents below, which we
@@ -47,7 +51,7 @@ static __u32 get_ubuntu_kernel_version(void)
 	if (ret != 3)
 		return 0;
 
-	return KERNEL_VERSION(major, minor, patch);
+	return LIBBPF_KERNEL_VERSION(major, minor, patch);
 }
 
 /* On Debian LINUX_VERSION_CODE doesn't correspond to info.release.
@@ -74,7 +78,7 @@ static __u32 get_debian_kernel_version(struct utsname *info)
 	if (sscanf(p, "Debian %u.%u.%u", &major, &minor, &patch) != 3)
 		return 0;
 
-	return KERNEL_VERSION(major, minor, patch);
+	return LIBBPF_KERNEL_VERSION(major, minor, patch);
 }
 
 __u32 get_kernel_version(void)
@@ -97,7 +101,7 @@ __u32 get_kernel_version(void)
 	if (sscanf(info.release, "%u.%u.%u", &major, &minor, &patch) != 3)
 		return 0;
 
-	return KERNEL_VERSION(major, minor, patch);
+	return LIBBPF_KERNEL_VERSION(major, minor, patch);
 }
 
 static int probe_prog_load(enum bpf_prog_type prog_type,
-- 
2.39.2 (Apple Git-143)

