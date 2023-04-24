Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C0A6EC347
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 02:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjDXAda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 20:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDXAd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 20:33:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A182F10D7;
        Sun, 23 Apr 2023 17:33:27 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-74adf6adac6so429738485a.0;
        Sun, 23 Apr 2023 17:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682296407; x=1684888407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ImiI1T82BoC75l7Q4KTC7ZYDR3+sxlOmDrEgnlmaLjo=;
        b=YdYZbtbaAwDfhD0kKPD0I2VMekKRqLApQrwYVJsP/vE8EHRol9GaMTLvVY+kKgVviQ
         ToglhcFaeOdkdNw2aD/nq5vQpx57RgK2A33xpruDvZlSSOcMZ8NaGIHiXkCEbD+ZPOwL
         wy58vaEJ8NhiN3aYmFL/RKMc6Hv3AOOaPDiG4lOlioigYNQKuBehD8dfAV4iXCgWJNTT
         S3vgPmAW/c9gP5jTio4kEzfxKrA/2kekkpN0vSddPGyxCZdcUs2AAUxiTMkdASiwWD1O
         bxeZIjXOOKiGrqCpO2CqjJdr1V98DbJsKDw7Tsx4n7vBejQOFVCxGWAvblCIXFTKxoiC
         esoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682296407; x=1684888407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImiI1T82BoC75l7Q4KTC7ZYDR3+sxlOmDrEgnlmaLjo=;
        b=eAX1eK94CiP//luHF1aSf6YJC0EedvAmZXeklVoaRn9nPucjYkxwTjyideJduUMgz6
         eULttN4MFgnDm0lTuxy47toT/aqFhRs4XZUkaZWqfwIDKLmCq2GCxttU5eyncXeIQkSx
         QUvQ4HhPA8SCEDVGrR+ZwdO2IPqzirrqoZpa9Ka5BvhUYx4Gk0JhSsAulbhjKzAm7Et3
         y3ujyIdCbnaMIRPSIRKfFKvFzXBXWIG5QYiXcSoRsv7UgDTo5vZzVUEF+40p2f/bXbXp
         hZIKhNp6GUqfmMthjmT0vH84H/B4LsETenoxnAt2z7GyAWtT324M7ikAJesgYiibt1WW
         EGrw==
X-Gm-Message-State: AAQBX9f1Y0fS1auKEdoiCra5WZX9IROsfoz1mVfMpaPXZ+SAIWlzvT/4
        lpoyFMjAK5FMasQBF/iJAno=
X-Google-Smtp-Source: AKy350bgmauIMKkvOkDgSzpZ2lCxZT0EIepKhGqt9HU+W0nlT56JKraWbigEhCmd5TTTBRNizkxq/w==
X-Received: by 2002:a05:622a:44a:b0:3ef:5f95:8365 with SMTP id o10-20020a05622a044a00b003ef5f958365mr15595249qtx.42.1682296406651;
        Sun, 23 Apr 2023 17:33:26 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n4-20020a05620a294400b0074d1b6a8187sm190726qkp.130.2023.04.23.17.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 17:33:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id C97A827C0054;
        Sun, 23 Apr 2023 20:33:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 23 Apr 2023 20:33:25 -0400
X-ME-Sender: <xms:U85FZMmiOM9ncgfsyiSEaigy-I45CjBCP04OU22Fh6iYS29OftMnwA>
    <xme:U85FZL0BoMRDwmzg09OQ9spoTP-emiL8Yxb3c81SDut8NzR7wX4CvB22i8MrhEcoe
    a7VBjz0UIiawJPmvg>
X-ME-Received: <xmr:U85FZKrjTPHdxmdPamwK_nOVPo2lU68rPPPflr4RyPyi4GaUikDaSsDvgiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgefftdduhedvfefgleevvdejiefgvedutdefvdeifeevtefhleekhefh
    geeukeeinecuffhomhgrihhnpeduheegrddvvddtrdefrdduudehnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:U85FZIkX42P5c3ik7nX-_Dy_vKVq0xBW8OwpqQLqBRoTG2I-XG1vlw>
    <xmx:U85FZK3fZUup3_3maTOnUbhd4Ho-vxy-VD4-kry6sM3kW7fc-swvNA>
    <xmx:U85FZPtGuFtP_ev_kB5ELwbtZhlCLXFSjOMpDWz8iFv6mrQhkyZOfA>
    <xmx:VM5FZDl1scgVvLKn8J0vkANveM8JES2HMnbPildbBRYJsO7fm6E-TQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Apr 2023 20:33:23 -0400 (EDT)
Date:   Sun, 23 Apr 2023 17:32:48 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
Message-ID: <ZEXOMC2casTlobE1@boqun-archlinux>
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 09:28:39PM +0200, Joel Fernandes wrote:
> On Sat, Apr 22, 2023 at 2:47 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> >
> > Dear PowerPC and RCU developers:
> > During the RCU torture test on mainline (on the VM of Opensource Lab
> > of Oregon State University), SRCU-P failed with __stack_chk_fail:
> > [  264.381952][   T99] [c000000006c7bab0] [c0000000010c67c0]
> > dump_stack_lvl+0x94/0xd8 (unreliable)
> > [  264.383786][   T99] [c000000006c7bae0] [c00000000014fc94] panic+0x19c/0x468
> > [  264.385128][   T99] [c000000006c7bb80] [c0000000010fca24]
> > __stack_chk_fail+0x24/0x30
> > [  264.386610][   T99] [c000000006c7bbe0] [c0000000002293b4]
> > srcu_gp_start_if_needed+0x5c4/0x5d0
> > [  264.388188][   T99] [c000000006c7bc70] [c00000000022f7f4]
> > srcu_torture_call+0x34/0x50
> > [  264.389611][   T99] [c000000006c7bc90] [c00000000022b5e8]
> > rcu_torture_fwd_prog+0x8c8/0xa60
> > [  264.391439][   T99] [c000000006c7be00] [c00000000018e37c] kthread+0x15c/0x170
> > [  264.392792][   T99] [c000000006c7be50] [c00000000000df94]
> > ret_from_kernel_thread+0x5c/0x64
> > The kernel config file can be found in [1].
> > And I write a bash script to accelerate the bug reproducing [2].
> > After a week's debugging, I found the cause of the bug is because the
> > register r10 used to judge for stack overflow is not constant between
> > context switches.
> > The assembly code for srcu_gp_start_if_needed is located at [3]:
> > c000000000226eb4:   78 6b aa 7d     mr      r10,r13
> > c000000000226eb8:   14 42 29 7d     add     r9,r9,r8
> > c000000000226ebc:   ac 04 00 7c     hwsync
> > c000000000226ec0:   10 00 7b 3b     addi    r27,r27,16
> > c000000000226ec4:   14 da 29 7d     add     r9,r9,r27
> > c000000000226ec8:   a8 48 00 7d     ldarx   r8,0,r9
> > c000000000226ecc:   01 00 08 31     addic   r8,r8,1
> > c000000000226ed0:   ad 49 00 7d     stdcx.  r8,0,r9
> > c000000000226ed4:   f4 ff c2 40     bne-    c000000000226ec8
> > <srcu_gp_start_if_needed+0x1c8>
> > c000000000226ed8:   28 00 21 e9     ld      r9,40(r1)
> > c000000000226edc:   78 0c 4a e9     ld      r10,3192(r10)
> > c000000000226ee0:   79 52 29 7d     xor.    r9,r9,r10
> > c000000000226ee4:   00 00 40 39     li      r10,0
> > c000000000226ee8:   b8 03 82 40     bne     c0000000002272a0
> > <srcu_gp_start_if_needed+0x5a0>
> > by debugging, I see the r10 is assigned with r13 on c000000000226eb4,
> > but if there is a context-switch before c000000000226edc, a false
> > positive will be reported.
> >
> > [1] http://154.220.3.115/logs/0422/configformainline.txt
> > [2] 154.220.3.115/logs/0422/whilebash.sh
> > [3] http://154.220.3.115/logs/0422/srcu_gp_start_if_needed.txt
> >
> > My analysis and debugging may not be correct, but the bug is easily
> > reproducible.
> 
> If this is a bug in the stack smashing protection as you seem to hint,
> I wonder if you see the issue with a specific gcc version and is a
> compiler-specific issue. It's hard to say, but considering this I

Very likely, more asm code from Zhouyi's link:

This is the __srcu_read_unlock_nmisafe(), since "hwsync" is
smp_mb__{after,before}_atomic(), and the following code is first
barrier then atomic, so it's the unlock.

	c000000000226eb4:	78 6b aa 7d 	mr      r10,r13

^ r13 is the pointer to percpu data on PPC64 kernel, and it's also
the pointer to TLS data for userspace code.

	c000000000226eb8:	14 42 29 7d 	add     r9,r9,r8
	c000000000226ebc:	ac 04 00 7c 	hwsync
	c000000000226ec0:	10 00 7b 3b 	addi    r27,r27,16
	c000000000226ec4:	14 da 29 7d 	add     r9,r9,r27
	c000000000226ec8:	a8 48 00 7d 	ldarx   r8,0,r9
	c000000000226ecc:	01 00 08 31 	addic   r8,r8,1
	c000000000226ed0:	ad 49 00 7d 	stdcx.  r8,0,r9
	c000000000226ed4:	f4 ff c2 40 	bne-    c000000000226ec8 <srcu_gp_start_if_needed+0x1c8>
	c000000000226ed8:	28 00 21 e9 	ld      r9,40(r1)
	c000000000226edc:	78 0c 4a e9 	ld      r10,3192(r10)

here I think that the compiler is using r10 as an alias to r13, since
for userspace program, it's safe to assume the TLS pointer doesn't
change. However this is not true for kernel percpu pointer.

The real intention here is to compare 40(r1) vs 3192(r13) for stack
guard checking, however since r13 is the percpu pointer in kernel, so
the value of r13 can be changed if the thread gets scheduled to a
different CPU after reading r13 for r10.

__srcu_read_unlock_nmisafe() triggers this issue, because:

* it contains a read from r13
* it locates at the very end of srcu_gp_start_if_needed().

This gives the compiler more opportunity to "optimize" a read from r13
away.

	c000000000226ee0:	79 52 29 7d 	xor.    r9,r9,r10
	c000000000226ee4:	00 00 40 39 	li      r10,0
	c000000000226ee8:	b8 03 82 40 	bne     c0000000002272a0 <srcu_gp_start_if_needed+0x5a0>

As a result, here triggers __stack_chk_fail if mis-match.

If I'm correct, the following should be a workaround:

	diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
	index ab4ee58af84b..f5ae3be3d04d 100644
	--- a/kernel/rcu/srcutree.c
	+++ b/kernel/rcu/srcutree.c
	@@ -747,6 +747,7 @@ void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)

		smp_mb__before_atomic(); /* C */  /* Avoid leaking the critical section. */
		atomic_long_inc(&sdp->srcu_unlock_count[idx]);
	+       asm volatile("" : : : "r13", "memory");
	 }
	 EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);

Zhouyi, could you give a try? Note I think the "memory" clobber here is
unnecesarry, but I just add it in case I'm wrong.


Needless to say, the correct fix is to make ppc stack protector aware of
r13 is volatile.

Regards,
Boqun

> think it's important for you to mention the compiler version in your
> report (along with kernel version, kernel logs etc.)
> 
> thanks,
> 
> - Joel
> 
> 
>  - Joel
