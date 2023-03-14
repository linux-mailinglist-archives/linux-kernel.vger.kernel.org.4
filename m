Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B004A6B8F64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjCNKMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCNKLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:11:44 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999DD9B2DF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1678788655;
        bh=W9skhsvXEGQ08C7gklvlc3PjcG4M+gp62gDeZRXjb6E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nGayq+lZCB/U9zaPu9LsWK93kFNf8NW8Z9MDjdYrRURLr72YFyigIXNUCWtW+ltO1
         clJGtkh5KLqnhjAqsXJS5Dty2n2F5zkD9Dj6XNSW0ZPGqqxQO4+pE/2spQ15WtojCH
         GJCacm6boFHGCOEeT8dK3uWyO8h6C/9RBnzeqG+I=
Received: from [192.168.124.9] (unknown [113.140.29.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 901BD65CBE;
        Tue, 14 Mar 2023 06:10:53 -0400 (EDT)
Message-ID: <109608ce770c2da249a7624f55666da640260f28.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Make WriteCombine configurable for ioremap()
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Tue, 14 Mar 2023 18:10:46 +0800
In-Reply-To: <CAAhV-H4TpQuq9sE2H=zbO8cvwn3Aer_pu1a-DU9L9OSR1bQX=g@mail.gmail.com>
References: <20230314085433.4078119-1-chenhuacai@loongson.cn>
         <21f5aba50b7732b48d2610a5015186adf6bdfb38.camel@xry111.site>
         <CAAhV-H4TpQuq9sE2H=zbO8cvwn3Aer_pu1a-DU9L9OSR1bQX=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-14 at 18:02 +0800, Huacai Chen wrote:
> > Hmm, is it possible to make a PCI quirk so SUC/WUC will be decided
> > automatically from the vendor:device ID of the PCI root controller?
> > Then we don't need to rely on the user or distro maintainer to select a=
n
> > option.=C2=A0 I see there is already many architecture-dependant #if
> > directives in drivers/pci/quirks.c so I guess such a quirk is acceptabl=
e
> > in PCI tree...
> Not a good idea, pci quirks need too long a time to review, and we
> don't know when this issue can be fixed in hardware.

How about make a PCI fixup in arch/loongarch/pci/pci.c then?  I think we
just need to set a flag in the fixup, then check the flag in
ioremap_wc...

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
