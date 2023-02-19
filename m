Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD469C1F5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 19:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjBSSiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 13:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjBSSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 13:38:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29768BDE6;
        Sun, 19 Feb 2023 10:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:Subject:Cc:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Z4sHEtYwmB+05SPntW4cUksZ5pR/+iUuongj1UotVXU=; b=Oa0DRbSRWD9RCCf8ksPqEk3deS
        kfGvoifqiN5BsztSgTprF9cv6UTQ+/Xxg4a8OlkBlqAGGJa83vvcuADrL1t6LBdP52oUm1/hguQO6
        B0XInu1fUnPUgOqpvhOcnV8wb6DFwwxlG+f2YeWJFutbapTZa807Sl+qO+Se8/NCEsVg4Mx/h0DBQ
        XLrcuGmUiIuX9YHg3NvykhZttbx6hl+4Zb2Cmc2YcPRJsn8p3SbRsnM2udPqOLffpSwjmhrk15FKZ
        Gb+Dd6M0hvSAjBrbwTlpRTi9C6ghfzDjKr3Eh0DQ3/u604sXDUVfuXDmscW0Pkofoe4BmySy0ESv9
        RW9eaSkQ==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pToZf-0027ns-UV; Sun, 19 Feb 2023 18:38:12 +0000
Message-ID: <0ddf5cc8-8f16-ba7e-7587-3fa37b2a82b8@infradead.org>
Date:   Sun, 19 Feb 2023 10:38:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: build warning in power: supply: Qualcomm PMIC GLINK power supply
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

FYI: (seen in passing, I wasn't looking for this.)

When doing compile tests on MIPS (32-bit):

In file included from ../arch/mips/include/asm/div64.h:89,
                 from ../include/linux/math.h:6,
                 from ../include/linux/math64.h:6,
                 from ../include/linux/time64.h:5,
                 from ../include/linux/restart_block.h:10,
                 from ../include/linux/thread_info.h:14,
                 from ../include/asm-generic/current.h:5,
                 from ./arch/mips/include/generated/asm/current.h:1,
                 from ../include/linux/sched.h:12,
                 from ../include/linux/ratelimit.h:6,
                 from ../include/linux/dev_printk.h:16,
                 from ../include/linux/device.h:15,
                 from ../include/linux/auxiliary_bus.h:11,
                 from ../drivers/power/supply/qcom_battmgr.c:6:
../drivers/power/supply/qcom_battmgr.c: In function 'qcom_battmgr_sm8350_callback':
../include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast
  222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
      |                                   ^~
../drivers/power/supply/qcom_battmgr.c:1130:25: note: in expansion of macro 'do_div'
 1130 |                         do_div(battmgr->status.percent, 100);
      |                         ^~~~~~
In file included from ../include/linux/dev_printk.h:14:
../include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
  234 |         } else if (likely(((n) >> 32) == 0)) {          \
      |                                ^~
../include/linux/compiler.h:77:45: note: in definition of macro 'likely'
   77 | # define likely(x)      __builtin_expect(!!(x), 1)
      |                                             ^
../drivers/power/supply/qcom_battmgr.c:1130:25: note: in expansion of macro 'do_div'
 1130 |                         do_div(battmgr->status.percent, 100);
      |                         ^~~~~~


The first argument must be 64-bit. qcom_battmgr_status.percent is 'unsigned int',
which is not 64-bit (AFAIK; and according to LDD3).

-- 
~Randy
