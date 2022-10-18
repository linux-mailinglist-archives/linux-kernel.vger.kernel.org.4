Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B716020FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJRCMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJRCMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:12:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFABDED7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:11:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g27so18490994edf.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DR8hRkwA5AHSr93eWnm+mbNvWthEwcd3tUUpP30+XjU=;
        b=vPFiv2pSZYqXK7zlUUAUlTIy5gRtzCU6KQVTMIRYUEhR+Os1YRvZQTfLeRwsQS63xz
         mOOay++6Jx6LcU6OineY3OJi5WPeEbw/pGsTFyFE9ThEL1prf9zstgHJzE2yaK7Tsjta
         aFlzkm1midhSCm23mSAbLloSuqVrtIz2kItawHR1amF8T6YAXV25CriHhMD1ivhBJkOk
         s6nM9/64zGgd9n65ck7iK8DYx2RFFNU+ODv0yPGgAFcmjxo8jfzReMZriXgH1j0JwuMV
         e6qc3wBHWKiUDSLh340daMMTC3jXcSSsWDeihqn6+G4H9PWh1tess/x4MgHvQMsEiv65
         5kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DR8hRkwA5AHSr93eWnm+mbNvWthEwcd3tUUpP30+XjU=;
        b=xXJkcFFtoDd27GvQjyqVbGJy1NQgbi+j+LTVEiOG/o4fpCseAmVys/lrmH7Kgzo9zJ
         qHEX8lKVLdZTWvKlA9MF5US3MXXhuZjqVqLdgI38YYLZkxVDFKTzsPvhV3zE6S1FfiVg
         PTq+oz8TxLCYjPrrANHULGvzJ8SWiSS8BS8MqX6Rs731m0dLvQ5EgasX1JfnRotXlzo8
         wMOUd1ZsI7xC21sAM/KVrYyjcSHedmLzSbsGe4IiOfNei55YVBs6xEy+uMSlX4eX26ab
         snZgG4z0qjLmw9Y7r00JNaX82z8lIfL4AjgLKewsH5EMkXF28oEMXYUtPZWVYbAIio4U
         a1EQ==
X-Gm-Message-State: ACrzQf3kG6GahkNmLBMShBMssnGkDolVWPBVYCI61RebFN2A3TFuo1Ub
        rqFsDONx84ivOjJ+EXKhUePoTqpQ9u53UmpJR0Iypw==
X-Google-Smtp-Source: AMsMyM6nNjPP5x1mR6UreoCEUeDuD3+sm4OPQ+qse36C0LTDFSUCZ26xYBzGTwr0I1q+TwI92sXwAjKQVMNAzujYHPw=
X-Received: by 2002:a05:6402:354d:b0:45c:b772:5ef4 with SMTP id
 f13-20020a056402354d00b0045cb7725ef4mr522114edd.225.1666059093228; Mon, 17
 Oct 2022 19:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221016095815.2550034-3-shawn.guo@linaro.org> <202210172205.YWukV2qP-lkp@intel.com>
In-Reply-To: <202210172205.YWukV2qP-lkp@intel.com>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Tue, 18 Oct 2022 10:11:21 +0800
Message-ID: <CAAQ0ZWQ-KV81HdjODQu1kDrKhxyn-VU=US4aqYV-nxxSjVAmOA@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM: domains: Consolidate genpd_restore_noirq() and genpd_resume_noirq()
To:     kernel test robot <lkp@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, kbuild-all@lists.01.org,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:50 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Shawn,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on rafael-pm/linux-next]
> [also build test WARNING on linus/master v6.1-rc1 next-20221017]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Guo/Manage-domain-power-state-for-hibernate-freeze/20221017-114450
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link:    https://lore.kernel.org/r/20221016095815.2550034-3-shawn.guo%40linaro.org
> patch subject: [PATCH 2/3] PM: domains: Consolidate genpd_restore_noirq() and genpd_resume_noirq()
> config: xtensa-randconfig-r032-20221017
> compiler: xtensa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/07af89f71f5cf3e02a29c7da292968404e8ae5be
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Shawn-Guo/Manage-domain-power-state-for-hibernate-freeze/20221017-114450
>         git checkout 07af89f71f5cf3e02a29c7da292968404e8ae5be
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/base/power/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/base/power/domain.c:1258: warning: expecting prototype for genpd_resume_noirq(). Prototype was for genpd_finish_resume() instead

It will be fixed in the next version.

Shawn
