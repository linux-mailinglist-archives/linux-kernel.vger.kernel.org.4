Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D141D66B6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 06:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjAPFtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 00:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjAPFt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 00:49:28 -0500
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 21:49:26 PST
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE7C868D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 21:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1673847696;
        bh=rEd5LJal0k18Z47RyzG7yfXliLKWwpAHYhS56ZWoUe4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W39RRFLrV0CslCMgWrHHxG3sW/TZBG215J1jo1nhqCpEqKh11pTqn2Hxr4Y9ICy+5
         TLPHJkH+03+dXFjt/6C2EcOt9t/5cgac9r+OA6bUqXAzh8NiMoEJB0vgpYgaWki+S8
         wxIZo9+P6SpF+o1QE5vi7zH7/YsZm25F3KP7nuRI=
Received: from [IPv6:240e:358:116a:de00:dc73:854d:832e:2] (unknown [IPv6:240e:358:116a:de00:dc73:854d:832e:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 1F93166753;
        Mon, 16 Jan 2023 00:41:29 -0500 (EST)
Message-ID: <972e4d0c69dea4e9659eb9459072b2b7b2fd963b.camel@xry111.site>
Subject: Re: [PATCH 1/4] LoongArch: Use trampoline for exception handlers
 and kill la.abs
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Youling Tang <tangyouling@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 13:41:17 +0800
In-Reply-To: <CAAhV-H55Kj4gMnORHfQUYJ3KBueLv7j+ktkNP9cE-=32nEShzg@mail.gmail.com>
References: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
         <1673255274-18238-2-git-send-email-tangyouling@loongson.cn>
         <6f1a1f3c-4569-c427-76ae-2f7093cb5e9f@loongson.cn>
         <CAAhV-H55Kj4gMnORHfQUYJ3KBueLv7j+ktkNP9cE-=32nEShzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-16 at 09:30 +0800, Huacai Chen wrote:
> On Sat, Jan 14, 2023 at 2:38 PM Jinyang He <hejinyang@loongson.cn>
> wrote:
> >=20
> > Hi, Ruoyao and Youling,
> >=20
> > I care about the performance when NUMA enabled. We set CSR.EENTRY
> > for each possible cpus where is NUMA-relative. So, I guess the more
> > codes in NUMA-relative memory makes more performance. If we just set
> > handler_trampoline as exception handler, the performance may be
> > influenced.
> So copying both the handlers and handler_trampoline can solve the
> problem? If that is possible, please do that on top of the latest code
> in
> https://github.com/loongson/linux/commits/loongarch-next

Hi folks,

I just wrote the trampoline code as a PoC to show "relocatable kernel
can work" and there must be some better way.  But I'm too sad to write
any serious code in this month, and I don't have access to a LoongArch
NUMA system.  So I think it's better to leave the job for you guys now
:).

Best regards

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
