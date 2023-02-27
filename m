Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CFF6A497F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjB0SUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjB0SUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:20:50 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8601024483;
        Mon, 27 Feb 2023 10:20:48 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s20so9717749lfb.11;
        Mon, 27 Feb 2023 10:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiS2lMaRysm5LXBYQP/NQhSFBV0vHLNWfoUGY+iNjEY=;
        b=fHCCa3fgWAnQaogxBjTOJFx/iI2K5GfIigYv2zqP3SUqtXgJLKobuTaqjKYQFQgEdh
         3Z1+1+oI+fE9JNZBKC9Yphr5xERZX0MospTrMdzOndh3w1GIl0OKeAZx1/egln06csf2
         tavcM/r6S3ZhE6vnfTUO5ho8/Jrtd3eRgUREHC4fbVxWqjS5Ug3+keEfTDl2PNxxY4mQ
         ENLd6/deZ5RBGvDZfAf6EN9UgHLe3OJPp0IQVAcKTmSpwL5c3Mzvfm6UCkuCru9aHbT+
         NuIvMkKPrIwaf51YIdJh8aJKm1m43PM0gtdtL20cxjncIBEv8tKd6NP5z6HBSMsQS+He
         ldoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiS2lMaRysm5LXBYQP/NQhSFBV0vHLNWfoUGY+iNjEY=;
        b=4KFqz9oXEhlOkuWvLf6WV/SUtRb+Nw3SD2HBByoUw07gAPjX6uwLfnmffVt50ahm4I
         vvkmsQqkSevJlUijevTKukOlJbIsncj9ti5Ey6W8oIv3ZPzkcnWwR2xcWuzzLioqqrLE
         lazfKruSPlrgkeycCf2RoPst4147WY3akCqq3GmmTCWu9iIQUMu4TKqMxdC1LIQJlri+
         zfXaysgNEM7tmxtcxVkElFtaDtHyRNeRiMBduKC/lu5orvXc7jSJBrZkgZq198SH+p+M
         Yw5T/5y4fgV6mdPBiyBVZBJWy+a8L0+ElJM223INPjtKP+akZuixYnDp87sBBfAtuQ+T
         tMjQ==
X-Gm-Message-State: AO0yUKXRut2ATQ5lm6hv4VCaZlWEtj+y8LnVlAilsEKVmB72fx0lNNFv
        Yc+lOEd2S3sPI6JFN/KcQec=
X-Google-Smtp-Source: AK7set96mR6jSGdJiJza9f6XAlzfBRhZgKEt1IFkcTkWx0OxRnUnMKDgEQYSM7BAMvNhPKbQty456w==
X-Received: by 2002:a19:a41a:0:b0:4e1:1bfe:38f7 with SMTP id q26-20020a19a41a000000b004e11bfe38f7mr742511lfc.27.1677522046763;
        Mon, 27 Feb 2023 10:20:46 -0800 (PST)
Received: from pc636 (host-90-235-25-56.mobileonline.telia.com. [90.235.25.56])
        by smtp.gmail.com with ESMTPSA id l30-20020ac2555e000000b004d51b590772sm968545lfk.255.2023.02.27.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:20:46 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 27 Feb 2023 19:20:44 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/z0fHHYdxEXcWMT@pc636>
References: <Y/zxDuxsihJXTdxf@pc636>
 <577E687B-1E01-4953-A353-D8B91DF8387E@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <577E687B-1E01-4953-A353-D8B91DF8387E@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 01:15:47PM -0500, Joel Fernandes wrote:
> 
> 
> > On Feb 27, 2023, at 1:06 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿On Mon, Feb 27, 2023 at 10:16:51AM -0500, Joel Fernandes wrote:
> >>> On Mon, Feb 27, 2023 at 9:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> 
> >>> On Mon, Feb 27, 2023 at 08:22:06AM -0500, Joel Fernandes wrote:
> >>>> 
> >>>> 
> >>>>> On Feb 27, 2023, at 2:53 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
> >>>>> 
> >>>>> ﻿
> >>>>>> 
> >>>>>> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>>>> Sent: Saturday, February 25, 2023 11:34 AM
> >>>>>> To: linux-kernel@vger.kernel.org
> >>>>>> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic Weisbecker
> >>>>>> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>; linux-
> >>>>>> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
> >>>>>> rcu@vger.kernel.org
> >>>>>> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
> >>>>>> completed
> >>>>>> 
> >>>>>> On many systems, a great deal of boot happens after the kernel thinks the
> >>>>>> boot has completed. It is difficult to determine if the system has really
> >>>>>> booted from the kernel side. Some features like lazy-RCU can risk slowing
> >>>>>> down boot time if, say, a callback has been added that the boot
> >>>>>> synchronously depends on.
> >>>>>> 
> >>>>>> Further, it is better to boot systems which pass 'rcu_normal_after_boot' to
> >>>>>> stay expedited for as long as the system is still booting.
> >>>>>> 
> >>>>>> For these reasons, this commit adds a config option
> >>>>>> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
> >>>>>> rcupdate.boot_end_delay.
> >>>>>> 
> >>>>>> By default, this value is 20s. A system designer can choose to specify a value
> >>>>>> here to keep RCU from marking boot completion.  The boot sequence will not
> >>>>>> be marked ended until at least boot_end_delay milliseconds have passed.
> >>>>> 
> >>>>> Hi Joel,
> >>>>> 
> >>>>> Just some thoughts on the default value of 20s, correct me if I'm wrong :-).
> >>>>> 
> >>>>> Does the OS with CONFIG_PREEMPT_RT=y kernel concern more about the
> >>>>> real-time latency than the overall OS boot time?
> >>>> 
> >>>> But every system has to boot, even an RT system.
> >>>> 
> >>>>> 
> >>>>> If so, we might make rcupdate.boot_end_delay = 0 as the default value
> >>>>> (NOT the default 20s) for CONFIG_PREEMPT_RT=y kernels?
> >>>> 
> >>>> Could you measure how much time your RT system takes to boot before the application runs?
> >>>> 
> >>>> I can change it to default 0 essentially NOOPing it, but I would rather have a saner default (10 seconds even), than having someone forget to tune this for their system.
> >>> 
> >>> Provide a /sys location that the userspace code writes to when it
> >>> is ready?  Different systems with different hardware and software
> >>> configurations are going to take different amounts of time to boot,
> >>> correct?
> >> 
> >> I could add a sysfs node, but I still wanted this patch as well
> >> because I am wary of systems where yet more userspace changes are
> >> required. I feel the kernel should itself be able to do this. Yes, it
> >> is possible the system completes "booting" at a different time than
> >> what the kernel thinks. But it does that anyway (even without this
> >> patch), so I am not seeing a good reason to not do this in the kernel.
> >> It is also only a minimum cap, so if the in-kernel boot takes too
> >> long, then the patch will have no effect.
> >> 
> >> Thoughts?
> >> 
> > Why "rcu_boot_ended" is not enough? As i see right after that an "init"
> > process or shell or panic is going to be invoked by the kernel. It basically
> > indicates that a kernel is fully functional.
> > 
> > Or an idea to wait even further? Until all kernel modules are loaded by
> > user space.
> 
> I mentioned in commit message it is daemons, userspace initialization etc. There is a lot of userspace booting up as well and using the kernel while doing so.
> 
> So, It does not make sense to me to mark kernel as booted too early. And no harm in adding some builtin kernel hysteresis. What am I missing?
> 
Than it is up to user space to decide when it is ready in terms of "boot completed".

--
Uladzislau Rezki
