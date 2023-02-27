Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62A6A4930
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjB0SGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjB0SGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:06:42 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F82385D;
        Mon, 27 Feb 2023 10:06:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f18so9722324lfa.3;
        Mon, 27 Feb 2023 10:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqXiBQXvXH+tElXzgaTKSkwKZs1Zusa9JO9iVkTj7A0=;
        b=iy+0fhbHz6snA10bci0QtKJt88K/3Lw7c2jTc7+6u1oEW66HHQJR6saRkRG4ngQbeK
         mMll76DaahOTkOtmvsgo0LTOlLFQvAAXyU2X+naTl0QDADMcCz6yBOjePB7vScArCHCV
         cIKHQ2CXob2AHDZ1X/a/why/vwAkdaf/CvZ+FnfZPjt8pf06XXfTZUFBdYWVpb3251NU
         noJwpSz8TZkmgSC0vChAf5xNQWjP10DHdvpJpFkcjOI0GpaL+JUmcm7sYE570O9QktTE
         AtjDixJ0hxArDsyWeaOHgeh53tX+rH2PmQbHYgceqaOgQbuqpt1Vumss6UrUHvK+0x+W
         plSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqXiBQXvXH+tElXzgaTKSkwKZs1Zusa9JO9iVkTj7A0=;
        b=OeNLp5oAu0vQrSxV2u1cfgpmDNsKEWQLFf9HpFbuzJiocBuy9a90M9v4+MuUEtkZYj
         VfQMaX+XXaJHayJDfyvh1/KovC2jfm2s2WPbFBfPqhq95UxklitZ4kkCopWw6lv4weu8
         nLtTT84i52tDO4onwnqtYAJm8NDemqwTdHIvYGdyiDEUCBwD3jtPiWUd9ZOJwawLiqhl
         ahgwT76FUAecCuXwfbj02cFCI3Z78BVwMgSNx78cuL4iMj0AH0IBgekJgEQF0nTzqCAl
         v4LWVHqkTpIJ8VxP33NuvtFWzGkfpB2NJdVPxpWGAU+CPN3ZKebLuBvHAAsT05Uexfk3
         yTIQ==
X-Gm-Message-State: AO0yUKWyrIChVQrK8lwBmggWrqQFLVBhYw28FVPq94RmsbhE5e9gbQDn
        1oOxFy5IRJi8sLht8ylH2fI=
X-Google-Smtp-Source: AK7set+mfTLrmu9GZtWHsgxdDFJz1H3Z7GZiePM0rFjZ200NmwtXLNwsJqcyvq18l5VAb6NvGLkhHQ==
X-Received: by 2002:a05:6512:3b9a:b0:4dd:9931:c560 with SMTP id g26-20020a0565123b9a00b004dd9931c560mr3144983lfv.15.1677521169479;
        Mon, 27 Feb 2023 10:06:09 -0800 (PST)
Received: from pc636 (host-90-235-25-56.mobileonline.telia.com. [90.235.25.56])
        by smtp.gmail.com with ESMTPSA id v1-20020a2e7a01000000b00295a318ace7sm810530ljc.77.2023.02.27.10.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:06:08 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 27 Feb 2023 19:06:06 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/zxDuxsihJXTdxf@pc636>
References: <IA1PR11MB617175CA398D425B7489CE4889AF9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <764CA486-6FB2-4667-B8CB-56E3AC31FD58@joelfernandes.org>
 <20230227145544.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSVm7fjJaX=AT-Yg70wXL-_1RxoVPfzN8M8zJAkc0um3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSVm7fjJaX=AT-Yg70wXL-_1RxoVPfzN8M8zJAkc0um3g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 10:16:51AM -0500, Joel Fernandes wrote:
> On Mon, Feb 27, 2023 at 9:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Feb 27, 2023 at 08:22:06AM -0500, Joel Fernandes wrote:
> > >
> > >
> > > > On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
> > > >
> > > > ﻿
> > > >>
> > > >> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >> Sent: Saturday, February 25, 2023 11:34 AM
> > > >> To: linux-kernel@vger.kernel.org
> > > >> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic Weisbecker
> > > >> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>; linux-
> > > >> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
> > > >> rcu@vger.kernel.org
> > > >> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
> > > >> completed
> > > >>
> > > >> On many systems, a great deal of boot happens after the kernel thinks the
> > > >> boot has completed. It is difficult to determine if the system has really
> > > >> booted from the kernel side. Some features like lazy-RCU can risk slowing
> > > >> down boot time if, say, a callback has been added that the boot
> > > >> synchronously depends on.
> > > >>
> > > >> Further, it is better to boot systems which pass 'rcu_normal_after_boot' to
> > > >> stay expedited for as long as the system is still booting.
> > > >>
> > > >> For these reasons, this commit adds a config option
> > > >> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
> > > >> rcupdate.boot_end_delay.
> > > >>
> > > >> By default, this value is 20s. A system designer can choose to specify a value
> > > >> here to keep RCU from marking boot completion.  The boot sequence will not
> > > >> be marked ended until at least boot_end_delay milliseconds have passed.
> > > >
> > > > Hi Joel,
> > > >
> > > > Just some thoughts on the default value of 20s, correct me if I'm wrong :-).
> > > >
> > > > Does the OS with CONFIG_PREEMPT_RT=y kernel concern more about the
> > > > real-time latency than the overall OS boot time?
> > >
> > > But every system has to boot, even an RT system.
> > >
> > > >
> > > > If so, we might make rcupdate.boot_end_delay = 0 as the default value
> > > > (NOT the default 20s) for CONFIG_PREEMPT_RT=y kernels?
> > >
> > > Could you measure how much time your RT system takes to boot before the application runs?
> > >
> > > I can change it to default 0 essentially NOOPing it, but I would rather have a saner default (10 seconds even), than having someone forget to tune this for their system.
> >
> > Provide a /sys location that the userspace code writes to when it
> > is ready?  Different systems with different hardware and software
> > configurations are going to take different amounts of time to boot,
> > correct?
> 
> I could add a sysfs node, but I still wanted this patch as well
> because I am wary of systems where yet more userspace changes are
> required. I feel the kernel should itself be able to do this. Yes, it
> is possible the system completes "booting" at a different time than
> what the kernel thinks. But it does that anyway (even without this
> patch), so I am not seeing a good reason to not do this in the kernel.
> It is also only a minimum cap, so if the in-kernel boot takes too
> long, then the patch will have no effect.
> 
> Thoughts?
> 
Why "rcu_boot_ended" is not enough? As i see right after that an "init"
process or shell or panic is going to be invoked by the kernel. It basically
indicates that a kernel is fully functional.

Or an idea to wait even further? Until all kernel modules are loaded by
user space.

Thanks!

--
Uladzislau Rezki
