Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B66C3881
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjCURn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCURn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:43:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A746168;
        Tue, 21 Mar 2023 10:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679420585; x=1710956585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+pjwBEmDe+T56Sgwt4qimQ2CIBOYEqSjWw1uHZNKv6U=;
  b=bs8VSpiykmh9MtC3xKMoByUznm9gjz2V9OM82KqWl89rBCm2wN7Zhe+Q
   y12WyD1BfKhvbs4hGfqKIASKDVvjpNL6M5v+xIx2i6GtwnLVQ1m/zjZ7t
   A0DJg1DxRXMs7z2jf9KhvjiVJEIe0UXNreScy2R4hr4YcDkuhJ5ip8KFv
   93F8tUp85CH/8PrfeYrX24ds5wEfsK+YhQ3QSHHtU66zlzLMsqifHFCf8
   kQHFVV+eYgaO8aUS4kUznloV/wyLPfhyRbBgpag7AbpsNoNF5r1Splvat
   IOuPKqjVGeAH+jktubjnuydBvyDTTpedHklTvxNkcDKYBexhCl7Qt+xaY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="340553609"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="340553609"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 10:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="805503023"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="805503023"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2023 10:42:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peg0Q-000CDT-1d;
        Tue, 21 Mar 2023 17:42:42 +0000
Date:   Wed, 22 Mar 2023 01:42:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, jernel@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/8] media: videobuf2: Access vb2_queue bufs array
 through helper functions
Message-ID: <202303220154.ioaH1XLM-lkp@intel.com>
References: <20230321102855.346732-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321102855.346732-2-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

I love your patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master v6.3-rc3 next-20230321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Access-vb2_queue-bufs-array-through-helper-functions/20230321-183154
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230321102855.346732-2-benjamin.gaignard%40collabora.com
patch subject: [PATCH v2 1/8] media: videobuf2: Access vb2_queue bufs array through helper functions
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230322/202303220154.ioaH1XLM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/625d46c1c1fe8e3229a780134d21bcd4a017cfdd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Gaignard/media-videobuf2-Access-vb2_queue-bufs-array-through-helper-functions/20230321-183154
        git checkout 625d46c1c1fe8e3229a780134d21bcd4a017cfdd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303220154.ioaH1XLM-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/media/atomisp/pci/atomisp_ioctl.c: In function 'atomisp_dqbuf_wrapper':
>> drivers/staging/media/atomisp/pci/atomisp_ioctl.c:1098:33: error: incompatible type for argument 1 of 'vb2_get_buffer'
    1098 |         vb = vb2_get_buffer(pipe->vb_queue, buf->index);
         |                             ~~~~^~~~~~~~~~
         |                                 |
         |                                 struct vb2_queue
   In file included from include/media/videobuf2-v4l2.h:16,
                    from drivers/staging/media/atomisp//pci/ia_css_frame_public.h:23,
                    from drivers/staging/media/atomisp/pci/sh_css_legacy.h:22,
                    from drivers/staging/media/atomisp/pci/atomisp_internal.h:34,
                    from drivers/staging/media/atomisp/pci/atomisp_cmd.h:30,
                    from drivers/staging/media/atomisp/pci/atomisp_ioctl.c:27:
   include/media/videobuf2-core.h:1239:67: note: expected 'struct vb2_queue *' but argument is of type 'struct vb2_queue'
    1239 | static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
         |                                                 ~~~~~~~~~~~~~~~~~~^


vim +/vb2_get_buffer +1098 drivers/staging/media/atomisp/pci/atomisp_ioctl.c

  1083	
  1084	static int atomisp_dqbuf_wrapper(struct file *file, void *fh, struct v4l2_buffer *buf)
  1085	{
  1086		struct video_device *vdev = video_devdata(file);
  1087		struct atomisp_video_pipe *pipe = atomisp_to_video_pipe(vdev);
  1088		struct atomisp_sub_device *asd = pipe->asd;
  1089		struct atomisp_device *isp = video_get_drvdata(vdev);
  1090		struct ia_css_frame *frame;
  1091		struct vb2_buffer *vb;
  1092		int ret;
  1093	
  1094		ret = vb2_ioctl_dqbuf(file, fh, buf);
  1095		if (ret)
  1096			return ret;
  1097	
> 1098		vb = vb2_get_buffer(pipe->vb_queue, buf->index);
  1099		frame = vb_to_frame(vb);
  1100	
  1101		buf->reserved = asd->frame_status[buf->index];
  1102	
  1103		/*
  1104		 * Hack:
  1105		 * Currently frame_status in the enum type which takes no more lower
  1106		 * 8 bit.
  1107		 * use bit[31:16] for exp_id as it is only in the range of 1~255
  1108		 */
  1109		buf->reserved &= 0x0000ffff;
  1110		if (!(buf->flags & V4L2_BUF_FLAG_ERROR))
  1111			buf->reserved |= frame->exp_id;
  1112		buf->reserved2 = pipe->frame_config_id[buf->index];
  1113	
  1114		dev_dbg(isp->dev,
  1115			"dqbuf buffer %d (%s) for asd%d with exp_id %d, isp_config_id %d\n",
  1116			buf->index, vdev->name, asd->index, buf->reserved >> 16,
  1117			buf->reserved2);
  1118		return 0;
  1119	}
  1120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
