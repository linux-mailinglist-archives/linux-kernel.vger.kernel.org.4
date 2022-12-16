Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD7964EDA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiLPPNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiLPPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:12:58 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36225101D7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:12:57 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id g7so2905351qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEcm9v6GuPGdbYufJ/cY13zsBhQTOYOSWCvpcJyORqE=;
        b=neargoPYa7EHGiZZxT0Yjv/CXXLVssqTRf+eNPnUo/gwb+jeuCq6WFbowIkjg+Yft8
         uYvbj/TMRwPueX54IgmZrzAejJSunRYZyB3Uzt7ZUjg/R3J/Hew2+VGbpBaQnS+pH//w
         sTud7ELaLtAAbSG6/MzEpvEG+RWhPaLJ1Ey5Tu1XYUz7DuqYPb1BYlApMagfMvS9cjfU
         gHWHSFzgZr1q5O4/L2T0Sw8CezMmoohKlx44r0VOGJgQMgUMfBeI2myKkSdWUQMQ8ryA
         t8/Jv+O7gRFcfAP6BtMxyQ0jpQ0bXM5eicNPOwWOyGrqUbIcMV9gwozzbzNJ4aboLZ5a
         x5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEcm9v6GuPGdbYufJ/cY13zsBhQTOYOSWCvpcJyORqE=;
        b=RrAGWOp8W6AdBF01vSZKZES3cOMhbl7zDMQBnVmqTbZMF4kLB7KjcTHmxivefL3ugv
         qRx3jVrOqwQHsra4PukXr3eW4RyoaLCQlmgUb+nNwcob6TtJGabD7KgJTlG5+QwnfxHf
         kmPZE3qfqpq1jOP5IlKTRGyX5S5zjyqXsqFLy5cYJjVgM8fKz7cGj/hVMK16LFPyCfLz
         ILKfs9/xAFvNYxFL/WqMBhIXWgr4Ilj+K+8qRxkv9MtGV2UHVfXtAVeAhIkzmOTL5AxN
         snD0n0yPII7KtqF39mL0F8/xYITrCCyQ2KG7galBNMufPo6RxsazjcykiadeUwANSw10
         WLRQ==
X-Gm-Message-State: ANoB5pkbDFM1kyunFchLhurrNNE2Lkh0ceWcdnAJBn5xC7nfdygGSzHU
        Ay1drj9IjCAVRY+iJZCuHYwHRvf/iivu/Y2LHV2qeg==
X-Google-Smtp-Source: AA0mqf72PtVwC+UyGceDvLHh2FZG6AJ1c9dI7OJGc/aRScdPfv/94GQ3VnkdQ5tlch7deR1wZ1gpcYIlUvZQQu4fORg=
X-Received: by 2002:ac8:7ef9:0:b0:3a7:f4ca:c2d1 with SMTP id
 r25-20020ac87ef9000000b003a7f4cac2d1mr5775203qtc.368.1671203576203; Fri, 16
 Dec 2022 07:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20221129120149.1035444-1-peternewman@google.com> <20221129120149.1035444-3-peternewman@google.com>
In-Reply-To: <20221129120149.1035444-3-peternewman@google.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 16 Dec 2022 16:12:45 +0100
Message-ID: <CALPaoCgQQGEypbEz_YMsq9+grM9bEKprVz+iByDUPh85acRM4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/resctrl: Implement rename op for mon groups
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Nov 29, 2022 at 1:02 PM Peter Newman <peternewman@google.com> wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 03b51543c26d..d6562d98b816 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3230,6 +3230,71 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
>         return ret;
>  }
>
> +static void mongrp_move(struct rdtgroup *rdtgrp, struct rdtgroup *new_prdtgrp)
> +{
> +       struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
> +       struct task_struct *p, *t;
> +
> +       WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
> +       list_del(&rdtgrp->mon.crdtgrp_list);
> +
> +       list_add_tail(&rdtgrp->mon.crdtgrp_list,
> +                     &new_prdtgrp->mon.crdtgrp_list);
> +       rdtgrp->mon.parent = new_prdtgrp;
> +
> +       read_lock(&tasklist_lock);
> +       for_each_process_thread(p, t) {
> +               if (is_closid_match(t, prdtgrp) && is_rmid_match(t, rdtgrp))
> +                       WRITE_ONCE(t->closid, new_prdtgrp->closid);
> +       }
> +       read_unlock(&tasklist_lock);
> +
> +       update_closid_rmid(cpu_online_mask, NULL);

I will need to refresh this patch now that we're back to building an
update mask.

This will once again depend on
https://lore.kernel.org/lkml/20221216133125.3159406-1-peternewman@google.com/
