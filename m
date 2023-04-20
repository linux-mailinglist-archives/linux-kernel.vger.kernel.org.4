Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8D6E96BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjDTONx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDTONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:13:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2535BE;
        Thu, 20 Apr 2023 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682000029; x=1713536029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JzV9UVrh3z0+38+XT/wGu5bBMfjLAZvZNkPN2oIaVAA=;
  b=i3DeW/Ezw/VNgUnw4Duq4XehkiOVrGyRTCcPjItoEgGVX4qN6V/JRhiw
   q3GJaj/3gbzPeXbuDgOS/jkwa3c7ZsO2dvbx9rU4U3LBZuZHEW+f/BNJd
   LWquAHAG/ryTfKXP9uxPW13Fr1n03p3gxzV5/dYmA1hnxPzzjDrPHP3cn
   poFxQ84xJEV4HQFQf2Eue+nyvG/Exd8A9rWc1Te6gjKHmPvdd1qVbU1WN
   BBM+bW8Tmpa+HKk8uFtYPvsGv58DhP/RJF0WDNqJ+M2us9lzjQkDFPABN
   y4SGN+Zlb6r02GpaZtVCS6Gm3rpgUsityaIMTM+NtO+TPGPbUeKDbT7IF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="325349807"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="325349807"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 07:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="694523902"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="694523902"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2023 07:13:43 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppV2c-000fsJ-1r;
        Thu, 20 Apr 2023 14:13:42 +0000
Date:   Thu, 20 Apr 2023 22:13:22 +0800
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
Message-ID: <202304202141.JYCKBVOQ-lkp@intel.com>
References: <20230420093457.18936-3-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420093457.18936-3-nylon.chen@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nylon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on thierry-reding-pwm/for-next rockchip/for-next linus/master v6.3-rc7 next-20230419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nylon-Chen/riscv-dts-sifive-unleashed-unmatched-Remove-PWM-controlled-LED-s-active-low-properties/20230420-173619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230420093457.18936-3-nylon.chen%40sifive.com
patch subject: [PATCH v3 2/2] pwm: sifive: change the PWM controlled LED algorithm
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230420/202304202141.JYCKBVOQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f2d706bf61190a45a8f90f1f455bc943d4ac7b6e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nylon-Chen/riscv-dts-sifive-unleashed-unmatched-Remove-PWM-controlled-LED-s-active-low-properties/20230420-173619
        git checkout f2d706bf61190a45a8f90f1f455bc943d4ac7b6e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304202141.JYCKBVOQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:26,
                    from include/linux/clk.h:13,
                    from drivers/pwm/pwm-sifive.c:14:
   drivers/pwm/pwm-sifive.c: In function 'pwm_sifive_apply':
   include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                   ^~
   include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:74:25: note: in expansion of macro '__careful_cmp'
      74 | #define max(x, y)       __careful_cmp(x, y, >)
         |                         ^~~~~~~~~~~~~
   drivers/pwm/pwm-sifive.c:157:18: note: in expansion of macro 'max'
     157 |         period = max(state->period, ddata->approx_period);
         |                  ^~~
>> drivers/pwm/pwm-sifive.c:135:34: warning: variable 'period' set but not used [-Wunused-but-set-variable]
     135 |         unsigned int duty_cycle, period;
         |                                  ^~~~~~


vim +/period +135 drivers/pwm/pwm-sifive.c

   129	
   130	static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   131				    const struct pwm_state *state)
   132	{
   133		struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
   134		struct pwm_state cur_state;
 > 135		unsigned int duty_cycle, period;
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
   157		period = max(state->period, ddata->approx_period);
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
