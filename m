Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9767478D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjASXxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjASXxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:53:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377346082;
        Thu, 19 Jan 2023 15:53:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id dw9so4018979pjb.5;
        Thu, 19 Jan 2023 15:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hnQrEGftYzdf6tY/q/kKi64pUoSAmvwVM0T/m3uVwb8=;
        b=Zzk2Pe5m9zaOfWTtCfHa6+NqdpP84oStIEScj/E3t2Oy2NcfilIjARw9BKNZ5gozDd
         5IYf2E4hMqq1h5R2if5mKKUikutc+wFCc6wZ0kHtIqYNzNdSufesvNV7BnlaRBOph0g3
         /zJ5dJdOBRVUZOmCs5vXfLxiYSpAEsfOMp0ye10pybO4Xkpgo+zQbk4Pso8mg/bAfU9f
         tzZYcH9rNuz584ID02LCqr9jp5BXr8hjsm/7ck2s1Kw4SV6EYsmguHBpArf6iD8hSFZa
         lV+VqvRI3l2rE+SkLWptue+/6M80lxhLoFz5yTH7rStbKz/02jWtQOXyw99f/oSyW3mZ
         o51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnQrEGftYzdf6tY/q/kKi64pUoSAmvwVM0T/m3uVwb8=;
        b=MO3qq/fpj8UqL8TPZhRtuCsOXj36TG2kHxiaCJc4SWMleRztnt+dPKhEOi6LBY31wP
         4yN0YJMdTX5fklydJs8hs4p3KE3voQI4oAqEBqXc+UxoeY6vLDq9WRBMQy5Xxvxb8yrN
         eKqkscybonZzrZstDUuRwslTcLpoCMF4PHfqav0/qRvttfkpS1JcAnP4uF+NRP4gumFD
         gRiSaG+ix49LY83OpVasTbyMsC8fr362HpUfJmgcKXXc1FkEkiQlNcSJYU8WuKEkS7Yg
         Bll2vWbrOMPHMvGqHjEESooE5o7jNLN+kdvIp9jGH6v3lgHAIwH9faxLGCOn8ALhXkF/
         dpHA==
X-Gm-Message-State: AFqh2koHrEa4Jz/EtDUpw6ZPvZoa4wF1CzboptAZwGWVetAPi0PdfP72
        ZWo4QTCMAUZv7HdcpHkPDd/z2Wi0KbJaF6p/2hE=
X-Google-Smtp-Source: AMrXdXtGqpDrTESFDKKUOM8ZNc4b9DnkLVz69Kgqe3L58sjNRH4OgzKd6FgS0GY4vG4UBR2KLQG4NbqGZVGWqsShLUQ=
X-Received: by 2002:a17:90b:f0a:b0:229:55bb:e575 with SMTP id
 br10-20020a17090b0f0a00b0022955bbe575mr1232525pjb.144.1674172394876; Thu, 19
 Jan 2023 15:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20230119204434.4017605-1-joel@joelfernandes.org>
In-Reply-To: <20230119204434.4017605-1-joel@joelfernandes.org>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Fri, 20 Jan 2023 07:53:03 +0800
Message-ID: <CAABZP2xy17GZKujvLNTmpLJi+BnGHhiQS0dn_F5_5brSd37D5Q@mail.gmail.com>
Subject: Re: [PATCH] tick/nohz: Fix cpu_is_hotpluggable() by checking with
 nohz subsystem
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 4:45 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> For CONFIG_NO_HZ_FULL systems, the tick_do_timer_cpu cannot be offlined.
> However, cpu_is_hotpluggable() still returns true for those CPUs. This causes
> torture tests that do offlining to end up trying to offline this CPU causing
> test failures. Such failure happens on all architectures.
>
> Fix it by asking the opinion of the nohz subsystem on whether the CPU can
> be hotplugged.
>
> [ Apply Frederic Weisbecker feedback on refactoring tick_nohz_cpu_down(). ]
Thanks for your fantastic work
I applied this fix to linux-5.15.y, and perform new round of rcu
torture test on PPC VM of Open Source Lab of Oregon State University.
Could you please wait for the test to finish?

The test results of linux-5.15.y before your patch can be viewed at [1]
The patched source code of linux-5.15.y can be viewed at [2]
The ongoing test of patched linux-5.15.y can be viewed at [3]

[1] http://140.211.169.189/linux-stable-rc/tools/testing/selftests/rcutorture/res/2023.01.18-13.22.39-torture/
[2] http://140.211.169.189/linux-stable-rc/
[3] http://140.211.169.189/linux-stable-rc/tools/testing/selftests/rcutorture/res/2023.01.19-23.40.55-torture/

Hope to continue to benefit the community.

Thank you all
Zhouyi
>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: rcu <rcu@vger.kernel.org>
> Fixes: 2987557f52b9 ("driver-core/cpu: Expose hotpluggability to the rest of the kernel")
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  drivers/base/cpu.c       |  3 ++-
>  include/linux/tick.h     |  2 ++
>  kernel/time/tick-sched.c | 12 +++++++++++-
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 55405ebf23ab..450dca235a2f 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
>  bool cpu_is_hotpluggable(unsigned int cpu)
>  {
>         struct device *dev = get_cpu_device(cpu);
> -       return dev && container_of(dev, struct cpu, dev)->hotpluggable;
> +       return dev && container_of(dev, struct cpu, dev)->hotpluggable
> +               && tick_nohz_cpu_hotpluggable(cpu);
>  }
>  EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
>
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index bfd571f18cfd..9459fef5b857 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -216,6 +216,7 @@ extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
>                                      enum tick_dep_bits bit);
>  extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
>                                        enum tick_dep_bits bit);
> +extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
>
>  /*
>   * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
> @@ -280,6 +281,7 @@ static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
>
>  static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
>  static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
> +static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
>
>  static inline void tick_dep_set(enum tick_dep_bits bit) { }
>  static inline void tick_dep_clear(enum tick_dep_bits bit) { }
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 9c6f661fb436..383a060f30c5 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -510,7 +510,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
>         tick_nohz_full_running = true;
>  }
>
> -static int tick_nohz_cpu_down(unsigned int cpu)
> +static int tick_nohz_cpu_hotplug_ret(unsigned int cpu)
>  {
>         /*
>          * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
> @@ -522,6 +522,16 @@ static int tick_nohz_cpu_down(unsigned int cpu)
>         return 0;
>  }
>
> +static int tick_nohz_cpu_down(unsigned int cpu)
> +{
> +       return tick_nohz_cpu_hotplug_ret(cpu);
> +}
> +
> +bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
> +{
> +       return tick_nohz_cpu_hotplug_ret(cpu) == 0;
> +}
> +
>  void __init tick_nohz_init(void)
>  {
>         int cpu, ret;
> --
> 2.39.0.246.g2a6d74b583-goog
>
