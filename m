Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA86ECC94
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjDXNHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjDXNG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:06:58 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A13C3A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:06:57 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3ef31924c64so1522161cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682341617; x=1684933617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx287Xzo7DZ7IW3RRrRsJADrJLhhrPWkHx34Ztc5z84=;
        b=LjmStF4s7OufMlj5ZN6s3ojcLTDs9E7a1Xin1UPDfgciBGXYjQnFXRCLIpgaA4p1jO
         mgYV+tkjrYi+vyDr4cE6YW95t78Bp7uqfuKYADLMbIptB15Deuti+rACxBB6hQmjPin4
         9KxwX5v64M1I3YRxCHMRWhZe7OE4TDHSObS0PV0Y5bTCA+y+z6LBSDLyn2N95hygguIq
         9VD87C3Eb1EkJEnUQqlxXIsHM/wHYBESB7v2A+tuZyQs84ob6iWJGmzQLKBtn+k2AnbB
         NuKl2a982dwvqip8j6i3IA4hqtFIW483xPlk8bOefcuwpB/lH6doEn6GrcT7iA2i2hO/
         1YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682341617; x=1684933617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx287Xzo7DZ7IW3RRrRsJADrJLhhrPWkHx34Ztc5z84=;
        b=dD9RVB/z3Pg3ogKUszccQhfjIHjrWdiu+8BlnjMhjFje0LVsq/FbKOo3ImkVvdL4Wq
         av+Fy6uDBtiEaDO3Yuh1bO9PpHj6CNeX1PJidjks+TzH6QQa87SyhKr+OKYOxMnBTXVV
         CD8yHlg479loxwytJH9A7GrvB0VWwH1iYyFzwKcAGp3nzUHAYuerYHhm35Ovpyp97d1o
         L5c8mf2q3boT9E+eYP1Z5Gnt4KrSW4OXJlsunEhhTLbXQY8y8OJ31pTFxKjWjnFKuwsY
         Z8p5Ei++eCymDWRbdpIu+V3jI6J/ztoHG9yavSTRJrRsfLDxrh46liiaWmh+bnVz7fkj
         /zkw==
X-Gm-Message-State: AAQBX9c7ibYvziUs0ET9YISgXdH7dAAoFD0j4kvIX+49v06dTGnJD1Fw
        M8Sb3DJd2Rxp8KVa1ojxVLo8ZP81UJHzMmUprmR9ww==
X-Google-Smtp-Source: AKy350YWINXy4lQxYER7LrvrEscY1KnkvioiWBZd+C24cpBwO+DpPH07x+TTP+DBQYUzzXy+72JXReZ1qTknTmcEMrE=
X-Received: by 2002:a05:622a:1998:b0:3ef:26ec:f27a with SMTP id
 u24-20020a05622a199800b003ef26ecf27amr539720qtc.13.1682341616609; Mon, 24 Apr
 2023 06:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-3-james.morse@arm.com>
In-Reply-To: <20230320172620.18254-3-james.morse@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 24 Apr 2023 15:06:45 +0200
Message-ID: <CALPaoCjTS5EFWkjkbJYZYtjFPmTGf=HXj1bWwOVNcqnr4W_wkg@mail.gmail.com>
Subject: Re: [PATCH v3 02/19] x86/resctrl: Access per-rmid structures by index
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
        Xin Hao <xhao@linux.alibaba.com>
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

Hi James,

On Mon, Mar 20, 2023 at 6:27=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/res=
ctrl/core.c
> index 030d3b409768..351319403f84 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -600,7 +600,7 @@ static void clear_closid_rmid(int cpu)
>         state->default_rmid =3D 0;
>         state->cur_closid =3D 0;
>         state->cur_rmid =3D 0;
> -       wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> +       wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_CLOSID, 0);

It looks like the RMID/CLOSID params are in the wrong order in this wrmsr()=
.

-Peter
