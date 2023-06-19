Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D78735DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjFSTrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFSTrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:47:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7205F106;
        Mon, 19 Jun 2023 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687204024; x=1718740024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u0fN8XEnTJTB1+Niijcu8Zh6wceQiwakljXz7VF7+TU=;
  b=DIZtvUbtYPuOui0AUiZCzocJCxkIwxW/oUCAL8ut1fuZNKq0OBZAlvPy
   bu7c/G13A78a0HrHkQN/sJwIWTxh9z2l3OH7Qn/b+ztNv2RHflXsJi4BY
   aiBxRBdkwswWnAYL70StbyUxcGyyYa4kzSLDCHDt/LLFQSlF2C7wUr3H5
   /dZ1+5JGqpwYupmbSH7VVCElo8LPMOVDqvv4DmdU9UuTBBtQCdxzsFY+8
   ET+fPeIAbh5hGSbNgZma82WWvymMDvhoPvhUfBgdWysmQ8K0URe5K0418
   nrde1RVBV0DLDZ5CACRxxPJdq5jLTcT9L9fhiYLpU+0qP1XhJeiXL4rDJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423369240"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="423369240"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 12:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="826702269"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="826702269"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2023 12:47:01 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBKq4-00054Y-2O;
        Mon, 19 Jun 2023 19:47:00 +0000
Date:   Tue, 20 Jun 2023 03:46:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/1] hwmon: (nct6775) Fix use of undefined variable
Message-ID: <202306200252.DaPAjeGo-lkp@intel.com>
References: <20230619133257.57569-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619133257.57569-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on next-20230619]
[cannot apply to linus/master v6.4-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/hwmon-nct6775-Fix-use-of-undefined-variable/20230619-213352
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230619133257.57569-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] hwmon: (nct6775) Fix use of undefined variable
config: riscv-randconfig-r042-20230619 (https://download.01.org/0day-ci/archive/20230620/202306200252.DaPAjeGo-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306200252.DaPAjeGo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306200252.DaPAjeGo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/nct6775-core.c:3854:14: error: incompatible integer to pointer conversion passing 'u16' (aka 'unsigned short') to parameter of type 'unsigned long *' [-Wint-conversion]
    3854 |                 bitmap_set(data->have_in, 0, 15);
         |                            ^~~~~~~~~~~~~
   include/linux/bitmap.h:453:55: note: passing argument to parameter 'map' here
     453 | static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
         |                                                       ^
   1 error generated.


vim +3854 drivers/hwmon/nct6775-core.c

  3444	
  3445	int nct6775_probe(struct device *dev, struct nct6775_data *data,
  3446			  const struct regmap_config *regmapcfg)
  3447	{
  3448		int i, s, err = 0;
  3449		int mask, available;
  3450		u16 src;
  3451		const u16 *reg_temp, *reg_temp_over, *reg_temp_hyst, *reg_temp_config;
  3452		const u16 *reg_temp_mon, *reg_temp_alternate, *reg_temp_crit;
  3453		const u16 *reg_temp_crit_l = NULL, *reg_temp_crit_h = NULL;
  3454		int num_reg_temp, num_reg_temp_mon, num_reg_tsi_temp;
  3455		struct device *hwmon_dev;
  3456		struct sensor_template_group tsi_temp_tg;
  3457	
  3458		data->regmap = devm_regmap_init(dev, NULL, data, regmapcfg);
  3459		if (IS_ERR(data->regmap))
  3460			return PTR_ERR(data->regmap);
  3461	
  3462		mutex_init(&data->update_lock);
  3463		data->name = nct6775_device_names[data->kind];
  3464		data->bank = 0xff;		/* Force initial bank selection */
  3465	
  3466		switch (data->kind) {
  3467		case nct6106:
  3468			data->in_num = 9;
  3469			data->pwm_num = 3;
  3470			data->auto_pwm_num = 4;
  3471			data->temp_fixed_num = 3;
  3472			data->num_temp_alarms = 6;
  3473			data->num_temp_beeps = 6;
  3474	
  3475			data->fan_from_reg = fan_from_reg13;
  3476			data->fan_from_reg_min = fan_from_reg13;
  3477	
  3478			data->temp_label = nct6776_temp_label;
  3479			data->temp_mask = NCT6776_TEMP_MASK;
  3480			data->virt_temp_mask = NCT6776_VIRT_TEMP_MASK;
  3481	
  3482			data->REG_VBAT = NCT6106_REG_VBAT;
  3483			data->REG_DIODE = NCT6106_REG_DIODE;
  3484			data->DIODE_MASK = NCT6106_DIODE_MASK;
  3485			data->REG_VIN = NCT6106_REG_IN;
  3486			data->REG_IN_MINMAX[0] = NCT6106_REG_IN_MIN;
  3487			data->REG_IN_MINMAX[1] = NCT6106_REG_IN_MAX;
  3488			data->REG_TARGET = NCT6106_REG_TARGET;
  3489			data->REG_FAN = NCT6106_REG_FAN;
  3490			data->REG_FAN_MODE = NCT6106_REG_FAN_MODE;
  3491			data->REG_FAN_MIN = NCT6106_REG_FAN_MIN;
  3492			data->REG_FAN_PULSES = NCT6106_REG_FAN_PULSES;
  3493			data->FAN_PULSE_SHIFT = NCT6106_FAN_PULSE_SHIFT;
  3494			data->REG_FAN_TIME[0] = NCT6106_REG_FAN_STOP_TIME;
  3495			data->REG_FAN_TIME[1] = NCT6106_REG_FAN_STEP_UP_TIME;
  3496			data->REG_FAN_TIME[2] = NCT6106_REG_FAN_STEP_DOWN_TIME;
  3497			data->REG_TOLERANCE_H = NCT6106_REG_TOLERANCE_H;
  3498			data->REG_PWM[0] = NCT6116_REG_PWM;
  3499			data->REG_PWM[1] = NCT6106_REG_FAN_START_OUTPUT;
  3500			data->REG_PWM[2] = NCT6106_REG_FAN_STOP_OUTPUT;
  3501			data->REG_PWM[5] = NCT6106_REG_WEIGHT_DUTY_STEP;
  3502			data->REG_PWM[6] = NCT6106_REG_WEIGHT_DUTY_BASE;
  3503			data->REG_PWM_READ = NCT6106_REG_PWM_READ;
  3504			data->REG_PWM_MODE = NCT6106_REG_PWM_MODE;
  3505			data->PWM_MODE_MASK = NCT6106_PWM_MODE_MASK;
  3506			data->REG_AUTO_TEMP = NCT6106_REG_AUTO_TEMP;
  3507			data->REG_AUTO_PWM = NCT6106_REG_AUTO_PWM;
  3508			data->REG_CRITICAL_TEMP = NCT6106_REG_CRITICAL_TEMP;
  3509			data->REG_CRITICAL_TEMP_TOLERANCE
  3510			  = NCT6106_REG_CRITICAL_TEMP_TOLERANCE;
  3511			data->REG_CRITICAL_PWM_ENABLE = NCT6106_REG_CRITICAL_PWM_ENABLE;
  3512			data->CRITICAL_PWM_ENABLE_MASK
  3513			  = NCT6106_CRITICAL_PWM_ENABLE_MASK;
  3514			data->REG_CRITICAL_PWM = NCT6106_REG_CRITICAL_PWM;
  3515			data->REG_TEMP_OFFSET = NCT6106_REG_TEMP_OFFSET;
  3516			data->REG_TEMP_SOURCE = NCT6106_REG_TEMP_SOURCE;
  3517			data->REG_TEMP_SEL = NCT6116_REG_TEMP_SEL;
  3518			data->REG_WEIGHT_TEMP_SEL = NCT6106_REG_WEIGHT_TEMP_SEL;
  3519			data->REG_WEIGHT_TEMP[0] = NCT6106_REG_WEIGHT_TEMP_STEP;
  3520			data->REG_WEIGHT_TEMP[1] = NCT6106_REG_WEIGHT_TEMP_STEP_TOL;
  3521			data->REG_WEIGHT_TEMP[2] = NCT6106_REG_WEIGHT_TEMP_BASE;
  3522			data->REG_ALARM = NCT6106_REG_ALARM;
  3523			data->ALARM_BITS = NCT6106_ALARM_BITS;
  3524			data->REG_BEEP = NCT6106_REG_BEEP;
  3525			data->BEEP_BITS = NCT6106_BEEP_BITS;
  3526			data->REG_TSI_TEMP = NCT6106_REG_TSI_TEMP;
  3527	
  3528			reg_temp = NCT6106_REG_TEMP;
  3529			reg_temp_mon = NCT6106_REG_TEMP_MON;
  3530			num_reg_temp = ARRAY_SIZE(NCT6106_REG_TEMP);
  3531			num_reg_temp_mon = ARRAY_SIZE(NCT6106_REG_TEMP_MON);
  3532			num_reg_tsi_temp = ARRAY_SIZE(NCT6106_REG_TSI_TEMP);
  3533			reg_temp_over = NCT6106_REG_TEMP_OVER;
  3534			reg_temp_hyst = NCT6106_REG_TEMP_HYST;
  3535			reg_temp_config = NCT6106_REG_TEMP_CONFIG;
  3536			reg_temp_alternate = NCT6106_REG_TEMP_ALTERNATE;
  3537			reg_temp_crit = NCT6106_REG_TEMP_CRIT;
  3538			reg_temp_crit_l = NCT6106_REG_TEMP_CRIT_L;
  3539			reg_temp_crit_h = NCT6106_REG_TEMP_CRIT_H;
  3540	
  3541			break;
  3542		case nct6116:
  3543			data->in_num = 9;
  3544			data->pwm_num = 3;
  3545			data->auto_pwm_num = 4;
  3546			data->temp_fixed_num = 3;
  3547			data->num_temp_alarms = 3;
  3548			data->num_temp_beeps = 3;
  3549	
  3550			data->fan_from_reg = fan_from_reg13;
  3551			data->fan_from_reg_min = fan_from_reg13;
  3552	
  3553			data->temp_label = nct6776_temp_label;
  3554			data->temp_mask = NCT6776_TEMP_MASK;
  3555			data->virt_temp_mask = NCT6776_VIRT_TEMP_MASK;
  3556	
  3557			data->REG_VBAT = NCT6106_REG_VBAT;
  3558			data->REG_DIODE = NCT6106_REG_DIODE;
  3559			data->DIODE_MASK = NCT6106_DIODE_MASK;
  3560			data->REG_VIN = NCT6106_REG_IN;
  3561			data->REG_IN_MINMAX[0] = NCT6106_REG_IN_MIN;
  3562			data->REG_IN_MINMAX[1] = NCT6106_REG_IN_MAX;
  3563			data->REG_TARGET = NCT6116_REG_TARGET;
  3564			data->REG_FAN = NCT6116_REG_FAN;
  3565			data->REG_FAN_MODE = NCT6116_REG_FAN_MODE;
  3566			data->REG_FAN_MIN = NCT6116_REG_FAN_MIN;
  3567			data->REG_FAN_PULSES = NCT6116_REG_FAN_PULSES;
  3568			data->FAN_PULSE_SHIFT = NCT6116_FAN_PULSE_SHIFT;
  3569			data->REG_FAN_TIME[0] = NCT6116_REG_FAN_STOP_TIME;
  3570			data->REG_FAN_TIME[1] = NCT6116_REG_FAN_STEP_UP_TIME;
  3571			data->REG_FAN_TIME[2] = NCT6116_REG_FAN_STEP_DOWN_TIME;
  3572			data->REG_TOLERANCE_H = NCT6116_REG_TOLERANCE_H;
  3573			data->REG_PWM[0] = NCT6116_REG_PWM;
  3574			data->REG_PWM[1] = NCT6116_REG_FAN_START_OUTPUT;
  3575			data->REG_PWM[2] = NCT6116_REG_FAN_STOP_OUTPUT;
  3576			data->REG_PWM[5] = NCT6106_REG_WEIGHT_DUTY_STEP;
  3577			data->REG_PWM[6] = NCT6106_REG_WEIGHT_DUTY_BASE;
  3578			data->REG_PWM_READ = NCT6106_REG_PWM_READ;
  3579			data->REG_PWM_MODE = NCT6106_REG_PWM_MODE;
  3580			data->PWM_MODE_MASK = NCT6106_PWM_MODE_MASK;
  3581			data->REG_AUTO_TEMP = NCT6116_REG_AUTO_TEMP;
  3582			data->REG_AUTO_PWM = NCT6116_REG_AUTO_PWM;
  3583			data->REG_CRITICAL_TEMP = NCT6116_REG_CRITICAL_TEMP;
  3584			data->REG_CRITICAL_TEMP_TOLERANCE
  3585			  = NCT6116_REG_CRITICAL_TEMP_TOLERANCE;
  3586			data->REG_CRITICAL_PWM_ENABLE = NCT6116_REG_CRITICAL_PWM_ENABLE;
  3587			data->CRITICAL_PWM_ENABLE_MASK
  3588			  = NCT6106_CRITICAL_PWM_ENABLE_MASK;
  3589			data->REG_CRITICAL_PWM = NCT6116_REG_CRITICAL_PWM;
  3590			data->REG_TEMP_OFFSET = NCT6106_REG_TEMP_OFFSET;
  3591			data->REG_TEMP_SOURCE = NCT6116_REG_TEMP_SOURCE;
  3592			data->REG_TEMP_SEL = NCT6116_REG_TEMP_SEL;
  3593			data->REG_WEIGHT_TEMP_SEL = NCT6106_REG_WEIGHT_TEMP_SEL;
  3594			data->REG_WEIGHT_TEMP[0] = NCT6106_REG_WEIGHT_TEMP_STEP;
  3595			data->REG_WEIGHT_TEMP[1] = NCT6106_REG_WEIGHT_TEMP_STEP_TOL;
  3596			data->REG_WEIGHT_TEMP[2] = NCT6106_REG_WEIGHT_TEMP_BASE;
  3597			data->REG_ALARM = NCT6106_REG_ALARM;
  3598			data->ALARM_BITS = NCT6116_ALARM_BITS;
  3599			data->REG_BEEP = NCT6106_REG_BEEP;
  3600			data->BEEP_BITS = NCT6116_BEEP_BITS;
  3601			data->REG_TSI_TEMP = NCT6116_REG_TSI_TEMP;
  3602	
  3603			reg_temp = NCT6106_REG_TEMP;
  3604			reg_temp_mon = NCT6106_REG_TEMP_MON;
  3605			num_reg_temp = ARRAY_SIZE(NCT6106_REG_TEMP);
  3606			num_reg_temp_mon = ARRAY_SIZE(NCT6106_REG_TEMP_MON);
  3607			num_reg_tsi_temp = ARRAY_SIZE(NCT6116_REG_TSI_TEMP);
  3608			reg_temp_over = NCT6106_REG_TEMP_OVER;
  3609			reg_temp_hyst = NCT6106_REG_TEMP_HYST;
  3610			reg_temp_config = NCT6106_REG_TEMP_CONFIG;
  3611			reg_temp_alternate = NCT6106_REG_TEMP_ALTERNATE;
  3612			reg_temp_crit = NCT6106_REG_TEMP_CRIT;
  3613			reg_temp_crit_l = NCT6106_REG_TEMP_CRIT_L;
  3614			reg_temp_crit_h = NCT6106_REG_TEMP_CRIT_H;
  3615	
  3616			break;
  3617		case nct6775:
  3618			data->in_num = 9;
  3619			data->pwm_num = 3;
  3620			data->auto_pwm_num = 6;
  3621			data->has_fan_div = true;
  3622			data->temp_fixed_num = 3;
  3623			data->num_temp_alarms = 3;
  3624			data->num_temp_beeps = 3;
  3625	
  3626			data->ALARM_BITS = NCT6775_ALARM_BITS;
  3627			data->BEEP_BITS = NCT6775_BEEP_BITS;
  3628	
  3629			data->fan_from_reg = fan_from_reg16;
  3630			data->fan_from_reg_min = fan_from_reg8;
  3631			data->target_temp_mask = 0x7f;
  3632			data->tolerance_mask = 0x0f;
  3633			data->speed_tolerance_limit = 15;
  3634	
  3635			data->temp_label = nct6775_temp_label;
  3636			data->temp_mask = NCT6775_TEMP_MASK;
  3637			data->virt_temp_mask = NCT6775_VIRT_TEMP_MASK;
  3638	
  3639			data->REG_CONFIG = NCT6775_REG_CONFIG;
  3640			data->REG_VBAT = NCT6775_REG_VBAT;
  3641			data->REG_DIODE = NCT6775_REG_DIODE;
  3642			data->DIODE_MASK = NCT6775_DIODE_MASK;
  3643			data->REG_VIN = NCT6775_REG_IN;
  3644			data->REG_IN_MINMAX[0] = NCT6775_REG_IN_MIN;
  3645			data->REG_IN_MINMAX[1] = NCT6775_REG_IN_MAX;
  3646			data->REG_TARGET = NCT6775_REG_TARGET;
  3647			data->REG_FAN = NCT6775_REG_FAN;
  3648			data->REG_FAN_MODE = NCT6775_REG_FAN_MODE;
  3649			data->REG_FAN_MIN = NCT6775_REG_FAN_MIN;
  3650			data->REG_FAN_PULSES = NCT6775_REG_FAN_PULSES;
  3651			data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
  3652			data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
  3653			data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_UP_TIME;
  3654			data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_DOWN_TIME;
  3655			data->REG_PWM[0] = NCT6775_REG_PWM;
  3656			data->REG_PWM[1] = NCT6775_REG_FAN_START_OUTPUT;
  3657			data->REG_PWM[2] = NCT6775_REG_FAN_STOP_OUTPUT;
  3658			data->REG_PWM[3] = NCT6775_REG_FAN_MAX_OUTPUT;
  3659			data->REG_PWM[4] = NCT6775_REG_FAN_STEP_OUTPUT;
  3660			data->REG_PWM[5] = NCT6775_REG_WEIGHT_DUTY_STEP;
  3661			data->REG_PWM_READ = NCT6775_REG_PWM_READ;
  3662			data->REG_PWM_MODE = NCT6775_REG_PWM_MODE;
  3663			data->PWM_MODE_MASK = NCT6775_PWM_MODE_MASK;
  3664			data->REG_AUTO_TEMP = NCT6775_REG_AUTO_TEMP;
  3665			data->REG_AUTO_PWM = NCT6775_REG_AUTO_PWM;
  3666			data->REG_CRITICAL_TEMP = NCT6775_REG_CRITICAL_TEMP;
  3667			data->REG_CRITICAL_TEMP_TOLERANCE
  3668			  = NCT6775_REG_CRITICAL_TEMP_TOLERANCE;
  3669			data->REG_TEMP_OFFSET = NCT6775_REG_TEMP_OFFSET;
  3670			data->REG_TEMP_SOURCE = NCT6775_REG_TEMP_SOURCE;
  3671			data->REG_TEMP_SEL = NCT6775_REG_TEMP_SEL;
  3672			data->REG_WEIGHT_TEMP_SEL = NCT6775_REG_WEIGHT_TEMP_SEL;
  3673			data->REG_WEIGHT_TEMP[0] = NCT6775_REG_WEIGHT_TEMP_STEP;
  3674			data->REG_WEIGHT_TEMP[1] = NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
  3675			data->REG_WEIGHT_TEMP[2] = NCT6775_REG_WEIGHT_TEMP_BASE;
  3676			data->REG_ALARM = NCT6775_REG_ALARM;
  3677			data->REG_BEEP = NCT6775_REG_BEEP;
  3678			data->REG_TSI_TEMP = NCT6775_REG_TSI_TEMP;
  3679	
  3680			reg_temp = NCT6775_REG_TEMP;
  3681			reg_temp_mon = NCT6775_REG_TEMP_MON;
  3682			num_reg_temp = ARRAY_SIZE(NCT6775_REG_TEMP);
  3683			num_reg_temp_mon = ARRAY_SIZE(NCT6775_REG_TEMP_MON);
  3684			num_reg_tsi_temp = ARRAY_SIZE(NCT6775_REG_TSI_TEMP);
  3685			reg_temp_over = NCT6775_REG_TEMP_OVER;
  3686			reg_temp_hyst = NCT6775_REG_TEMP_HYST;
  3687			reg_temp_config = NCT6775_REG_TEMP_CONFIG;
  3688			reg_temp_alternate = NCT6775_REG_TEMP_ALTERNATE;
  3689			reg_temp_crit = NCT6775_REG_TEMP_CRIT;
  3690	
  3691			break;
  3692		case nct6776:
  3693			data->in_num = 9;
  3694			data->pwm_num = 3;
  3695			data->auto_pwm_num = 4;
  3696			data->has_fan_div = false;
  3697			data->temp_fixed_num = 3;
  3698			data->num_temp_alarms = 3;
  3699			data->num_temp_beeps = 6;
  3700	
  3701			data->ALARM_BITS = NCT6776_ALARM_BITS;
  3702			data->BEEP_BITS = NCT6776_BEEP_BITS;
  3703	
  3704			data->fan_from_reg = fan_from_reg13;
  3705			data->fan_from_reg_min = fan_from_reg13;
  3706			data->target_temp_mask = 0xff;
  3707			data->tolerance_mask = 0x07;
  3708			data->speed_tolerance_limit = 63;
  3709	
  3710			data->temp_label = nct6776_temp_label;
  3711			data->temp_mask = NCT6776_TEMP_MASK;
  3712			data->virt_temp_mask = NCT6776_VIRT_TEMP_MASK;
  3713	
  3714			data->REG_CONFIG = NCT6775_REG_CONFIG;
  3715			data->REG_VBAT = NCT6775_REG_VBAT;
  3716			data->REG_DIODE = NCT6775_REG_DIODE;
  3717			data->DIODE_MASK = NCT6775_DIODE_MASK;
  3718			data->REG_VIN = NCT6775_REG_IN;
  3719			data->REG_IN_MINMAX[0] = NCT6775_REG_IN_MIN;
  3720			data->REG_IN_MINMAX[1] = NCT6775_REG_IN_MAX;
  3721			data->REG_TARGET = NCT6775_REG_TARGET;
  3722			data->REG_FAN = NCT6775_REG_FAN;
  3723			data->REG_FAN_MODE = NCT6775_REG_FAN_MODE;
  3724			data->REG_FAN_MIN = NCT6776_REG_FAN_MIN;
  3725			data->REG_FAN_PULSES = NCT6776_REG_FAN_PULSES;
  3726			data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
  3727			data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
  3728			data->REG_FAN_TIME[1] = NCT6776_REG_FAN_STEP_UP_TIME;
  3729			data->REG_FAN_TIME[2] = NCT6776_REG_FAN_STEP_DOWN_TIME;
  3730			data->REG_TOLERANCE_H = NCT6776_REG_TOLERANCE_H;
  3731			data->REG_PWM[0] = NCT6775_REG_PWM;
  3732			data->REG_PWM[1] = NCT6775_REG_FAN_START_OUTPUT;
  3733			data->REG_PWM[2] = NCT6775_REG_FAN_STOP_OUTPUT;
  3734			data->REG_PWM[5] = NCT6775_REG_WEIGHT_DUTY_STEP;
  3735			data->REG_PWM[6] = NCT6776_REG_WEIGHT_DUTY_BASE;
  3736			data->REG_PWM_READ = NCT6775_REG_PWM_READ;
  3737			data->REG_PWM_MODE = NCT6776_REG_PWM_MODE;
  3738			data->PWM_MODE_MASK = NCT6776_PWM_MODE_MASK;
  3739			data->REG_AUTO_TEMP = NCT6775_REG_AUTO_TEMP;
  3740			data->REG_AUTO_PWM = NCT6775_REG_AUTO_PWM;
  3741			data->REG_CRITICAL_TEMP = NCT6775_REG_CRITICAL_TEMP;
  3742			data->REG_CRITICAL_TEMP_TOLERANCE
  3743			  = NCT6775_REG_CRITICAL_TEMP_TOLERANCE;
  3744			data->REG_TEMP_OFFSET = NCT6775_REG_TEMP_OFFSET;
  3745			data->REG_TEMP_SOURCE = NCT6775_REG_TEMP_SOURCE;
  3746			data->REG_TEMP_SEL = NCT6775_REG_TEMP_SEL;
  3747			data->REG_WEIGHT_TEMP_SEL = NCT6775_REG_WEIGHT_TEMP_SEL;
  3748			data->REG_WEIGHT_TEMP[0] = NCT6775_REG_WEIGHT_TEMP_STEP;
  3749			data->REG_WEIGHT_TEMP[1] = NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
  3750			data->REG_WEIGHT_TEMP[2] = NCT6775_REG_WEIGHT_TEMP_BASE;
  3751			data->REG_ALARM = NCT6775_REG_ALARM;
  3752			data->REG_BEEP = NCT6776_REG_BEEP;
  3753			data->REG_TSI_TEMP = NCT6776_REG_TSI_TEMP;
  3754	
  3755			reg_temp = NCT6775_REG_TEMP;
  3756			reg_temp_mon = NCT6775_REG_TEMP_MON;
  3757			num_reg_temp = ARRAY_SIZE(NCT6775_REG_TEMP);
  3758			num_reg_temp_mon = ARRAY_SIZE(NCT6775_REG_TEMP_MON);
  3759			num_reg_tsi_temp = ARRAY_SIZE(NCT6776_REG_TSI_TEMP);
  3760			reg_temp_over = NCT6775_REG_TEMP_OVER;
  3761			reg_temp_hyst = NCT6775_REG_TEMP_HYST;
  3762			reg_temp_config = NCT6776_REG_TEMP_CONFIG;
  3763			reg_temp_alternate = NCT6776_REG_TEMP_ALTERNATE;
  3764			reg_temp_crit = NCT6776_REG_TEMP_CRIT;
  3765	
  3766			break;
  3767		case nct6779:
  3768			data->in_num = 15;
  3769			data->pwm_num = 5;
  3770			data->auto_pwm_num = 4;
  3771			data->has_fan_div = false;
  3772			data->temp_fixed_num = 6;
  3773			data->num_temp_alarms = 2;
  3774			data->num_temp_beeps = 2;
  3775	
  3776			data->ALARM_BITS = NCT6779_ALARM_BITS;
  3777			data->BEEP_BITS = NCT6779_BEEP_BITS;
  3778	
  3779			data->fan_from_reg = fan_from_reg_rpm;
  3780			data->fan_from_reg_min = fan_from_reg13;
  3781			data->target_temp_mask = 0xff;
  3782			data->tolerance_mask = 0x07;
  3783			data->speed_tolerance_limit = 63;
  3784	
  3785			data->temp_label = nct6779_temp_label;
  3786			data->temp_mask = NCT6779_TEMP_MASK;
  3787			data->virt_temp_mask = NCT6779_VIRT_TEMP_MASK;
  3788	
  3789			data->REG_CONFIG = NCT6775_REG_CONFIG;
  3790			data->REG_VBAT = NCT6775_REG_VBAT;
  3791			data->REG_DIODE = NCT6775_REG_DIODE;
  3792			data->DIODE_MASK = NCT6775_DIODE_MASK;
  3793			data->REG_VIN = NCT6779_REG_IN;
  3794			data->REG_IN_MINMAX[0] = NCT6775_REG_IN_MIN;
  3795			data->REG_IN_MINMAX[1] = NCT6775_REG_IN_MAX;
  3796			data->REG_TARGET = NCT6775_REG_TARGET;
  3797			data->REG_FAN = NCT6779_REG_FAN;
  3798			data->REG_FAN_MODE = NCT6775_REG_FAN_MODE;
  3799			data->REG_FAN_MIN = NCT6776_REG_FAN_MIN;
  3800			data->REG_FAN_PULSES = NCT6779_REG_FAN_PULSES;
  3801			data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
  3802			data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
  3803			data->REG_FAN_TIME[1] = NCT6776_REG_FAN_STEP_UP_TIME;
  3804			data->REG_FAN_TIME[2] = NCT6776_REG_FAN_STEP_DOWN_TIME;
  3805			data->REG_TOLERANCE_H = NCT6776_REG_TOLERANCE_H;
  3806			data->REG_PWM[0] = NCT6775_REG_PWM;
  3807			data->REG_PWM[1] = NCT6775_REG_FAN_START_OUTPUT;
  3808			data->REG_PWM[2] = NCT6775_REG_FAN_STOP_OUTPUT;
  3809			data->REG_PWM[5] = NCT6775_REG_WEIGHT_DUTY_STEP;
  3810			data->REG_PWM[6] = NCT6776_REG_WEIGHT_DUTY_BASE;
  3811			data->REG_PWM_READ = NCT6775_REG_PWM_READ;
  3812			data->REG_PWM_MODE = NCT6776_REG_PWM_MODE;
  3813			data->PWM_MODE_MASK = NCT6776_PWM_MODE_MASK;
  3814			data->REG_AUTO_TEMP = NCT6775_REG_AUTO_TEMP;
  3815			data->REG_AUTO_PWM = NCT6775_REG_AUTO_PWM;
  3816			data->REG_CRITICAL_TEMP = NCT6775_REG_CRITICAL_TEMP;
  3817			data->REG_CRITICAL_TEMP_TOLERANCE
  3818			  = NCT6775_REG_CRITICAL_TEMP_TOLERANCE;
  3819			data->REG_CRITICAL_PWM_ENABLE = NCT6779_REG_CRITICAL_PWM_ENABLE;
  3820			data->CRITICAL_PWM_ENABLE_MASK
  3821			  = NCT6779_CRITICAL_PWM_ENABLE_MASK;
  3822			data->REG_CRITICAL_PWM = NCT6779_REG_CRITICAL_PWM;
  3823			data->REG_TEMP_OFFSET = NCT6779_REG_TEMP_OFFSET;
  3824			data->REG_TEMP_SOURCE = NCT6775_REG_TEMP_SOURCE;
  3825			data->REG_TEMP_SEL = NCT6775_REG_TEMP_SEL;
  3826			data->REG_WEIGHT_TEMP_SEL = NCT6775_REG_WEIGHT_TEMP_SEL;
  3827			data->REG_WEIGHT_TEMP[0] = NCT6775_REG_WEIGHT_TEMP_STEP;
  3828			data->REG_WEIGHT_TEMP[1] = NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
  3829			data->REG_WEIGHT_TEMP[2] = NCT6775_REG_WEIGHT_TEMP_BASE;
  3830			data->REG_ALARM = NCT6779_REG_ALARM;
  3831			data->REG_BEEP = NCT6776_REG_BEEP;
  3832			data->REG_TSI_TEMP = NCT6776_REG_TSI_TEMP;
  3833	
  3834			reg_temp = NCT6779_REG_TEMP;
  3835			reg_temp_mon = NCT6779_REG_TEMP_MON;
  3836			num_reg_temp = ARRAY_SIZE(NCT6779_REG_TEMP);
  3837			num_reg_temp_mon = ARRAY_SIZE(NCT6779_REG_TEMP_MON);
  3838			num_reg_tsi_temp = ARRAY_SIZE(NCT6776_REG_TSI_TEMP);
  3839			reg_temp_over = NCT6779_REG_TEMP_OVER;
  3840			reg_temp_hyst = NCT6779_REG_TEMP_HYST;
  3841			reg_temp_config = NCT6779_REG_TEMP_CONFIG;
  3842			reg_temp_alternate = NCT6779_REG_TEMP_ALTERNATE;
  3843			reg_temp_crit = NCT6779_REG_TEMP_CRIT;
  3844	
  3845			break;
  3846		case nct6791:
  3847		case nct6792:
  3848		case nct6793:
  3849		case nct6795:
  3850		case nct6796:
  3851		case nct6797:
  3852		case nct6798:
  3853		case nct6799:
> 3854			bitmap_set(data->have_in, 0, 15);
  3855			data->pwm_num = (data->kind == nct6796 ||
  3856					 data->kind == nct6797 ||
  3857					 data->kind == nct6798 ||
  3858					 data->kind == nct6799) ? 7 : 6;
  3859			data->auto_pwm_num = 4;
  3860			data->has_fan_div = false;
  3861			data->temp_fixed_num = 6;
  3862			data->num_temp_alarms = 2;
  3863			data->num_temp_beeps = 2;
  3864	
  3865			data->ALARM_BITS = NCT6791_ALARM_BITS;
  3866			data->BEEP_BITS = NCT6779_BEEP_BITS;
  3867	
  3868			data->fan_from_reg = fan_from_reg_rpm;
  3869			data->fan_from_reg_min = fan_from_reg13;
  3870			data->target_temp_mask = 0xff;
  3871			data->tolerance_mask = 0x07;
  3872			data->speed_tolerance_limit = 63;
  3873	
  3874			switch (data->kind) {
  3875			default:
  3876			case nct6791:
  3877				data->temp_label = nct6779_temp_label;
  3878				data->temp_mask = NCT6791_TEMP_MASK;
  3879				data->virt_temp_mask = NCT6791_VIRT_TEMP_MASK;
  3880				break;
  3881			case nct6792:
  3882				data->temp_label = nct6792_temp_label;
  3883				data->temp_mask = NCT6792_TEMP_MASK;
  3884				data->virt_temp_mask = NCT6792_VIRT_TEMP_MASK;
  3885				break;
  3886			case nct6793:
  3887				data->temp_label = nct6793_temp_label;
  3888				data->temp_mask = NCT6793_TEMP_MASK;
  3889				data->virt_temp_mask = NCT6793_VIRT_TEMP_MASK;
  3890				break;
  3891			case nct6795:
  3892			case nct6797:
  3893				data->temp_label = nct6795_temp_label;
  3894				data->temp_mask = NCT6795_TEMP_MASK;
  3895				data->virt_temp_mask = NCT6795_VIRT_TEMP_MASK;
  3896				break;
  3897			case nct6796:
  3898				data->temp_label = nct6796_temp_label;
  3899				data->temp_mask = NCT6796_TEMP_MASK;
  3900				data->virt_temp_mask = NCT6796_VIRT_TEMP_MASK;
  3901				break;
  3902			case nct6798:
  3903				data->temp_label = nct6798_temp_label;
  3904				data->temp_mask = NCT6798_TEMP_MASK;
  3905				data->virt_temp_mask = NCT6798_VIRT_TEMP_MASK;
  3906				break;
  3907			case nct6799:
  3908				data->temp_label = nct6799_temp_label;
  3909				data->temp_mask = NCT6799_TEMP_MASK;
  3910				data->virt_temp_mask = NCT6799_VIRT_TEMP_MASK;
  3911				break;
  3912			}
  3913	
  3914			data->REG_CONFIG = NCT6775_REG_CONFIG;
  3915			data->REG_VBAT = NCT6775_REG_VBAT;
  3916			data->REG_DIODE = NCT6775_REG_DIODE;
  3917			data->DIODE_MASK = NCT6775_DIODE_MASK;
  3918			data->REG_VIN = NCT6779_REG_IN;
  3919			data->REG_IN_MINMAX[0] = NCT6775_REG_IN_MIN;
  3920			data->REG_IN_MINMAX[1] = NCT6775_REG_IN_MAX;
  3921			data->REG_TARGET = NCT6775_REG_TARGET;
  3922			data->REG_FAN = NCT6779_REG_FAN;
  3923			data->REG_FAN_MODE = NCT6775_REG_FAN_MODE;
  3924			data->REG_FAN_MIN = NCT6776_REG_FAN_MIN;
  3925			data->REG_FAN_PULSES = NCT6779_REG_FAN_PULSES;
  3926			data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
  3927			data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
  3928			data->REG_FAN_TIME[1] = NCT6776_REG_FAN_STEP_UP_TIME;
  3929			data->REG_FAN_TIME[2] = NCT6776_REG_FAN_STEP_DOWN_TIME;
  3930			data->REG_TOLERANCE_H = NCT6776_REG_TOLERANCE_H;
  3931			data->REG_PWM[0] = NCT6775_REG_PWM;
  3932			data->REG_PWM[1] = NCT6775_REG_FAN_START_OUTPUT;
  3933			data->REG_PWM[2] = NCT6775_REG_FAN_STOP_OUTPUT;
  3934			data->REG_PWM[5] = NCT6791_REG_WEIGHT_DUTY_STEP;
  3935			data->REG_PWM[6] = NCT6791_REG_WEIGHT_DUTY_BASE;
  3936			data->REG_PWM_READ = NCT6775_REG_PWM_READ;
  3937			data->REG_PWM_MODE = NCT6776_REG_PWM_MODE;
  3938			data->PWM_MODE_MASK = NCT6776_PWM_MODE_MASK;
  3939			data->REG_AUTO_TEMP = NCT6775_REG_AUTO_TEMP;
  3940			data->REG_AUTO_PWM = NCT6775_REG_AUTO_PWM;
  3941			data->REG_CRITICAL_TEMP = NCT6775_REG_CRITICAL_TEMP;
  3942			data->REG_CRITICAL_TEMP_TOLERANCE
  3943			  = NCT6775_REG_CRITICAL_TEMP_TOLERANCE;
  3944			data->REG_CRITICAL_PWM_ENABLE = NCT6779_REG_CRITICAL_PWM_ENABLE;
  3945			data->CRITICAL_PWM_ENABLE_MASK
  3946			  = NCT6779_CRITICAL_PWM_ENABLE_MASK;
  3947			data->REG_CRITICAL_PWM = NCT6779_REG_CRITICAL_PWM;
  3948			data->REG_TEMP_OFFSET = NCT6779_REG_TEMP_OFFSET;
  3949			data->REG_TEMP_SOURCE = NCT6775_REG_TEMP_SOURCE;
  3950			data->REG_TEMP_SEL = NCT6775_REG_TEMP_SEL;
  3951			data->REG_WEIGHT_TEMP_SEL = NCT6791_REG_WEIGHT_TEMP_SEL;
  3952			data->REG_WEIGHT_TEMP[0] = NCT6791_REG_WEIGHT_TEMP_STEP;
  3953			data->REG_WEIGHT_TEMP[1] = NCT6791_REG_WEIGHT_TEMP_STEP_TOL;
  3954			data->REG_WEIGHT_TEMP[2] = NCT6791_REG_WEIGHT_TEMP_BASE;
  3955			data->REG_ALARM = NCT6791_REG_ALARM;
  3956			if (data->kind == nct6791)
  3957				data->REG_BEEP = NCT6776_REG_BEEP;
  3958			else
  3959				data->REG_BEEP = NCT6792_REG_BEEP;
  3960			switch (data->kind) {
  3961			case nct6791:
  3962			case nct6792:
  3963			case nct6793:
  3964				data->REG_TSI_TEMP = NCT6776_REG_TSI_TEMP;
  3965				num_reg_tsi_temp = ARRAY_SIZE(NCT6776_REG_TSI_TEMP);
  3966				break;
  3967			case nct6795:
  3968			case nct6796:
  3969			case nct6797:
  3970			case nct6798:
  3971			case nct6799:
  3972				data->REG_TSI_TEMP = NCT6796_REG_TSI_TEMP;
  3973				num_reg_tsi_temp = ARRAY_SIZE(NCT6796_REG_TSI_TEMP);
  3974				break;
  3975			default:
  3976				num_reg_tsi_temp = 0;
  3977				break;
  3978			}
  3979	
  3980			reg_temp = NCT6779_REG_TEMP;
  3981			num_reg_temp = ARRAY_SIZE(NCT6779_REG_TEMP);
  3982			if (data->kind == nct6791) {
  3983				reg_temp_mon = NCT6779_REG_TEMP_MON;
  3984				num_reg_temp_mon = ARRAY_SIZE(NCT6779_REG_TEMP_MON);
  3985			} else {
  3986				reg_temp_mon = NCT6792_REG_TEMP_MON;
  3987				num_reg_temp_mon = ARRAY_SIZE(NCT6792_REG_TEMP_MON);
  3988			}
  3989			reg_temp_over = NCT6779_REG_TEMP_OVER;
  3990			reg_temp_hyst = NCT6779_REG_TEMP_HYST;
  3991			reg_temp_config = NCT6779_REG_TEMP_CONFIG;
  3992			reg_temp_alternate = NCT6779_REG_TEMP_ALTERNATE;
  3993			reg_temp_crit = NCT6779_REG_TEMP_CRIT;
  3994	
  3995			break;
  3996		default:
  3997			return -ENODEV;
  3998		}
  3999		data->have_in = BIT(data->in_num) - 1;
  4000		data->have_temp = 0;
  4001	
  4002		/*
  4003		 * On some boards, not all available temperature sources are monitored,
  4004		 * even though some of the monitoring registers are unused.
  4005		 * Get list of unused monitoring registers, then detect if any fan
  4006		 * controls are configured to use unmonitored temperature sources.
  4007		 * If so, assign the unmonitored temperature sources to available
  4008		 * monitoring registers.
  4009		 */
  4010		mask = 0;
  4011		available = 0;
  4012		for (i = 0; i < num_reg_temp; i++) {
  4013			if (reg_temp[i] == 0)
  4014				continue;
  4015	
  4016			err = nct6775_read_value(data, data->REG_TEMP_SOURCE[i], &src);
  4017			if (err)
  4018				return err;
  4019			src &= 0x1f;
  4020			if (!src || (mask & BIT(src)))
  4021				available |= BIT(i);
  4022	
  4023			mask |= BIT(src);
  4024		}
  4025	
  4026		/*
  4027		 * Now find unmonitored temperature registers and enable monitoring
  4028		 * if additional monitoring registers are available.
  4029		 */
  4030		err = add_temp_sensors(data, data->REG_TEMP_SEL, &available, &mask);
  4031		if (err)
  4032			return err;
  4033		err = add_temp_sensors(data, data->REG_WEIGHT_TEMP_SEL, &available, &mask);
  4034		if (err)
  4035			return err;
  4036	
  4037		mask = 0;
  4038		s = NUM_TEMP_FIXED;	/* First dynamic temperature attribute */
  4039		for (i = 0; i < num_reg_temp; i++) {
  4040			if (reg_temp[i] == 0)
  4041				continue;
  4042	
  4043			err = nct6775_read_value(data, data->REG_TEMP_SOURCE[i], &src);
  4044			if (err)
  4045				return err;
  4046			src &= 0x1f;
  4047			if (!src || (mask & BIT(src)))
  4048				continue;
  4049	
  4050			if (!(data->temp_mask & BIT(src))) {
  4051				dev_info(dev,
  4052					 "Invalid temperature source %d at index %d, source register 0x%x, temp register 0x%x\n",
  4053					 src, i, data->REG_TEMP_SOURCE[i], reg_temp[i]);
  4054				continue;
  4055			}
  4056	
  4057			mask |= BIT(src);
  4058	
  4059			/* Use fixed index for SYSTIN(1), CPUTIN(2), AUXTIN(3) */
  4060			if (src <= data->temp_fixed_num) {
  4061				data->have_temp |= BIT(src - 1);
  4062				data->have_temp_fixed |= BIT(src - 1);
  4063				data->reg_temp[0][src - 1] = reg_temp[i];
  4064				data->reg_temp[1][src - 1] = reg_temp_over[i];
  4065				data->reg_temp[2][src - 1] = reg_temp_hyst[i];
  4066				if (reg_temp_crit_h && reg_temp_crit_h[i])
  4067					data->reg_temp[3][src - 1] = reg_temp_crit_h[i];
  4068				else if (reg_temp_crit[src - 1])
  4069					data->reg_temp[3][src - 1]
  4070					  = reg_temp_crit[src - 1];
  4071				if (reg_temp_crit_l && reg_temp_crit_l[i])
  4072					data->reg_temp[4][src - 1] = reg_temp_crit_l[i];
  4073				data->reg_temp_config[src - 1] = reg_temp_config[i];
  4074				data->temp_src[src - 1] = src;
  4075				continue;
  4076			}
  4077	
  4078			if (s >= NUM_TEMP)
  4079				continue;
  4080	
  4081			/* Use dynamic index for other sources */
  4082			data->have_temp |= BIT(s);
  4083			data->reg_temp[0][s] = reg_temp[i];
  4084			data->reg_temp[1][s] = reg_temp_over[i];
  4085			data->reg_temp[2][s] = reg_temp_hyst[i];
  4086			data->reg_temp_config[s] = reg_temp_config[i];
  4087			if (reg_temp_crit_h && reg_temp_crit_h[i])
  4088				data->reg_temp[3][s] = reg_temp_crit_h[i];
  4089			else if (reg_temp_crit[src - 1])
  4090				data->reg_temp[3][s] = reg_temp_crit[src - 1];
  4091			if (reg_temp_crit_l && reg_temp_crit_l[i])
  4092				data->reg_temp[4][s] = reg_temp_crit_l[i];
  4093	
  4094			data->temp_src[s] = src;
  4095			s++;
  4096		}
  4097	
  4098		/*
  4099		 * Repeat with temperatures used for fan control.
  4100		 * This set of registers does not support limits.
  4101		 */
  4102		for (i = 0; i < num_reg_temp_mon; i++) {
  4103			if (reg_temp_mon[i] == 0)
  4104				continue;
  4105	
  4106			err = nct6775_read_value(data, data->REG_TEMP_SEL[i], &src);
  4107			if (err)
  4108				return err;
  4109			src &= 0x1f;
  4110			if (!src)
  4111				continue;
  4112	
  4113			if (!(data->temp_mask & BIT(src))) {
  4114				dev_info(dev,
  4115					 "Invalid temperature source %d at index %d, source register 0x%x, temp register 0x%x\n",
  4116					 src, i, data->REG_TEMP_SEL[i],
  4117					 reg_temp_mon[i]);
  4118				continue;
  4119			}
  4120	
  4121			/*
  4122			 * For virtual temperature sources, the 'virtual' temperature
  4123			 * for each fan reflects a different temperature, and there
  4124			 * are no duplicates.
  4125			 */
  4126			if (!(data->virt_temp_mask & BIT(src))) {
  4127				if (mask & BIT(src))
  4128					continue;
  4129				mask |= BIT(src);
  4130			}
  4131	
  4132			/* Use fixed index for SYSTIN(1), CPUTIN(2), AUXTIN(3) */
  4133			if (src <= data->temp_fixed_num) {
  4134				if (data->have_temp & BIT(src - 1))
  4135					continue;
  4136				data->have_temp |= BIT(src - 1);
  4137				data->have_temp_fixed |= BIT(src - 1);
  4138				data->reg_temp[0][src - 1] = reg_temp_mon[i];
  4139				data->temp_src[src - 1] = src;
  4140				continue;
  4141			}
  4142	
  4143			if (s >= NUM_TEMP)
  4144				continue;
  4145	
  4146			/* Use dynamic index for other sources */
  4147			data->have_temp |= BIT(s);
  4148			data->reg_temp[0][s] = reg_temp_mon[i];
  4149			data->temp_src[s] = src;
  4150			s++;
  4151		}
  4152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
