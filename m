Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0458A5EB602
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiIZXzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIZXz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:55:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29B563F08;
        Mon, 26 Sep 2022 16:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34F7AB8076B;
        Mon, 26 Sep 2022 23:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9E0C433C1;
        Mon, 26 Sep 2022 23:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664236524;
        bh=M5vKo2AC5OEfW8y5bXyxUWVSJ8AMqKMYxEBQGX7Ly64=;
        h=From:To:Cc:Subject:Date:From;
        b=D4OQzVjhB74gEU/NdxBLaW8mY1XXDXeu6Gr9LJaVPy63RPWq+qeZV8r1sJdTVoZ2d
         JLGnkn9njHg3Tp9KmlTlVnUr+O00TMj34Id1LZN4WBRTaJ8p4mj/nnfJsVkTxrnBJf
         tYmAGSQTTYVNFOFIH4HwK8bUi6tDoZ4xPa1o6kEsMjz9kRYYRPZkFFo+U/cMOdppYW
         ZO4q24D3/QgmR/m/8xfg/UaAHj9NZU3UxVcXHaAw9D4o16aFe1rk4hgoO20qsi/HS6
         +r42wT5JCHKlSIO+6lHUsWNfNJuDkXNuN8kh8aMkAmL2twHrAQsqIdgpkJXgiFQXlG
         NheNiw/iLt4sg==
From:   broonie@kernel.org
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bitmap tree
Date:   Tue, 27 Sep 2022 00:53:48 +0100
Message-Id: <20220926235348.1269963-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the bitmap tree, today's linux-next build (x86
allmodconfig) failed like this:

In file included from /tmp/next/build/include/linux/printk.h:573,
                 from /tmp/next/build/include/linux/kernel.h:29,
                 from /tmp/next/build/arch/x86/include/asm/percpu.h:27,
                 from /tmp/next/build/arch/x86/include/asm/nospec-branch.h:14,
                 from /tmp/next/build/arch/x86/include/asm/paravirt_types.h:40,
                 from /tmp/next/build/arch/x86/include/asm/ptrace.h:97,
                 from /tmp/next/build/arch/x86/include/asm/math_emu.h:5,
                 from /tmp/next/build/arch/x86/include/asm/processor.h:13,
                 from /tmp/next/build/arch/x86/include/asm/timex.h:5,
                 from /tmp/next/build/include/linux/timex.h:67,
                 from /tmp/next/build/include/linux/time32.h:13,
                 from /tmp/next/build/include/linux/time.h:60,
                 from /tmp/next/build/include/linux/stat.h:19,
                 from /tmp/next/build/include/linux/module.h:13,
                 from /tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:9:
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c: In function 'rvu_npc_exact_alloc_mem_table_entry':
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:454:20: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Werror=format=]
  454 |  dev_dbg(rvu->dev, "%s: No space in 4 way exact way, weight=%lu\n", __func__,
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/dynamic_debug.h:223:15: note: in definition of macro '__dynamic_func_call_cls'
  223 |   func(&id, ##__VA_ARGS__);   \
      |               ^~~~~~~~~~~
/tmp/next/build/include/linux/dynamic_debug.h:249:2: note: in expansion of macro '_dynamic_func_call_cls'
  249 |  _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/dynamic_debug.h:272:2: note: in expansion of macro '_dynamic_func_call'
  272 |  _dynamic_func_call(fmt, __dynamic_dev_dbg,   \
      |  ^~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/dev_printk.h:155:2: note: in expansion of macro 'dynamic_dev_dbg'
  155 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~
/tmp/next/build/include/linux/dev_printk.h:155:23: note: in expansion of macro 'dev_fmt'
  155 |  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                       ^~~~~~~
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:454:2: note: in expansion of macro 'dev_dbg'
  454 |  dev_dbg(rvu->dev, "%s: No space in 4 way exact way, weight=%lu\n", __func__,
      |  ^~~~~~~
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:454:63: note: format string is defined here
  454 |  dev_dbg(rvu->dev, "%s: No space in 4 way exact way, weight=%lu\n", __func__,
      |                                                             ~~^
      |                                                               |
      |                                                               long unsigned int
      |                                                             %u
In file included from /tmp/next/build/include/linux/device.h:15,
                 from /tmp/next/build/include/linux/pci.h:37,
                 from /tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:10:
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c: In function 'rvu_npc_exact_alloc_id':
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:492:21: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Werror=format=]
  492 |   dev_err(rvu->dev, "%s: No space in id bitmap (%lu)\n",
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
  110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
      |                ^~~
/tmp/next/build/include/linux/dev_printk.h:144:49: note: in expansion of macro 'dev_fmt'
  144 |  dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                                                 ^~~~~~~
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:492:3: note: in expansion of macro 'dev_err'
  492 |   dev_err(rvu->dev, "%s: No space in id bitmap (%lu)\n",
      |   ^~~~~~~
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:492:51: note: format string is defined here
  492 |   dev_err(rvu->dev, "%s: No space in id bitmap (%lu)\n",
      |                                                 ~~^
      |                                                   |
      |                                                   long unsigned int
      |                                                 %u
In file included from /tmp/next/build/include/linux/device.h:15,
                 from /tmp/next/build/include/linux/pci.h:37,
                 from /tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:10:
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c: In function 'rvu_npc_exact_alloc_cam_table_entry':
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:525:22: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Werror=format=]
  525 |   dev_info(rvu->dev, "%s: No space in exact cam table, weight=%lu\n", __func__,
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/dev_printk.h:110:16: note: in definition of macro 'dev_printk_index_wrap'
  110 |   _p_func(dev, fmt, ##__VA_ARGS__);   \
      |                ^~~
/tmp/next/build/include/linux/dev_printk.h:150:51: note: in expansion of macro 'dev_fmt'
  150 |  dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                                                   ^~~~~~~
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:525:3: note: in expansion of macro 'dev_info'
  525 |   dev_info(rvu->dev, "%s: No space in exact cam table, weight=%lu\n", __func__,
      |   ^~~~~~~~
/tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:525:65: note: format string is defined here
  525 |   dev_info(rvu->dev, "%s: No space in exact cam table, weight=%lu\n", __func__,
      |                                                               ~~^
      |                                                                 |
      |                                                                 long unsigned int
      |                                                               %u
cc1: all warnings being treated as errors
make[8]: *** [/tmp/next/build/scripts/Makefile.build:249: drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.o] Error 1
make[7]: *** [/tmp/next/build/scripts/Makefile.build:440: drivers/net/ethernet/marvell/octeontx2/af] Error 2
make[6]: *** [/tmp/next/build/scripts/Makefile.build:440: drivers/net/ethernet/marvell/octeontx2] Error 2
make[5]: *** [/tmp/next/build/scripts/Makefile.build:440: drivers/net/ethernet/marvell] Error 2
make[5]: *** Waiting for unfinished jobs....
/tmp/next/build/drivers/gpu/drm/i915/gt/intel_sseu.c: In function 'intel_sseu_print_ss_info':
/tmp/next/build/drivers/gpu/drm/i915/gt/intel_sseu.c:867:39: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Werror=format=]
  867 |   seq_printf(m, "  %s Geometry DSS: %lu\n", type,
      |                                     ~~^
      |                                       |
      |                                       long unsigned int
      |                                     %u
  868 |       bitmap_weight(sseu->geometry_subslice_mask.xehp,
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |       |
      |       unsigned int
  869 |       XEHP_BITMAP_BITS(sseu->geometry_subslice_mask)));
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/drivers/gpu/drm/i915/gt/intel_sseu.c:870:38: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Werror=format=]
  870 |   seq_printf(m, "  %s Compute DSS: %lu\n", type,
      |                                    ~~^
      |                                      |
      |                                      long unsigned int
      |                                    %u
  871 |       bitmap_weight(sseu->compute_subslice_mask.xehp,
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |       |
      |       unsigned int
  872 |       XEHP_BITMAP_BITS(sseu->compute_subslice_mask)));
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

These look like they have probably been there for a while but I've used
a slightly different compiler version to Stephen so they're showing up
now once the bitmap tree is merged.  I will have a proper look tomorrow
hopefully but for now I've dropped the bitmap tree as it's getting very
late and it is likely I'll not finish the -next run today at all.
