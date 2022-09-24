Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117065E8820
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 06:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiIXEBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 00:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiIXEBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 00:01:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F9BB6544
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 21:01:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fs14so1687933pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 21:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=siq4IcBVR5DSXY5et4N/hDfecxS0FiRN49vF9Lazl6M=;
        b=jwxCtyrUq4SL3a1OIWF3RQWRKiG6sh7HzSwBLVIR/NB9xW4DMV+6ZUsPa6gHJbpGwQ
         vQM1hAMMdVf7c0ukNAHuICrMmEEVbMH6GL2QOlThcv4HYoiZeV3oBiKlZPMZTPE9PqRR
         davlzctJ3KClPuA0Wvm82akDpSrHUihYwL0OQ5IAHfBDU+cmox/gWV+Q6WN0JJ7WcKPW
         kWVD0n5rjZVSytnniqXslt4qblCgAvoz6okPYQjWxffPiqUYnQy7qSdtXcGWP+Z23iX7
         z/YvA0nQK1Xr4L0JZ7SStpfhS3FxVF/VDlyopRlDrLfaoGw+8YAsjoKWg8ehZNn14SMR
         yL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=siq4IcBVR5DSXY5et4N/hDfecxS0FiRN49vF9Lazl6M=;
        b=AvzMnByDARqwmM1dk48S4Cohs/G3/YtUY4261obwK/p3lBSHnCoKQSzAGnBTN5lpgW
         AKNdF4Z/hI+CCmtudzTm3LRlb2ELVVYoFAeI+fR+NoTH16y1/bNRWGhZUwpuNsV6wlJx
         6FOtNiqsoO0VNYZk1Tcvoec0ptDA4paRuRs3D2UEuMT1NpE1Y+R/M0V80uXgtqG9hcc2
         C8y8SG6UAjJ/nkJgKifITq3IyiVXHCr+Fpu46+1yPYaRSdNjvv0uNDDWlSUrfM+iX5KA
         xEBUJHu2LplZjVc3gEGuGfJ+XL2o7TCGZ5Q9G1s1AhEKZbk4L7PjOb8QLczvJzqDVjQ2
         TF9Q==
X-Gm-Message-State: ACrzQf1TzOyi6JNd04mMMarVhWVPFX1QVn8t1R9qIeZEKQugnfh17pR4
        qY5acZGELZpO1ESaEhaf09TrwEJ0sEI=
X-Google-Smtp-Source: AMsMyM71BHiGhhNRu5mNRFmTiLS3aoi9IMqVOur57PNOa65KLfhKxHOUXUH4syzlfz7oiMqMM2bYWg==
X-Received: by 2002:a17:90b:3504:b0:202:5d53:86c with SMTP id ls4-20020a17090b350400b002025d53086cmr12899317pjb.182.1663992062751;
        Fri, 23 Sep 2022 21:01:02 -0700 (PDT)
Received: from localhost (27-32-155-116.static.tpgi.com.au. [27.32.155.116])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b001755e4278a6sm6681934plk.261.2022.09.23.21.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 21:01:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 24 Sep 2022 14:00:55 +1000
Message-Id: <CN4BYDAY75PX.33LJ1P2VQJXD9@bobo>
Subject: Re: [PATCH] powerpc/irq: Modernise inline assembly in
 irq_soft_mask_{set,return}
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Segher Boessenkool" <segher@kernel.crashing.org>
Cc:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.11.0
References: <178f30ff62c0317061f019b3dbbc079073f104c3.1663656058.git.christophe.leroy@csgroup.eu> <CN3LB8F3D9LM.3W1RQRVS64UXU@bobo> <20220923121829.GL25951@gate.crashing.org> <CN3X6YN1FRQ3.1Z9BVD6WYQY3M@bobo> <20220923221543.GN25951@gate.crashing.org>
In-Reply-To: <20220923221543.GN25951@gate.crashing.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 24, 2022 at 8:15 AM AEST, Segher Boessenkool wrote:
> On Sat, Sep 24, 2022 at 02:26:52AM +1000, Nicholas Piggin wrote:
> > I still don't see what clauses guarantees asm("%0" ::"r"(foo)) to give
> > 13. It doesn't say access via inline assembly is special,
>
> But it is.  It is for all register variables, local and global.  I agree
> this isn't documented clearly.  For local register variables this is the
> *only* thing guaranteed; for global register vars there is more (it
> changes the ABI, there are safe/restore effects, that kind of thing).
>
> Never it is guaranteed that all accesses through this variable will use
> the register directly: this fundamentally cannot work on all archs, and
> also not at -O0.  More in general it doesn't work if some basic
> optimisations are not done, be it because of a compiler deficiency, or a
> straight out bug, or maybe it is a conscious choice in some cases.

Right, and we know better than to rely on a spec that is not 100% air
tight with no possibility of lawyering. This may be what the intention is,
it may be what gcc and clang do now, and everybody involved today agrees
with that interpretation. We still have to maintain the kernel tomorrow
though, so explicit r13 it must be.

>
> > I think if it was obviously guaranteed then this might be marginally
> > better than explicit r13 in the asm
> >=20
> >        asm volatile(
> >                "stb %0,%2(%1)"
> >                :
> >                : "r" (mask),
> > 	         "r" (local_paca),
> >                  "i" (offsetof(struct paca_struct, irq_soft_mask))
> >                : "memory");
>
> (Please use "n" instead of "i".  Doesn't matter here, but it does in
> many other places.)

What is the difference? Just "i" allows assmebly-time constants?

How about "I"? that looks like it was made for it. Gives much better
errors.

Thanks,
Nick
