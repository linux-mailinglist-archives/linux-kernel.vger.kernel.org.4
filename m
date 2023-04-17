Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E786E4D13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjDQPYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjDQPYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:24:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3228410262;
        Mon, 17 Apr 2023 08:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC86F61FF1;
        Mon, 17 Apr 2023 15:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68587C433D2;
        Mon, 17 Apr 2023 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681744954;
        bh=2iS+hQ1LA78BC7w3OziP9UD8SgJ+yICD0rVzKV1MhnY=;
        h=From:To:Cc:Subject:Date:From;
        b=Msv80enbQmM8W8qql8Ux3d4etvStWQMH7w3mE9jcMweBs//4DN5if+coNy+LhAL8/
         9m0afJjlrAjH2gkoliKZ9Q2G2JuDFTVeCdKaiEH7aCXlQsPk5k2t2KDoUWGJzJwbaG
         pKLuQg/TDQIQR3O0KFEq5u2Qe5R/ol+rNPMPHon2TA3shbw78RNqMv3h2QM16rpWUA
         Qsn7oPcSP/mZljKzs7nvdl66SNEwUpAGcQVXp/lCutbFrn5zUBiGh4HBDW/513Bcvm
         moCwo1bOWV7eCioZEM7Sz+WMhgsyNsMszEHtmNfGtxy4Y5H4JCQ7frkdKGVecesl6R
         Z1SE8Fxg2zTwQ==
From:   broonie@kernel.org
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: linux-next: manual merge of the iommu tree with the v4l-dvb-next tree
Date:   Mon, 17 Apr 2023 16:22:27 +0100
Message-Id: <20230417152227.2603080-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the iommu tree got conflicts in:

  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c

between commit:

  0f4afd529224a ("media: Use of_property_present() for testing DT property presence")

from the v4l-dvb-next tree and commits:

  aa0ee7b4d5221 ("media: mediatek: vcodec: Remove the setting for dma_mask")
  7d35584d9c6d2 ("media: mtk-jpegdec: Remove the setting for dma_mask")

from the iommu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 6c7c5f3648df8,9b96d24363119..0000000000000
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
diff --cc drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 9ba5dc5df648d,11583405cf618..0000000000000
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
diff --cc drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 755f567b9e54f,50e5571608cdf..0000000000000
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
