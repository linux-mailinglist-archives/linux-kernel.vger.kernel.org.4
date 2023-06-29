Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132D9741F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjF2FK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjF2FKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:10:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ABB270A;
        Wed, 28 Jun 2023 22:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688015418; x=1719551418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6LQAu91eVGZWW31xWhtJ43lX+y8sn/3qZXLOGp6FHk0=;
  b=Ol6ec8y/b7GISf+4fs0hT47optLW1bOD7gdI0xgRjBQ2mHGUuHSHzLMh
   MU8zbwlokuDAWNMWkmtUsh4wNCDL807qP4IGwjw8AGP9dLcaBHZ6AUCo7
   xWsz+ZzRLeeoTC1kpRpauiPAQgZWF8qnaa4rDjEzp8537RfKsc7g1EA5i
   HOnVbygyjaDtTIVZ5tGJaWfrzzUzyR4YdmEnlGch98gBvze4VDrxI8coZ
   cWYQk0Fa0FExxGnslUczYajhOewTtYZ0D8E8wPgJtSfQApxZKpmtFieFV
   lfiauEOITSCDHuHm5YYZAVFzdJb969UOkMuMV5hl627Jyn4KHxza22gvM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342362852"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="342362852"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 22:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="694496366"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="694496366"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jun 2023 22:10:11 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEjv0-000DqN-1O;
        Thu, 29 Jun 2023 05:10:10 +0000
Date:   Thu, 29 Jun 2023 13:09:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        Irui Wang <irui.wang@mediatek.com>,
        George Sun <george.sun@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: media: mediatek: vcodec: fix AV1 decode fail for 36bit iova
Message-ID: <202306291250.o5AmGFiC-lkp@intel.com>
References: <20230628054111.8967-1-xiaoyong.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628054111.8967-1-xiaoyong.lu@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaoyong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230627]
[cannot apply to media-tree/master v6.4 v6.4-rc7 v6.4-rc6 linus/master v6.4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaoyong-Lu/media-mediatek-vcodec-fix-AV1-decode-fail-for-36bit-iova/20230628-134327
base:   next-20230627
patch link:    https://lore.kernel.org/r/20230628054111.8967-1-xiaoyong.lu%40mediatek.com
patch subject: media: mediatek: vcodec: fix AV1 decode fail for 36bit iova
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230629/202306291250.o5AmGFiC-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306291250.o5AmGFiC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306291250.o5AmGFiC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c: In function 'vdec_av1_slice_setup_tile_buffer':
>> drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c:1676:91: warning: suggest parentheses around '+' inside '<<' [-Wparentheses]
    1676 |                 tile_info_buf[tile_info_base + 1] = (unsigned int)(tile_buf_pa >> 4) << 4 +
         |                                                                                         ~~^
    1677 |                         ((unsigned int)(tile_buf_pa >> 32) & 0xf);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                          

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SM_GCC_8350
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_VIDEOCC_8350 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   WARNING: unmet direct dependencies detected for SM_GCC_8450
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_GPUCC_8450 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   - SM_VIDEOCC_8450 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   WARNING: unmet direct dependencies detected for SM_GCC_8550
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_GPUCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   - SM_VIDEOCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]


vim +1676 drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c

  1649	
  1650	static void vdec_av1_slice_setup_tile_buffer(struct vdec_av1_slice_instance *instance,
  1651						     struct vdec_av1_slice_vsi *vsi,
  1652						     struct mtk_vcodec_mem *bs)
  1653	{
  1654		struct vdec_av1_slice_tile_group *tile_group = &instance->tile_group;
  1655		struct vdec_av1_slice_uncompressed_header *uh = &vsi->frame.uh;
  1656		struct vdec_av1_slice_tile *tile = &uh->tile;
  1657		u32 tile_num, tile_row, tile_col;
  1658		u32 allow_update_cdf = 0;
  1659		u32 sb_boundary_x_m1 = 0, sb_boundary_y_m1 = 0;
  1660		int tile_info_base;
  1661		u64 tile_buf_pa;
  1662		u32 *tile_info_buf = instance->tile.va;
  1663		u64 pa = (u64)bs->dma_addr;
  1664	
  1665		if (uh->disable_cdf_update == 0)
  1666			allow_update_cdf = 1;
  1667	
  1668		for (tile_num = 0; tile_num < tile_group->num_tiles; tile_num++) {
  1669			/* each uint32 takes place of 4 bytes */
  1670			tile_info_base = (AV1_TILE_BUF_SIZE * tile_num) >> 2;
  1671			tile_row = tile_num / tile->tile_cols;
  1672			tile_col = tile_num % tile->tile_cols;
  1673			tile_info_buf[tile_info_base + 0] = (tile_group->tile_size[tile_num] << 3);
  1674			tile_buf_pa = pa + tile_group->tile_start_offset[tile_num];
  1675	
> 1676			tile_info_buf[tile_info_base + 1] = (unsigned int)(tile_buf_pa >> 4) << 4 +
  1677				((unsigned int)(tile_buf_pa >> 32) & 0xf);
  1678			tile_info_buf[tile_info_base + 2] = (tile_buf_pa % 16) << 3;
  1679	
  1680			sb_boundary_x_m1 =
  1681				(tile->mi_col_starts[tile_col + 1] - tile->mi_col_starts[tile_col] - 1) &
  1682				0x3f;
  1683			sb_boundary_y_m1 =
  1684				(tile->mi_row_starts[tile_row + 1] - tile->mi_row_starts[tile_row] - 1) &
  1685				0x1ff;
  1686	
  1687			tile_info_buf[tile_info_base + 3] = (sb_boundary_y_m1 << 7) | sb_boundary_x_m1;
  1688			tile_info_buf[tile_info_base + 4] = ((allow_update_cdf << 18) | (1 << 16));
  1689	
  1690			if (tile_num == tile->context_update_tile_id &&
  1691			    uh->disable_frame_end_update_cdf == 0)
  1692				tile_info_buf[tile_info_base + 4] |= (1 << 17);
  1693	
  1694			mtk_vcodec_debug(instance, "// tile buf %d pos(%dx%d) offset 0x%x\n",
  1695					 tile_num, tile_row, tile_col, tile_info_base);
  1696			mtk_vcodec_debug(instance, "// %08x %08x %08x %08x\n",
  1697					 tile_info_buf[tile_info_base + 0],
  1698					 tile_info_buf[tile_info_base + 1],
  1699					 tile_info_buf[tile_info_base + 2],
  1700					 tile_info_buf[tile_info_base + 3]);
  1701			mtk_vcodec_debug(instance, "// %08x %08x %08x %08x\n",
  1702					 tile_info_buf[tile_info_base + 4],
  1703					 tile_info_buf[tile_info_base + 5],
  1704					 tile_info_buf[tile_info_base + 6],
  1705					 tile_info_buf[tile_info_base + 7]);
  1706		}
  1707	}
  1708	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
