Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED60F65279E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiLTUNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiLTUNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:13:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211011D64E;
        Tue, 20 Dec 2022 12:13:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A78AA6159F;
        Tue, 20 Dec 2022 20:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2276C433EF;
        Tue, 20 Dec 2022 20:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671567196;
        bh=Gv7ILarnqG6VXDv1zDoq4dXMcpli2fdU3fYWtrhD7CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNIgEyD2b/kwnXbaR5eP2QBP6UOPAvQD/zXFajZWt6RT74gXhm2s6OW4N4KlIDYfC
         Wxj/cb6C47OFZnLUTyNjRVTrtsstBCz34eSTcFuSh8xOdIJfvtKJ0/S3YG8qtuZO+h
         LVw/GM01Blb4idgGSfUfT/5N9ejTRXvuE5Mw1vrfiD3+t4k4Xbat5lWBMHcLkl/46L
         MZPNmMJsegfvf0rTSEXW5sH0CokCzOrUgUPmh+IzXUqga3I07y9uao2n9w8QT5IQiS
         MZzetOEpR2Sv47PnKm1OJ3NaodmMfXpe4ekWd75YuDtjccDI1UPYcXzuqMblveH5rR
         DHTVp2kedMNHw==
Date:   Tue, 20 Dec 2022 20:13:14 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <Y6IXWltScF2CI1v3@gmail.com>
References: <20221212185347.1286824-1-Jason@zx2c4.com>
 <86cfa465-2485-ff24-16f5-9014e25a0e98@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86cfa465-2485-ff24-16f5-9014e25a0e98@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 05:17:52PM +0000, Christophe Leroy wrote:
> Hi Jason,
> 
> Le 12/12/2022 à 19:53, Jason A. Donenfeld a écrit :
> > Changes v11->v12:
> > ----------------
> > - In order to avoid mlock()ing pages, and the related rlimit and fork
> >    inheritance issues there, Introduce VM_DROPPABLE to prevent swapping
> >    while meeting the cache-like requirements of vDSO getrandom().
> > 
> >    This has some tenticles in mm/ and arch/x86/ code, so I've marked the
> >    two patches for that as still RFC, while the rest of the series is not
> >    RFC.
> > 
> > - Mandate that opaque state blobs don't straddle page boundaries, so
> >    that VM_DROPPABLE can work on page-level granularity rather than
> >    allocation-level granularity.
> > 
> > - Add compiler barriers to vDSO getrandom() to prevent theoretical
> >    reordering potential.
> > 
> > - Initialize the trials loop counter in the chacha test.
> 
> I would have liked to give it a try on powerpc, but the series 
> conflicts. I tried both on v6.1 and on linus/master from now:
> 

Same here, I can't figure out how to apply this series.

It would help if people always used the --base option to git format-patch...

- Eric
