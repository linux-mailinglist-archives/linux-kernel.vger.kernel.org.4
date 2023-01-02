Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268165B348
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjABOWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjABOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:22:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06566430
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3058960FCC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 14:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61165C433D2;
        Mon,  2 Jan 2023 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672669331;
        bh=VfMD8RDW2VxniDqFWHUmTDlVNvUxpQS/SZfN7ZYTQ1g=;
        h=Date:From:To:Cc:Subject:From;
        b=Dz4fb4lSOFbAJZ3oPmkJqNmf73uHi+hYArktB9+dYcJS6cWvVaheI/3Md1CGmA/AY
         fa7QhxAQ6tRZ2JeWuop1BmRGS1WqQidq40QlBqYLdUD/eEEcMU7mZ1ufFQ1rCU0Fb1
         XHvty0uZfMmV5y4j5CCTLqWT4BtLbMKxXMX2tdH7jJKBsD31OO7Dfr8RV35jnWIw5T
         2ipg9bLl7Hr9mYwu0d5LlRjU6bPBH2E6buSw0/zBaVzOlszvtbl0+HZ0f8l+Py/SQq
         vVTGis5s1RLJidrFk3UrNyeY0ADw1j3ALyzNnW0njNnk2OXW5lbgswbK9XBsx6SY+h
         1V8O98JaAgCLw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B577640468; Mon,  2 Jan 2023 11:22:07 -0300 (-03)
Date:   Mon, 2 Jan 2023 11:22:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <Y7Loj5slB908QSXf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes in:

  b0305c1e0e27ad91 ("KVM: x86/xen: Add KVM_XEN_INVALID_GPA and KVM_XEN_INVALID_GFN to uapi")

That just rebuilds perf, as these patches don't add any new KVM ioctl to
be harvested for the the 'perf trace' ioctl syscall argument
beautifiers.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 20522d4ba1e0d8b0..55155e262646e5fc 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1767,6 +1767,7 @@ struct kvm_xen_hvm_attr {
 		__u8 runstate_update_flag;
 		struct {
 			__u64 gfn;
+#define KVM_XEN_INVALID_GFN ((__u64)-1)
 		} shared_info;
 		struct {
 			__u32 send_port;
@@ -1798,6 +1799,7 @@ struct kvm_xen_hvm_attr {
 	} u;
 };
 
+
 /* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_SHARED_INFO */
 #define KVM_XEN_ATTR_TYPE_LONG_MODE		0x0
 #define KVM_XEN_ATTR_TYPE_SHARED_INFO		0x1
@@ -1823,6 +1825,7 @@ struct kvm_xen_vcpu_attr {
 	__u16 pad[3];
 	union {
 		__u64 gpa;
+#define KVM_XEN_INVALID_GPA ((__u64)-1)
 		__u64 pad[8];
 		struct {
 			__u64 state;
-- 
2.39.0

