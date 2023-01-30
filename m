Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901F6680DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbjA3Mc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbjA3McX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:32:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D7F3755B;
        Mon, 30 Jan 2023 04:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675081927; x=1706617927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VRScn7azVs3RNAip1lwo/iLiGA4aPiARFKff3Doh2wE=;
  b=UwD+4OnQrkNoRnZvSDs8ZHcSpTS2b9OLoDWMyUTsymyqxpfLDk0EmDW4
   Y5I5KKk/rkzGLIA6+wPvvpPw4sEpk1ovxFeGtSvZnYlyX8nQFi+TJnJPq
   xM5sR5Y/y8qWxRsIo2+b2wITFHHeeZM4xeThiFuJ6L1uWxQssT6idnOXJ
   a7DEUlPhv5BPOBtqpVj2y4Lqjy2AkRjKxdHxYhK2cC1JskFc8G45JHFuX
   IB5+f4B98rLPnDI0eJnA4/bd4O3/U2qzhNSN4qaAMu9eIfTGMMdy+kOhI
   zjRQtsAr6v8SDaAIWemDPwWrdKIq9ry/QYRwJvi++YlwLyeyIX9v8u4o5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="325241599"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="325241599"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:32:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="837953665"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="837953665"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2023 04:32:03 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMTKL-0003cU-36;
        Mon, 30 Jan 2023 12:32:01 +0000
Date:   Mon, 30 Jan 2023 20:31:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?Q?Micha=C5=82?= Krawczyk <mk@semihalf.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Micha=C5=82?= Krawczyk <mk@semihalf.com>
Subject: Re: [PATCH] media: venus: dec: Fix handling of the start cmd
Message-ID: <202301302043.AAXAiTHh-lkp@intel.com>
References: <20230130105423.1338554-1-mk@semmihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230130105423.1338554-1-mk@semmihalf.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michał,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v6.2-rc6 next-20230130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Krawczyk/media-venus-dec-Fix-handling-of-the-start-cmd/20230130-185626
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230130105423.1338554-1-mk%40semmihalf.com
patch subject: [PATCH] media: venus: dec: Fix handling of the start cmd
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230130/202301302043.AAXAiTHh-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3aa2620bc66440999bc7906165d2a5adb129402f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Micha-Krawczyk/media-venus-dec-Fix-handling-of-the-start-cmd/20230130-185626
        git checkout 3aa2620bc66440999bc7906165d2a5adb129402f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/media/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/media/platform/qcom/venus/vdec.c: In function 'vdec_decoder_cmd':
>> drivers/media/platform/qcom/venus/vdec.c:529:27: warning: variable 'dst_vq' set but not used [-Wunused-but-set-variable]
     529 |         struct vb2_queue *dst_vq;
         |                           ^~~~~~


vim +/dst_vq +529 drivers/media/platform/qcom/venus/vdec.c

   524	
   525	static int
   526	vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
   527	{
   528		struct venus_inst *inst = to_inst(file);
 > 529		struct vb2_queue *dst_vq;
   530		struct hfi_frame_data fdata = {0};
   531		int ret;
   532	
   533		ret = v4l2_m2m_ioctl_try_decoder_cmd(file, fh, cmd);
   534		if (ret)
   535			return ret;
   536	
   537		mutex_lock(&inst->lock);
   538	
   539		if (cmd->cmd == V4L2_DEC_CMD_STOP) {
   540			/*
   541			 * Implement V4L2_DEC_CMD_STOP by enqueue an empty buffer on
   542			 * decoder input to signal EOS.
   543			 */
   544			if (!(inst->streamon_out && inst->streamon_cap))
   545				goto unlock;
   546	
   547			fdata.buffer_type = HFI_BUFFER_INPUT;
   548			fdata.flags |= HFI_BUFFERFLAG_EOS;
   549			if (IS_V6(inst->core))
   550				fdata.device_addr = 0;
   551			else
   552				fdata.device_addr = 0xdeadb000;
   553	
   554			ret = hfi_session_process_buf(inst, &fdata);
   555	
   556			if (!ret && inst->codec_state == VENUS_DEC_STATE_DECODING) {
   557				inst->codec_state = VENUS_DEC_STATE_DRAIN;
   558				inst->drain_active = true;
   559			}
   560		} else if (cmd->cmd == V4L2_DEC_CMD_START &&
   561			   inst->codec_state == VENUS_DEC_STATE_STOPPED) {
   562			dst_vq = v4l2_m2m_get_vq(inst->fh.m2m_ctx,
   563						 V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
   564			vb2_clear_last_buffer_dequeued(&inst->fh.m2m_ctx->cap_q_ctx.q);
   565	
   566			inst->codec_state = VENUS_DEC_STATE_DECODING;
   567		}
   568	
   569	unlock:
   570		mutex_unlock(&inst->lock);
   571		return ret;
   572	}
   573	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
