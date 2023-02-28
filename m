Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2336A505E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjB1BB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjB1BB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:01:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952A29E23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:01:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F6A860F2D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF65CC4339B;
        Tue, 28 Feb 2023 01:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677546111;
        bh=2gj263AdMgYZH+wcBWLUMUdi3HPC5MwnbHazidKehrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syoZSkNJcb80V8oIhsj//R9WMq4ejNc82k6cCurH7OZD3Ky/hwqAtsHkd/aISYnho
         bUA8CKk77gjM55mTrwQyOBfCwZby3wcFoTP4EEjV69RiiiSMmkp9TDN111hWLi3j7b
         6xIGvC55qyRJBQoM81IxlScOzu3AzvW27ZsRNe51K7JpLuixTD5R0LMSnwgOyLA9o/
         Rr9tbCN3vELJ1hAsgYXcWTs4u77fQHaDLeR4kNqkX94yioZZo6Ld/iQo/q06U/isiQ
         DPyNoPFPYFFOi441iDmABBNDDuKsP65ERExi95D8ZFHPpzMNpB6QUNax18vR5Abewk
         KxDaxHLBgUPFg==
Date:   Mon, 27 Feb 2023 18:01:48 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hch@lst.de,
        tonyb@cybernetics.com, akpm@linux-foundation.org,
        kernel-team@meta.com
Subject: Re: [PATCHv4 11/12] dmapool: link blocks across pages
Message-ID: <Y/1SfK4//04Tznvy@kbusch-mbp.dhcp.thefacebook.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
 <20230126215125.4069751-12-kbusch@meta.com>
 <20230227005445.GA3425881@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227005445.GA3425881@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 04:54:45PM -0800, Guenter Roeck wrote:
> With this patch in linux-next, I see a boot failure when trying to boot
> a powernv qemu emulation from the SCSI MEGASAS controller.
> 
> Qemu command line is
> 
> qemu-system-ppc64 -M powernv -cpu POWER9 -m 2G \
> 	-kernel arch/powerpc/boot/zImage.epapr \
> 	-snapshot \
> 	-device megasas,id=scsi,bus=pcie.0 -device scsi-hd,bus=scsi.0,drive=d0 \
> 	-drive file=rootfs-el.ext2,format=raw,if=none,id=d0 \
> 	-device i82557a,netdev=net0,bus=pcie.1 -netdev user,id=net0 \
> 	-nographic -vga none -monitor null -no-reboot \
> 	--append "root=/dev/sda console=tty console=hvc0"
> 
> Reverting this patch together with "dmapool: create/destroy cleanup"
> fixes the problem.

Thanks for the notice. I was able to recreate, and it does look like this is
fixed with my more recent update changing the dma pool block order, and that is
still pending out of tree. Would you also be able to verify? The patch is
available here:

  https://lore.kernel.org/linux-mm/Y%2FzmUXrAiNujjoib@kbusch-mbp.dhcp.thefacebook.com/T/#t
