Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B436C3CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCUV2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCUV2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:28:31 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1FE125A8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:28:28 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-544787916d9so303480947b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679434107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAyM6HcLMXUbep+NWnijC7oArwLlYvYZ0Qrd0e/DUWw=;
        b=GBq2XqeRCcqiSyw+I8ye20BWKI2g76OtubrkdYzkR5a8PanrxkqvJuGfwngdHq0kPb
         TFCcAblMoWd6c+KmDcJtOjm/D4AoRouYs1hdet31Cj4qXBdgn97CpNDdbwZ7AsZjnlfI
         vcDHkuOn5EpVR3UUBS6N1ieKBEz/lJ3qSD7Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAyM6HcLMXUbep+NWnijC7oArwLlYvYZ0Qrd0e/DUWw=;
        b=gl2r/ATWhLDcHZ3HXNHiuZF1gcQL7ALY2DY4jDl35w2KE/NGgw4xt7D+MI1ZE3nrm7
         o3WCIwOAU1ShajR6dfTm8RIWBbcJvW5P8+GC93LBuD2jRorwVFRHvv7bOfLOq9GUN705
         GAllcrS+DqWLFTl836N8fnWUNjehZKEDz5PP/ngo+mx1BaR3nMEbXyB7P8xPcAu5aWEm
         G0+dNniJ7sAA31H1s+plVF56V9s4tOyjtoqKa11Gw9D/7Y55sE683+lO10uq2L4aHKzu
         N44GyWFq0D8xp5omjWnaPA4Y4b5nEiUYEhmgztN8NPfVF3rjdeX4qEyI6D+VDLldIeA5
         d+yQ==
X-Gm-Message-State: AAQBX9f4AqoTtLcfgsCw6v7gDMvJ2+y5F/VA1PJOIpF16bL10vRhP8tk
        tYTmxiDaLYcmQqTeKhRwiPFW4MzUvgf3RgDCl4avGA==
X-Google-Smtp-Source: AKy350YGtvswyCj1+mf1xNISdbVIFwQA993JMQd99BzUST4T1TEeelc4DxHheGfXiG5YYsBzt0hWtYUs4LJqPnnRPEM=
X-Received: by 2002:a81:b3c1:0:b0:541:9895:4ce9 with SMTP id
 r184-20020a81b3c1000000b0054198954ce9mr1914145ywh.9.1679434107171; Tue, 21
 Mar 2023 14:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <72ba8619-88cb-4bf4-8232-18d8a1b6b5bf@paulmck-laptop>
 <20230321052337.26553-1-qiuxu.zhuo@intel.com> <20230321052337.26553-2-qiuxu.zhuo@intel.com>
 <20230321154751.hgeppd5v327juc36@offworld> <a4a3e103-78b3-4be3-80b8-bbae7b1bb2f4@paulmck-laptop>
In-Reply-To: <a4a3e103-78b3-4be3-80b8-bbae7b1bb2f4@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 21 Mar 2023 17:28:16 -0400
Message-ID: <CAEXW_YQW=O_85j6FFP5K8BPGOLAntWnt9Zi0CoL2XQWL4q-w4A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
To:     paulmck@kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, frederic@kernel.org,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 3:24=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Mar 21, 2023 at 08:47:51AM -0700, Davidlohr Bueso wrote:
> > On Tue, 21 Mar 2023, Qiuxu Zhuo wrote:
> >
> > > When running the 'kfree_rcu_test' test case with commands [1] the cal=
l
> > > trace [2] was thrown. This was because the kfree_scale_thread thread(=
s)
> > > still run after unloading rcuscale and torture modules. Fix the call
> > > trace by invoking kfree_scale_cleanup() from rcu_scale_cleanup() when
> > > removing the rcuscale module.
> > >
> > > [1] modprobe rcuscale kfree_rcu_test=3D1
> > >    // After some time
> > >    rmmod rcuscale
> > >    rmmod torture
> > >
> > > [2] BUG: unable to handle page fault for address: ffffffffc0601a87
> > >    #PF: supervisor instruction fetch in kernel mode
> > >    #PF: error_code(0x0010) - not-present page
> > >    PGD 11de4f067 P4D 11de4f067 PUD 11de51067 PMD 112f4d067 PTE 0
> > >    Oops: 0010 [#1] PREEMPT SMP NOPTI
> > >    CPU: 1 PID: 1798 Comm: kfree_scale_thr Not tainted 6.3.0-rc1-rcu+ =
#1
> > >    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 =
02/06/2015
> > >    RIP: 0010:0xffffffffc0601a87
> > >    Code: Unable to access opcode bytes at 0xffffffffc0601a5d.
> > >    RSP: 0018:ffffb25bc2e57e18 EFLAGS: 00010297
> > >    RAX: 0000000000000000 RBX: ffffffffc061f0b6 RCX: 0000000000000000
> > >    RDX: 0000000000000000 RSI: ffffffff962fd0de RDI: ffffffff962fd0de
> > >    RBP: ffffb25bc2e57ea8 R08: 0000000000000000 R09: 0000000000000000
> > >    R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> > >    R13: 0000000000000000 R14: 000000000000000a R15: 00000000001c1dbe
> > >    FS:  0000000000000000(0000) GS:ffff921fa2200000(0000) knlGS:000000=
0000000000
> > >    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >    CR2: ffffffffc0601a5d CR3: 000000011de4c006 CR4: 0000000000370ee0
> > >    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > >    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >    Call Trace:
> > >     <TASK>
> > >     ? kvfree_call_rcu+0xf0/0x3a0
> > >     ? kthread+0xf3/0x120
> > >     ? kthread_complete_and_exit+0x20/0x20
> > >     ? ret_from_fork+0x1f/0x30
> > >     </TASK>
> > >    Modules linked in: rfkill sunrpc ... [last unloaded: torture]
> > >    CR2: ffffffffc0601a87
> > >    ---[ end trace 0000000000000000 ]---
> > >
> > > Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
> > > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>
> Much better, thank you both!
>
> But unfortunately, these patches do not apply cleanly.  Qiuxu Zhuo,
> could you please forward port these to the -rcu "dev" branch [1]?

After making it cleanly apply:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

>
>                                                 Thanx, Paul
>
> [1] https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcuto=
do.html
