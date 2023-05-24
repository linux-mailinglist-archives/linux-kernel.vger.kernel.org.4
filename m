Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B470FB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjEXQN3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjEXQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:13:27 -0400
Received: from sinikuusama2.dnainternet.net (sinikuusama2.dnainternet.net [83.102.40.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5D0122
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:13:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sinikuusama2.dnainternet.net (Postfix) with ESMTP id CF793DE18;
        Wed, 24 May 2023 19:13:15 +0300 (EEST)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Score: 0.92
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
Received: from sinikuusama2.dnainternet.net ([83.102.40.152])
        by localhost (sinikuusama2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id Ce7PVoYQRckz; Wed, 24 May 2023 19:13:15 +0300 (EEST)
Received: from luumupuu2.dnainternet.net (luumupuu2.dnainternet.net [83.102.40.55])
        by sinikuusama2.dnainternet.net (Postfix) with ESMTP id 80A2AE355;
        Wed, 24 May 2023 19:13:15 +0300 (EEST)
Received: from basile.localnet (87-92-194-88.rev.dnainternet.fi [87.92.194.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by luumupuu2.dnainternet.net (Postfix) with ESMTPS id 84DA22C60;
        Wed, 24 May 2023 19:13:10 +0300 (EEST)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andy.chiu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH -next v20 20/26] riscv: Add prctl controls for userspace vector
 management
Date:   Wed, 24 May 2023 19:13:10 +0300
Message-ID: <2621691.14T4csFsIl@basile.remlab.net>
Organization: Remlab
In-Reply-To: <mhng-52f8af07-f3fc-4674-94ea-abbe2108907a@palmer-ri-x1c9a>
References: <mhng-52f8af07-f3fc-4674-94ea-abbe2108907a@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le keskiviikkona 24. toukokuuta 2023, 3.18.26 EEST Palmer Dabbelt a écrit :
> > I don't think the value of an auxillary vector entry can change in an
> > existing process nor that we need that. If an application starts with V
> > disabled, you can keep the V bit clear even if V gets enabled later on;
> > that won't break existing userspace code, which simply won't use vectors.
> > 
> > What does break existing userspace is setting the V bit whilst vectors are
> > disabled.
> So maybe the right answer is to just not set V at all?

That is one possibility that I can live, although it feels unnecessarily user-
hostile compared to setting it only if the process _started_ with V enabled.

> The
> single-letter extensions are sort of defunct now, there's multi-letter
> sub extensions for most things, but V got ratified with those
> sub-extensions so we could just call it extra-ambiguous?

Maybe; I must admit I have zero visibility to RVI inner workings. At least C, 
D and F bits could work for JIT use cases, I suppose. E and M are totally 
impractical to support. G, I, X and Z cannot are already wasted by the design, 
and I guess we will now waste all 16 others.

But as for V, what is the user-space story for the prctl()? Who is intended to 
enablet V mode? If there is no clear story, it is all but guaranteed that 
random libraries will call it, and just _blindly_ assume that there is enough 
stack space for signal handling. If so, then there is not much point having a 
prctl() in the first place; might as well stick to just a kernel Kconfig with no 
runtime configuration.

-- 
Rémi Denis-Courmont
http://www.remlab.net/



