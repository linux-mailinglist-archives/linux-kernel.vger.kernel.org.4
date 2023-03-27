Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554A96CAB12
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjC0QwP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjC0QwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:52:10 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A283C02;
        Mon, 27 Mar 2023 09:51:51 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id ek18so38884652edb.6;
        Mon, 27 Mar 2023 09:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679935905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i7oFEe73tySQfhnZAAorku18WfFptPAQV/pDmjOVSA=;
        b=Fw1OP8nPDOvU3Uh2TIPIvrqzuYNqgyF0KUjpvPaDM5dElhtpZjHCYMztzcNSyMe2ht
         FKfCbZa0u4zjLSwnZShBA+hgMgYlXhbB3X7qn+7C45BSNmIFY55aI7Jd2GDdhMqsUZBq
         kMnQoKsPpjOB2PV+ZB+eMWEJWTPbl2uZUDq3DgeEkUligHcW2psknA8EGkxHr3PcVBC/
         8HXw6uEyfPcwoLDUOX/BMl+WhdnvtfttgQvVOgutQLHcrVbKv7USBpFvHbbYU+NaFKuF
         A4LzVY+BS9iwxwbMUGly5WZ1GIL3CKVZrdICER+rh0Ws6L5+q2w3cj14BLdezEm41pP+
         RCIQ==
X-Gm-Message-State: AAQBX9epi9OuMITiRX27rU5vYjcxwYLj9T+Ej8Q5a5dabEuBB3xFW7GK
        1qx3oBIbGqilpgnHcZfYEAkmoP44S3eE+NwuAjI=
X-Google-Smtp-Source: AKy350ZYSmpIfgUCyG1GyC43BDvsimHGcZqAriixBeTrSmL4Ak6OGNqQvtHXjLl60ptA8ZCVs9YP7/LmcalZ1N2fJT4=
X-Received: by 2002:a17:907:d02:b0:931:6921:bdbb with SMTP id
 gn2-20020a1709070d0200b009316921bdbbmr5845969ejc.2.1679935904807; Mon, 27 Mar
 2023 09:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com> <20230207051105.11575-17-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207051105.11575-17-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 18:51:33 +0200
Message-ID: <CAJZ5v0iMkADWu2P_cn9+8FV4HR+0eDF2uAwEMAZwTAMuE3kBkA@mail.gmail.com>
Subject: Re: [PATCH v3 16/24] thermal: intel: hfi: Define a default class for
 unclassified tasks
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> A task may be unclassified if it has been recently created, spend most of
> its lifetime sleeping, or hardware has not provided a classification.
>
> Most tasks will be eventually classified as scheduler's IPC class 1
> (HFI class 0). This class corresponds to the capabilities in the legacy,
> classless, HFI table.
>
> IPC class 1 is a reasonable choice until hardware provides an actual
> classification. Meanwhile, the scheduler will place classes of tasks with
> higher IPC scores on higher-performance CPUs.
>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Fine with me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes since v2:
>  * None
>
> Changes since v1:
>  * Now the default class is 1.
> ---
>  drivers/thermal/intel/intel_hfi.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> index fa9b4a678d92..7ea6acce7107 100644
> --- a/drivers/thermal/intel/intel_hfi.c
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -185,6 +185,19 @@ static struct workqueue_struct *hfi_updates_wq;
>  #ifdef CONFIG_IPC_CLASSES
>  static int __percpu *hfi_ipcc_scores;
>
> +/*
> + * A task may be unclassified if it has been recently created, spend most of
> + * its lifetime sleeping, or hardware has not provided a classification.
> + *
> + * Most tasks will be classified as scheduler's IPC class 1 (HFI class 0)
> + * eventually. Meanwhile, the scheduler will place classes of tasks with higher
> + * IPC scores on higher-performance CPUs.
> + *
> + * IPC class 1 is a reasonable choice. It matches the performance capability
> + * of the legacy, classless, HFI table.
> + */
> +#define HFI_UNCLASSIFIED_DEFAULT 1
> +
>  void intel_hfi_update_ipcc(struct task_struct *curr)
>  {
>         union hfi_thread_feedback_char_msr msr;
> @@ -215,7 +228,7 @@ unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
>                 return -EINVAL;
>
>         if (ipcc == IPC_CLASS_UNCLASSIFIED)
> -               return -EINVAL;
> +               ipcc = HFI_UNCLASSIFIED_DEFAULT;
>
>         /*
>          * Scheduler IPC classes start at 1. HFI classes start at 0.
> --
> 2.25.1
>
