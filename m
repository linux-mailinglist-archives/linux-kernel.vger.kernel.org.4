Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D0C6FA3A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjEHJsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjEHJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:48:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31918FF6;
        Mon,  8 May 2023 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683539315; x=1715075315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cWmWF6uKtJ7K13p4GwcrX3bQ+qpYDfz2qJtqq6XorVs=;
  b=FaBQttJVv9GcL9sfH+H0PSmiJV7Ac9iEhdfMYsaCd1CqMQmJ3Yn7h91V
   ChUzfjKzQPFMt/dTezArfZ1AKzD/ySjoM1ruV6Awel3va/1Cd3Ceh7CGA
   MZLKp99NgJl8YeZtDbtdHf3it+0wm0OxKJ7qzJKjc+Rh8Iv/aKBE1/5dx
   LpnJrQWTWt/4y488MVKNwQRotj7EfzrYYSX6zWA7QL6HvFyOxon0538SU
   MhWwmt5AY4jSD2mMEZkrcOeVdZdpzqS8jeXuO/WxzJivaorTuTKWobGjE
   cqAQEshkGIp3oadW+Me4+tgmJDWqsCIpIx/iJGTSGIHUwyEFv2/gEiX9E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="415163171"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="415163171"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 02:48:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="788035025"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="788035025"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 May 2023 02:48:30 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvxTp-0001An-1l;
        Mon, 08 May 2023 09:48:29 +0000
Date:   Mon, 8 May 2023 17:48:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nylon Chen <nylon.chen@sifive.com>, aou@eecs.berkeley.edu,
        conor@kernel.org, emil.renner.berthing@canonical.com,
        geert+renesas@glider.be, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, nylon.chen@sifive.com,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED
 algorithm
Message-ID: <202305081759.wgN4Q80I-lkp@intel.com>
References: <20230420093457.18936-3-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420093457.18936-3-nylon.chen@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nylon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on thierry-reding-pwm/for-next rockchip/for-next linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nylon-Chen/riscv-dts-sifive-unleashed-unmatched-Remove-PWM-controlled-LED-s-active-low-properties/20230420-173619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230420093457.18936-3-nylon.chen%40sifive.com
patch subject: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED algorithm
config: powerpc-randconfig-s041-20230507 (https://download.01.org/0day-ci/archive/20230508/202305081759.wgN4Q80I-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/f2d706bf61190a45a8f90f1f455bc943d4ac7b6e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nylon-Chen/riscv-dts-sifive-unleashed-unmatched-Remove-PWM-controlled-LED-s-active-low-properties/20230420-173619
        git checkout f2d706bf61190a45a8f90f1f455bc943d4ac7b6e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/pwm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305081759.wgN4Q80I-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pwm/pwm-sifive.c:157:18: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> drivers/pwm/pwm-sifive.c:157:18: sparse:    unsigned long long const *
>> drivers/pwm/pwm-sifive.c:157:18: sparse:    unsigned int *

vim +157 drivers/pwm/pwm-sifive.c

   129	
   130	static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   131				    const struct pwm_state *state)
   132	{
   133		struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
   134		struct pwm_state cur_state;
   135		unsigned int duty_cycle, period;
   136		unsigned long long num;
   137		bool enabled;
   138		int ret = 0;
   139		u32 frac;
   140	
   141		if (state->polarity != PWM_POLARITY_NORMAL && state->polarity != PWM_POLARITY_INVERSED)
   142			return -EINVAL;
   143	
   144		cur_state = pwm->state;
   145		enabled = cur_state.enabled;
   146	
   147		duty_cycle = state->duty_cycle;
   148		if (!state->enabled)
   149			duty_cycle = 0;
   150	
   151		/*
   152		 * The problem of output producing mixed setting as mentioned at top,
   153		 * occurs here. To minimize the window for this problem, we are
   154		 * calculating the register values first and then writing them
   155		 * consecutively
   156		 */
 > 157		period = max(state->period, ddata->approx_period);
   158		num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
   159		frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
   160		frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
   161		/* The hardware cannot generate a 100% duty cycle */
   162		frac = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
   163	
   164	
   165		mutex_lock(&ddata->lock);
   166		if (state->period != ddata->approx_period) {
   167			/*
   168			 * Don't let a 2nd user change the period underneath the 1st user.
   169			 * However if ddate->approx_period == 0 this is the first time we set
   170			 * any period, so let whoever gets here first set the period so other
   171			 * users who agree on the period won't fail.
   172			 */
   173			if (ddata->user_count != 1 && ddata->approx_period) {
   174				mutex_unlock(&ddata->lock);
   175				return -EBUSY;
   176			}
   177			ddata->approx_period = state->period;
   178			pwm_sifive_update_clock(ddata, clk_get_rate(ddata->clk));
   179		}
   180		mutex_unlock(&ddata->lock);
   181	
   182		/*
   183		 * If the PWM is enabled the clk is already on. So only enable it
   184		 * conditionally to have it on exactly once afterwards independent of
   185		 * the PWM state.
   186		 */
   187		if (!enabled) {
   188			ret = clk_enable(ddata->clk);
   189			if (ret) {
   190				dev_err(ddata->chip.dev, "Enable clk failed\n");
   191				return ret;
   192			}
   193		}
   194	
   195		writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
   196	
   197		if (!state->enabled)
   198			clk_disable(ddata->clk);
   199	
   200		return 0;
   201	}
   202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
