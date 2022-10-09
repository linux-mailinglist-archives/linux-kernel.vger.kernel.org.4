Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77C15F8ACC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 13:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJILHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 07:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJILG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 07:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79AD28733
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 04:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4214660AE9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E01C433C1;
        Sun,  9 Oct 2022 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665313615;
        bh=bDQO5nPf+lVMNKr0A9V63/VARoFUePFNmz0paVann+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lh6KNRlMUBJMDhKijORUgTjeqq0c1vtkL5x0vLvbTNwERqVEdWnCGu2FxlEkBGcn+
         xjiiFHa+CJx9o7faJ1WRwSTfYSQ7wQsHG7b70vo1BVmv6kdMZAlOwXNzkQ0rIxMTLa
         boh8I6USg2O6ZZFNH5rzTt7ozAbyRWsyu3UliSlaXhG6/EP9MnB/qf7XnEhZ3WrbTN
         73iMNQ8c9V389d6Do3fGdUG8a4Lttp4rwHfOQliOAz9wyt/9bhX9AB2NM0MUv9SXPP
         bSmnI4zfT58B0fmLz7ozMrVvAaQ7RgQy0Keyq4I1pPNbwLyYFEoIj5GveAT/nPVB7n
         ZPcx0pvvZm0vQ==
Received: by pali.im (Postfix)
        id 52B8A7C1; Sun,  9 Oct 2022 13:06:52 +0200 (CEST)
Date:   Sun, 9 Oct 2022 13:06:52 +0200
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
Message-ID: <20221009110652.h7senqesk7nabxmn@pali>
References: <20220820105200.30425-1-pali@kernel.org>
 <20220828095659.4061-1-pali@kernel.org>
 <e3cb2642-20e4-6c26-104d-329a04260946@csgroup.eu>
 <c8d657db-02da-7840-5b40-755e47277a2c@csgroup.eu>
 <20220828174135.rcql4uiunqbnn5gh@pali>
 <d49c5905-ff68-00e9-ddaf-d60d5e5ebe65@csgroup.eu>
 <20220829085451.upubyo5e7uop72lb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220829085451.upubyo5e7uop72lb@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 August 2022 10:54:51 Pali Rohár wrote:
> On Sunday 28 August 2022 17:43:53 Christophe Leroy wrote:
> > Le 28/08/2022 à 19:41, Pali Rohár a écrit :
> > > On Sunday 28 August 2022 17:39:25 Christophe Leroy wrote:
> > >> Le 28/08/2022 à 19:33, Christophe Leroy a écrit :
> > >>>
> > >>>
> > >>> Le 28/08/2022 à 11:56, Pali Rohár a écrit :
> > >>>> When CONFIG_TARGET_CPU is specified then pass its value to the compiler
> > >>>> -mcpu option. This fixes following build error when building kernel with
> > >>>> powerpc e500 SPE capable cross compilers:
> > >>>>
> > >>>>       BOOTAS  arch/powerpc/boot/crt0.o
> > >>>>     powerpc-linux-gnuspe-gcc: error: unrecognized argument in option
> > >>>> ‘-mcpu=powerpc’
> > >>>>     powerpc-linux-gnuspe-gcc: note: valid arguments to ‘-mcpu=’ are:
> > >>>> 8540 8548 native
> > >>>>     make[1]: *** [arch/powerpc/boot/Makefile:231:
> > >>>> arch/powerpc/boot/crt0.o] Error 1
> > >>>
> > >>> corenet64_smp_defconfig :
> > >>>
> > >>>     BOOTAS  arch/powerpc/boot/crt0.o
> > >>> powerpc64-linux-gcc: error: missing argument to '-mcpu='
> > >>> make[1]: *** [arch/powerpc/boot/Makefile:237 : arch/powerpc/boot/crt0.o]
> > >>> Erreur 1
> > >>> make: *** [arch/powerpc/Makefile:253 : uImage] Erreur 2
> > >>>
> > >>>
> > >>
> > >> Seems like in fact, E5500_CPU and E6500_CPU are not taken into account
> > >> in CONFIG_TARGET_CPU, and get special treatment directly in
> > >> arch/powerpc/Makefile.
> > >>
> > >> This goes unnoticed because of CFLAGS-$(CONFIG_TARGET_CPU_BOOL) +=
> > >> $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
> > >>
> > >> I think we need to fix that prior to your patch.
> > > 
> > > It looks like that CONFIG_TARGET_CPU is broken.
> > > 
> > >    $ make ARCH=powerpc corenet64_smp_defconfig CROSS_COMPILE=powerpc64-linux-gnu-
> > >    ...
> > >    # configuration written to .config
> > > 
> > >    $ grep CONFIG_TARGET_CPU .config
> > >    CONFIG_TARGET_CPU_BOOL=y
> > > 
> > > CONFIG_TARGET_CPU_BOOL is set but CONFIG_TARGET_CPU not!
> > 
> > Yes, because there is no default value for E5500_CPU and E6500_CPU. We 
> > need to add one for each.
> 
> I see... Will you prepare this fixup for your previous patch?
> 
> And I think that following construct
> 
>   $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
> 
> should be changed just to
> 
>   -mcpu=$(CONFIG_TARGET_CPU)
> 
> Because if user specified that want build for specific target CPU, it
> should not be silently ignored.

Christophe, should I do something in this area?
