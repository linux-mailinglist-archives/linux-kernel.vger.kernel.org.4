Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3DE60FF30
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiJ0RRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbiJ0RRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:17:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D4017A96F;
        Thu, 27 Oct 2022 10:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94F58B82716;
        Thu, 27 Oct 2022 17:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B35EC433D6;
        Thu, 27 Oct 2022 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666891040;
        bh=vEnsvlXaU7b0fHU1VrvjtPlhLZuHphl4v98hbaO4yy8=;
        h=Date:From:To:Cc:Subject:From;
        b=ZEJPi/0hLjM5COTd1em2C7YnF2aORocoSHMJlEhm793j04R/hn0JJd5m6HUZmIGPJ
         j3IEUZCp/lqmwhg2ewZqRsl2ImftohJ85ZZfWZVlkVtwF9ct84NO1YhTtirNiA208y
         KcmXJctu91dgx1F/EGIYaqEMCLs7NfZ/nbHxK831gl2SRV6tax/Oiyy+8n38Hf68jM
         ySjO/sIXbdfH6mIdZPoNv8ptjISVn3IlT13hxOncSuLQOS62Q0z/DFWX366yD11hFH
         GNynlQD7YiwZD/ln/JtaNjl0Iq7Wmsd5y93ae+4+QqmQdFQwf3mydSOjrHslRdUAzG
         OVGU3sQp9R7VA==
Date:   Thu, 27 Oct 2022 18:17:14 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.1-rc3] media fixes
Message-ID: <20221027181714.3d12aba5@sal.lan>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-3

For a bunch of patches addressing issues at the vivid driver and adding
new checks at V4L2 to validate the input parameters from some ioctls.

Regards,
Mauro

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.1-3

for you to fetch changes up to de547896aac606a00435a219757a940ece142bf0:

  media: vivid.rst: loop_video is set on the capture devnode (2022-10-25 16:43:54 +0100)

----------------------------------------------------------------
media fixes for v6.1-rc3

----------------------------------------------------------------
Hans Verkuil (8):
      media: vivid: s_fbuf: add more sanity checks
      media: vivid: dev->bitmap_cap wasn't freed in all cases
      media: v4l2-dv-timings: add sanity checks for blanking values
      media: videodev2.h: V4L2_DV_BT_BLANKING_HEIGHT should check 'interlaced'
      media: vivid: fix control handler mutex deadlock
      media: vivid: drop GFP_DMA32
      media: vivid: set num_in/outputs to 0 if not supported
      media: vivid.rst: loop_video is set on the capture devnode

 Documentation/admin-guide/media/vivid.rst        |  2 +-
 drivers/media/test-drivers/vivid/vivid-core.c    | 38 +++++++++++++++++++++---
 drivers/media/test-drivers/vivid/vivid-core.h    |  2 ++
 drivers/media/test-drivers/vivid/vivid-osd.c     |  2 +-
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 35 ++++++++++++++++++----
 drivers/media/v4l2-core/v4l2-dv-timings.c        | 14 +++++++++
 include/uapi/linux/videodev2.h                   |  3 +-
 7 files changed, 83 insertions(+), 13 deletions(-)

