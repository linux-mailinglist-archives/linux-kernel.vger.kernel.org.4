Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5696E1B37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 06:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDNEwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 00:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNEwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:52:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045394683
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 21:52:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v9so22686017pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 21:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681447933; x=1684039933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XsU9lZArJwu37m7sQ+4Jia5PhjsvR2rXS9gSLThM1pY=;
        b=IYHSNxOqba5lKkbyyviQCR4CIisPIGAZ4jOToUEiA+HafejrCfxcNcOgcXMpR0Zrks
         obW605P+0oed56AOWmWMLYNeAZJXONEPnv8lx/y9f8KgjoYjqLEdjgETQ9tplQRAR9+8
         JY6beEmVzKTVG8S6SCkmtRsND/XHZ+vSmbx/9Z3uXOb93I3wPCOEwThiPti4AW6It7C1
         RlQNyYAayg8X30uwFhX7zhf0weP7kJ4TuJnmnw+cBC5w/S2EmPjDUqayMccu1RS+Nd9K
         5wbDz+3YEKWz6qzbQSJ40E4T+g1pyrOMGO/N/rTqesaWKVRTfSzeF6/ZVtZeaItcYM+w
         59dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681447933; x=1684039933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsU9lZArJwu37m7sQ+4Jia5PhjsvR2rXS9gSLThM1pY=;
        b=Zg1MPH0EIi35NAL06Yv08npuNd8Ay2jlI0E/x1/dE73cTJ7Tfs4BXhfAgVfAkis+Hc
         a4sjHVcFtmwNsuCj/ylHs/j/g/gjRWmW22cp0WfGKNGTMr6luZjMV65EqnK3QvFZ9lvO
         cGdgvJOgph0J5iK/roCMDF2Qkr3aHZWGr0jEtmBtD1O8VkLRm4iSFGeVpI5gyVK3VxCK
         /qNiS6RgHkVWMnj+trzYK9+0yuOtLeFPP6SkCS4Upv+/UrwFAHu1ltFsYCFqSLV8UB8E
         vzaK4+Ty8VMQuuUK+GeZeDjUV5IZ1/8ykHX9QtX+k4U2Lmr5RsEu5cK/o7kKrDDsyjwv
         6bZg==
X-Gm-Message-State: AAQBX9eA5qjiT65fmS+5qvK9QnOFBbQD8m+Rfy7++7XkLJf9UbXfyygZ
        V/0mRkkmDz8JTTQxAdPg5AYoPE6YGneFqp2C3A==
X-Google-Smtp-Source: AKy350aLdPSbjLVkBEiTR+Y5yvKEpD8nC1GJ6dUg4Riz6nNWOf9Uym6CVj64bAwFTr3LNLIepq0t5g==
X-Received: by 2002:a05:6a20:b22:b0:ec:74b:d247 with SMTP id x34-20020a056a200b2200b000ec074bd247mr3918966pzf.44.1681447933148;
        Thu, 13 Apr 2023 21:52:13 -0700 (PDT)
Received: from HX3YDL60GM.bytedance.net ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id p13-20020a63e64d000000b0051b51b83c4fsm1817009pgj.66.2023.04.13.21.52.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Apr 2023 21:52:12 -0700 (PDT)
From:   "songrui.771" <songrui.771@bytedance.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        "songrui.771" <songrui.771@bytedance.com>
Subject: [PATCH] libbpf: correct the macro KERNEL_VERSION for old kernel
Date:   Fri, 14 Apr 2023 12:52:04 +0800
Message-Id: <20230414045204.9748-1-songrui.771@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 tools/lib/bpf/libbpf_probes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 4f3bc968ff8e..a1486dd3bea2 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -12,12 +12,15 @@
 #include <linux/btf.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 
 #include "bpf.h"
 #include "libbpf.h"
 #include "libbpf_internal.h"
 
+#ifndef KERNEL_VERSION
+#define KERNEL_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c)))
+#endif
+
 /* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
  * but Ubuntu provides /proc/version_signature file, as described at
  * https://ubuntu.com/kernel, with an example contents below, which we
-- 
2.39.2 (Apple Git-143)

