Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6246F27E0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 08:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjD3Gt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 02:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3Gty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 02:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CE81B8;
        Sat, 29 Apr 2023 23:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D19860A2A;
        Sun, 30 Apr 2023 06:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876F4C433EF;
        Sun, 30 Apr 2023 06:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682837390;
        bh=pwOCPEg+HScTv6sM47dUx/NLcjpZWowJc8Ut3PoBeK0=;
        h=Date:From:To:Cc:Subject:From;
        b=qv4JkBypIq1wXeBJCNTi9S5nVmPEDKiuDWbe/E1PsKPqgCryK6vYYhzF4sd7pJsuL
         DpOMAP2cu5net9SpSRMnAxIjxXT3oW3sIq2MzI8sDpO+l/6HVC54ketKVex6S3VSrK
         D9lHbAz5h4Y3U7cumrtztGLCV5zKdEaKH3YgKPSsumYUdq946RCAocAfW7HbqDWQ+A
         fF2gvUS6c+CY8VltQJfoePZCrOigOBvidBfKsxvIUl53iNbBqWq09PQdJJ119YIDAz
         hyFzRx6GzpGLirxVntyEjiJAAyhoIs2QrwTkokxboGf4jJ3xefXmB7jNB+lGP6wvmw
         CVvp3FwkPGl1A==
Date:   Sat, 29 Apr 2023 23:49:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tools@linux.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>
Subject: [ANNOUNCE] New script that finds partially-backported patchsets
Message-ID: <20230430064948.GA36600@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As I promised on the "AUTOSEL process" centi-thread
(https://lore.kernel.org/stable/20230226034256.771769-12-sashal@kernel.org/T/#u),
I've developed some new scripts that can be found at
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/stable-tools.git :

- `find-orig-patch`: Finds the original patch email from a git commit.
   It first checks for a matching "Message-Id:" or "Link:" from the git commit.
   If that fails, it falls back to a search of https://lore.kernel.org by
   commit title and uses some heuristics to try to find the right patch email.

- `find-orig-series`: Like find-orig-patch but outputs the full series.

- `find-missing-prereqs`: Finds commits that were backported without previous
  patches in their original series also being backported.  It accepts a range of
  git commits.  I also added an option to filter the results by AUTOSEL only.

For more information, see the README at
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/stable-tools.git/tree/README.md

Note: since it wasn't clear where to put these or how to integrate them into
anything else, for now this is a completely standalone project.  Perhaps the
find-orig-patch functionality would be a nice feature for b4, but the more
stable-kernel-maintenance-specific logic should be in a separate project.  BTW,
I used the same language and license as b4: Python and GPLv2+.

I wrote some regression tests that show that find-missing-prereqs is able to
detect the missing patches for a couple examples of missed backports that broke
users, including the recent blk-cgroup one
(https://lore.kernel.org/linux-block/CAOCAAm4reGhz400DSVrh0BetYD3Ljr2CZen7_3D4gXYYdB4SKQ@mail.gmail.com/T/#u).

For another example, at the end of this email I've also pasted the output of
'find-missing-prereqs v6.1.24..v6.1.26', which covers the last couple weeks of
6.1.  I don't immediately see anything super interesting in there, and it picked
up a few very long patchsets which is a bit annoying (maybe very long patchsets
generally aren't interesting and should be skipped?).  But it's just an example.

Something that could be built on top of this is a script that applies the
patches from the stable-queue repository for each stable kernel version, and
generates a report about each one.  BTW, I can work on these scripts more, but
what I can't commit to doing is manually sending out reports every week...  I
hope that this can be automated and/or adopted by the stable maintainers.

Here's the output of 'find-missing-prereqs v6.1.24..v6.1.26':

The following commit(s):
  [PATCH 24/33] commit 779fd2a575cc ("drm/amd/display: Pass the right info to drm_dp_remove_payload")
... are backported without earlier commit(s) in series:
  [PATCH 1/33] commit de534c1cb031 ("drm/amd/display: Add height granularity limitation for dsc slice height calculation")
  [PATCH 2/33] commit aee0c07a74d3 ("drm/amd/display: Unify DC logging for BW Alloc")
  [PATCH 3/33] commit 67d198da2fd4 ("drm/amd/display: When blanking during init loop to find OPP index")
  [PATCH 4/33] commit c93aa7f33e94 ("drm/amd/display: 3.2.225")
  [PATCH 5/33] commit 0db13eae41fc ("drm/amd/display: Add minimum Z8 residency debug option")
  [PATCH 6/33] commit 0215ce9057ed ("drm/amd/display: Update minimum stutter residency for DCN314 Z8")
  [PATCH 7/33] commit c0a561d96a28 ("drm/amd/display: Drop CONFIG_DRM_AMD_DC_HDR")
  [PATCH 8/33] commit 11efe095dfe0 ("drm/amd/display: Fix no-DCN build")
  [PATCH 9/33] commit ab487ea8910d ("drm/amd/display: fix typo in dc_dsc_config_options structure")
  [PATCH 10/33] commit 1e88eb1b2c25 ("drm/amd/display: Drop CONFIG_DRM_AMD_DC_HDCP")
  [PATCH 11/33] commit efa4c4df864e ("drm/amd/display: call remove_stream_from_ctx from res_pool funcs")
  [PATCH 12/33] commit 84c03df58d8b ("drm/amd/display: Build DSC without DCN config")
  [PATCH 13/33] commit 36516001a7c9 ("drm/amd/display: move dc_link functions in accessories folder to dc_link_exports")
  [PATCH 14/33] commit 76f5dc40ebb1 ("drm/amd/display: move dc_link functions in link root folder to dc_link_exports")
  [PATCH 15/33] commit 6455cb522191 ("drm/amd/display: link link_dp_dpia_bw.o in makefile")
  [PATCH 16/33] commit 202a3816f37e ("drm/amd/display: move dc_link functions in protocols folder to dc_link_exports")
  [PATCH 17/33] commit 788c6e2ce5c7 ("drm/amd/display: replace all dc_link function call in link with link functions")
  [PATCH 18/33] commit 34fd6df78869 ("drm/amd/display: Simplify register offsets")
  [PATCH 19/33] commit 2b02d746c181 ("drm/amd/display: Keep PHY active for dp config")
  [PATCH 21/33] commit bf77fda02411 ("drm/amd/display: Drop unnecessary DCN guards")
  [PATCH 22/33] commit 4652ae7a51b7 ("drm/amd/display: Rename DCN config to FP")
  [PATCH 23/33] commit de930140bb57 ("drm/amd/display: Update to correct min FCLK when construction BB")
Original patch series is "[PATCH 00/33] DC Patches Mar 6th, 2023"
(https://lore.kernel.org/r/20230303154022.2667-1-qingqing.zhuo@amd.com)

The following commit(s):
  [PATCH 2/4] commit 3570f3cc4aab ("RDMA/erdma: Update default EQ depth to 4096 and max_send_wr to 8192")
  [PATCH 3/4] commit d682c9bc41fa ("RDMA/erdma: Inline mtt entries into WQE if supported")
  [PATCH 4/4] commit 132918e08e86 ("RDMA/erdma: Defer probing if netdevice can not be found")
... are backported without earlier commit(s) in series:
  [PATCH 1/4] commit 3fe26c0493e4 ("RDMA/erdma: Fix some typos")
Original patch series is "[PATCH for-rc 0/4] RDMA/erdma: erdma fixes 3-20-2023"
(https://lore.kernel.org/r/20230320084652.16807-1-chengyou@linux.alibaba.com)

The following commit(s):
  [PATCH 15/26] commit 361b02e68181 ("KVM: arm64: Initialise hypervisor copies of host symbols unconditionally")
... are backported without earlier commit(s) in series:
  [PATCH 1/26] commit 0f4f7ae10ee4 ("KVM: arm64: Move hyp refcount manipulation helpers to common header file")
  [PATCH 2/26] commit 72a5bc0f153c ("KVM: arm64: Allow attaching of non-coalescable pages to a hyp pool")
  [PATCH 3/26] commit 8e6bcc3a4502 ("KVM: arm64: Back the hypervisor 'struct hyp_page' array for all memory")
  [PATCH 4/26] commit 0d16d12eb26e ("KVM: arm64: Fix-up hyp stage-1 refcounts for all pages mapped at EL2")
  [PATCH 5/26] commit 33bc332d4061 ("KVM: arm64: Unify identifiers used to distinguish host and hypervisor")
  [PATCH 6/26] commit 1ed5c24c26f4 ("KVM: arm64: Implement do_donate() helper for donating memory")
  [PATCH 7/26] commit 43c1ff8b7501 ("KVM: arm64: Prevent the donation of no-map pages")
  [PATCH 8/26] commit 9926cfce8dcb ("KVM: arm64: Add helpers to pin memory shared with the hypervisor at EL2")
  [PATCH 9/26] commit 4d968b12e6bb ("KVM: arm64: Include asm/kvm_mmu.h in nvhe/mem_protect.h")
  [PATCH 10/26] commit 1c80002e3264 ("KVM: arm64: Add hyp_spinlock_t static initializer")
  [PATCH 11/26] commit 5304002dc375 ("KVM: arm64: Rename 'host_kvm' to 'host_mmu'")
  [PATCH 12/26] commit a1ec5c70d3f6 ("KVM: arm64: Add infrastructure to create and track pKVM instances at EL2")
  [PATCH 13/26] commit 9d0c063a4d1d ("KVM: arm64: Instantiate pKVM hypervisor VM and vCPU structures from EL1")
  [PATCH 14/26] commit aa6948f82f0b ("KVM: arm64: Add per-cpu fixmap infrastructure at EL2")
Original patch series is "[PATCH v6 00/26] KVM: arm64: Introduce pKVM hyp VM and vCPU state at EL2"
(https://lore.kernel.org/r/20221110190259.26861-1-will@kernel.org)

The following commit(s):
  [PATCH 2/2] commit 2fcfd51add22 ("Bluetooth: SCO: Fix possible circular locking dependency sco_sock_getsockopt")
... are backported without earlier commit(s) in series:
  [PATCH 1/2] commit 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")

The following commit(s):
  [PATCH 3/4] commit 5620eeb379d1 ("tracing: Add trace_array_puts() to write into instance")
... are backported without earlier commit(s) in series:
  [PATCH 1/4] commit cb1f98c5e574 ("tracing: Add creation of instances at boot command line")
  [PATCH 2/4] commit c4846480831e ("tracing: Add enabling of events to boot instances")
Original patch series is "[PATCH v2 0/4] tracing: Addition of tracing instances via kernel command line"
(https://lore.kernel.org/r/20230207172849.461894073@goodmis.org)

The following commit(s):
  [PATCH 36/66] commit 4ac57c3fe2c0 ("drm/amd/display: set dcn315 lb bpp to 48")
... are backported without earlier commit(s) in series:
  [PATCH 31/66] commit 0b5dfe12755f ("drm/amd/display: fix a divided-by-zero error")
  [PATCH 35/66] commit 1e994cc0956b ("drm/amd/display: limit timing for single dimm memory")
Original patch series is "[PATCH 00/66] DC Patches Apr 17th, 2023"
(https://lore.kernel.org/r/20230414155330.5215-1-Qingqing.Zhuo@amd.com)

