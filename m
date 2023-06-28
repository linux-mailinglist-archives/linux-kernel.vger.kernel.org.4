Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82329740DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjF1JxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjF1Jn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:43:26 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E082119
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:43:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4007b5bafceso175141cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687945404; x=1690537404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xc48rBVZsLOiSEa3oMkPeMBce2yb6sDPpiW6pwcCNoo=;
        b=x3ZsMrbusFi+IePpNS5Mo9bZDJ7S5QC7ngE0gCBFadsOV4f3BaMeHc1SAzWFJ8qyW+
         0IFdOx4YhwYo9b13PAxRuk7idaR3uLiL7+lN3bUfAblMLv72W9YRvYGNK8M67Pw1G1Fw
         Tn6zOOast0mxVVvMHCf8tocHCxd3UYUoe2AiKCWwYZPk9K7VPOkzFJRo3U0TSNQzA00j
         7GYqkmoa160qDgxhMnhGrbsbNiGmtzFnVyUghYw929i7jE8JN7dYIYKMGgEkoFUCIsD1
         U136wG/+/DN/EwiRssjCwnDRMBehpIO+nRj4njxjNS10MIJlneKctvWWM9VpaPl7yaex
         eTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687945404; x=1690537404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xc48rBVZsLOiSEa3oMkPeMBce2yb6sDPpiW6pwcCNoo=;
        b=J6Mq3q7ZLTo5NXcB61y7dAzU/emB7zBdx925d8av/XAoVFOvTIwsiF227wqsRpBsXU
         aq4FcB/oDEwLrb+0LMa617dOHO1zihhvHIGOBAT4DiS6RmtjDj1EByWIHrMaCnzGP4M3
         fm03DKDuyJJqCZydR/2xSson/XiEskqjpntVPoebLXZ20x4oo31zFHEV0JnE5ognt5Fx
         oq1B7i/5K70RuagJt7rTwlCnj+Mj2fhKGBB+0s8jx2PRf665gDyuyYPij+olUKlFjfwq
         zHW42eQoJiC1uhkYQcN3WLBFw8yyE0eKS0JBnbrM50rTLH8cbfTtz4FbkFJV+aTib4x2
         rtjA==
X-Gm-Message-State: AC+VfDw9h6/Lzxxt894qLtlme7ZXH4kWCUSfxLduTJtWozYyPW8ukDzI
        +c3nOrHo1cVgNBfzf2UbAWc8otUoX+unU6N+UM12SA==
X-Google-Smtp-Source: ACHHUZ5ThdefZ5zrxt8vbic/eVPtftP8/D0ci1YRpZ+PpEC4vB72hVRtLPei4agSrnA6TWDJ8Y0zaMUyKmkLLpVlQPs=
X-Received: by 2002:ac8:5710:0:b0:3ef:343b:fe7e with SMTP id
 16-20020ac85710000000b003ef343bfe7emr197664qtw.2.1687945403876; Wed, 28 Jun
 2023 02:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230620033702.33344-1-tony.luck@intel.com>
In-Reply-To: <20230620033702.33344-1-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 28 Jun 2023 11:43:13 +0200
Message-ID: <CALPaoChfFSKiWeVC39wFoxUXG+hYU3_HQtCU6AQaB+kAYh3ffg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
To:     Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, aricciardi@baylibre.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Tue, Jun 20, 2023 at 5:37=E2=80=AFAM Tony Luck <tony.luck@intel.com> wro=
te:
>
> Back in April I posted some RFC patches that added a "driver
> registration" interface to the core resctrl code so that additional
> resource control and monitor features could be added without further
> complicating the core code. Link to that discussion:
>
> https://lore.kernel.org/all/20230420220636.53527-1-tony.luck@intel.com/
>
> Reinette gave the feedback that it would be better to base the module
> registration on the resctrl resource structure. Reinette also pointed
> me to work from James Morse, and some additional discussion happened
> here:
>
> https://lore.kernel.org/all/ZG%2FMZVrWYrCHm%2Ffr@agluck-desk3/
>
> James provided details on where ARM's MPAM has similarities and
> differences from the Intel Resource Director Technology and AMD's
> similar implementation. Drew Fustini was also pulled into that
> conversation to comment on RISC-V CBQRI.
>
> From those discussions I believed we need a do-over on the core
> /sys/fs/resctrl implementation to make it friendlier for architecural
> variations. Here's what I have so far.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | N.B. This is a general direction check. There are many obvious        |
> | rough edges (e.g. some careful thought needs to happen on locking     |
> | for the files in /sys/fs/resctrl that are "owned" by modules that     |
> | can be unloaded). I'm mostly looking for feedback from AMD, ARM and   |
> | RISCV on whether this is a foundation to build on, whether some small |
> | tweaks could make it better, or if this is still going to be really   |
> | hard for architectures that have radical divergence from the Intel    |
> | model.                                                                |
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks for working on this! I played with these changes locally on
some of our machines and they seemed reasonably functional so far and
was happy to see dynamically adding and removing resources working.

I will need to try working with the code to give it a serious
evaluation, though. Would you consider it ready for me to try
re-implementing soft RMIDs on it?

I'm also very interested in James's opinion and what this means for
the ongoing MPAM upstreaming.

Thanks!
-Peter
