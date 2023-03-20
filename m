Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B86C2349
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCTU7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCTU7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:59:36 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4123944A6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:59:34 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-316d901b2ecso364745ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679345973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya6k6XneT9oNlmbQGRbd51/3j9UL/1AGsLcorUKiClw=;
        b=aa7XLH0idAgP0yzrCgir3ppCyAuNzZxdBSbGOhIgGuWFXkwOaAJPJ+BEAhhbypv8kG
         2h333hSywfDGf1WxynNO7ag3FZy3bl66TCk6i9OS6fwJO/yr1uHm+dEI91PEF/yZ7Swv
         hW6NhPfrN3ameCTKG5tOG7XAMmddWLUqRpfmpuOWvNu/DgzMqqKN95twV+lnKvMHR1v5
         lHLg1P5xHpnXeMOZeAWyr02461VntRin6P2WMbT304ucfnrzjEyapNk45NR2sj4lXj4/
         udRxk0tAAac5ofsE/69x7vnFmAsUyHdiqkb0kHkS2NFGvWxOtl6JwW66pEw8bsd7yFRU
         hwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ya6k6XneT9oNlmbQGRbd51/3j9UL/1AGsLcorUKiClw=;
        b=IKCbq8379s75qr0o9/lRCu2R7GBH9Lm6WPZEdvqYsue898ElrM+CUZBieDP+rRvlY0
         pWJfdI0eoigdmenBEnAehAceUY1v6JpyfVZGj/ip/v/XCfKIm0N1t6+080XxYTOrwtZG
         N6fjc+wpXJ1xBZ3bac/SjhBZIaoh57sLZvaFmVvp0LHHspFcQ5/o7II4+YD0OfDeCqI9
         cC8jfE976vyQgxj0KBb36R5pKU0u4OAIRskGMuI8bRnkDbYfLdTGwizP6Bnf6ZKGxJkZ
         hPIgBjlzWzV7cyt1Ab0bUGfbYO4pVZVWRvlyP80HjRttYtabjGM3ANZgjTgCZwcxOhL9
         iakA==
X-Gm-Message-State: AO0yUKWMBA94oLfJDu7mLl7wVKPxu/yYs0MGRMGClvzCmKA+ATu7iEgE
        QWdxr5dG5dp6PJxdgKxaMGvSD6ElIBt2odlJPJRXBQ==
X-Google-Smtp-Source: AK7set9AJD5sV9L/Lz4sXs1f2Bjwx2N5OxMyqptFUpmWxLJsvpHowyu77H9Vx71LvBGx3RnyquL2YwZzYzgryZIQb70=
X-Received: by 2002:a05:6e02:1a48:b0:313:93c8:e71f with SMTP id
 u8-20020a056e021a4800b0031393c8e71fmr62381ilv.19.1679345972656; Mon, 20 Mar
 2023 13:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu> <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
In-Reply-To: <167778869402.1053859.6094569492538617564.stgit@bmoger-ubuntu>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 20 Mar 2023 16:59:21 -0400
Message-ID: <CABPqkBQWy2anBCvfo6DK5EyBxv3WrbUcxFVoLP=YsgYoQ1anxw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] x86/resctrl: Display the RMID and COSID for
 resctrl groups
To:     Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, christophe.leroy@csgroup.eu,
        jarkko@kernel.org, adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 3:25=E2=80=AFPM Babu Moger <babu.moger@amd.com> wrot=
e:
>
> When a user creates a control or monitor group, the CLOSID or RMID
> are not visible to the user. These are architecturally defined entities.
> There is no harm in displaying these in resctrl groups. Sometimes it
> can help to debug the issues.
>
> Add CLOSID and RMID to the control/monitor groups display in resctrl
> interface.
>
> $cat /sys/fs/resctrl/clos1/closid
> 1
> $cat /sys/fs/resctrl/mon_groups/mon1/rmid
> 3
>
Is the intent here to be x86 specific?
How would that work on ARM?
Shouldn't we be using more generic names such as monitoring_id,   control_i=
d?


> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst          |   17 ++++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++++=
++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rs=
t
> index 25203f20002d..67eae74fe40c 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -321,6 +321,15 @@ All groups contain the following files:
>         Just like "cpus", only using ranges of CPUs instead of bitmasks.
>
>
> +"rmid":
> +       Available only with debug option.Reading this file shows the
> +       Resource Monitoring ID (RMID) for monitoring the resource
> +       utilization. Monitoring is performed by tagging each core (or
> +       thread) or process via a RMID. Kernel assigns a new RMID when
> +       a group is created depending on the available RMIDs. Multiple
> +       cores (or threads) or processes can share a same RMID in a resctr=
l
> +       domain.
> +
>  When control is enabled all CTRL_MON groups will also contain:
>
>  "schemata":
> @@ -342,6 +351,14 @@ When control is enabled all CTRL_MON groups will als=
o contain:
>         file. On successful pseudo-locked region creation the mode will
>         automatically change to "pseudo-locked".
>
> +"closid":
> +       Available only with debug option. Reading this file shows the
> +       Class of Service (CLOS) id which acts as a resource control tag
> +       on which the resources can be throttled. Kernel assigns a new
> +       CLOSID a control group is created depending on the available
> +       CLOSIDs. Multiple cores(or threads) or processes can share a
> +       same CLOSID in a resctrl domain.
> +
>  When monitoring is enabled all MON groups will also contain:
>
>  "mon_data":
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl/rdtgroup.c
> index 1eb538965bd3..389d64b42704 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -760,6 +760,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_fi=
le *of,
>         return ret;
>  }
>
> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
> +                               struct seq_file *s, void *v)
> +{
> +       struct rdtgroup *rdtgrp;
> +       int ret =3D 0;
> +
> +       rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
> +       if (rdtgrp)
> +               seq_printf(s, "%u\n", rdtgrp->closid);
> +       else
> +               ret =3D -ENOENT;
> +       rdtgroup_kn_unlock(of->kn);
> +
> +       return ret;
> +}
> +
> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
> +                             struct seq_file *s, void *v)
> +{
> +       struct rdtgroup *rdtgrp;
> +       int ret =3D 0;
> +
> +       rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
> +       if (rdtgrp)
> +               seq_printf(s, "%u\n", rdtgrp->mon.rmid);
> +       else
> +               ret =3D -ENOENT;
> +       rdtgroup_kn_unlock(of->kn);
> +
> +       return ret;
> +}
> +
>  #ifdef CONFIG_PROC_CPU_RESCTRL
>
>  /*
> @@ -1821,6 +1853,12 @@ static struct rftype res_common_files[] =3D {
>                 .seq_show       =3D rdtgroup_tasks_show,
>                 .fflags         =3D RFTYPE_BASE,
>         },
> +       {
> +               .name           =3D "rmid",
> +               .mode           =3D 0444,
> +               .kf_ops         =3D &rdtgroup_kf_single_ops,
> +               .seq_show       =3D rdtgroup_rmid_show,
> +       },
>         {
>                 .name           =3D "schemata",
>                 .mode           =3D 0644,
> @@ -1844,6 +1882,12 @@ static struct rftype res_common_files[] =3D {
>                 .seq_show       =3D rdtgroup_size_show,
>                 .fflags         =3D RFTYPE_BASE_CTRL,
>         },
> +       {
> +               .name           =3D "closid",
> +               .mode           =3D 0444,
> +               .kf_ops         =3D &rdtgroup_kf_single_ops,
> +               .seq_show       =3D rdtgroup_closid_show,
> +       },
>
>  };
>
>
>
