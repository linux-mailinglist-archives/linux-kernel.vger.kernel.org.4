Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BF464E96F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiLPK07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiLPK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:26:57 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601A2A243
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:26:56 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id r15so1357591qvm.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U3Q3iicbR9oH4idcMT6MZ2fiYgNJtG2Xjo0mDw2kb4U=;
        b=Z3nrN8Mn8puxntF84+HwQFNAyndPCfQKazd2wCsXP6U+Vl/A7xfnEB87aT1zyfsliL
         nSTD0a+oc6/LaHzBpxP47Og/bT2rRRc+r47I85P9WXfWIc0Ovc+jcp+/tNg7ZgzH2OMG
         vzkWd/CArwmP4prwOVDzDmbZ04/hzOZJVULz5/lVcuZI2u/d3iZMRy+DEvkfCWLMILal
         K2hgaMMbhApdtdmp3a1coMKO82cyr/ZAvONsrlchbKAns9pjV2Hx9zqhB2ltZ/Y2Lix7
         OpF2dYZtx8kJVob0wM+oHJG7SqttZ3eLt/1Gx8DP72jXPZc3652czFLYJwRLzuDfbVA0
         5jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3Q3iicbR9oH4idcMT6MZ2fiYgNJtG2Xjo0mDw2kb4U=;
        b=tK8Nhv+T3VCr42+7ORIqWxZZYQvt02Ohx55TMl29hUk7UV6Ci4hvlnO4qSvtDMoqpQ
         avfIbHTj9TAYgKz+3ujjjdrx+zYWen99qlpBxr3bYd3i1EIEzNwhQcWpTGbqWWhcihaK
         7ttWvqyAeDQpf88jyobM3JCq+taXSnt36CGpmlgcXLgfoOku+n8QYaJpWc4RzzTVp6B8
         QzGKHdjNVn8TZ+XUjcI2qIydHhAPv5lWEBTV+8zkY3eBUkRNP2M7SqwTIs5PYszS/XtF
         TTzuv2oMhBOEvS2UY5SNwcXnXCMnEEe5EtYtuXwfbKPPpbI/E1t/pBrr73nzqIgxVWDr
         Egpg==
X-Gm-Message-State: AFqh2kr3ZsezOHmC8KbKWBeepyuM3MROUxMfps96q81mVC1DTAiZc0qk
        UnLzwEzrAcOasYBBIw9KycN/ka9Aq49apk87PoSYBQ==
X-Google-Smtp-Source: AMrXdXugTAMs6Y/YImGfUoICGvtytKLTrTb+HAwT8S/W2D4Yk1SRqFTNjpaTI040grNcf4RIHDDfkLAUjpurVBZ2WlA=
X-Received: by 2002:a05:6214:5b81:b0:4ef:cd33:b1f9 with SMTP id
 lq1-20020a0562145b8100b004efcd33b1f9mr477900qvb.130.1671186415828; Fri, 16
 Dec 2022 02:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20221214114447.1935755-1-peternewman@google.com>
 <20221214114447.1935755-2-peternewman@google.com> <bbc57154-b7f5-4b9a-65ba-ca8dc0fe0dfe@intel.com>
In-Reply-To: <bbc57154-b7f5-4b9a-65ba-ca8dc0fe0dfe@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 16 Dec 2022 11:26:44 +0100
Message-ID: <CALPaoCgt+epHFO=O8B0LWfps0NjJ1RvwmfGey22XyamkUbm0hg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] x86/resctrl: Fix task CLOSID/RMID update race
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, bp@alien8.de, derkling@google.com,
        eranian@google.com, hpa@zytor.com, james.morse@arm.com,
        jannh@google.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
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

Hi Reinette,

On Fri, Dec 16, 2022 at 12:52 AM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> For a fix a Fixes: tag is expected. It looks like the following
> may be relevant:
> Fixes: ae28d1aae48a ("x86/resctrl: Use an IPI instead of task_work_add() to update PQR_ASSOC MSR")
> Fixes: 0efc89be9471 ("x86/intel_rdt: Update task closid immediately on CPU in rmdir and unmount")

Thanks for preparing these lines. I'll include them.

>
> > Signed-off-by: Peter Newman <peternewman@google.com>
>
> Also, please do let the stable team know about this via:
> Cc: stable@vger.kernel.org

I wasn't sure if this fix met the criteria for backporting to stable,
because I found it by code inspection, so it doesn't meet the "bothers
people" criterion.

However I can make a case that it's exploitable:

"In a memory bandwidth-metered compute host, malicious jobs could
exploit this race to remain in a previous CLOSID or RMID in order to
dodge a class-of-service downgrade imposed by an admin or steal
bandwidth."


>
> Thank you very much for sticking with this and always paying attention
> to the details along the way.
>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you, Reinette! This has been a learning experience for me.

-Peter
