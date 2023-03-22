Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E6F6C4B99
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjCVNV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCVNVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:21:47 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E508162FDC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:21:36 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q88so5832793qvq.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679491295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLckaVx57qZBDyyDNeivPWqqhfNG6EDAEC2ht6/RFig=;
        b=hgvCcHQP3ciKnZC5Jt7CeB9z5EVa5YOuzWJhXB2rGK45dRDvlKlIXtIvoLB9adV9kG
         SSdZDb9yOodqtXIJfxXo2ziVVs3LP3lHlaFovYDh7TCFbZ9sgCkXpnVujV4twIGklthO
         Ahadoz9iGGan5rTw0nURWOFVNeZ7w4ReHG+ww3O15SCMOZFWF/bIUp2WNS5Bu+Dtv4XI
         fGlIa7Kh/9zr4w7NZAzgBCIBS79DxicfZ+XHhaYAesBikouvvLZOI84TZcIzrCQdDrCJ
         qAE1pIf/bxeX7XUgS6uPJ8p/rey2Ee2xpvi6Ne4dArjgcvwTfl2BkBPMMMcKHU0DJ14I
         Ug7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLckaVx57qZBDyyDNeivPWqqhfNG6EDAEC2ht6/RFig=;
        b=I/ebf09LeKuc3lvkSzZCe1m501USjtnxeyjawWLOKHwtcjjEAd6j9MIh4A31mZIKX2
         /yQxPdYKRI0ondfYKiaHXFVkN05X9YwhtD7HmKEOkJpzV1A41lelXKxGeagOz/4esJmv
         XjtuVoGkcmhyD8hy5FSrq/Jwv4EQ4RJDu8blebGUMVu0+sJOwZ7o+/Bojg+RfzhJTzk6
         EVM7dctOMo7R3TDYULJ0TrgtOR4ulrzjwYe6Q3Lt7mY8M0h7d2r/KzqrMspRA17EST1F
         43579/SPf6qCB7O2OmihunGKqnnNu1O57nRYAE7l1uBfncMt6pkrgUf2eCD/+7VTgmPR
         9O/w==
X-Gm-Message-State: AO0yUKWaq1IXrwE9hs2mulyG0au08jepcbrUo0dHg+dEcM7XEVjJeypa
        VM2MxSK7kAQhbP2HNi5zzoF9dcmb0/fYX/L+fV2Ynw==
X-Google-Smtp-Source: AK7set8YCgmgVHlG0DaIp4TJNbgJoPf0XBEhk5T1+UEBU6OrdTspWXo+oPxdh4dFhMYAq0HtB08r/B7C6PSyaMMiQQ8=
X-Received: by 2002:a05:6214:aaa:b0:56f:a4:d7f4 with SMTP id
 ew10-20020a0562140aaa00b0056f00a4d7f4mr759101qvb.9.1679491295574; Wed, 22 Mar
 2023 06:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230113175459.14825-1-james.morse@arm.com> <20230113175459.14825-10-james.morse@arm.com>
 <CALPaoCg4T52ju5XJC-BVX-EuZUtc67LruWbgyH5s8CoiEwOUPw@mail.gmail.com>
 <c3ca6d66-e58c-8ace-e88e-45ded5de836f@arm.com> <CALPaoCik0j7ATCv-He5HWVqbL+3njpqO1fhF5FQJO7qqT1zR3w@mail.gmail.com>
 <c8d85eae-e291-99a6-509c-94c41514ac16@arm.com> <CALPaoCgEaT2oax35ezRydUZwL9bMmMFFr2wRqPe4VYAnEQ-GGg@mail.gmail.com>
 <f8a25b5f-4a7d-0891-1152-33f349059b5d@arm.com> <CALPaoCim-QkHbm=dXzpfh1N5mx-4u=d21SUrjnBk2OU=R4apbA@mail.gmail.com>
 <546a2513-fbfb-da1b-d34b-6c7a2024a861@arm.com>
In-Reply-To: <546a2513-fbfb-da1b-d34b-6c7a2024a861@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 22 Mar 2023 14:21:24 +0100
Message-ID: <CALPaoCjqTtSf1qrvms-==1-ZSEHDDG=Cm2uFeO-DP7JrcKJRkw@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, Mar 20, 2023 at 6:12=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
> On 10/03/2023 09:28, Peter Newman wrote:
> > In the interest of enabling MPAM functionality, I think the low-effort
> > approach is to only allocate an MBWU monitor to a newly-created MON or
> > CTRL_MON group if one is available. On Intel and AMD, the resources are
> > simply always available.
>
> I agree its low-effort, but I think the result is not worth having.
>
> What does user-space get when it reads 'mbm_total_bytes'? Returning an er=
ror here sucks.
> How is user-space supposed to identify the groups it wants to monitor, an=
d those it
> doesn't care about?
>
> Taking "the only way to win is not to play" means the MPAM driver will on=
ly offer those
> 'mbm_total_bytes' files if they are going to work in the same way they do=
 today. (as you
> said, on Intel and AMD the resources are simply always available).

I told you that only Intel so far has resources for all RMIDs. AMD
implementations allocate MBW monitors on demand, even reallocating ones
that are actively in use.

> I agree those files have always been able to return errors - but I've nev=
er managed to
> make the Intel system I have do it... so I bet user-space doesn't expect =
errors here.
> (let alone persistent errors)

Find some AMD hardware. It's very easy to get persistent errors due to
no counters being allocated for an RMID:

(this is an 'AMD Ryzen Threadripper PRO 3995WX 64-Cores')

# cd /sys/fs/resctrl/mon_groups
# mkdir test
# cat test/mon_data/*/mbm_total_bytes
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
# cat test/mon_data/*/mbm_total_bytes
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable
Unavailable


> This patch to allow resctrl_arch_rmid_read() to sleep is about MPAM's CSU=
 NRDY and the
> high likelyhood that folk build systems where MSCs are sliced up and priv=
ate to something
> smaller than the resctrl:domain. Without the perf support, this would sti=
ll be necessary.

I was worried about the blocking more when I thought you were doing it
for MBWU monitoring. Serializing access to limited CSU monitors makes
more sense.

> The changes needed for perf support are to make resctrl_arch_rmid_read() =
re-entrant, and
> for the domain list to be protected by RCU. Neither of these are as onero=
us as changes to
> the user-space interface, and the associated risk of breaking programs th=
at work on other
> platforms.

I went ahead and tried to rebase my reliable-MBM-on-AMD changes onto
your series and they seemed to work with less difficulty than I was
expecting, so I'll try to stop worrying about the churn of this series
now.

-Peter
