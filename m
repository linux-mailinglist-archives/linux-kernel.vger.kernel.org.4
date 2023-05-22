Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C256A70C3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjEVRDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjEVRDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:03:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514D0F9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684774969; i=efault@gmx.de;
        bh=ORpmvPAkqWS/v44VsYaTYCPaHR9Y3ark4QbSKrgUsP8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=BXdIIvvYEJyO0KKCSr9c5IomAuHnzMcOh8hMxz4Jpp+JdqjaAq0qrm6AiKl1ILv/l
         w4E5WOTIctLYIzVezCaGhgyIzVUdz2H6YtFaKOapOLqE//yyP+Jzo3Bs4vEf1y7Y7/
         bJNJ2k3qY14Rn7o+GU4Kj6WRd8rhgPIQLcT9T3BD0oPjUKOTtl/Yah2Up27okvefPi
         eza3QNcDlmqnzK+sq4zJBcMOD72xfU7dpmeO3AIvBb/gvzkbGUfJffq7BdjqGBmDRM
         m4ZNEo2Ze4DuZbv75tTtpgn2gTpM6ApK8FE2/vB5v+YEU5M/kD/0Fv0+IS+9IKhMT2
         cQrZaDP/9wYBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.219.131]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Vi-1qC4803Xtw-016LSq; Mon, 22
 May 2023 19:02:48 +0200
Message-ID: <1bea6e585a1be8ab89b9a3db2fb5c58431378f50.camel@gmx.de>
Subject: Re: r8169: disable ASPM during NAPI poll locking changes --> BUG:
 Invalid wait context --> PREEMPT_RT pain
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 22 May 2023 19:02:48 +0200
In-Reply-To: <20230522134315.oBK0Ll7f@linutronix.de>
References: <e55be0ae115ad6494ebb48fecd03e5c2fe528230.camel@gmx.de>
         <28727b435c143f15feddffb4c29095fee2500dff.camel@gmx.de>
         <20230522080604.MgUGcyeU@linutronix.de>
         <d7fa9ffe0e6cd546b8ff3826379c2cf78e5342b6.camel@gmx.de>
         <20230522134315.oBK0Ll7f@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+YuEUmHkCRxSUnwoixwKo2G1HzCHBHwk0ssstlK+Sr0EGiGOsF3
 FtCP+4fGb/nIGhjsIhkxARri9b1VMFCvfxN7NkZHpNkNYErw1a09ykoIpHj1uAwIxk08Hpf
 Rx8icofEXToipNTYIgcq98/bpJ+Dx1yVptluH5NEcuwNQ+Yv3VF01F+Ub6Njw0N9OqkHoQn
 0V1BcSJvhATwhqXmDv/5w==
UI-OutboundReport: notjunk:1;M01:P0:R5ITfINEA6k=;sXvoy99F7R7/xhoQ2DBUzHznD4/
 1TrbY3YQkwjr2Z4J5vGtO02zJyuKnhLNxfpRNJixQeInl9CgNBmZ9ixIqUxDZyqFAx61rGEw8
 SyPgJw8dqKGV/0OxQLLhvMkiEocNCQAyxf5PwSmCFaO3qHocciqbUx7auUauCn69UOnVfnhO1
 bCspKQrTrITI+n7QMOPUZwLZ1uNBXXQV54hXfKJXE+sUsCAsqLeZEtBb+XiUGkvmez/wqoyvA
 RYRVwQqCBfzHRSmqqWWmhw36Ki+wObyEpO0qZxxBzaSEhiG1Ix2O3VRdr1CFdfsAKtJm9NMZ7
 hpaImlUNxyUC/noqBCNmeKGf9pfg+FpXK+8nF0VYU5lFCuFfZBVtUY91tWGNxlN752gSLJaoY
 VJZyYx+rNwiKTIZetSnfxDtx9a/prKw8Sz7fyqBLvwvoGsmUcQFDp6rhpsPPPwhGj59UyyI7z
 sRjusp28lwNrE5YD3XpEpR+cXzoGvlQ/DNs0AogdsFcctttmH45439hkXkMRYrjgIbNwL85A6
 0otXyUY2iMy80Bw3mrSjA82TdlcjcKuLxEj5gFSbAk/rV8qO8gcUtCEO0CR1SN+OcL8WO/Fna
 OtOYaa3Iv8QkWMbsFK7qh3cjFoSF1FEtR61s3zc6Ng+7yhfHS2LEvkKYeBnS9+ueBho7RjZo/
 80gAu4cf9f1DIFHcnMJNSRfHTy1VNle8mkQItmTdo/zq/TXkZS4kYT9dNRe5U4v5hT42eJs+W
 ZxrAiLN/31vuY1kAsNc+tNXXHVSvvgWvKoS8vUDEHIXNl7x4p43V8aHgpXGecvsfrgqar8Meb
 VlQTdSp5o/rnFggDeMwIjlnlO43DEjgQTHT49usoxCTyFLB2Qf8SDTlnVg2Cg8flKJpgRGALm
 /2sp6KxaSkMvRfCfdhmkMKdORnZUCbRayWjbhxrLxJ2wXl5n6F11eEQhrGrbjnU3RpMDTmXB1
 XoI0fyT2lOR0VoWFmKldc6UD9XA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-22 at 15:43 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-05-22 12:41:21 [+0200], Mike Galbraith wrote:
> > > I've been looking at the r8169 the other day and it seemed all good
> > > since it was only scheduling workqueues and NAPI. But now I see this
> > > mac_ocp_lock + config25_lock which are acquire in hardirq context bu=
t
> > > can't. This needs to be taken care.
> >
> > I did a patch converting the locks, but didn't post it hoping maybe
> > those locks weren't really really needed.=C2=A0 It doesn't matter for =
my
> > box, as it doesn't do anything but give RT chances to trip over bugs.
>
> I missed that part. Do you still see those 160us if you keep the locks
> as-it as drop the no-threads flag? I'm trying to figure out if this is
> due to hwirq context or just blocked PCI-bus due ASPM.

That 160us was with the nouveau left on by mistake, the worst ftrace
recorded with me beating up box was 77us (and it inflates).  Without
ftrace and keeping box quiet except for youtube and netperf with lappy,
it looks like rtmutex v spinlock would eventually end in a near tie,
both being noticeable, but for a box without an RT mission, hohum.

Me preferring to not notice them, <poof> all better.

no locks
policy: fifo: loadavg: 13.22 9.21 4.16 12/970 5737

T: 0 ( 4385) P:99 I:1000 C: 329625 Min:      1 Act:    4 Avg:    3 Max:   =
   31
T: 1 ( 4386) P:99 I:1500 C: 219749 Min:      1 Act:    5 Avg:    3 Max:   =
   24
T: 2 ( 4387) P:99 I:2000 C: 164811 Min:      1 Act:    4 Avg:    3 Max:   =
   24
T: 3 ( 4388) P:99 I:2500 C: 131849 Min:      1 Act:    6 Avg:    4 Max:   =
   25
T: 4 ( 4389) P:99 I:3000 C: 109874 Min:      1 Act:    4 Avg:    3 Max:   =
   24
T: 5 ( 4390) P:99 I:3500 C:  94177 Min:      1 Act:    5 Avg:    4 Max:   =
   25
T: 6 ( 4391) P:99 I:4000 C:  82405 Min:      1 Act:    5 Avg:    4 Max:   =
   23
T: 7 ( 4392) P:99 I:4500 C:  73248 Min:      1 Act:    5 Avg:    4 Max:   =
   27

spinlock_t IRQF_SHARED
policy: fifo: loadavg: 13.99 10.01 4.63 11/925 5459

T: 0 ( 5188) P:99 I:1000 C: 330449 Min:      1 Act:    4 Avg:    3 Max:   =
   41
T: 1 ( 5189) P:99 I:1500 C: 220298 Min:      1 Act:    6 Avg:    4 Max:   =
   25
T: 2 ( 5190) P:99 I:2000 C: 165223 Min:      1 Act:   12 Avg:    4 Max:   =
   58
T: 3 ( 5191) P:99 I:2500 C: 132178 Min:      1 Act:    8 Avg:    4 Max:   =
   44
T: 4 ( 5192) P:99 I:3000 C: 110148 Min:      1 Act:    8 Avg:    4 Max:   =
   43
T: 5 ( 5193) P:99 I:3500 C:  94412 Min:      1 Act:    6 Avg:    4 Max:   =
   23
T: 6 ( 5194) P:99 I:4000 C:  82611 Min:      1 Act:    6 Avg:    5 Max:   =
   24
T: 7 ( 5195) P:99 I:4500 C:  73431 Min:      1 Act:   10 Avg:    5 Max:   =
   38

raw_spinlock_t IRQF_NO_THREAD
policy: fifo: loadavg: 14.84 10.35 4.81 4/1031 5744

T: 0 ( 4680) P:99 I:1000 C: 347816 Min:      1 Act:    6 Avg:    4 Max:   =
   29
T: 1 ( 4681) P:99 I:1500 C: 231877 Min:      1 Act:    6 Avg:    4 Max:   =
   49
T: 2 ( 4682) P:99 I:2000 C: 173907 Min:      1 Act:    7 Avg:    5 Max:   =
   39
T: 3 ( 4683) P:99 I:2500 C: 139125 Min:      1 Act:    6 Avg:    5 Max:   =
   46
T: 4 ( 4684) P:99 I:3000 C: 115937 Min:      1 Act:    4 Avg:    4 Max:   =
   34
T: 5 ( 4685) P:99 I:3500 C:  99375 Min:      1 Act:    7 Avg:    5 Max:   =
   32
T: 6 ( 4686) P:99 I:4000 C:  86953 Min:      1 Act:    9 Avg:    5 Max:   =
   28
T: 7 ( 4687) P:99 I:4500 C:  77291 Min:      1 Act:    6 Avg:    5 Max:   =
   37




