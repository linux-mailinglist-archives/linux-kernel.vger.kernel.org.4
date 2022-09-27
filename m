Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDA25EC857
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiI0Pl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiI0PkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:40:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D67B1D05C9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:37:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B72DCE189A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 15:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBD2C433D7;
        Tue, 27 Sep 2022 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664293051;
        bh=kaonFxPHFP9c3oc0xQ1sbz7q3Xz1JH0DOwDgQK9xliU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXq+1/wskynGAhYGzrwWQmalLnnfobOiJehIAjHIxV07e9FodZLij8Tey9gsIhHsx
         q5casJoy6HsRiWJQr0Jzen6bF+xnEL4yNhrYeLJ+Ak9wTO8fb4zGmaa8rL62i28PSs
         l1hmjYmMc0+LjKDtALAlfjXHjvoJmYA1KJbB7y2w=
Date:   Tue, 27 Sep 2022 17:37:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Christoph Lameter <cl@linux.com>
Subject: Re: [dm-devel] [PATCH] kernfs: fix a crash when two processes delete
 the same directory
Message-ID: <YzMYuAaHRpydr7Fy@kroah.com>
References: <alpine.LRH.2.02.2209260418360.16612@file01.intranet.prod.int.rdu2.redhat.com>
 <YzGYFBv0pdt+DQg+@kroah.com>
 <6c75a90d-3793-55fc-e525-eca14e562350@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c75a90d-3793-55fc-e525-eca14e562350@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:22:46PM +0200, Milan Broz wrote:
> On 9/26/22 14:16, Greg Kroah-Hartman wrote:
> > On Mon, Sep 26, 2022 at 07:04:52AM -0400, Mikulas Patocka wrote:
> > > There is a crash when running the cryptsetup testsuite on Fedora Rawhide.
> > > It can be reproduced by installing Rawhide with the 6.0-rc6 kernel,
> > > downloading and compiling the cryptsetup repository and running this test
> > > in a loop for about 15 minuts:
> > > 	while ./integrity-compat-test; do :; done
> > > 
> > >   ------------[ cut here ]------------
> > >   WARNING: CPU: 0 PID: 50087 at fs/kernfs/dir.c:504 __kernfs_remove.part.0+0x26f/0x2b0
> > >   Modules linked in: crc32_generic loop dm_integrity async_xor async_tx tls isofs uinput snd_seq_dummy snd_hrtimer nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr sunrpc snd_hda_codec_generic ledtrig_audio snd_hda_intel iTCO_wdt snd_intel_dspcfg intel_pmc_bxt snd_intel_sdw_acpi iTCO_vendor_support snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device joydev snd_pcm i2c_i801 snd_timer pcspkr i2c_smbus virtio_balloon snd lpc_ich soundcore zram virtio_net net_failover virtio_blk serio_raw failover qxl virtio_console drm_ttm_helper ttm ip6_tables ip_tables fuse qemu_fw_cfg
> > >   Unloaded tainted modules: crc32_pclmul():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
> > >   CPU: 0 PID: 50087 Comm: integritysetup Not tainted 6.0.0-0.rc6.41.fc38.x86_64 #1
> > >   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> > >   RIP: 0010:__kernfs_remove.part.0+0x26f/0x2b0
> 
> ...
> 
> > Can you see if 4abc99652812 ("kernfs: fix use-after-free in
> > __kernfs_remove") in linux-next fixes this for you or not?  It seems to
> > be the same issue, as was also reported at:
> > 	https://lore.kernel.org/r/7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp
> 
> 
> I tried it on system where cryptsetup testsuite almost immediately crashed in the integrity test.
> 
> With the patch in https://lore.kernel.org/r/7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp
> it now iterates for some time without any problems, so I think it is fixed.
> 
> Tested-by: Milan Broz <gmazyland@gmail.com>

Wait, what about the patch that is in linux-next that I pointed to, not
the one in the email?

thanks,

greg k-h
