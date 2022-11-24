Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41810637E51
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKXReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKXReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:34:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E23F12F420
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:34:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d1so3373627wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XcU9QM1ckQIRe8QVhZPdinZjsfGER7s7lyyPku7DYQ=;
        b=R1b3oSBO1JQM5LWUbXVCjlamk8u5bPM5JN3ayETkQT+gate4ffVmiBGlW84XSnwPk/
         b0XbSiqw+PMQe3qXaMcBSFpSViggoHXm0b6BP+faSQXldVowV3WTZYjG2sCyfuSx3Ist
         QZ6NwCs090UekQs7cZy5A9064ozKwMTb2EHafIvYWnXT+mSemqxEX/EqKvgYlXV+ELp/
         kUodW+WY43ZZh1x48XR40d3KZHDW0KgRQ1nKrd5/tJzYA/BiGN9JtD7007zaCPZOYVpJ
         yMPPSTuqCMdelktj1zwIboW5EHbi2b6Im+FpTsFU3o7VJuIqZMTwyTgfHb7bG/AIqBfs
         vH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XcU9QM1ckQIRe8QVhZPdinZjsfGER7s7lyyPku7DYQ=;
        b=uT2xcLStEUb2vr7FGaGXaeTJ1lrQw9g5NRfBDy2iyIOh4xHPftP4LyFK5890b1/tj5
         uWUnVZkLfYBVhY0rgmq8A5clsruY7Xpif75cWf0rK1U0XzlBnkMTpqLUR+UehhepJGGO
         OigpS3N41nNOPin6YLUb/ppsP0VVQ6lLjCxioTWk81HDDJDpHqYP/GRcXrS9BREmlhp7
         u2kjOQvVJo/z4pU9rTyWXE7QJRUMysUAIc8Rg8EECau2yJ4ZsmrXkx7NsRsSqvAqyZmC
         5Fp3RNb3cpsDvaTWOtXHrf5Ql/VPkM13yxJx8vm4Fjjq8g9S5Opry5TXraCoZAV07NYP
         oQvA==
X-Gm-Message-State: ANoB5pk5NVpAXi5E6P2MhQF+VCy1IoSrkoUUZbcPpO5xo7t62UjsAgqr
        S0y5sIm7JKB90aBwyEpMGWnDvQ==
X-Google-Smtp-Source: AA0mqf59SeeMbBnb9HJBK2F4/46LuJC45dS0pyoVhoePMQNWhplXAcRq5kUENsm8AZLBjko11x/Www==
X-Received: by 2002:adf:fd01:0:b0:235:83aa:a6ed with SMTP id e1-20020adffd01000000b0023583aaa6edmr19825861wrr.543.1669311257016;
        Thu, 24 Nov 2022 09:34:17 -0800 (PST)
Received: from vermeer ([145.224.92.100])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d6e42000000b0024194bba380sm1869088wrz.22.2022.11.24.09.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:34:16 -0800 (PST)
Date:   Thu, 24 Nov 2022 18:34:11 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
Message-ID: <Y3+rE6j/CzTpINi+@vermeer>
References: <YqYz+xDsXr/tNaNu@Sun>
 <YqY0i22SdbHjB/MX@Sun>
 <Y385rS/5zDaDJ3Os@vermeer>
 <Y39AXYPFzSiBngwI@wendy>
 <Y39Lwp4rQc3Qkl0i@vermeer>
 <Y39blUaC/jHiOYCk@wendy>
 <Y3+mBAV8oxphjHcJ@vermeer>
 <c9ae9644-5cd0-29c2-a25c-bb497dfcb1c8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ae9644-5cd0-29c2-a25c-bb497dfcb1c8@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:20:37PM +0000, Conor Dooley wrote:
> On 24/11/2022 17:12, Samuel Ortiz wrote:
> > [You don't often get email from sameo@rivosinc.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, Nov 24, 2022 at 11:55:01AM +0000, Conor Dooley wrote:
> >> On Thu, Nov 24, 2022 at 11:47:30AM +0100, Samuel Ortiz wrote:
> >>
> >>> Patch #1 is definitely needed regardless of which interface we pick for
> >>> exposing the ISA strings to userspace.
> >>
> >> I took another look at #1, and I feel more confused about what
> >> constitutes canonical order than I did before! If you know better than
> >> I, and you probably do since you're interested in these 6 month old
> >> patches, some insight would be appreciated!
> > 
> > Assuming we don't go with hwcap, I dont think the order of the
> > riscv_isa_ext_id enum matters that much?
> 
> The chief put it in canonical order so that's good enough for me!
> 
> > 
> > iiuc we're building the cpuinfo string from the riscv_isa_ext_data
> > array, and I think the current code is incorrect:
> > 
> > static struct riscv_isa_ext_data isa_ext_arr[] = {
> >     __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >     __RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> >     __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> >     __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> >     __RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> >     __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >     __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> > };
> > 
> > zicbom and zihintpause should come before supervisor level extensions.
> > I'm going to send a patch for that.
> 
> idk, Palmer explicitly re-ordered this:
> https://lore.kernel.org/linux-riscv/20220920204518.10988-1-palmer@rivosinc.com/
> 
> By my reading of the isa manual, what Palmer did is correct as
> those are not "Additional Standard Extensions". /shrug

Hmm, by their name (Z[a-b]+) they are Additional Standard Extensions.
What am I missing?

Cheers,
Samuel.
> 
