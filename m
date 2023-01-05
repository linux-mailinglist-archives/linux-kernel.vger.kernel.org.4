Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC665E21D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAEBAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 20:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjAEA7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:59:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA4947309;
        Wed,  4 Jan 2023 16:58:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29907B81716;
        Thu,  5 Jan 2023 00:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9903C433EF;
        Thu,  5 Jan 2023 00:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672880318;
        bh=G20leUtEUw9tobzMM7YamKZ/d8zVXVzh16H30wqZ98k=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ND3hK1V4ql4Hb6KaQuLMW94lOLEWEXsHlCZvgf4lIvnoSRlyKW6KVpv9Z7ZdDfpC/
         ocUiahp2qwV0v3C9vvlpc/ZMyeLrgl+SzWdiDU+4ejZxq63ycZPgUl8/HugV7xCEVX
         qdIZolBwiISP12lUQEvt69lChuUpGXG7h2bLOX+tBkEbjhbNWfLFUaSSRvVrJRLXbF
         DDQfN9HutqRFUBzdgDo0Ukl2p9xRbsJGHVLvhx1fQC/aRxhXrcBsUpYBtzKcwdgQOV
         HPT4NNTiVWbEIrBpVJBifazckfmXY5ETi4VVMPdandtdDOjINALhDz8a7Tarqwg6mz
         eV/smDZr+Akiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 75A7C5C05CA; Wed,  4 Jan 2023 16:58:38 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:58:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     mhiramat@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        ndesaulniers@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        joel@joelfernandes.org, quic_neeraju@quicinc.com, urezki@gmail.com
Subject: [PATCH RFC bootconfig] Allow forcing unconditional bootconfig
 processing
Message-ID: <20230105005838.GA1772817@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
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

The BOOT_CONFIG family of Kconfig options allows a bootconfig file
containing kernel boot parameters to be embedded into an initrd or into
the kernel itself.  This can be extremely useful when deploying kernels
in cases where some of the boot parameters depend on the kernel version
rather than on the server hardware, firmware, or workload.

Unfortunately, the "bootconfig" kernel parameter must be specified in
order to cause the kernel to look for the embedded bootconfig file,
and it clearly does not help to embed this "bootconfig" kernel parameter
into that file.

Therefore, provide a new BOOT_CONFIG_FORCE Kconfig option that causes the
kernel to act as if the "bootconfig" kernel parameter had been specified.
In other words, kernels built with CONFIG_BOOT_CONFIG_FORCE=y will look
for the embedded bootconfig file even when the "bootconfig" kernel
parameter is omitted.  This permits kernel-version-dependent kernel
boot parameters to be embedded into the kernel image without the need to
(for example) update large numbers of boot loaders.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <linux-doc@vger.kernel.org>

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 9355c525fbe0a..91339efdcb541 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -201,6 +201,8 @@ To remove the config from the image, you can use -d option as below::
 
 Then add "bootconfig" on the normal kernel command line to tell the
 kernel to look for the bootconfig at the end of the initrd file.
+Alternatively, build your kernel with the ``CONFIG_BOOT_CONFIG_FORCE``
+Kconfig option selected.
 
 Embedding a Boot Config into Kernel
 -----------------------------------
@@ -217,7 +219,9 @@ path to the bootconfig file from source tree or object tree.
 The kernel will embed it as the default bootconfig.
 
 Just as when attaching the bootconfig to the initrd, you need ``bootconfig``
-option on the kernel command line to enable the embedded bootconfig.
+option on the kernel command line to enable the embedded bootconfig, or,
+alternatively, build your kernel with the ``CONFIG_BOOT_CONFIG_FORCE``
+Kconfig option selected.
 
 Note that even if you set this option, you can override the embedded
 bootconfig by another bootconfig which attached to the initrd.
diff --git a/init/Kconfig b/init/Kconfig
index 7e5c3ddc341de..f894fb004bad4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1376,6 +1376,18 @@ config BOOT_CONFIG
 
 	  If unsure, say Y.
 
+config BOOT_CONFIG_FORCE
+	bool "Force unconditional bootconfig processing"
+	depends on BOOT_CONFIG
+	help
+	  With this Kconfig option set, BOOT_CONFIG processing is carried
+	  out even when the "bootconfig" kernel-boot parameter is omitted.
+	  In fact, with this Kconfig option set, there is no way to
+	  make the kernel ignore the BOOT_CONFIG-supplied kernel-boot
+	  parameters.
+
+	  If unsure, say N.
+
 config BOOT_CONFIG_EMBED
 	bool "Embed bootconfig file in the kernel"
 	depends on BOOT_CONFIG
diff --git a/init/main.c b/init/main.c
index e1c3911d7c707..669cb892e6c17 100644
--- a/init/main.c
+++ b/init/main.c
@@ -156,7 +156,7 @@ static char *extra_init_args;
 
 #ifdef CONFIG_BOOT_CONFIG
 /* Is bootconfig on command line? */
-static bool bootconfig_found;
+static bool bootconfig_found = IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE);
 static size_t initargs_offs;
 #else
 # define bootconfig_found false
