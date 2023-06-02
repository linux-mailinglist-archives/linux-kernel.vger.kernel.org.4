Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6D7203EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjFBOBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjFBOBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:01:41 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E58518C;
        Fri,  2 Jun 2023 07:01:40 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-62614f2eee1so18142136d6.0;
        Fri, 02 Jun 2023 07:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685714499; x=1688306499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkyZNYaRvjb5OIxj50rRSjMVw65g+0jak5ymUtIvvTU=;
        b=hCHVodpdLg+1FlAM0XucKOoUbYSJ/O6Y0QWPnbCKlXAdIj1k9TcnwiRsLejXGLNKJm
         T8ivnvFga6Tx/ePxAAv09d6S4AqhZYkMIhF/4Knn4/JDMui9wIeAv/9fdTA0oKvy+M1O
         O0j12w5fWzNIyQpdwgQnTOqpQWnR2vCLcmH+3u+sXIoFkGPVDqk6Ijv43mx17xlq8axP
         jKQ60z3HFbDEnlLMSjruPuf+ADpV3cnRlm/4yhZp8LQpoEfjMkrFazHfJaT3aWFGomiK
         /UipjRsyS3jvDbupgZTJP109gmrnNWyl+OCLmolKbSCxrvJ6jCXZq6PWxTJq3k25idXY
         Uv+w==
X-Gm-Message-State: AC+VfDxduLz8/nDxidJ60GSLZgPdzlyTYSnI/liU/v/zysA+nz/aG6Co
        2pUGvPSdUZBzMHr3nJrMuJTU2kZ5s8KJvfoP
X-Google-Smtp-Source: ACHHUZ4APRqV07DOqsV0OXwtg8oqUsKPVJUXIw31CKeY7n/G6tXYGG/Xhd9O13qxjXBxA7dHbYxzFA==
X-Received: by 2002:ad4:5dee:0:b0:626:3bf8:aef0 with SMTP id jn14-20020ad45dee000000b006263bf8aef0mr15970160qvb.23.1685714498625;
        Fri, 02 Jun 2023 07:01:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:1317])
        by smtp.gmail.com with ESMTPSA id q6-20020a0ce9c6000000b005dd8b9345besm835218qvo.86.2023.06.02.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:01:25 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH] selftests/bpf: Add missing selftests kconfig options
Date:   Fri,  2 Jun 2023 09:01:08 -0500
Message-Id: <20230602140108.1177900-1-void@manifault.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our selftests of course rely on the kernel being built with
CONFIG_DEBUG_INFO_BTF=y, though this (nor its dependencies of
CONFIG_DEBUG_INFO=y and CONFIG_DEBUG_INFO_DWARF4=y) are not specified.
This causes the wrong kernel to be built, and selftests to similarly
fail to build.

Additionally, in the BPF selftests kconfig file,
CONFIG_NF_CONNTRACK_MARK=y is specified, so that the 'u_int32_t mark'
field will be present in the definition of struct nf_conn.  While a
dependency of CONFIG_NF_CONNTRACK_MARK=y, CONFIG_NETFILTER_ADVANCED=y,
should be enabled by default, I've run into instances of
CONFIG_NF_CONNTRACK_MARK not being set because CONFIG_NETFILTER_ADVANCED
isn't set, and have to manually enable them with make menuconfig.

Let's add these missing kconfig options to the file so that the
necessary dependencies are in place to build vmlinux. Otherwise, we'll
get errors like this when we try to compile selftests and generate
vmlinux.h:

$ cd /path/to/bpf-next
$ make mrproper; make defconfig
$ cat tools/testing/selftests/config >> .config
$ make -j
...
$ cd tools/testing/selftests/bpf
$ make clean
$ make -j
...
  LD [M]
  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.ko
  tools/testing/selftests/bpf/tools/build/bpftool/bootstrap/bpftool
  btf dump file vmlinux format c >
  tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h
  libbpf: failed to find '.BTF' ELF section in
  vmlinux
  Error: failed to load BTF from bpf-next/vmlinux:
  No data available
  make[1]: *** [Makefile:208:
  tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h]
  Error 195
  make[1]: *** Deleting file
  'tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h'
  make: *** [Makefile:261:
  tools/testing/selftests/bpf/tools/sbin/bpftool]
  Error 2

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 63cd4ab70171..3b350bc31343 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -13,6 +13,9 @@ CONFIG_CGROUP_BPF=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DYNAMIC_FTRACE=y
 CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
@@ -60,6 +63,7 @@ CONFIG_NET_SCH_INGRESS=y
 CONFIG_NET_SCHED=y
 CONFIG_NETDEVSIM=y
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_SYNPROXY=y
 CONFIG_NETFILTER_XT_CONNMARK=y
 CONFIG_NETFILTER_XT_MATCH_STATE=y
-- 
2.40.1

