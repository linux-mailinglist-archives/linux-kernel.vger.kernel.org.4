Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA506B34EC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCJDo6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Mar 2023 22:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCJDo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:44:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83DE7ED8;
        Thu,  9 Mar 2023 19:44:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6124C60C26;
        Fri, 10 Mar 2023 03:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FA6C433D2;
        Fri, 10 Mar 2023 03:44:53 +0000 (UTC)
Date:   Thu, 9 Mar 2023 22:44:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        platform-driver-x86@vger.kernel.org
Subject: [BUILD BUG v6.3-rc1] platform/x86/amd: error: implicit declaration
 of function =?UTF-8?B?4oCYYW1kX3BtY193cml0ZV9zdGLigJk=?=
Message-ID: <20230309224451.13b9648b@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Someone on the linux-rt IRC channel complained of a build failure for
6.3-rc1-rt1, but investigating it further, the build failure exists in
6.3-rc1 vanilla.

With CONFIG_SUSPEND not defined I get:

drivers/platform/x86/amd/pmc.c: In function ‘amd_pmc_stb_debugfs_open_v2’:
drivers/platform/x86/amd/pmc.c:256:15: error: implicit declaration of function ‘amd_pmc_write_stb’; did you mean ‘amd_pmc_read_stb’? [-Werror=implicit-function-declaration]
  256 |         ret = amd_pmc_write_stb(dev, AMD_PMC_STB_DUMMY_PC);
      |               ^~~~~~~~~~~~~~~~~
      |               amd_pmc_read_stb


I see in that file:

#ifdef CONFIG_SUSPEND
static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
{
[...]
}
#endif

And that commit b0d4bb973539 ("platform/x86/amd: pmc: Write dummy postcode
into the STB DRAM") adds a call to amd_pmc_write_stb() right were that
error is, without any protection against CONFIG_SUSPEND.

Try it! Build AMD/pmc.c without CONFIG_SUSPEND to enjoy the same build
message as I received.

-- Steve
