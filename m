Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFE86F83F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjEEN0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEEN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC6C2075E;
        Fri,  5 May 2023 06:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF1E063E2B;
        Fri,  5 May 2023 13:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD2FC433EF;
        Fri,  5 May 2023 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683293177;
        bh=ID6tW6Ir95UnY+CJe/xBNPDkriFuLBjLVGBTGdMHAHA=;
        h=From:To:Cc:Subject:Date:From;
        b=KtfAnawU1C9rk+poKY/7dK9D4kU21XPGcTzi2oI6K8aZvUvXDBcocyY5/uTR4s0NP
         DNvceo27gyliZM6a2DYfRmCFwvGYUrJ1dW0tySXjQOG+nt6dMtaz4afVnNZgypVkSU
         enh7LCCunBHhJ496LMVtB+J62qcyUMOSSqrszUuuyFu8/kEI+jROyu2NqhXnFvAbyZ
         9urnbKfQ0UpyPLgHAEu88j3cYoAQ6JdxICWMjfez03hJCXa1jgehx4hVKBAfQL7C7d
         QEk1Iqs857FdswUusQjoHKrJF8XQxlng+YAqbHZGX8JkdCx98+WL/q+LYxXpTKYdWE
         FaswtRqUN9VRQ==
From:   Mark Brown <broonie@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Alvin Lee <Alvin.Lee2@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Jasdeep Dhillon <jasdeep.dhillon@amd.com>,
        Josip Pavic <Josip.Pavic@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with the drm-next tree
Date:   Fri,  5 May 2023 22:26:13 +0900
Message-Id: <20230505132613.215401-1-broonie@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the amdgpu tree got conflicts in:

  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
  drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
  drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h

between commits:

  822b84ecfc646 ("drm/amd/display: Add missing WA and MCLK validation")
  f11aee97b13ea ("drm/amd/display: copy dmub caps to dc on dcn31")
  3caab67db1f69 ("drm/amd/display: Isolate remaining FPU code in DCN32")

from the drm-next tree and commits:

  e0a77e09c707c ("drm/amd/display: Add missing WA and MCLK validation")
  4f63b7a59926e ("drm/amd/display: Add FAMS capability to DCN31")
  b058e3999021e ("drm/amd/display: Enable SubVP on PSR panels if single stream")
  1938bcdc4b530 ("drm/amd/display: Query GECC enable for SubVP disable")

from the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 62ce36c75c4d2,55494730e5008..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
diff --cc drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 1f5ee5cde6e1c,4950eaa4406b2..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
diff --cc drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 47beb4ea779d3,826059d5b3675..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
diff --cc drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index dcf512cd30721,a4206b71d650a..0000000000000
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
