Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5139073859E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjFUNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFUNrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:47:39 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED18E6E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1687355258;
        bh=mKMqUuWKo4We6APzwpiPt0WTyPKwoFAwN9+UkpLCRtE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KC0DQHUZkjXHWXaKGJ0UQnv2k/xQabEBosK5yr17/Rp6taOu4ZxqZxr/VsvZnvBjU
         CgLYuyHwcLl+zSBoRXLHvyHqfdqOVmL1tui7gI6iHIRcf8HJ7MPiqdgiGwM/zW3/IF
         EQu4v05yHkl87bHHTMdKGcTF24Ae6ENl82tNrRKk=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id BA66665A7B;
        Wed, 21 Jun 2023 09:47:37 -0400 (EDT)
Message-ID: <e7113e249fa0fc1f259408c9f97655ec199dba5e.camel@xry111.site>
Subject: Re: A question about prefetchw detection in "x86/asm: Cleanup
 prefetch primitives"
From:   Xi Ruoyao <xry111@xry111.site>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 21 Jun 2023 21:47:36 +0800
In-Reply-To: <20230621134645.GIZJL/Rf1IdeLMQGl2@fat_crate.local>
References: <0b663d8f6802e8dbf443397718234bcb6d0811c8.camel@xry111.site>
         <20230621111346.GFZJLbavDw1JiLi34n@fat_crate.local>
         <a155ebb791d3aefce5db32658e3c519a1cfac1f6.camel@xry111.site>
         <e76180a1b82d1c29715587e94e2d6923b64bb893.camel@xry111.site>
         <20230621125749.GGZJLzzUw0rA3goV1X@fat_crate.local>
         <b50735128c5a985634468d63fef092f093f0aebc.camel@xry111.site>
         <20230621130955.GHZJL2o771lIEPURUl@fat_crate.local>
         <29beee7faf370ea892cb4e5a85ddd1f7ee132164.camel@xry111.site>
         <20230621134645.GIZJL/Rf1IdeLMQGl2@fat_crate.local>
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

On Wed, 2023-06-21 at 15:46 +0200, Borislav Petkov wrote:
> On Wed, Jun 21, 2023 at 09:19:34PM +0800, Xi Ruoyao wrote:
> > On Wed, 2023-06-21 at 15:09 +0200, Borislav Petkov wrote:
> > > On Wed, Jun 21, 2023 at 09:06:51PM +0800, Xi Ruoyao wrote:
> > > > I think it's not an issue in the kernel itself, but announcing
> > > > 3dnowprefetch in /proc/cpuinfo for an old Intel CPU w/o real
> > > > prefetchw
> > > > implementation seems problematic (to me).
> > >=20
> > > And this is a problem because?
> >=20
> > If a code generator parses /proc/cpuinfo for CPU capabilities, it
> > may
> > generates a no-op prefetchw instead of prefetcht0 as a fallback.
>=20
> Err, go back.
>=20
> That code snippet you pasted, did you see where that comes from?
>=20
> A function called init_amd().
>=20
> Now, is Intel hardware and SDM PREFETCHW text at all relevant here?

Oh s**t, I'm completely stupid :(.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
