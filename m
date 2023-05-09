Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66F76FC1DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjEIIoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjEIIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:44:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660CE83C5
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683621892; x=1715157892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CxchOLSb2uQiQ0wq39RpL59EhQg6Bj3Eg9bjmW5VqwU=;
  b=Rvb213U8HtHGTALiDDmivSPhCoFmkqmu/uFBJYe9iX3xG+JQcJ+irbq2
   ESTCs0EO8Iwh5U/DZ5U98hE9CJNzxf7A+PTKyjHUJQzvgsAIxdk8xFrI1
   rPJ4it6MPEW5ULUKqD+J2ct7uxcwWOKsQUDzAQlIz4164FStROLI/ifx5
   jymqO1fzOzLYTJ+Yty7aKNIpTrPSye6sObluwlZDgWJ2y0cHDyfEJTB5W
   tVZf8+eKuWohtq8ef05NqBm7HN2XmqK1NqAiQL+UPFsb3dTE8iPcvh5dI
   obrfsSyIkTAbTaz1oMdX3uuj1FrpHhdyPpkW84GZinbQN5f5Q2U67iaqB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436163461"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="436163461"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 01:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="763733944"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="763733944"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 May 2023 01:44:49 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwIxk-0001zE-2r;
        Tue, 09 May 2023 08:44:48 +0000
Date:   Tue, 9 May 2023 16:43:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, quic_visr@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC:codecs: lpass: Fix for KASAN use_after_free out of
 bounds
Message-ID: <202305091655.6KwfcuWa-lkp@intel.com>
References: <20230509061321.10218-1-quic_visr@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509061321.10218-1-quic_visr@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravulapati,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.4-rc1 next-20230509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ravulapati-Vishnu-Vardhan-Rao/ASoC-codecs-lpass-Fix-for-KASAN-use_after_free-out-of-bounds/20230509-141447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230509061321.10218-1-quic_visr%40quicinc.com
patch subject: [PATCH] ASoC:codecs: lpass: Fix for KASAN use_after_free out of bounds
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230509/202305091655.6KwfcuWa-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/83fb508f4eb95e9495f0e440b47226040e3b4efc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ravulapati-Vishnu-Vardhan-Rao/ASoC-codecs-lpass-Fix-for-KASAN-use_after_free-out-of-bounds/20230509-141447
        git checkout 83fb508f4eb95e9495f0e440b47226040e3b4efc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305091655.6KwfcuWa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/soc/codecs/lpass-tx-macro.c: In function 'tx_macro_put_dec_enum':
   sound/soc/codecs/lpass-tx-macro.c:801:57: warning: missing terminating " character
     801 |                                 dev_err(component->dev, "dmic for clk sel is wrong,
         |                                                         ^
   sound/soc/codecs/lpass-tx-macro.c:802:79: warning: missing terminating " character
     802 |                                         expected less than 4 but received %d\n", dmic);
         |                                                                               ^
   sound/soc/codecs/lpass-tx-macro.c:2199:23: error: unterminated argument list invoking macro "dev_err"
    2199 | MODULE_LICENSE("GPL");
         |                       ^
   sound/soc/codecs/lpass-tx-macro.c:801:33: error: 'dev_err' undeclared (first use in this function); did you mean '_dev_err'?
     801 |                                 dev_err(component->dev, "dmic for clk sel is wrong,
         |                                 ^~~~~~~
         |                                 _dev_err
   sound/soc/codecs/lpass-tx-macro.c:801:33: note: each undeclared identifier is reported only once for each function it appears in
   sound/soc/codecs/lpass-tx-macro.c:801:40: error: expected ';' at end of input
     801 |                                 dev_err(component->dev, "dmic for clk sel is wrong,
         |                                        ^
         |                                        ;
   ......
   sound/soc/codecs/lpass-tx-macro.c:801:33: error: expected declaration or statement at end of input
     801 |                                 dev_err(component->dev, "dmic for clk sel is wrong,
         |                                 ^~~~~~~
   sound/soc/codecs/lpass-tx-macro.c:801:33: error: expected declaration or statement at end of input
   sound/soc/codecs/lpass-tx-macro.c:788:19: note: '-Wmisleading-indentation' is disabled from this point onwards, since column-tracking was disabled due to the size of the code/headers
     788 |                 } else if (val < 5) {
         |                   ^~~~
   sound/soc/codecs/lpass-tx-macro.c:788:19: note: adding '-flarge-source-files' will allow for more column-tracking support, at the expense of compilation time and memory
   sound/soc/codecs/lpass-tx-macro.c:801:33: error: expected declaration or statement at end of input
     801 |                                 dev_err(component->dev, "dmic for clk sel is wrong,
         |                                 ^~~~~~~
   sound/soc/codecs/lpass-tx-macro.c:801:33: error: expected declaration or statement at end of input
   At top level:
   sound/soc/codecs/lpass-tx-macro.c:737:12: warning: 'tx_macro_put_dec_enum' defined but not used [-Wunused-function]
     737 | static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
         |            ^~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/lpass-tx-macro.c:717:12: warning: 'tx_macro_mclk_event' defined but not used [-Wunused-function]
     717 | static int tx_macro_mclk_event(struct snd_soc_dapm_widget *w,
         |            ^~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/lpass-tx-macro.c:699:13: warning: 'tx_macro_mute_update_callback' defined but not used [-Wunused-function]
     699 | static void tx_macro_mute_update_callback(struct work_struct *work)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/lpass-tx-macro.c:655:13: warning: 'tx_macro_tx_hpf_corner_freq_callback' defined but not used [-Wunused-function]
     655 | static void tx_macro_tx_hpf_corner_freq_callback(struct work_struct *work)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/codecs/lpass-tx-macro.c:587:35: warning: 'tx_regmap_config' defined but not used [-Wunused-const-variable=]
     587 | static const struct regmap_config tx_regmap_config = {
         |                                   ^~~~~~~~~~~~~~~~
   In file included from include/sound/tlv.h:10,
                    from sound/soc/codecs/lpass-tx-macro.c:13:
>> sound/soc/codecs/lpass-tx-macro.c:281:35: warning: 'digital_gain' defined but not used [-Wunused-const-variable=]
     281 | static const DECLARE_TLV_DB_SCALE(digital_gain, -8400, 100, -8400);
         |                                   ^~~~~~~~~~~~
   include/uapi/sound/tlv.h:53:22: note: in definition of macro 'SNDRV_CTL_TLVD_DECLARE_DB_SCALE'
      53 |         unsigned int name[] = { \
         |                      ^~~~
   sound/soc/codecs/lpass-tx-macro.c:281:14: note: in expansion of macro 'DECLARE_TLV_DB_SCALE'
     281 | static const DECLARE_TLV_DB_SCALE(digital_gain, -8400, 100, -8400);
         |              ^~~~~~~~~~~~~~~~~~~~


vim +/tx_regmap_config +587 sound/soc/codecs/lpass-tx-macro.c

c39667ddcfc516 Srinivas Kandagatla 2021-02-11  586  
c39667ddcfc516 Srinivas Kandagatla 2021-02-11 @587  static const struct regmap_config tx_regmap_config = {
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  588  	.name = "tx_macro",
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  589  	.reg_bits = 16,
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  590  	.val_bits = 32,
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  591  	.reg_stride = 4,
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  592  	.cache_type = REGCACHE_FLAT,
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  593  	.max_register = TX_MAX_OFFSET,
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  594  	.reg_defaults = tx_defaults,
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  595  	.num_reg_defaults = ARRAY_SIZE(tx_defaults),
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  596  	.writeable_reg = tx_is_rw_register,
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  597  	.volatile_reg = tx_is_volatile_register,
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  598  	.readable_reg = tx_is_rw_register,
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  599  };
c39667ddcfc516 Srinivas Kandagatla 2021-02-11  600  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
