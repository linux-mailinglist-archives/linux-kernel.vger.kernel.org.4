Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951E1730D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbjFODHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbjFODHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:07:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C230026A9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:07:30 -0700 (PDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4QhRzj0gN6z4wjF;
        Thu, 15 Jun 2023 13:07:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhRzh71vKz4wgq;
        Thu, 15 Jun 2023 13:07:28 +1000 (AEST)
From:   Michael Ellerman <michaele@au1.ibm.com>
To:     Sachin Sant <sachinp@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, jarkko@kernel.org
Subject: Re: [6.4-rc6] Crash during a kexec operation
 (tpm_amd_is_rng_defective)
In-Reply-To: <99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com>
References: <99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com>
Date:   Thu, 15 Jun 2023 13:07:26 +1000
Message-ID: <87o7lhfmoh.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sachin Sant <sachinp@linux.ibm.com> writes:
> Following crash is observed during a kexec operation on 
> IBM Power10 server:
>
> [ 34.381548] Kernel attempted to read user page (50) - exploit attempt? (uid: 0)
> [ 34.381562] BUG: Kernel NULL pointer dereference on read at 0x00000050
> [ 34.381565] Faulting instruction address: 0xc0000000009db1e4
> [ 34.381569] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 34.381572] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> [ 34.381576] Modules linked in: dm_mod(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) bonding(E) tls(E) rfkill(E) ip_set(E) sunrpc(E) nf_tables(E) nfnetlink(E) pseries_rng(E) aes_gcm_p10_crypto(E) drm(E) drm_panel_orientation_quirks(E) xfs(E) libcrc32c(E) sd_mod(E) sr_mod(E) t10_pi(E) crc64_rocksoft_generic(E) cdrom(E) crc64_rocksoft(E) crc64(E) sg(E) ibmvscsi(E) scsi_transport_srp(E) ibmveth(E) vmx_crypto(E) fuse(E)
> [ 34.381613] CPU: 18 PID: 5918 Comm: kexec Kdump: loaded Tainted: G E 6.4.0-rc6-00037-gb6dad5178cea #3
> [ 34.381618] Hardware name: IBM,9080-HEX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1030.20 (NH1030_058) hv:phyp pSeries
> [ 34.381621] NIP: c0000000009db1e4 LR: c0000000009db928 CTR: c0000000009eab60
> [ 34.381625] REGS: c00000009742f780 TRAP: 0300 Tainted: G E (6.4.0-rc6-00037-gb6dad5178cea)
> [ 34.381628] MSR: 800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE> CR: 44488884 XER: 00000001
> [ 34.381638] CFAR: c0000000009db19c DAR: 0000000000000050 DSISR: 40000000 IRQMASK: 0 
> [ 34.381638] GPR00: c0000000009db928 c00000009742fa20 c0000000014a1500 c0000000081d0000 
> [ 34.381638] GPR04: c00000000d842c50 c00000000d842c50 0000000000000025 fffffffffffe0000 
> [ 34.381638] GPR08: 0000000000000000 0000000000000000 0000000000000009 c008000000785280 
> [ 34.381638] GPR12: c0000000009eab60 c00000135fab7f00 0000000000000000 0000000000000000 
> [ 34.381638] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 34.381638] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 34.381638] GPR24: 0000000000000000 0000000000000000 0000000000000000 c000000002e21e08 
> [ 34.381638] GPR28: c00000000d842c48 c000000002a02208 c00000000321c0c0 c0000000081d0000 
> [ 34.381674] NIP [c0000000009db1e4] tpm_amd_is_rng_defective+0x74/0x240
> [ 34.381681] LR [c0000000009db928] tpm_chip_unregister+0x138/0x160
> [ 34.381685] Call Trace:
> [ 34.381686] [c00000009742faa0] [c0000000009db928] tpm_chip_unregister+0x138/0x160
> [ 34.381690] [c00000009742fae0] [c0000000009eab94] tpm_ibmvtpm_remove+0x34/0x130
...
> [ 34.381788] Code: 5463063e 408201c8 38210080 4e800020 60000000 60000000 60000000 7c0802a6 fbe10078 7c7f1b78 f8010090 e9230728 <e9890050> 2c2c0000 41820020 7d8903a6 

  2c:   28 07 23 e9     ld      r9,1832(r3)
  30:   50 00 89 e9     ld      r12,80(r9)

Where r3 is *chip.
r9 is NULL, and 80 = 0x50.

Looks like a NULL chip->ops, which oopses in:

static int tpm_request_locality(struct tpm_chip *chip)
{
	int rc;

	if (!chip->ops->request_locality)


Can you test the patch below?

cheers


diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index cd48033b804a..82eb36e2e16d 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -36,7 +36,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 {
 	int rc;
 
-	if (!chip->ops->request_locality)
+	if (!chip->ops || !chip->ops->request_locality)
 		return 0;
 
 	rc = chip->ops->request_locality(chip, 0);
