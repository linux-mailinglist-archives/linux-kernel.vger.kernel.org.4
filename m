Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3FA619C5D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiKDP7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiKDP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:59:42 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466CB3054D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:59:40 -0700 (PDT)
Date:   Sat, 5 Nov 2022 00:59:30 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667577579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=hvKqqCFa2Y3MaM+wraMd6xMk0p5uNFUgrkQpd1dibAI=;
        b=eHtc8PgjHaKlv1TpPFmVGhbRE0mKoY7czsJGPW6D8CVNyBADa6qytE0Tpjlc/1RTKCkkMD
        gTttOEsjF0bT9kyK91zYPpI0ucEDg00lRn/hBL11UAEOI1yZ7HSMR9qpwaW8QBnJYFEimB
        p9ENNaY15+GTp9yyy8GBSvNRsbqy6GI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     ville.syrjala@linux.intel.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        regressions@lists.linux.dev, naoya.horiguchi@nec.com
Subject: Re: [mm-unstable PATCH v7 2/8] mm/hugetlb: make pud_huge() and
 follow_huge_pud() aware of non-present pud entry
Message-ID: <20221104155930.GA527246@ik1-406-35019.vs.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2LYXItKQyaJTv8j@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 10:51:40PM +0200, Ville Syrjälä wrote:
> On Thu, Jul 14, 2022 at 01:24:14PM +0900, Naoya Horiguchi wrote:
> > +/*
> > + * pud_huge() returns 1 if @pud is hugetlb related entry, that is normal
> > + * hugetlb entry or non-present (migration or hwpoisoned) hugetlb entry.
> > + * Otherwise, returns 0.
> > + */
> >  int pud_huge(pud_t pud)
> >  {
> > -	return !!(pud_val(pud) & _PAGE_PSE);
> > +	return !pud_none(pud) &&
> > +		(pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
> >  }
> 
> Hi,
> 
> This causes i915 to trip a BUG_ON() on x86-32 when I start X.

Hello,

Thank you for finding and reporting the issue.

x86-32 does not enable CONFIG_ARCH_HAS_GIGANTIC_PAGE, so pud_huge() is
supposed to be false on x86-32.  Doing like below looks to me a fix
(reverting to the original behavior for x86-32):


diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 6b3033845c6d..bf73f25aaa32 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -37,8 +37,12 @@ int pmd_huge(pmd_t pmd)
  */
 int pud_huge(pud_t pud)
 {
+#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
        return !pud_none(pud) &&
                (pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
+#else
+       return !!(pud_val(pud) & _PAGE_PSE);    // or "return 0;" ?
+#endif
 }

 #ifdef CONFIG_HUGETLB_PAGE


Let me guess what the PUD entry was there when triggering the issue.
Assuming that the original code (before 3a194f3f8ad0) was correct, the PSE
bit in pud_val(pud) should be always cleared.  So, when pud_huge() returns
true since 3a194f3f8ad0, the PRESENT bit should be clear and some other
bits (rather than PRESENT and PSE) are set so that pud_none() is false.
I'm not sure what such a non-present PUD entry does mean.

Thanks,
Naoya Horiguchi

> 
> [  225.777375] kernel BUG at mm/memory.c:2664!
> [  225.777391] invalid opcode: 0000 [#1] PREEMPT SMP
> [  225.777405] CPU: 0 PID: 2402 Comm: Xorg Not tainted 6.1.0-rc3-bdg+ #86
> [  225.777415] Hardware name:  /8I865G775-G, BIOS F1 08/29/2006
> [  225.777421] EIP: __apply_to_page_range+0x24d/0x31c
> [  225.777437] Code: ff ff 8b 55 e8 8b 45 cc e8 0a 11 ec ff 89 d8 83 c4 28 5b 5e 5f 5d c3 81 7d e0 a0 ef 96 c1 74 ad 8b 45 d0 e8 2d 83 49 00 eb a3 <0f> 0b 25 00 f0 ff ff 81 eb 00 00 00 40 01 c3 8b 45 ec 8b 00 e8 76
> [  225.777446] EAX: 00000001 EBX: c53a3b58 ECX: b5c00000 EDX: c258aa00
> [  225.777454] ESI: b5c00000 EDI: b5900000 EBP: c4b0fdb4 ESP: c4b0fd80
> [  225.777462] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010202
> [  225.777470] CR0: 80050033 CR2: b5900000 CR3: 053a3000 CR4: 000006d0
> [  225.777479] Call Trace:
> [  225.777486]  ? i915_memcpy_init_early+0x63/0x63 [i915]
> [  225.777684]  apply_to_page_range+0x21/0x27
> [  225.777694]  ? i915_memcpy_init_early+0x63/0x63 [i915]
> [  225.777870]  remap_io_mapping+0x49/0x75 [i915]
> [  225.778046]  ? i915_memcpy_init_early+0x63/0x63 [i915]
> [  225.778220]  ? mutex_unlock+0xb/0xd
> [  225.778231]  ? i915_vma_pin_fence+0x6d/0xf7 [i915]
> [  225.778420]  vm_fault_gtt+0x2a9/0x8f1 [i915]
> [  225.778644]  ? lock_is_held_type+0x56/0xe7
> [  225.778655]  ? lock_is_held_type+0x7a/0xe7
> [  225.778663]  ? 0xc1000000
> [  225.778670]  __do_fault+0x21/0x6a
> [  225.778679]  handle_mm_fault+0x708/0xb21
> [  225.778686]  ? mt_find+0x21e/0x5ae
> [  225.778696]  exc_page_fault+0x185/0x705
> [  225.778704]  ? doublefault_shim+0x127/0x127
> [  225.778715]  handle_exception+0x130/0x130
> [  225.778723] EIP: 0xb700468a
> [  225.778730] Code: 44 24 40 8b 7c 24 1c 89 47 54 8b 44 24 5c 65 2b 05 14 00 00 00 0f 85 8a 01 00 00 83 c4 6c 5b 5e 5f 5d c3 8b 44 24 1c 8b 40 28 <c7> 00 00 00 00 00 8b 44 24 20 8d 90 20 1b 00 00 8b 02 83 e8 01 89
> [  225.778738] EAX: b5900000 EBX: b7148000 ECX: 00000000 EDX: 00000000
> [  225.778745] ESI: 0103eb60 EDI: b7148000 EBP: b6cf7000 ESP: bfd76650
> [  225.778752] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010246
> [  225.778761]  ? doublefault_shim+0x127/0x127
> [  225.778769] Modules linked in: i915 prime_numbers i2c_algo_bit iosf_mbi drm_buddy video wmi drm_display_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm drm_panel_orientation_quirks backlight cfg80211 rfkill sch_fq_codel xt_tcpudp xt_multiport xt_state iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv4 ip_tables x_tables binfmt_misc i2c_dev iTCO_wdt snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm snd_timer psmouse i2c_i801 snd i2c_smbus uhci_hcd i2c_core pcspkr soundcore lpc_ich mfd_core ehci_pci ehci_hcd skge intel_agp intel_gtt usbcore agpgart usb_common rng_core parport_pc parport evdev
> [  225.778899] ---[ end trace 0000000000000000 ]---
> [  225.778906] EIP: __apply_to_page_range+0x24d/0x31c
> [  225.778916] Code: ff ff 8b 55 e8 8b 45 cc e8 0a 11 ec ff 89 d8 83 c4 28 5b 5e 5f 5d c3 81 7d e0 a0 ef 96 c1 74 ad 8b 45 d0 e8 2d 83 49 00 eb a3 <0f> 0b 25 00 f0 ff ff 81 eb 00 00 00 40 01 c3 8b 45 ec 8b 00 e8 76
> [  225.778924] EAX: 00000001 EBX: c53a3b58 ECX: b5c00000 EDX: c258aa00
> [  225.778931] ESI: b5c00000 EDI: b5900000 EBP: c4b0fdb4 ESP: c4b0fd80
> [  225.778938] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010202
> [  225.778946] CR0: 80050033 CR2: b5900000 CR3: 053a3000 CR4: 000006d0
> 
> -- 
> Ville Syrjälä
> Intel
