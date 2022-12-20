Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD38652783
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiLTUCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiLTUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:02:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CCB1D321;
        Tue, 20 Dec 2022 12:02:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BC0AB81980;
        Tue, 20 Dec 2022 20:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59D8C433EF;
        Tue, 20 Dec 2022 20:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671566568;
        bh=NuKWALWvqUDHPuIolpje8BOkN9wBD5QKiFERUmc1WBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4YVmBvyCUSn46y+nCKFk/IoGWAEo/35kPbbHetOA98UicNzQLIds7TTZW7PJERv2
         ZlBx3JTMi5jmsT4A4xJuBy7QGGBPYX5FtY+KaPQpAi7EDiyxnLjwjruAlL1zSU5Vmu
         177R/Sl/CsryALUwidpzw/p+cWrusCGk13BVhCJ0LFzE8BfBlk9VsmGb9ixUh5p/S1
         e6I4Urq4iYmt+P0fAtA+qooekYQqcXN3TQidEwQK1O56y5PE3vZRnfBlWqef8TRsb8
         OrUdt4p9WS27wKYMa3abNrTX8SQ+0/Gmyhbcg1aX/y7671alVzMzbDmCBOkXoVeVsx
         ki1mt+2sbSyoQ==
Date:   Tue, 20 Dec 2022 20:02:32 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, Jason@zx2c4.com,
        ardb@kernel.org, ap420073@gmail.com, David.Laight@aculab.com,
        tim.c.chen@linux.intel.com, peter@n8pjl.ca, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] crypto: x86 - yield FPU context during long loops
Message-ID: <Y6IU2CmNE18RzByP@gmail.com>
References: <20221219220223.3982176-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219220223.3982176-1-elliott@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 04:02:10PM -0600, Robert Elliott wrote:
> This is an offshoot of the previous patch series at:
>   https://lore.kernel.org/linux-crypto/20221219202910.3063036-1-elliott@hpe.com
> 
> Add a kernel_fpu_yield() function for x86 crypto drivers to call
> periodically during long loops.
> 
> Test results
> ============
> I created 28 tcrypt modules so modprobe can run concurrent tests,
> added 1 MiB functional and speed tests to tcrypt, and ran three processes
> spawning 28 subprocesses (one per physical CPU core) each looping forever
> through all the tcrypt test modes. This keeps the system quite busy,
> generating RCU stalls and soft lockups during both generic and x86
> crypto function processing.
> 
> In conjunction with these patch series:
> * [PATCH 0/8] crypto: kernel-doc for assembly language
>   https://lore.kernel.org/linux-crypto/20221219185555.433233-1-elliott@hpe.com
> * [PATCH 0/3] crypto/rcu: suppress unnecessary CPU stall warnings
>   https://lore.kernel.org/linux-crypto/20221219202910.3063036-1-elliott@hpe.com
> * [PATCH 0/3] crypto: yield at end of operations
>   https://lore.kernel.org/linux-crypto/20221219203733.3063192-1-elliott@hpe.com
> 
> while using the default RCU values (60 s stalls, 21 s expedited stalls),
> several nights of testing did not result in any RCU stall warnings or soft
> lockups in any of these preemption modes:
>    preempt=none
>    preempt=voluntary
>    preempt=full
> 
> Setting the shortest possible RCU timeouts (3 s, 20 ms) did still result
> in RCU stalls, but only about one every 2 hours, and not occurring
> on particular modules like sha512_ssse3 and sm4-generic.
> 
> systemd usually crashes and restarts when its journal becomes full from
> all the tcrypt printk messages. Without the patches, that triggered more
> RCU stall reports and soft lockups; with the patches, only userspace
> seems perturbed.
> 

Where does this patch series apply to?

- Eric
