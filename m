Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C426ABF84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCFMbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCFMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:31:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238872B2B7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDF5AB80DA9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D007C433D2;
        Mon,  6 Mar 2023 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678105868;
        bh=aE58fh/+iOEA599RJk5aJ/orVwg0N7DES+uvqiSXMZk=;
        h=Date:From:To:Cc:Subject:From;
        b=G2ckKXr7RzGF48sibYcWOLJa3GhARAltsKpqJOKNeukNWUmBIzFtlc50gsbj4h+Tx
         s0YY0gGOnVHL6ZMAv86A1arU8Tjcf0YMHi0pdq/kP2j7FHeWZhA86DCcMaHamS6otQ
         wfvSgP+BjZeOVonVDbzTZf618gP56ywgicqNkp6dcKH9NuY0vRCxzDTNRKDuuP/OfL
         RcblYbWVvlPNfNCBK+uOVq06tpnQ05FWzhapauKDPTg8r7zkUTkw8bSwBuFhSRehKT
         Z0PwKC1gYwXDZEDvzqUuqc0Z4JBbZEn0zzz048NiJz76cGj6rcb/ARbzYabuZhmk71
         ybjtxfBlArhUA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D52FE4049F; Mon,  6 Mar 2023 09:31:05 -0300 (-03)
Date:   Mon, 6 Mar 2023 09:31:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync linux/vhost.h with the
 kernel sources
Message-ID: <ZAXdCTecxSNwAoeK@kernel.org>
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

To get the changes in:

  3b688d7a086d0438 ("vhost-vdpa: uAPI to resume the device")

To pick up these changes and support them:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > before
  $ cp ../linux/include/uapi/linux/vhost.h tools/include/uapi/linux/vhost.h
  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
  $ diff -u before after
  --- before	2023-03-06 09:26:14.889251817 -0300
  +++ after	2023-03-06 09:26:20.594406270 -0300
  @@ -30,6 +30,7 @@
   	[0x77] = "VDPA_SET_CONFIG_CALL",
   	[0x7C] = "VDPA_SET_GROUP_ASID",
   	[0x7D] = "VDPA_SUSPEND",
  +	[0x7E] = "VDPA_RESUME",
   };
   static const char *vhost_virtio_ioctl_read_cmds[] = {
   	[0x00] = "GET_FEATURES",
  $

For instance, see how those 'cmd' ioctl arguments get translated, now
VDPA_RESUME will be as well:

  # perf trace -a -e ioctl --max-events=10
       0.000 ( 0.011 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSYNC, arg: 0x1)                        = 0
      21.353 ( 0.014 ms): pipewire/2261 ioctl(fd: 60, cmd: SNDRV_PCM_HWSYNC, arg: 0x1)                        = 0
      25.766 ( 0.014 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffe4a22c740)            = 0
      25.845 ( 0.034 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7fd43915dc70)            = 0
      25.916 ( 0.011 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffe4a22c8a0)               = 0
      25.941 ( 0.025 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ATOMIC, arg: 0x7ffe4a22c840)               = 0
      32.915 ( 0.009 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_RMFB, arg: 0x7ffe4a22cf9c)                 = 0
      42.522 ( 0.013 ms): gnome-shell/2196 ioctl(fd: 14, cmd: DRM_I915_IRQ_WAIT, arg: 0x7ffe4a22c740)            = 0
      42.579 ( 0.031 ms): gnome-shel:cs0/2212 ioctl(fd: 14, cmd: DRM_I915_IRQ_EMIT, arg: 0x7fd43915dc70)            = 0
      42.644 ( 0.010 ms): gnome-shell/2196 ioctl(fd: 9, cmd: DRM_MODE_ADDFB2, arg: 0x7ffe4a22c8a0)               = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/vhost.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index f9f115a7c75b8a30..92e1b700b51cbdf6 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -180,4 +180,12 @@
  */
 #define VHOST_VDPA_SUSPEND		_IO(VHOST_VIRTIO, 0x7D)
 
+/* Resume a device so it can resume processing virtqueue requests
+ *
+ * After the return of this ioctl the device will have restored all the
+ * necessary states and it is fully operational to continue processing the
+ * virtqueue descriptors.
+ */
+#define VHOST_VDPA_RESUME		_IO(VHOST_VIRTIO, 0x7E)
+
 #endif
-- 
2.39.2

