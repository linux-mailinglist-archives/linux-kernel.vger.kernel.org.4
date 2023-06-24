Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACC473CD70
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjFXXee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 19:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjFXXe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:34:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415BA10F4;
        Sat, 24 Jun 2023 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687649668; x=1719185668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uSich5WtIL4xEDBsn+PUSmiT50AF+RCLc8UMqP5tImA=;
  b=Kox0T0vk10oRBNLnPo8erjBEidnzQMqWPog1vNTdr3a/2yz1HkPTRh/P
   YOyN9CeLYUy7zzQduV7c/JkHh1gkjp2d+00HB0MVYJFlm6JjPrbhB2oMW
   cYqUu9Ad2TFy8be12ItJ72d2vRPTVvfPLYDQee54J6Vf/l56HXcJm0f+d
   16iuXq2aX4WjDb1KiTvnOwNxfyDLy11KB7+LrNoYC6SYdoV6/uvJSU2+H
   os9J5NNIvFIHRAP0qDSe1GqCwFXw0k4tkiCRkyv1BgG7MBb7xmzsLdlgu
   zILeIWs2xaWNqgSkiU5GgyzCNEMOiEOK0+aT5z5zxrzYuaJQJu3wbVndH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="391122035"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="391122035"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 16:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="839837858"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="839837858"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Jun 2023 16:34:22 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDClq-0009Xr-05;
        Sat, 24 Jun 2023 23:34:22 +0000
Date:   Sun, 25 Jun 2023 07:34:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v3 01/11] media: videobuf2: Access vb2_queue bufs array
 through helper functions
Message-ID: <202306250705.Ts4zHhMG-lkp@intel.com>
References: <20230622131349.144160-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622131349.144160-2-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master v6.4-rc7 next-20230623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Access-vb2_queue-bufs-array-through-helper-functions/20230622-214122
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230622131349.144160-2-benjamin.gaignard%40collabora.com
patch subject: [PATCH v3 01/11] media: videobuf2: Access vb2_queue bufs array through helper functions
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230625/202306250705.Ts4zHhMG-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230625/202306250705.Ts4zHhMG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306250705.Ts4zHhMG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/media/atomisp/pci/atomisp_ioctl.c:1080:22: error: passing 'struct vb2_queue' to parameter of incompatible type 'struct vb2_queue *'; take the address with &
           vb = vb2_get_buffer(pipe->vb_queue, buf->index);
                               ^~~~~~~~~~~~~~
                               &
   include/media/videobuf2-core.h:1239:67: note: passing argument to parameter 'q' here
   static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
                                                                     ^
   1 error generated.


vim +1080 drivers/staging/media/atomisp/pci/atomisp_ioctl.c

  1065	
  1066	static int atomisp_dqbuf_wrapper(struct file *file, void *fh, struct v4l2_buffer *buf)
  1067	{
  1068		struct video_device *vdev = video_devdata(file);
  1069		struct atomisp_video_pipe *pipe = atomisp_to_video_pipe(vdev);
  1070		struct atomisp_sub_device *asd = pipe->asd;
  1071		struct atomisp_device *isp = video_get_drvdata(vdev);
  1072		struct ia_css_frame *frame;
  1073		struct vb2_buffer *vb;
  1074		int ret;
  1075	
  1076		ret = vb2_ioctl_dqbuf(file, fh, buf);
  1077		if (ret)
  1078			return ret;
  1079	
> 1080		vb = vb2_get_buffer(pipe->vb_queue, buf->index);
  1081		frame = vb_to_frame(vb);
  1082	
  1083		buf->reserved = asd->frame_status[buf->index];
  1084	
  1085		/*
  1086		 * Hack:
  1087		 * Currently frame_status in the enum type which takes no more lower
  1088		 * 8 bit.
  1089		 * use bit[31:16] for exp_id as it is only in the range of 1~255
  1090		 */
  1091		buf->reserved &= 0x0000ffff;
  1092		if (!(buf->flags & V4L2_BUF_FLAG_ERROR))
  1093			buf->reserved |= frame->exp_id;
  1094		buf->reserved2 = pipe->frame_config_id[buf->index];
  1095	
  1096		dev_dbg(isp->dev,
  1097			"dqbuf buffer %d (%s) with exp_id %d, isp_config_id %d\n",
  1098			buf->index, vdev->name, buf->reserved >> 16, buf->reserved2);
  1099		return 0;
  1100	}
  1101	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
