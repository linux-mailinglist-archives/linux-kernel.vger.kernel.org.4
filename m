Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B6647606
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiLHTQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHTQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:16:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EDC3B9FA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 373B7B825FE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8F4C433EF;
        Thu,  8 Dec 2022 19:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670526989;
        bh=pxwQPnCXqG586C3H5ieqJi51v5G6Xt2CGmhL4Tp86Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gspoUKMF6ct/veenO8JLmK5QjDcc1PF31I+eSRol66JmDMXFVo0FnEJIRC8bJkxAC
         aAMzaNINNu2GKZBPk2kKCK/3bTUvupRsxsBXqVbXsw4Y8a3DRPf6ZrK0PbU4D9zqit
         Tx0wt99k0iqDN4DGi0f0IJWT6FQOLKtrPq9Lq8E7zSAogHcrER4w1OpS5MLIUHOkhc
         ZkFZ02hHSgfxecll3N7d18tGqOkAWOMU5/9YfNZjkdSuBiJbXV48eqlwhEvajqoxLW
         +4eUaSqrnLto0fuVFyOMjpEf7hV8B0r0yehDcDsTgvmYRnjhfsCF0BTOR8wbbSVso+
         Z1R051UYF54nA==
Received: by pali.im (Postfix)
        id CBFC997E; Thu,  8 Dec 2022 20:16:26 +0100 (CET)
Date:   Thu, 8 Dec 2022 20:16:26 +0100
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
Message-ID: <20221208191626.vqez4aofjndnj4ih@pali>
References: <e3cb2642-20e4-6c26-104d-329a04260946@csgroup.eu>
 <c8d657db-02da-7840-5b40-755e47277a2c@csgroup.eu>
 <20220828174135.rcql4uiunqbnn5gh@pali>
 <d49c5905-ff68-00e9-ddaf-d60d5e5ebe65@csgroup.eu>
 <20220829085451.upubyo5e7uop72lb@pali>
 <20221009110652.h7senqesk7nabxmn@pali>
 <20221101221255.gwaem6w7upv545fw@pali>
 <00398948-d06c-3894-5be3-acb6cc09ff6b@csgroup.eu>
 <20221126163044.cnoccovve4a74a7l@pali>
 <aa61fc51-c6ea-2ad9-42c6-c62b280ab034@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa61fc51-c6ea-2ad9-42c6-c62b280ab034@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2022 13:39:18 Christophe Leroy wrote:
> Le 26/11/2022 à 17:30, Pali Rohár a écrit :
> > On Wednesday 02 November 2022 14:05:35 Christophe Leroy wrote:
> >> Le 01/11/2022 à 23:12, Pali Rohár a écrit :
> >>> On Sunday 09 October 2022 13:06:52 Pali Rohár wrote:
> >>>> On Monday 29 August 2022 10:54:51 Pali Rohár wrote:
> >>>>> On Sunday 28 August 2022 17:43:53 Christophe Leroy wrote:
> >>>>>> Le 28/08/2022 à 19:41, Pali Rohár a écrit :
> >>>>>>> On Sunday 28 August 2022 17:39:25 Christophe Leroy wrote:
> >>>>>>>> Le 28/08/2022 à 19:33, Christophe Leroy a écrit :
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Le 28/08/2022 à 11:56, Pali Rohár a écrit :
> >>>>>>>>>> When CONFIG_TARGET_CPU is specified then pass its value to the compiler
> >>>>>>>>>> -mcpu option. This fixes following build error when building kernel with
> >>>>>>>>>> powerpc e500 SPE capable cross compilers:
> >>>>>>>>>>
> >>>>>>>>>>         BOOTAS  arch/powerpc/boot/crt0.o
> >>>>>>>>>>       powerpc-linux-gnuspe-gcc: error: unrecognized argument in option
> >>>>>>>>>> ‘-mcpu=powerpc’
> >>>>>>>>>>       powerpc-linux-gnuspe-gcc: note: valid arguments to ‘-mcpu=’ are:
> >>>>>>>>>> 8540 8548 native
> >>>>>>>>>>       make[1]: *** [arch/powerpc/boot/Makefile:231:
> >>>>>>>>>> arch/powerpc/boot/crt0.o] Error 1
> >>>>>>>>>
> >>>>>>>>> corenet64_smp_defconfig :
> >>>>>>>>>
> >>>>>>>>>       BOOTAS  arch/powerpc/boot/crt0.o
> >>>>>>>>> powerpc64-linux-gcc: error: missing argument to '-mcpu='
> >>>>>>>>> make[1]: *** [arch/powerpc/boot/Makefile:237 : arch/powerpc/boot/crt0.o]
> >>>>>>>>> Erreur 1
> >>>>>>>>> make: *** [arch/powerpc/Makefile:253 : uImage] Erreur 2
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Seems like in fact, E5500_CPU and E6500_CPU are not taken into account
> >>>>>>>> in CONFIG_TARGET_CPU, and get special treatment directly in
> >>>>>>>> arch/powerpc/Makefile.
> >>>>>>>>
> >>>>>>>> This goes unnoticed because of CFLAGS-$(CONFIG_TARGET_CPU_BOOL) +=
> >>>>>>>> $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
> >>>>>>>>
> >>>>>>>> I think we need to fix that prior to your patch.
> >>>>>>>
> >>>>>>> It looks like that CONFIG_TARGET_CPU is broken.
> >>>>>>>
> >>>>>>>      $ make ARCH=powerpc corenet64_smp_defconfig CROSS_COMPILE=powerpc64-linux-gnu-
> >>>>>>>      ...
> >>>>>>>      # configuration written to .config
> >>>>>>>
> >>>>>>>      $ grep CONFIG_TARGET_CPU .config
> >>>>>>>      CONFIG_TARGET_CPU_BOOL=y
> >>>>>>>
> >>>>>>> CONFIG_TARGET_CPU_BOOL is set but CONFIG_TARGET_CPU not!
> >>>>>>
> >>>>>> Yes, because there is no default value for E5500_CPU and E6500_CPU. We
> >>>>>> need to add one for each.
> >>>>>
> >>>>> I see... Will you prepare this fixup for your previous patch?
> >>>>>
> >>>>> And I think that following construct
> >>>>>
> >>>>>     $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
> >>>>>
> >>>>> should be changed just to
> >>>>>
> >>>>>     -mcpu=$(CONFIG_TARGET_CPU)
> >>>>>
> >>>>> Because if user specified that want build for specific target CPU, it
> >>>>> should not be silently ignored.
> >>>>
> >>>> Christophe, should I do something in this area?
> >>>
> >>> Christophe, any input from your side?
> >>
> >> Hi, sorry I was on holiday until today. I'll try to have a look in the
> >> coming days.
> > 
> > Ok, Did you have a time to look at it?
> 
> I just sent a patch for it.
> 
> Christophe

Thanks!
