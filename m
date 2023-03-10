Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5B76B4BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCJPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjCJPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:54:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E62B58C0F;
        Fri, 10 Mar 2023 07:47:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20DA6B822BF;
        Fri, 10 Mar 2023 15:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3572C433D2;
        Fri, 10 Mar 2023 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678463233;
        bh=gzue86b2gSvOsnn9Q/6GTc0RLgmyxaXXm1MWH4Xg/es=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=UvZz8QqfXAvTUElNtCyXSgDO9z+QXA0jkc6pA9wuimJhrDt3rxq62DV3c4iTw9jZv
         BpL6pRMZt6fopnP5w01CUPrq+Vc9p4zvqPEZdesT657VZe8TxiIEr7JjJBVsVolM9J
         jETO+J0xrrQnYb48VInAyYpjO3abwea6PH54oKx78TdVsSZzezPPEavEub0PchFqU6
         hsmz+2zfW+EfF85PovbALWoX1FLvFjF2W8QaCd6uq7SjTMFUswsKBrOAL7bcrDWmea
         Wb4W+VG73xXaqU/pYtA7e50XEmxHPodM9VKTk4BP8L/Lnsz2oNV8qmdVBuHxqdvZ8o
         2gmLSXEzHVbwA==
Date:   Fri, 10 Mar 2023 07:47:12 -0800
From:   Kees Cook <kees@kernel.org>
To:     Ornaghi Davide <davide.ornaghi@intre.it>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "nsaenzju@redhat.com" <nsaenzju@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Introduce per-interrupt kernel-stack randomization
User-Agent: K-9 Mail for Android
In-Reply-To: <ef2c926cf7b148028f1902279cb35a41@intre.it>
References: <ef2c926cf7b148028f1902279cb35a41@intre.it>
Message-ID: <906901ED-DAE3-4A36-A3E4-16DF6F251C48@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 9, 2023 1:00:20 PM PST, Ornaghi Davide <davide=2Eornaghi@intre=2Ei=
t> wrote:
>Per-system-call kernel-stack randomization was introduced to
>prevent attackers from predicting the addresses of certain data
>structures on the stack upon sequential syscalls=2E
>
>However, when entering soft interrupt context, a new stack is allocated
>via vmalloc at a location that stays constant for each cpu until reboot=
=2E
>
>Recent security vulnerabilities such as CVE-2023-0179 showed how an
>infoleak under the softirq context could allow the attacker to locate
>kernel data structures like nftables registers, where a malicious payload
>could be stored=2E
>
>Instead of keeping a constant address, reuse kstack_offset to also
>randomize the soft interrupt stack on every __do_softirq entry=2E
>
>This basic patch version has the drawback of using the same base
>address for all pending softirqs, including softirqd ones, but has low
>impacts on performance=2E
>Alternatively, the stack offset could be updated for every softirq
>action, which I suspect might cause some performance issues=2E
>
>Signed-off-by: Davide Ornaghi <davide=2Eornaghi@intre=2Eit>

This seems like a good place to start=2E Thanks!

Reviewed-by: Kees Cook <keescook@chromium=2Eorg>

One thought is that without a reselection of the offset after this use, th=
e offset will be shared by the next syscall too=2E If softirq timing is con=
trollable by an attacker, this might allow for some exposure?

-Kees

>---
> kernel/softirq=2Ec | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/kernel/softirq=2Ec b/kernel/softirq=2Ec
>index c8a6913c067d=2E=2E8c3eb2fffe39 100644
>--- a/kernel/softirq=2Ec
>+++ b/kernel/softirq=2Ec
>@@ -27,6 +27,7 @@
> #include <linux/tick=2Eh>
> #include <linux/irq=2Eh>
> #include <linux/wait_bit=2Eh>
>+#include <linux/randomize_kstack=2Eh>
>
> #include <asm/softirq_stack=2Eh>
>
>@@ -535,6 +536,7 @@ asmlinkage __visible void __softirq_entry __do_softir=
q(void)
>  __u32 pending;
>  int softirq_bit;
>
>+ add_random_kstack_offset();
>  /*
>  * Mask out PF_MEMALLOC as the current task context is borrowed for the
>  * softirq=2E A softirq handled, such as network RX, might set PF_MEMALL=
OC
>--
>2=2E34=2E1
>
>
>Davide Ornaghi
>Offensive Security Specialist & Intrusion Analyst
>
>T=2E +39 039 28=2E45=2E774 +39 039 96=2E34=2E717
>Intr=C3=A9 Security - a venture of Intr=C3=A9 S=2Er=2El=2E
>www=2Eintre=2Eit
>
>Nota informativa: In ottemperanza della Legge 196/2003 e al Regolamento U=
E 679/2016 (GDPR) sulla tutela dei dati personali, le informazioni contenut=
e in questo messaggio sono strettamente riservate e sono esclusivamente ind=
irizzate al destinatario indicato (oppure alla persona responsabile di rime=
tterlo al destinatario)=2E Le idee e opinioni espresse sono quelle dell'aut=
ore e, a meno che non sia chiaramente scritto, non rappresentano necessaria=
mente quelle di Intr=C3=A9 S=2Er=2El=2E Qualsiasi uso, riproduzione o divul=
gazione di questo messaggio e' vietata, anche ai sensi dell'art=2E 616 c=2E=
p=2E italiano=2E Nel caso in cui aveste ricevuto questa e-mail per errore, =
vogliate avvertirci al piu' presto a mezzo posta elettronica all'indirizzo =
privacy@intre=2Eit e distruggere il presente messaggio=2E
>
>Please note: In reference to Italian law 196/2003 and to the Regulation E=
U 679/2016 (GDPR), this email transmission including its attachments, is in=
tended only for the person or entity to which it is addressed and may conta=
in confidential and/or privileged material=2E Any views or opinions are sol=
ely those of the author and do not necessarily represent those of Intr=C3=
=A9 S=2Er=2El=2E, unless specifically stated=2E Any review, retransmission,=
 dissemination or other use of, or taking of any action in reliance upon, t=
his information by persons or entities other than the intended recipient is=
 prohibited=2E If you received this email due to an error, please contact t=
he sender via e-mail to the address privacy@intre=2Eit and delete the email=
 transmission immediately=2E


--=20
Kees Cook
