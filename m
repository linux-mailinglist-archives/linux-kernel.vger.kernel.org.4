Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198BC61F385
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiKGMly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiKGMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:41:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E24918B3F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:41:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0637C224B0;
        Mon,  7 Nov 2022 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667824910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/x/1mci2VKQOrgCg6u84GQYMUF90/boVK2bBGca/jb4=;
        b=SY35+fnF4ybsrusYCaIwV9dQGyU+HzMHojxfBDDGTuzIZ6VMj9+71u7otyUWlcT6nFmz7A
        ai8nggY+ZbUHE0hfa7ObwGYtTvJWHFlK0lozulhjSh/9kBDbBtv6lLW+AznozXXkPFVxVP
        sxUe32k6Z0aXXwkneg5iLOzBQRcLwV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667824910;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/x/1mci2VKQOrgCg6u84GQYMUF90/boVK2bBGca/jb4=;
        b=8C+olMdncS283awPAoHhqKAYIG4JNUQW9t7WbYdRN27IXsgoYfmZwB/Yjdu7zqky9FJDbP
        kzd/zB80J+5AjYCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC39613AC7;
        Mon,  7 Nov 2022 12:41:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T+1hOQ39aGNMPwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Nov 2022 12:41:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4F620A0704; Mon,  7 Nov 2022 13:41:49 +0100 (CET)
Date:   Mon, 7 Nov 2022 13:41:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <20221107124149.bbcigolec3z7bfau@quack3>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <20221104080637.626-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104080637.626-1-hdanton@sina.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-11-22 16:06:37, Hillf Danton wrote:
> On 3 Nov 2022 12:54:44 +0100 Jan Kara <jack@suse.cz>
> > Hello,
> > 
> > I was tracking down the following crash with 6.0 kernel with
> > patch-6.0.5-rt14.patch applied:
> > 
> > [ T6611] ------------[ cut here ]------------
> > [ T6611] kernel BUG at fs/inode.c:625!
> > [ T6611] Internal error: Oops - BUG: 0 [#1] PREEMPT_RT SMP
> > [ T6611] Modules linked in: xfs(E) af_packet(E) iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) mlx5_ib(E) ib_uverbs(E) ib_core(E) arm_spe_pmu(E) mlx5_core(E) sunrpc(E) mlxfw(E) pci_hyperv_intf(E) nls_iso8859_1(E) acpi_ipmi(E) nls_cp437(E) ipmi_ssif(E) vfat(E) ipmi_devintf(E) tls(E) igb(E) psample(E) button(E) arm_cmn(E) arm_dmc620_pmu(E) ipmi_msghandler(E) fat(E) cppc_cpufreq(E) arm_dsu_pmu(E) fuse(E) ip_tables(E) x_tables(E) ast(E) i2c_algo_bit(E) drm_vram_helper(E) aes_ce_blk(E) aes_ce_cipher(E) crct10dif_ce(E) ghash_ce(E) gf128mul(E) nvme(E) drm_kms_helper(E) sha2_ce(E) syscopyarea(E) sha256_arm64(E) sysfillrect(E) xhci_pci(E) sha1_ce(E) sysimgblt(E) nvme_core(E) xhci_pci_renesas(E) fb_sys_fops(E) nvme_common(E) drm_ttm_helper(E) sbsa_gwdt(E) t10_pi(E) ttm(E) xhci_hcd(E) crc64_rocksoft_generic(E) crc64_rocksoft(E) usbcore(E) crc64(E) drm(E) usb_common(E) i2c_designware_platform(E) i2c_designware_core(E) btrfs(E) blake2b_generic(E) libcrc32c(E) xor(E) xor_neon(E)
> > [ T6611]  raid6_pq(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) scsi_common(E)
> > [ T6611] CPU: 11 PID: 6611 Comm: dbench Tainted: G            E   6.0.0-rt14-rt+ #1 4a18df02c109f1e703cf2ff86b77cf9cd9d5a188
> > [ T6611] Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F16f (SCP: 1.06.20210615) 07/01/2021
> > [ T6611] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [ T6611] pc : clear_inode+0xa0/0xc0
> > [ T6611] lr : clear_inode+0x38/0xc0
> > [ T6611] sp : ffff80000f4f3cd0
> > [ T6611] x29: ffff80000f4f3cd0 x28: ffff07ff92142000 x27: 0000000000000000
> > [ T6611] x26: ffff08012aef6058 x25: 0000000000000002 x24: ffffb657395e8000
> > [ T6611] x23: ffffb65739072008 x22: ffffb656e0bed0a8 x21: ffff08012aef6190
> > [ T6611] x20: ffff08012aef61f8 x19: ffff08012aef6058 x18: 0000000000000014
> > [ T6611] x17: 00000000f0d86255 x16: ffffb65737dfdb00 x15: 0100000004000000
> > [ T6611] x14: 644d000008090000 x13: 644d000008090000 x12: ffff80000f4f3b20
> > [ T6611] x11: 0000000000000002 x10: ffff083f5ffbe1c0 x9 : ffffb657388284a4
> > [ T6611] x8 : fffffffffffffffe x7 : ffff80000f4f3b20 x6 : ffff80000f4f3b20
> > [ T6611] x5 : ffff08012aef6210 x4 : ffff08012aef6210 x3 : 0000000000000000
> > [ T6611] x2 : ffff08012aef62d8 x1 : ffff07ff8fbbf690 x0 : ffff08012aef61a0
> > [ T6611] Call trace:
> > [ T6611]  clear_inode+0xa0/0xc0
> > [ T6611]  evict+0x160/0x180
> > [ T6611]  iput+0x154/0x240
> > [ T6611]  do_unlinkat+0x184/0x300
> > [ T6611]  __arm64_sys_unlinkat+0x48/0xc0
> > [ T6611]  el0_svc_common.constprop.4+0xe4/0x2c0
> > [ T6611]  do_el0_svc+0xac/0x100
> > [ T6611]  el0_svc+0x78/0x200
> > [ T6611]  el0t_64_sync_handler+0x9c/0xc0
> > [ T6611]  el0t_64_sync+0x19c/0x1a0
> > [ T6611] Code: d4210000 d503201f d4210000 d503201f (d4210000) 
> > [ T6611] ---[ end trace 0000000000000000 ]---
> > 
> > The machine is aarch64 architecture, kernel config is attached. I have seen
> > the crashes also with 5.14-rt kernel so it is not a new thing. The crash is
> > triggered relatively reliably (on two different aarch64 machines) by our
> > performance testing framework when running dbench benchmark against an XFS
> > filesystem.
> > 
> > Now originally I thought this is some problem with XFS or writeback code
> > but after debugging this for some time I don't think that anymore.
> > clear_inode() complains about inode->i_wb_list being non-empty. In fact
> > looking at the list_head, I can see it is corrupted. In all the occurences
> > of the problem ->prev points back to the list_head itself but ->next points
> > to some list_head that used to be part of the sb->s_inodes_wb list (or
> > actually that list spliced in wait_sb_inodes() because I've seen a pointer to
> > the stack as ->next pointer as well).
> > 
> > This is not just some memory ordering issue with the check in
> > clear_inode(). If I add sb->s_inode_wblist_lock locking around the check in
> > clear_inode(), the problem still reproduces.
> > 
> > If I enable CONFIG_DEBUG_LIST or if I convert sb->s_inode_wblist_lock to
> > raw_spinlock_t, the problem disappears.
> > 
> > Finally, I'd note that the list is modified from three places which makes
> > audit relatively simple. sb_mark_inode_writeback(),
> > sb_clear_inode_writeback(), and wait_sb_inodes(). All these places hold
> > sb->s_inode_wblist_lock when modifying the list. So at this point I'm at
> > loss what could be causing this. As unlikely as it seems to me I've started
> > wondering whether it is not some subtle issue with RT spinlocks on aarch64
> > possibly in combination with interrupts (because sb_clear_inode_writeback()
> > may be called from an interrupt).
> > 
> > Any ideas?
> 
> Feel free to collect debug info ONLY in your spare cycles, given your
> relatively reliable reproducer.

So in fact I made sure (by debug counters) that sb_mark_inode_writeback()
and sb_clear_inode_writeback() get called the same number of times before
evict() gets called. So your debug patch would change nothing AFAICT...

								Honza


> +++ b/fs/fs-writeback.c
> @@ -1256,6 +1256,7 @@ void sb_mark_inode_writeback(struct inod
>  	if (list_empty(&inode->i_wb_list)) {
>  		spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
>  		if (list_empty(&inode->i_wb_list)) {
> +			ihold(inode);
>  			list_add_tail(&inode->i_wb_list, &sb->s_inodes_wb);
>  			trace_sb_mark_inode_writeback(inode);
>  		}
> @@ -1272,12 +1273,19 @@ void sb_clear_inode_writeback(struct ino
>  	unsigned long flags;
>  
>  	if (!list_empty(&inode->i_wb_list)) {
> +		int put = 0;
>  		spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
>  		if (!list_empty(&inode->i_wb_list)) {
> +			put = 1;
>  			list_del_init(&inode->i_wb_list);
>  			trace_sb_clear_inode_writeback(inode);
>  		}
>  		spin_unlock_irqrestore(&sb->s_inode_wblist_lock, flags);
> +		if (put) {
> +			ihold(inode);
> +			iput(inode);
> +			iput(inode);
> +		}
>  	}
>  }
>  
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
