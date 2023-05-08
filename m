Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA1F6FA19C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjEHHxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjEHHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:53:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2761BCB;
        Mon,  8 May 2023 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683532409; x=1715068409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Tu2WMi9r4rbtbprNUAWE/SRewUCDAJL/iZHE274epA=;
  b=ng5WBSKt9s+wXtPOaCmnqGy2wec7zvsGmunX09owtBDnFwmOruY4YIA7
   HhVn9Q9WWF/bNkhmUHPGLKAs+rCan4J+lPy6eHNb17srJiykelaEPnjDe
   X0hoaZXv+xImaipbvyTK1CULV6RiZqsa36n//6eBGZ7ZGycKjsM7i0osn
   8NNgKJO0gs7fQye3q5ynY7N50MUEuCsbV5CV7PH9LuGHLcxUd2QRiu7VY
   UervR4eU+oHXxlxDysrSFR/434mESsyZgSzz6IFF52r7El3XOodoeV8th
   DlUbvSpRcsvjZiXdQQeap2T8jsBBKhgmNTLtd9BXTL8pwp4+otQ5jVA7Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="349615662"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="349615662"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 00:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="1028328725"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="1028328725"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 May 2023 00:53:26 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvvgT-00017p-2H;
        Mon, 08 May 2023 07:53:25 +0000
Date:   Mon, 8 May 2023 15:52:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     alison@she-devel.com, johan@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alison@she-devel.com, achaiken@aurora.tech
Subject: Re: [PATCH v4 1/2] gnss: ubx: customize serial device open to set
 U-Blox Zed-F9P baud
Message-ID: <202305081529.zgHsJsZq-lkp@intel.com>
References: <20230508011159.263322-2-alison@she-devel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508011159.263322-2-alison@she-devel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alison-she-devel-com/dt-bindings-gnss-Add-U-Blox-Zed-F9/20230508-101304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230508011159.263322-2-alison%40she-devel.com
patch subject: [PATCH v4 1/2] gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20230508/202305081529.zgHsJsZq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/93acd4265d325a1881a411703abc6dd45b81c1d0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review alison-she-devel-com/dt-bindings-gnss-Add-U-Blox-Zed-F9/20230508-101304
        git checkout 93acd4265d325a1881a411703abc6dd45b81c1d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305081529.zgHsJsZq-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gnss/ubx.c: In function 'ubx_set_active':
>> drivers/gnss/ubx.c:225:36: error: invalid use of undefined type 'struct ubx_data'
     225 |         ret = regulator_enable(data->vcc);
         |                                    ^~
   drivers/gnss/ubx.c: In function 'ubx_set_standby':
   drivers/gnss/ubx.c:237:37: error: invalid use of undefined type 'struct ubx_data'
     237 |         ret = regulator_disable(data->vcc);
         |                                     ^~
   drivers/gnss/ubx.c: In function 'ubx_probe':
>> drivers/gnss/ubx.c:288:54: error: invalid application of 'sizeof' to incomplete type 'struct ubx_data'
     288 |         gserial = gnss_serial_allocate(serdev, sizeof(*data));
         |                                                      ^
   drivers/gnss/ubx.c:305:21: error: invalid use of undefined type 'struct ubx_data'
     305 |                 data->is_configured = 0;
         |                     ^~
   drivers/gnss/ubx.c:306:21: error: invalid use of undefined type 'struct ubx_data'
     306 |                 data->features = of_match_device(ubx_of_match, &serdev->dev)->data;
         |                     ^~
   drivers/gnss/ubx.c:306:50: error: 'ubx_of_match' undeclared (first use in this function)
     306 |                 data->features = of_match_device(ubx_of_match, &serdev->dev)->data;
         |                                                  ^~~~~~~~~~~~
   drivers/gnss/ubx.c:306:50: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gnss/ubx.c:307:25: error: invalid use of undefined type 'struct ubx_data'
     307 |                 if (data->features && data->features->open) {
         |                         ^~
   drivers/gnss/ubx.c:307:43: error: invalid use of undefined type 'struct ubx_data'
     307 |                 if (data->features && data->features->open) {
         |                                           ^~
   drivers/gnss/ubx.c:308:51: error: invalid use of undefined type 'struct ubx_data'
     308 |                         ubx_gnss_ops->open  = data->features->open;
         |                                                   ^~
   drivers/gnss/ubx.c:314:13: error: invalid use of undefined type 'struct ubx_data'
     314 |         data->vcc = devm_regulator_get(&serdev->dev, "vcc");
         |             ^~
   drivers/gnss/ubx.c:315:24: error: invalid use of undefined type 'struct ubx_data'
     315 |         if (IS_ERR(data->vcc)) {
         |                        ^~
   drivers/gnss/ubx.c:316:35: error: invalid use of undefined type 'struct ubx_data'
     316 |                 ret = PTR_ERR(data->vcc);
         |                                   ^~
   drivers/gnss/ubx.c:320:13: error: invalid use of undefined type 'struct ubx_data'
     320 |         data->v_bckp = devm_regulator_get_optional(&serdev->dev, "v-bckp");
         |             ^~
   drivers/gnss/ubx.c:321:24: error: invalid use of undefined type 'struct ubx_data'
     321 |         if (IS_ERR(data->v_bckp)) {
         |                        ^~
   drivers/gnss/ubx.c:322:35: error: invalid use of undefined type 'struct ubx_data'
     322 |                 ret = PTR_ERR(data->v_bckp);
         |                                   ^~
   drivers/gnss/ubx.c:324:29: error: invalid use of undefined type 'struct ubx_data'
     324 |                         data->v_bckp = NULL;
         |                             ^~
   drivers/gnss/ubx.c:329:17: error: invalid use of undefined type 'struct ubx_data'
     329 |         if (data->v_bckp) {
         |                 ^~
   drivers/gnss/ubx.c:330:44: error: invalid use of undefined type 'struct ubx_data'
     330 |                 ret = regulator_enable(data->v_bckp);
         |                                            ^~
   drivers/gnss/ubx.c:342:17: error: invalid use of undefined type 'struct ubx_data'
     342 |         if (data->v_bckp)
         |                 ^~
   drivers/gnss/ubx.c:343:39: error: invalid use of undefined type 'struct ubx_data'
     343 |                 regulator_disable(data->v_bckp);
         |                                       ^~
   drivers/gnss/ubx.c: In function 'ubx_remove':
   drivers/gnss/ubx.c:356:17: error: invalid use of undefined type 'struct ubx_data'
     356 |         if (data->v_bckp)
         |                 ^~
   drivers/gnss/ubx.c:357:39: error: invalid use of undefined type 'struct ubx_data'
     357 |                 regulator_disable(data->v_bckp);
         |                                       ^~


vim +225 drivers/gnss/ubx.c

93acd4265d325a Alison Chaiken 2023-05-07  219  
1ad69f10e3a58d Johan Hovold   2018-06-01  220  static int ubx_set_active(struct gnss_serial *gserial)
1ad69f10e3a58d Johan Hovold   2018-06-01  221  {
1ad69f10e3a58d Johan Hovold   2018-06-01  222  	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
1ad69f10e3a58d Johan Hovold   2018-06-01  223  	int ret;
1ad69f10e3a58d Johan Hovold   2018-06-01  224  
1ad69f10e3a58d Johan Hovold   2018-06-01 @225  	ret = regulator_enable(data->vcc);
1ad69f10e3a58d Johan Hovold   2018-06-01  226  	if (ret)
1ad69f10e3a58d Johan Hovold   2018-06-01  227  		return ret;
1ad69f10e3a58d Johan Hovold   2018-06-01  228  
1ad69f10e3a58d Johan Hovold   2018-06-01  229  	return 0;
1ad69f10e3a58d Johan Hovold   2018-06-01  230  }
1ad69f10e3a58d Johan Hovold   2018-06-01  231  
1ad69f10e3a58d Johan Hovold   2018-06-01  232  static int ubx_set_standby(struct gnss_serial *gserial)
1ad69f10e3a58d Johan Hovold   2018-06-01  233  {
1ad69f10e3a58d Johan Hovold   2018-06-01  234  	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
1ad69f10e3a58d Johan Hovold   2018-06-01  235  	int ret;
1ad69f10e3a58d Johan Hovold   2018-06-01  236  
1ad69f10e3a58d Johan Hovold   2018-06-01  237  	ret = regulator_disable(data->vcc);
1ad69f10e3a58d Johan Hovold   2018-06-01  238  	if (ret)
1ad69f10e3a58d Johan Hovold   2018-06-01  239  		return ret;
1ad69f10e3a58d Johan Hovold   2018-06-01  240  
1ad69f10e3a58d Johan Hovold   2018-06-01  241  	return 0;
1ad69f10e3a58d Johan Hovold   2018-06-01  242  }
1ad69f10e3a58d Johan Hovold   2018-06-01  243  
1ad69f10e3a58d Johan Hovold   2018-06-01  244  static int ubx_set_power(struct gnss_serial *gserial,
1ad69f10e3a58d Johan Hovold   2018-06-01  245  				enum gnss_serial_pm_state state)
1ad69f10e3a58d Johan Hovold   2018-06-01  246  {
1ad69f10e3a58d Johan Hovold   2018-06-01  247  	switch (state) {
1ad69f10e3a58d Johan Hovold   2018-06-01  248  	case GNSS_SERIAL_ACTIVE:
1ad69f10e3a58d Johan Hovold   2018-06-01  249  		return ubx_set_active(gserial);
1ad69f10e3a58d Johan Hovold   2018-06-01  250  	case GNSS_SERIAL_OFF:
1ad69f10e3a58d Johan Hovold   2018-06-01  251  	case GNSS_SERIAL_STANDBY:
1ad69f10e3a58d Johan Hovold   2018-06-01  252  		return ubx_set_standby(gserial);
1ad69f10e3a58d Johan Hovold   2018-06-01  253  	}
1ad69f10e3a58d Johan Hovold   2018-06-01  254  
1ad69f10e3a58d Johan Hovold   2018-06-01  255  	return -EINVAL;
1ad69f10e3a58d Johan Hovold   2018-06-01  256  }
1ad69f10e3a58d Johan Hovold   2018-06-01  257  
55570f1a441787 Colin Ian King 2018-07-16  258  static const struct gnss_serial_ops ubx_gserial_ops = {
1ad69f10e3a58d Johan Hovold   2018-06-01  259  	.set_power = ubx_set_power,
1ad69f10e3a58d Johan Hovold   2018-06-01  260  };
1ad69f10e3a58d Johan Hovold   2018-06-01  261  
93acd4265d325a Alison Chaiken 2023-05-07  262  #ifdef CONFIG_OF
93acd4265d325a Alison Chaiken 2023-05-07  263  static const struct ubx_features zedf9p_feats = {
93acd4265d325a Alison Chaiken 2023-05-07  264  	.min_baud		=	9600,
93acd4265d325a Alison Chaiken 2023-05-07  265  	.default_baud		=	38400,
93acd4265d325a Alison Chaiken 2023-05-07  266  	.max_baud		=	921600,
93acd4265d325a Alison Chaiken 2023-05-07  267  	.baud_config_reg	=	0x40520001,
93acd4265d325a Alison Chaiken 2023-05-07  268  	.open			=	zed_f9p_serial_open,
93acd4265d325a Alison Chaiken 2023-05-07  269  };
93acd4265d325a Alison Chaiken 2023-05-07  270  
93acd4265d325a Alison Chaiken 2023-05-07  271  static const struct of_device_id ubx_of_match[] = {
93acd4265d325a Alison Chaiken 2023-05-07  272  	{ .compatible = "u-blox,neo-6m" },
93acd4265d325a Alison Chaiken 2023-05-07  273  	{ .compatible = "u-blox,neo-8" },
93acd4265d325a Alison Chaiken 2023-05-07  274  	{ .compatible = "u-blox,neo-m8" },
93acd4265d325a Alison Chaiken 2023-05-07  275  	{ .compatible = "u-blox,zed-f9p", .data = &zedf9p_feats },
93acd4265d325a Alison Chaiken 2023-05-07  276  	{},
93acd4265d325a Alison Chaiken 2023-05-07  277  };
93acd4265d325a Alison Chaiken 2023-05-07  278  MODULE_DEVICE_TABLE(of, ubx_of_match);
93acd4265d325a Alison Chaiken 2023-05-07  279  #endif
93acd4265d325a Alison Chaiken 2023-05-07  280  
1ad69f10e3a58d Johan Hovold   2018-06-01  281  static int ubx_probe(struct serdev_device *serdev)
1ad69f10e3a58d Johan Hovold   2018-06-01  282  {
1ad69f10e3a58d Johan Hovold   2018-06-01  283  	struct gnss_serial *gserial;
1ad69f10e3a58d Johan Hovold   2018-06-01  284  	struct ubx_data *data;
93acd4265d325a Alison Chaiken 2023-05-07  285  	struct gnss_operations *ubx_gnss_ops;
1ad69f10e3a58d Johan Hovold   2018-06-01  286  	int ret;
1ad69f10e3a58d Johan Hovold   2018-06-01  287  
1ad69f10e3a58d Johan Hovold   2018-06-01 @288  	gserial = gnss_serial_allocate(serdev, sizeof(*data));
1ad69f10e3a58d Johan Hovold   2018-06-01  289  	if (IS_ERR(gserial)) {
1ad69f10e3a58d Johan Hovold   2018-06-01  290  		ret = PTR_ERR(gserial);
1ad69f10e3a58d Johan Hovold   2018-06-01  291  		return ret;
1ad69f10e3a58d Johan Hovold   2018-06-01  292  	}
93acd4265d325a Alison Chaiken 2023-05-07  293  	ubx_gnss_ops = kzalloc(sizeof(struct gnss_operations), GFP_KERNEL);
93acd4265d325a Alison Chaiken 2023-05-07  294  	if (IS_ERR(ubx_gnss_ops)) {
93acd4265d325a Alison Chaiken 2023-05-07  295  		ret = PTR_ERR(ubx_gnss_ops);
93acd4265d325a Alison Chaiken 2023-05-07  296  		return ret;
93acd4265d325a Alison Chaiken 2023-05-07  297  	}
1ad69f10e3a58d Johan Hovold   2018-06-01  298  
1ad69f10e3a58d Johan Hovold   2018-06-01  299  	gserial->ops = &ubx_gserial_ops;
1ad69f10e3a58d Johan Hovold   2018-06-01  300  
10f146639fee5f Johan Hovold   2018-06-01  301  	gserial->gdev->type = GNSS_TYPE_UBX;
10f146639fee5f Johan Hovold   2018-06-01  302  
1ad69f10e3a58d Johan Hovold   2018-06-01  303  	data = gnss_serial_get_drvdata(gserial);
93acd4265d325a Alison Chaiken 2023-05-07  304  	if (IS_ENABLED(CONFIG_OF)) {
93acd4265d325a Alison Chaiken 2023-05-07  305  		data->is_configured = 0;
93acd4265d325a Alison Chaiken 2023-05-07  306  		data->features = of_match_device(ubx_of_match, &serdev->dev)->data;
93acd4265d325a Alison Chaiken 2023-05-07  307  		if (data->features && data->features->open) {
93acd4265d325a Alison Chaiken 2023-05-07  308  			ubx_gnss_ops->open  = data->features->open;
93acd4265d325a Alison Chaiken 2023-05-07  309  			ubx_gnss_ops->close = gserial->gdev->ops->close;
93acd4265d325a Alison Chaiken 2023-05-07  310  			ubx_gnss_ops->write_raw = gserial->gdev->ops->write_raw;
93acd4265d325a Alison Chaiken 2023-05-07  311  			gserial->gdev->ops = ubx_gnss_ops;
93acd4265d325a Alison Chaiken 2023-05-07  312  		}
93acd4265d325a Alison Chaiken 2023-05-07  313  	}
1ad69f10e3a58d Johan Hovold   2018-06-01  314  	data->vcc = devm_regulator_get(&serdev->dev, "vcc");
1ad69f10e3a58d Johan Hovold   2018-06-01  315  	if (IS_ERR(data->vcc)) {
1ad69f10e3a58d Johan Hovold   2018-06-01  316  		ret = PTR_ERR(data->vcc);
1ad69f10e3a58d Johan Hovold   2018-06-01  317  		goto err_free_gserial;
1ad69f10e3a58d Johan Hovold   2018-06-01  318  	}
1ad69f10e3a58d Johan Hovold   2018-06-01  319  
1ad69f10e3a58d Johan Hovold   2018-06-01  320  	data->v_bckp = devm_regulator_get_optional(&serdev->dev, "v-bckp");
1ad69f10e3a58d Johan Hovold   2018-06-01  321  	if (IS_ERR(data->v_bckp)) {
1ad69f10e3a58d Johan Hovold   2018-06-01  322  		ret = PTR_ERR(data->v_bckp);
1ad69f10e3a58d Johan Hovold   2018-06-01  323  		if (ret == -ENODEV)
1ad69f10e3a58d Johan Hovold   2018-06-01  324  			data->v_bckp = NULL;
1ad69f10e3a58d Johan Hovold   2018-06-01  325  		else
1ad69f10e3a58d Johan Hovold   2018-06-01  326  			goto err_free_gserial;
1ad69f10e3a58d Johan Hovold   2018-06-01  327  	}
1ad69f10e3a58d Johan Hovold   2018-06-01  328  
1ad69f10e3a58d Johan Hovold   2018-06-01  329  	if (data->v_bckp) {
1ad69f10e3a58d Johan Hovold   2018-06-01  330  		ret = regulator_enable(data->v_bckp);
1ad69f10e3a58d Johan Hovold   2018-06-01  331  		if (ret)
1ad69f10e3a58d Johan Hovold   2018-06-01  332  			goto err_free_gserial;
1ad69f10e3a58d Johan Hovold   2018-06-01  333  	}
1ad69f10e3a58d Johan Hovold   2018-06-01  334  
1ad69f10e3a58d Johan Hovold   2018-06-01  335  	ret = gnss_serial_register(gserial);
1ad69f10e3a58d Johan Hovold   2018-06-01  336  	if (ret)
1ad69f10e3a58d Johan Hovold   2018-06-01  337  		goto err_disable_v_bckp;
1ad69f10e3a58d Johan Hovold   2018-06-01  338  
1ad69f10e3a58d Johan Hovold   2018-06-01  339  	return 0;
1ad69f10e3a58d Johan Hovold   2018-06-01  340  
1ad69f10e3a58d Johan Hovold   2018-06-01  341  err_disable_v_bckp:
1ad69f10e3a58d Johan Hovold   2018-06-01  342  	if (data->v_bckp)
1ad69f10e3a58d Johan Hovold   2018-06-01  343  		regulator_disable(data->v_bckp);
1ad69f10e3a58d Johan Hovold   2018-06-01  344  err_free_gserial:
1ad69f10e3a58d Johan Hovold   2018-06-01  345  	gnss_serial_free(gserial);
1ad69f10e3a58d Johan Hovold   2018-06-01  346  
1ad69f10e3a58d Johan Hovold   2018-06-01  347  	return ret;
1ad69f10e3a58d Johan Hovold   2018-06-01  348  }
1ad69f10e3a58d Johan Hovold   2018-06-01  349  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
