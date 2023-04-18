Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E0C6E6A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjDRRAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjDRRAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E981FC6;
        Tue, 18 Apr 2023 10:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 640FE636FE;
        Tue, 18 Apr 2023 17:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672CEC433EF;
        Tue, 18 Apr 2023 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681837227;
        bh=OFHXRE5qXP1a+sm2H9OUlYGDoa6H2rSEbiVxtGES2uo=;
        h=From:To:Cc:Subject:Date:From;
        b=YC07IhdC1GCouwXzwOav29Nj1u0XA/2IDev/fmRCVQJlVIuJ9EgibnLxWV9NC4Ovd
         063sFe7YQk0xQ/Wi41+ZxZz6oyzkAl0IeAEodxj1d/ydijSc9/ACePOV1FHAQu6UxN
         6f7tC689fI5lmXYOvDzG6E1dN4HVi1pBpv4FIaQ8qvFnp/3fvYQE2m4sTT2GmzI2r2
         aP5qk6FYEXIPKpdUhsIWSZI0yRFUrJUrR3PWLNWaIQjNTCr/ofMr1ibp5MhRuQxpCh
         OaK3c0c9+XTwgMj4CwsCOHgx/gKfwbB9is4IU0Jd2PFh6Ib/s6srfDCY99xGlAoYG7
         +np4pCIPNVBIQ==
From:   broonie@kernel.org
To:     Tianyu Lan <tiala@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hyperv tree
Date:   Tue, 18 Apr 2023 18:00:21 +0100
Message-Id: <20230418170021.90280-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the hyperv tree, today's linux-next build (x86 allmodconfig)
failed like this:

/tmp/next/build/arch/x86/kernel/x86_init.c:36:12: error: static declaration of 'set_rtc_noop' follows non-static declaration
   36 | static int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
      |            ^~~~~~~~~~~~
In file included from /tmp/next/build/arch/x86/include/asm/mpspec.h:7,
                 from /tmp/next/build/arch/x86/include/asm/topology.h:38,
                 from /tmp/next/build/include/linux/topology.h:36,
                 from /tmp/next/build/include/linux/gfp.h:8,
                 from /tmp/next/build/include/linux/xarray.h:15,
                 from /tmp/next/build/include/linux/radix-tree.h:21,
                 from /tmp/next/build/include/linux/idr.h:15,
                 from /tmp/next/build/include/linux/kernfs.h:12,
                 from /tmp/next/build/include/linux/sysfs.h:16,
                 from /tmp/next/build/include/linux/kobject.h:20,
                 from /tmp/next/build/include/linux/pci.h:35,
                 from /tmp/next/build/arch/x86/kernel/x86_init.c:9:
/tmp/next/build/arch/x86/include/asm/x86_init.h:333:12: note: previous declaration of 'set_rtc_noop' with type 'int(const struct timespec64 *)'
  333 | extern int set_rtc_noop(const struct timespec64 *now);
      |            ^~~~~~~~~~~~
/tmp/next/build/arch/x86/kernel/x86_init.c:37:13: error: static declaration of 'get_rtc_noop' follows non-static declaration
   37 | static void get_rtc_noop(struct timespec64 *now) { }
      |             ^~~~~~~~~~~~
In file included from /tmp/next/build/arch/x86/include/asm/mpspec.h:7,
                 from /tmp/next/build/arch/x86/include/asm/topology.h:38,
                 from /tmp/next/build/include/linux/topology.h:36,
                 from /tmp/next/build/include/linux/gfp.h:8,
                 from /tmp/next/build/include/linux/xarray.h:15,
                 from /tmp/next/build/include/linux/radix-tree.h:21,
                 from /tmp/next/build/include/linux/idr.h:15,
                 from /tmp/next/build/include/linux/kernfs.h:12,
                 from /tmp/next/build/include/linux/sysfs.h:16,
                 from /tmp/next/build/include/linux/kobject.h:20,
                 from /tmp/next/build/include/linux/pci.h:35,
                 from /tmp/next/build/arch/x86/kernel/x86_init.c:9:
/tmp/next/build/arch/x86/include/asm/x86_init.h:334:13: note: previous declaration of 'get_rtc_noop' with type 'void(struct timespec64 *)'
  334 | extern void get_rtc_noop(struct timespec64 *now);
      |             ^~~~~~~~~~~~

Caused by commit

  25dcc7316ef7def25c ("x86/init: Make get/set_rtc_noop() public")

I will use the hyperv tree from yesterday instead.
