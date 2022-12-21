Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD96653276
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiLUO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiLUO0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:26:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9108723BD9;
        Wed, 21 Dec 2022 06:25:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F7D8617E4;
        Wed, 21 Dec 2022 14:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D712FC433D2;
        Wed, 21 Dec 2022 14:25:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lRfbtyA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671632752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8QQzlcDreGvKeI1pdR+V0dkEGrKkHpwe4Fd6Sw7snfM=;
        b=lRfbtyA5Ug1Tw0zhKb/BNFVoEpWyjAGCyO/CoLabvh7W3k4ANnWkdSVX9WueP0sD+6Ai0z
        fM66bagOmE4QBhCc6XTBVj7Ox6yRN+8yBHyMnexD8QI1Ge3QpORi6PmoQMnlF78mdrWHTA
        +rvAZXe36hNg+4rNK2pXFWP3l6D+F3g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 421bb0b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 21 Dec 2022 14:25:52 +0000 (UTC)
Date:   Wed, 21 Dec 2022 15:25:49 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v12 0/6] implement getrandom() in vDSO
Message-ID: <Y6MXbTAHBSR5WBrU@zx2c4.com>
References: <20221212185347.1286824-1-Jason@zx2c4.com>
 <86cfa465-2485-ff24-16f5-9014e25a0e98@csgroup.eu>
 <Y6IXWltScF2CI1v3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6IXWltScF2CI1v3@gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 08:13:14PM +0000, Eric Biggers wrote:
> On Tue, Dec 20, 2022 at 05:17:52PM +0000, Christophe Leroy wrote:
> > Hi Jason,
> > 
> > Le 12/12/2022 à 19:53, Jason A. Donenfeld a écrit :
> > > Changes v11->v12:
> > > ----------------
> > > - In order to avoid mlock()ing pages, and the related rlimit and fork
> > >    inheritance issues there, Introduce VM_DROPPABLE to prevent swapping
> > >    while meeting the cache-like requirements of vDSO getrandom().
> > > 
> > >    This has some tenticles in mm/ and arch/x86/ code, so I've marked the
> > >    two patches for that as still RFC, while the rest of the series is not
> > >    RFC.
> > > 
> > > - Mandate that opaque state blobs don't straddle page boundaries, so
> > >    that VM_DROPPABLE can work on page-level granularity rather than
> > >    allocation-level granularity.
> > > 
> > > - Add compiler barriers to vDSO getrandom() to prevent theoretical
> > >    reordering potential.
> > > 
> > > - Initialize the trials loop counter in the chacha test.
> > 
> > I would have liked to give it a try on powerpc, but the series 
> > conflicts. I tried both on v6.1 and on linus/master from now:
> > 
> 
> Same here, I can't figure out how to apply this series.

Rebased v13 posted: https://lore.kernel.org/all/20221221142327.126451-1-Jason@zx2c4.com/

Jason
