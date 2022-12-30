Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC01655ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 18:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiLXRpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 12:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXRpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 12:45:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC585A195
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 09:44:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B1B9B801BA
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 17:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E61C433D2;
        Sat, 24 Dec 2022 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671903896;
        bh=He27IQA6KWGHia3dQKQhu9qvd62uNfXqU30MadzXD7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dUAVA1qE8G9kwB7CUsS8aorbmPKeDcbUc0NsvtCqjl9JOhF4Z/mGTev5zfewOgEu8
         Ikuqp3eWfeFbPzTp6XyPSDrLnU+6EpfCfBCTZqaOXHT1ML6VQ6jc7mDZ2mAKIqv6z+
         nMzA0CSWU2uNFZl1SL3VmY0QNrbqn+Bp/5W80L86rQvk4hMp6MD2tLSMzQhUet8OBB
         kz6nPQz/t+UeF3a103Yz522wOFta8hshg54VPU8+Ek+YEsVqMXwzrHwq9qp9mAQIIu
         OdsuYg60k6cVekRP8pC5ftp+b5Gtk6Lw+BAz9uK3W1PCYHcaM2zWXIH+z4Nq5I0d+v
         LjAOVk2LfC3UA==
Received: by pali.im (Postfix)
        id 8BFD0720; Sat, 24 Dec 2022 18:44:52 +0100 (CET)
Date:   Sat, 24 Dec 2022 18:44:52 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] powerpc/boot: Don't always pass -mcpu=powerpc when
 building 32-bit uImage
Message-ID: <20221224174452.xxlkmos7yoy3qn42@pali>
References: <20220820105200.30425-1-pali@kernel.org>
 <20220828095659.4061-1-pali@kernel.org>
 <e3cb2642-20e4-6c26-104d-329a04260946@csgroup.eu>
 <c8d657db-02da-7840-5b40-755e47277a2c@csgroup.eu>
 <20220828174135.rcql4uiunqbnn5gh@pali>
 <d49c5905-ff68-00e9-ddaf-d60d5e5ebe65@csgroup.eu>
 <20221208191602.diywrt3g2f6zmt4s@pali>
 <aca70dc9-2185-9def-7bc0-b415bec8a5c6@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aca70dc9-2185-9def-7bc0-b415bec8a5c6@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 December 2022 19:57:39 Christophe Leroy wrote:
> Le 08/12/2022 à 20:16, Pali Rohár a écrit :
> > On Sunday 28 August 2022 17:43:53 Christophe Leroy wrote:
> >> Le 28/08/2022 à 19:41, Pali Rohár a écrit :
> >>> On Sunday 28 August 2022 17:39:25 Christophe Leroy wrote:
> >>>> Le 28/08/2022 à 19:33, Christophe Leroy a écrit :
> >>>>>
> >>>>>
> >>>>> Le 28/08/2022 à 11:56, Pali Rohár a écrit :
> >>>>>> When CONFIG_TARGET_CPU is specified then pass its value to the compiler
> >>>>>> -mcpu option. This fixes following build error when building kernel with
> >>>>>> powerpc e500 SPE capable cross compilers:
> >>>>>>
> >>>>>>        BOOTAS  arch/powerpc/boot/crt0.o
> >>>>>>      powerpc-linux-gnuspe-gcc: error: unrecognized argument in option
> >>>>>> ‘-mcpu=powerpc’
> >>>>>>      powerpc-linux-gnuspe-gcc: note: valid arguments to ‘-mcpu=’ are:
> >>>>>> 8540 8548 native
> >>>>>>      make[1]: *** [arch/powerpc/boot/Makefile:231:
> >>>>>> arch/powerpc/boot/crt0.o] Error 1
> >>>>>
> >>>>> corenet64_smp_defconfig :
> >>>>>
> >>>>>      BOOTAS  arch/powerpc/boot/crt0.o
> >>>>> powerpc64-linux-gcc: error: missing argument to '-mcpu='
> >>>>> make[1]: *** [arch/powerpc/boot/Makefile:237 : arch/powerpc/boot/crt0.o]
> >>>>> Erreur 1
> >>>>> make: *** [arch/powerpc/Makefile:253 : uImage] Erreur 2
> >>>>>
> >>>>>
> >>>>
> >>>> Seems like in fact, E5500_CPU and E6500_CPU are not taken into account
> >>>> in CONFIG_TARGET_CPU, and get special treatment directly in
> >>>> arch/powerpc/Makefile.
> >>>>
> >>>> This goes unnoticed because of CFLAGS-$(CONFIG_TARGET_CPU_BOOL) +=
> >>>> $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
> >>>>
> >>>> I think we need to fix that prior to your patch.
> >>>
> >>> It looks like that CONFIG_TARGET_CPU is broken.
> >>>
> >>>     $ make ARCH=powerpc corenet64_smp_defconfig CROSS_COMPILE=powerpc64-linux-gnu-
> >>>     ...
> >>>     # configuration written to .config
> >>>
> >>>     $ grep CONFIG_TARGET_CPU .config
> >>>     CONFIG_TARGET_CPU_BOOL=y
> >>>
> >>> CONFIG_TARGET_CPU_BOOL is set but CONFIG_TARGET_CPU not!
> >>
> >> Yes, because there is no default value for E5500_CPU and E6500_CPU. We
> >> need to add one for each.
> > 
> > With "[PATCH v1] powerpc/64: Set default CPU in Kconfig" patch from
> > https://lore.kernel.org/linuxppc-dev/3fd60c2d8a28668a42b766b18362a526ef47e757.1670420281.git.christophe.leroy@csgroup.eu/
> > this change does not throw above compile error anymore.
> 
> 
> That patch should land in powerpc/next soon. When it has landed, could 
> you resent this patch so that snowpatch checks the build again ?

Yes. But I'm still waiting because patch is not in powerpc/next yet.

> Because at the time being it is flagged as "failed", see 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220828095659.4061-1-pali@kernel.org/
> 
> Christophe
