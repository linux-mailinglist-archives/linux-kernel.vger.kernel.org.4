Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A834D73CA6F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjFXKVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjFXKVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 06:21:41 -0400
Received: from mailout2.dotplex.com (mailout2.dotplex.com [185.231.124.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C981BF2;
        Sat, 24 Jun 2023 03:21:39 -0700 (PDT)
Received: from remote.ip.hidden (remote.ip.hidden [127.0.0.1])
        (Authenticated sender: estellnb@elstel.org)
        by mailout.dotplex.com (Postfix) with ESMTPSA id E3AAA1FFD9;
        Sat, 24 Jun 2023 12:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elstel.org;
        s=dotplex2; t=1687602096;
        bh=YayD2xsPG/u9QipwKVgv8sYGJIMNSUBWm5Mlh00T62A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=K+ghvmpeu2tNtq9w2E+GyUDHW3zQJoYl/HWE6kz1nYSna89Wu+M4DxHbZjc1+VVdr
         HUE5IPSNZde2pATWK58pg5GZ6O9xMNP+eb9Ito+laVJtJ+RoZ8X7+PSkpOaBK6gMTs
         I1QKObULsU81vG6GG+Jw6loaxdZLsdPbZbsFc8Yi5j6YP/8dKMvDXZ81hTT9EHnV/5
         Wo7TiIqE8fB7niVNsGCn5nZgVtLTPV62I7gKpw0rRj3I1rQ34GMunIwhX/DozU7yNT
         pvz6Abxnhpfxk8S26Y9OaZiuiMupzKBYrL9FkqWswCMW02hrJFqZdO4uuzIbJthLbl
         b8ysBJBdAedww==
Date:   Sat, 24 Jun 2023 12:21:29 +0200
From:   Elmar Stellnberger <estellnb@elstel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: kernel fault on hibernation: get_zeroed_page/swsusp_write
Message-ID: <ZJbDqStCNfdpwObE@mail.dotplex.com>
References: <5d4959b7-61da-8ab0-6bc6-21305d37c7aa@gmail.com>
 <ZJXFgfldS6W_LCiI@mail.dotplex.com>
 <ZJZGE4ZxJzrhRznA@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZJZGE4ZxJzrhRznA@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas S., Hi all

concerns: Bug 217544 - kernel fault on hibernation: get_zeroed_page/swsusp_write 
https://bugzilla.kernel.org/show_bug.cgi?id=217544

  Bisection does not make sense here, since I can not reproduce the
issue. Packing the kernel binaries and symbol files was meant to invoke
gdb directly on the kcore:
 
> /usr/src/kernel-6.3.7-desktop586-1.mga9/scripts/extract-vmlinux vmlinuz-6.3.7-desktop-1.mga9 >vmlinux
> file vmlinuz-6.3.7-desktop-1.mga9 
vmlinuz-6.3.7-desktop-1.mga9: Linux kernel x86 boot executable bzImage, version 6.3.7-desktop-1.mga9 (iurt@ecosse.mageia.org) #1 SMP PREEMPT_DYNAMIC Fri Jun  9 17:47:53 UTC 2023, RO-rootFS, swap_dev 0X6, Normal VGA
> file vmlinux
vmlinux: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), statically linked, BuildID[sha1]=942674511321671b33c739cceddb1e3a48a17895, stripped
> grep __alloc_pages /boot/System.map...
0xc03758... T __alloc_pages
> gdb vmlinux kcore
# x/5i 0xc03758..

Am Sat, Jun 24, 2023 at 08:25:39AM +0700 schrieb Bagas Sanjaya:
> Also, you don't need to upload full kernel images instead; people can
> grab /proc/config.gz you uploaded on Bugzilla and then `make olddefconfig`
> from it.
> 
  I would heavily doubt that the same symbols would get to be located at
the same address if you started to compile from source, even if you
applied all Mageia specific patches. We would need reproducible builds
for that. Nonetheless you are free to check whether the symbols will
reside at the same place in your System.map afterwards.
  I wonder whether there is a way to convert the System.map text file
(which looks to me like the output of 'nm -S') back into an elf section
to be added to the stripped vmlinux with objcopy. Shouldn´t there be a
script/ for this?

:: Sometimes you have only one chance to catch a bug.

Cheers,
Elmar

Am Sat, Jun 24, 2023 at 08:25:39AM +0700 schrieb Bagas Sanjaya:
> On Fri, Jun 23, 2023 at 06:17:05PM +0200, Elmar Stellnberger wrote:
> Can you attach [1] to your Bugzilla report? Also, any report on bisection?

Pardon, what is [1]?

