Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03750738464
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjFUNHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjFUNG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:06:57 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E24AE57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1687352813;
        bh=5dWRuH89Ilyk+Eum5Le0jx45SYBFgGknhsbmLYsC0Hc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=i3XeniyB32M1KpXMPq7niwPRSVa4qDtOCcEB/SAqUBZTYCtBIQK4RvrldO79W+Fj8
         6Ajr9EBtK/Wlqg9GG2zkFt+3n2pHYfHz1CkvBCJ1DnU9bE4caLVQ5Yopup8a3JPM8o
         zdLhqz1cHZBVHURrHK1yV/bKdLhYuQtryqgJxavM=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id C7F5E65DD0;
        Wed, 21 Jun 2023 09:06:52 -0400 (EDT)
Message-ID: <b50735128c5a985634468d63fef092f093f0aebc.camel@xry111.site>
Subject: Re: A question about prefetchw detection in "x86/asm: Cleanup
 prefetch primitives"
From:   Xi Ruoyao <xry111@xry111.site>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 21 Jun 2023 21:06:51 +0800
In-Reply-To: <20230621125749.GGZJLzzUw0rA3goV1X@fat_crate.local>
References: <0b663d8f6802e8dbf443397718234bcb6d0811c8.camel@xry111.site>
         <20230621111346.GFZJLbavDw1JiLi34n@fat_crate.local>
         <a155ebb791d3aefce5db32658e3c519a1cfac1f6.camel@xry111.site>
         <e76180a1b82d1c29715587e94e2d6923b64bb893.camel@xry111.site>
         <20230621125749.GGZJLzzUw0rA3goV1X@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 14:57 +0200, Borislav Petkov wrote:
> On Wed, Jun 21, 2023 at 08:04:39PM +0800, Xi Ruoyao wrote:
> > Hmm, while it's true for AMD, the Intel SDM claims otherwise.=C2=A0 It
> > says
> > prefetchw is only (really) supported with "Intel=C2=AE Core=E2=84=A2 M =
processor
> > family; 5th Generation Intel=C2=AE Core=E2=84=A2 processor family, Inte=
l Atom
> > processor based on Silvermont microarchitecture" or later.=C2=A0 On the
> > earlier Intel CPUs supporting LM, the prefetchw instruction is
> > treated
> > as NOP.
>=20
> And this is a problem because?

I think it's not an issue in the kernel itself, but announcing
3dnowprefetch in /proc/cpuinfo for an old Intel CPU w/o real prefetchw
implementation seems problematic (to me).
>=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
