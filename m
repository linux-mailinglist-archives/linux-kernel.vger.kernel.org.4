Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461FC5F6B0A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiJFPxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiJFPw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:52:58 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E1FA99D3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:52:56 -0700 (PDT)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 728C4108545A;
        Thu,  6 Oct 2022 17:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1665071573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQ0i0sPzuTtjUDaZgb8tL1dtkl35e6HuhYlKu+zcPPE=;
        b=uq5/L5BuWqCoH8S9tu9NmPWBB1CDesmvt8wC+zhGouw6l4UqrVoKuB24EpRURCd9oW+/4g
        wNEPCcZs9rp0TfRR+K4rMV4IpMk93yxYTFjcm+E918kzPDXiSNPIPZKSh8y36SqaTm8K8z
        4xnaXL6YvqpdOZOHyb+4v4RjSAyJvu0=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: Panic/lockup in z3fold_zpool_free
Date:   Thu, 06 Oct 2022 17:52:52 +0200
Message-ID: <2650550.mvXUDI8C0e@natalenko.name>
In-Reply-To: <2650562.mvXUDI8C0e@natalenko.name>
References: <6f834faddf927b6fa5a8edd8adfde63c@natalenko.name> <YyxJAObMV8tFVLkM@bfoster> <2650562.mvXUDI8C0e@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On p=C3=A1tek 23. z=C3=A1=C5=99=C3=AD 2022 10:33:14 CEST Oleksandr Natalenk=
o wrote:
> On =C4=8Dtvrtek 22. z=C3=A1=C5=99=C3=AD 2022 13:37:36 CEST Brian Foster w=
rote:
> > On Thu, Sep 22, 2022 at 08:53:09AM +0200, Oleksandr Natalenko wrote:
> > > Since 5.19 series, zswap went unstable for me under memory pressure, =
and
> > > occasionally I get the following:
> > >=20
> > > ```
> > > watchdog: BUG: soft lockup - CPU#0 stuck for 10195s! [mariadbd:478]
> > > Modules linked in: netconsole joydev mousedev intel_agp psmouse pcspkr
> > > intel_gtt cfg80211 cirrus i2c_piix4 tun rfkill mac_hid nft_ct tcp_bbr2
> > > nft_chain_nat nf_tables nfnetlink nf_nat nf_conntrack nf_defrag_ipv6
> > > nf_defrag_ipv4 fuse qemu_fw_cfg ip_tables x_tables xfs libcrc32c
> > > crc32c_generic dm_crypt cbc encrypted_keys trusted asn1_encoder tee t=
pm
> > > rng_core dm_mod crct10dif_pclmul crc32_pclmul crc32c_intel
> > > ghash_clmulni_intel virtio_net aesni_intel serio_raw net_failover
> > > ata_generic virtio_balloon failover pata_acpi crypto_simd virtio_blk =
atkbd
> > > libps2 vivaldi_fmap virtio_pci cryptd virtio_pci_legacy_dev ata_piix
> > > virtio_pci_modern_dev i8042 floppy serio usbhid
> > > Unloaded tainted modules: intel_cstate():1 intel_uncore():1 pcc_cpufr=
eq():1
> > > acpi_cpufreq():1
> > > CPU: 0 PID: 478 Comm: mariadbd Tainted: G             L    5.19.0-pf5=
 #1
> > > 12baccda8e49539e158b9dd97cbda6c7317d73af
> > > Hardware name: Red Hat KVM, BIOS 1.11.0-2.el7 04/01/2014
> > > RIP: 0010:z3fold_zpool_free+0x4c/0x5e0
> > > Code: 7c 24 08 48 89 04 24 0f 85 e0 00 00 00 48 89 f5 41 bd 00 00 00 =
80 48
> > > 83 e5 c0 48 83 c5 28 eb 0a 48 89 df e8 b6 8d 9f 00 f3 90 <48> 89 ef e=
8 bc 8b
> > > 9f 00 4d 8b 34 24 49 81 e6 00 f0 ff ff 49 8d 5e
> > > RSP: 0000:ffffbeadc0e87b68 EFLAGS: 00000202
> > > RAX: 0000000000000030 RBX: ffff99ac73d2c010 RCX: ffff99ac4e4ba380
> > > RDX: 0000665340000000 RSI: ffffe3b540000000 RDI: ffff99ac73d2c010
> > > RBP: ffff99ac55ef3a68 R08: ffff99ac422f0bf0 R09: 000000000000c60b
> > > R10: ffffffffffffffc0 R11: 0000000000000000 R12: ffff99ac55ef3a50
> > > R13: 0000000080000000 R14: ffff99ac73d2c000 R15: ffff99acf3d2c000
> > > FS:  00007f587fcd66c0(0000) GS:ffff99ac7ec00000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f587ce8bec8 CR3: 0000000005b48006 CR4: 00000000000206f0
> > > Call Trace:
> > >  <TASK>
> > >  zswap_free_entry+0xb5/0x110
> > >  zswap_frontswap_invalidate_page+0x72/0xa0
> > >  __frontswap_invalidate_page+0x3a/0x60
> > >  swap_range_free+0xb5/0xd0
> > >  swapcache_free_entries+0x16e/0x2e0
> > >  free_swap_slot+0xb4/0xc0
> > >  put_swap_page+0x259/0x420
> > >  delete_from_swap_cache+0x63/0xb0
> > >  try_to_free_swap+0x1b5/0x2a0
> > >  do_swap_page+0x24c/0xb80
> > >  __handle_mm_fault+0xa59/0xf70
> > >  handle_mm_fault+0x100/0x2f0
> > >  do_user_addr_fault+0x1c7/0x6a0
> > >  exc_page_fault+0x74/0x170
> > >  asm_exc_page_fault+0x26/0x30
> > > RIP: 0033:0x556e96280428
> > > Code: a0 03 00 00 67 e8 28 64 ff ff 48 8b 83 b0 00 00 00 48 8b 0d da =
18 72
> > > 00 48 8b 10 66 48 0f 6e c1 48 85 d2 74 27 0f 1f 44 00 00 <48> c7 82 9=
8 00 00
> > > 00 00 00 00 00 48 8b 10 48 83 c0 08 f2 0f 11 82
> > > RSP: 002b:00007f587fcd3980 EFLAGS: 00010206
> > > RAX: 00007f587d028468 RBX: 00007f587cb1a818 RCX: 3ff0000000000000
> > > RDX: 00007f587ce8be30 RSI: 0000000000000000 RDI: 00007f587cedd030
> > > RBP: 00007f587fcd39c0 R08: 0000000000000016 R09: 0000000000000000
> > > R10: 0000000000000008 R11: 0000556e970961a0 R12: 00007f587d1f17b8
> > > R13: 00007f5883595598 R14: 00007f587d1f17a8 R15: 00007f587cb1a928
> > >  </TASK>
> > > ```
> > >=20
> > > This happens on the latest v5.19.10 kernel as well.
> > >=20
> > > Sometimes it's not a soft lockup but GPF, although the stack trace is=
 the
> > > same. So, to me it looks like a memory corruption, UAF, double free or
> > > something like that.
> > >=20
> > > Have you got any idea regarding what's going on?
> > >=20
> >=20
> > It might be unrelated, but this looks somewhat similar to a problem I
> > hit recently that is caused by swap entry data stored in page->private
> > being clobbered when splitting a huge page. That problem was introduced
> > in v5.19, so that potentially lines up as well.
> >=20
> > More details in the links below. [1] includes a VM_BUG_ON() splat with
> > DEBUG_VM enabled, but the problem originally manifested as a soft lockup
> > without the debug checks enabled. [2] includes a properly formatted
> > patch. Any chance you could give that a try?
>=20
> Thanks for your reply.
>=20
> I'll give it a try. The only problem is that for me the issue is not repr=
oducible at will, it can take 1 day, or it can take 2 weeks before the pani=
c is hit.
>=20
> > [1] https://lore.kernel.org/linux-mm/YxDyZLfBdFHK1Y1P@bfoster/
> > [2] https://lore.kernel.org/linux-mm/20220906190602.1626037-1-bfoster@r=
edhat.com/

So far, I haven't reproduced this issue with your patch. I haven't run the =
machine sufficiently long, just under a week, so this is rather to let you =
know that I haven't abandoned testing.

Thanks.


=2D-=20
Oleksandr Natalenko (post-factum)


