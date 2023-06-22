Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9873ACF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFVXM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVXMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:12:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851CD13E;
        Thu, 22 Jun 2023 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687475573; x=1719011573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YF+i4k+p20bNeWeCgKkHDXbLmP2kzXmF7Q2NTsnY5cs=;
  b=OXuKAoOwUDRNP9/tIU7n3mxQHRZ7cm2/QJpDemfbelA4wijt1Vo1Ngui
   DHQ/6ASHlCmkWwvjsGLWT233MCrycWNLHyud0TbQMPMcJdiKsCgb30m8x
   PqVDVgGFZ4XRfZnHiUKxxDY73MG/RwQqdHJguJN9JtS4CdiH9a9UcuC91
   wPq9xR7yGbL4+9oTr2vO9X8N08KDxi+qfMP+6TtQCsxO2Z6snNzS6+j4I
   H0ck4N6LBp1QpBZu9ptyiteexAuywjq4b49rJGqMUGWWFQzTNeY4In5BL
   jdc9TFbN1dWaMl9/OD7jKE8JVNC+rFe/utiV4cs1OFHNH6U8mMU7t1R+d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340976510"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="340976510"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 16:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="889261769"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="889261769"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2023 16:12:48 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCTTr-0007o7-21;
        Thu, 22 Jun 2023 23:12:47 +0000
Date:   Fri, 23 Jun 2023 07:12:35 +0800
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
Subject: Re: [PATCH v3 10/11] media: v4l2: Add DELETE_BUF ioctl
Message-ID: <202306230742.KaUokotT-lkp@intel.com>
References: <20230622131349.144160-11-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622131349.144160-11-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master v6.4-rc7]
[cannot apply to next-20230622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-videobuf2-Access-vb2_queue-bufs-array-through-helper-functions/20230622-214122
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230622131349.144160-11-benjamin.gaignard%40collabora.com
patch subject: [PATCH v3 10/11] media: v4l2: Add DELETE_BUF ioctl
config: i386-buildonly-randconfig-r004-20230622 (https://download.01.org/0day-ci/archive/20230623/202306230742.KaUokotT-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306230742.KaUokotT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306230742.KaUokotT-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vb2_core_delete_buf" [drivers/media/common/videobuf2/videobuf2-v4l2.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
