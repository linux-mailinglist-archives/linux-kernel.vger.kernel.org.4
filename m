Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41E35FB8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJKRET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJKREK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1657B43AC7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E244611E4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 17:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5F9C433D6;
        Tue, 11 Oct 2022 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665507847;
        bh=QFWretD5XAgF1hs6LQIHm6e4n5ZNZUx8I1gdUxgAZ/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nl38CY5bfejPeodSJaRGdCvu5/ye1FJ7kNlgSbY1Ji2kCK0GE6N6kLCnc4RD+dwlI
         x5swoRQ8CuNWyzlFgAOJcyHpIfbAnJ82oQNB60dLqGtQR2lFTPi2PIGoE61Rf4DPyI
         20ZMhtRdfx4UGsare3jcqr/q6H02Wu/Dgz1QufaI7jqtBO2tNkjU8bO3BSwOBEeNwg
         j93HGlYa9bmVrnWRd45AlCZRhbZlIs4GltmiV6ArvsSp2OSymeDCsioLyNFOr2+w42
         iMaHjKeCYyWeaaYEZXxfGw30QEDCIJ5JlFeHt51t9FSKIg4kj+2Biw5Ou+r3RwK5pg
         ugCl9EEjG48aQ==
Date:   Tue, 11 Oct 2022 18:04:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        Conor.Dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Make mmap() with PROT_WRITE imply PROT_READ
Message-ID: <Y0WiAgnN5IcQDrez@spud>
References: <20220915193702.2201018-1-abrestic@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915193702.2201018-1-abrestic@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Palmer,

On Thu, Sep 15, 2022 at 03:37:00PM -0400, Andrew Bresticker wrote:
> Commit 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is
> invalid") made mmap() reject mappings with only PROT_WRITE set in an
> attempt to fix an observed inconsistency in behavior when attempting
> to read from a PROT_WRITE-only mapping. The root cause of this behavior
> was actually that while RISC-V's protection_map maps VM_WRITE to
> readable PTE permissions (since write-only PTEs are considered reserved
> by the privileged spec), the page fault handler considered loads from
> VM_WRITE-only VMAs illegal accesses. Fix the underlying cause by
> handling faults in VM_WRITE-only VMAs (patch 1) and then re-enable
> use of mmap(PROT_WRITE) (patch 2), making RISC-V's behavior consistent
> with all other architectures that don't support write-only PTEs.
> 
> Both patches are tagged as fixes for the aforementioned commit since that
> commit made a userspace visible change that will break any software relying
> on mmap(PROT_WRITE). (Also cc: stable since the offending commit was
> itself backported to stable).

The patch that these commits fix has hit the distros & manifests as a
userspace breakage for openJDK:
https://lore.kernel.org/linux-riscv/a69ee775-e565-3d72-eb5f-8378616694d3@gmail.com/
https://lore.kernel.org/linux-riscv/d6c9e249-08bd-4439-7dcc-371b32e7b851@canonical.com/

Eva tested these patches and reported that their problem was fixed:
https://lore.kernel.org/linux-riscv/20282242-5cad-42be-ce6c-834b0e7ef269@gmail.com/

I asked them for a T-b but I don't see one on lore etc, but it would be
from Eva Kotova <nyandarknessgirl@gmail.com> if you consider their
comments their sufficient for a T-B

Thanks,
Conor.

> 
> v1 -> v2: Allow handling of load faults in VM_WRITE VMAs
> v2 -> v3: Split into two pathces
> v3 -> v4: Fixes tags (+ this cover letter)
> 
> Andrew Bresticker (2):
>   riscv: Make VM_WRITE imply VM_READ
>   riscv: Allow PROT_WRITE-only mmap()
> 
>  arch/riscv/kernel/sys_riscv.c | 3 ---
>  arch/riscv/mm/fault.c         | 3 ++-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
