Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815426C430A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCVGWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCVGWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:22:32 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6607759E4B;
        Tue, 21 Mar 2023 23:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+GOYCrC/OPRC4w5qRvD7ykYI55KkiEH9qkzVpgPhTz4=; b=jLUkDzq9ukfIUN8XaQn0G7Kzw5
        KhL9EusDTAO6ovWmukM6ipl/wg+rivKiPco5hkKGPbeLjuCxZRn58DyJTUHWJ6U8l5cPseBNTFLl3
        U7NWdFpi+KgakmnMn+JKPVPmjBVoVbxFJBeWf6cEXrfFesfpy3xsmXI4VyeFPzGEHGkGCC5/R57lE
        dHtANALwFXm67fHMtj4N7uaR+IfAseul7hXn/k/b6M+v4ZDw1Nliyix7p5sMWuqfisbOltH9oLELX
        4vEarGwOJ9NZnBWP7idcE3l9Im/QYJvMztMMEMtubv+og1//PZsD5H5b54qIJl9L+fZmc2IwQL+fe
        bgCp9kBA==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <carnil@debian.org>)
        id 1perrF-00FubZ-RT; Wed, 22 Mar 2023 06:22:02 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
        id 108CEBE2DE0; Wed, 22 Mar 2023 07:21:59 +0100 (CET)
Date:   Wed, 22 Mar 2023 07:21:59 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Aurelien Jarno <aurel32@debian.org>, 1033301@bugs.debian.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Tom Saeger <tom.saeger@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kibi@debian.org,
        vagrant@debian.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Bug#1033301: linux: arm64 kernel size increased from 31 to 39
 MB, causing u-boot-rpi to fail
Message-ID: <ZBqeh6aN4lFsFPb3@eldamar.lan>
References: <167943667390.3323902.2304413357807812348.reportbug@ohm.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167943667390.3323902.2304413357807812348.reportbug@ohm.local>
X-Debian-User: carnil
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aurelien,

Thanks for tracking this down. I would like to loop in Masahiro and
upstream to see if something can/should be done on upstream side.

Masahiro, in short, upstream change 994b7ac1697b ("arm64: remove
special treatment for the link order of head.o") (which got backported
as well to 6.1.14) caused the vmlinuz size to icrease significantly,
causing boot failures on Raspberry Pi 3 Model B Plus with u-boot
parameters previously working. Full quoting the Debian report below

On Tue, Mar 21, 2023 at 11:11:13PM +0100, Aurelien Jarno wrote:
> Source: linux
> Version: 6.1.15-1
> Severity: important
> Tags: upstream
> X-Debbugs-Cc: vagrant@debian.org
> Control: affects -1 + u-boot-rpi
> 
> Hi,
> 
> Following the upgrade of the kernel from 6.1.12-1 to 6.1.15-1 on a
> Raspberry Pi 3 Model B Plus, u-boot (from the u-boot-rpi package) failed
> to boot with:
> 
> | 40175552 bytes read in 1695 ms (23 MiB/s)
> | 43794863 bytes read in 1817 ms (23 MiB/s)
> | Moving Image from 0x80000 to 0x200000, end=2990000
> | ERROR: RD image overlaps OS image (OS=0x200000..0x2990000)
> 
> I tracked the issue to a significant increase of the kernel size between
> version 6.1.12-1 and 6.15-1:
> 
> | 31492   /boot/vmlinuz-6.1.0-5-arm64
> | 39236   /boot/vmlinuz-6.1.0-6-arm64
> 
> This is more than the 36MB that is allowed by u-boot with the default
> load addresses. A workaround is to shift the load addresses at the
> u-boot level as in the attached patch.
> 
> I have tracked issue on the upstream kernel side to the following commit
> on the stable tree:
> 
> | commit 3e3e4d234d46e48480a7c7c35399fa811182e8ef
> | Author: Masahiro Yamada <masahiroy@kernel.org>
> | Date:   Thu Oct 13 08:35:00 2022 +0900
> | 
> |     arm64: remove special treatment for the link order of head.o
> |     
> |     commit 994b7ac1697b4581b7726d2ac64321e3c840229b upstream.
> |     
> |     In the previous discussion (see the Link tag), Ard pointed out that
> |     arm/arm64/kernel/head.o does not need any special treatment - the only
> |     piece that must appear right at the start of the binary image is the
> |     image header which is emitted into .head.text.
> |     
> |     The linker script does the right thing to do. The build system does
> |     not need to manipulate the link order of head.o.
> |     
> |     Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=1F8Uy-uAWGVDm4-CG=EuA@mail.gmail.com/
> |     Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> |     Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> |     Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> |     Link: https://lore.kernel.org/r/20221012233500.156764-1-masahiroy@kernel.org
> |     Signed-off-by: Will Deacon <will@kernel.org>
> |     Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> |     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> The problem is still reproducible on Linus' master.
> 
> I am reporting the bug to the linux package as I believed there is no
> real reason for such an increase in the kernel size. In case I missed
> something and this is actually wanted, the bug can be reassigned to the
> u-boot package.
> 
> Regards
> Aurelien

> --- u-boot-2023.01+dfsg.orig/include/configs/rpi.h
> +++ u-boot-2023.01+dfsg/include/configs/rpi.h
> @@ -95,32 +95,32 @@
>   *   text_offset bytes (specified in the header of the Image) into a 2MB
>   *   boundary. The 'booti' command relocates the image if necessary. Linux uses
>   *   a default text_offset of 0x80000.  In summary, loading at 0x80000
> - *   satisfies all these constraints and reserving memory up to 0x02400000
> - *   permits fairly large (roughly 36M) kernels.
> + *   satisfies all these constraints and reserving memory up to 0x02a00000
> + *   permits fairly large (roughly 42M) kernels.
>   *
>   * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn't
>   * conflict with something else. Reserving 1M for each of them at
> - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> + * 0x02a00000-0x02b00000 and 0x02c00000-0x02d00000 should be plenty.
>   *
>   * On ARM, both the DTB and any possible initrd must be loaded such that they
>   * fit inside the lowmem mapping in Linux. In practice, this usually means not
>   * more than ~700M away from the start of the kernel image but this number can
>   * be larger OR smaller depending on e.g. the 'vmalloc=xxxM' command line
>   * parameter given to the kernel. So reserving memory from low to high
> - * satisfies this constraint again. Reserving 1M at 0x02600000-0x02700000 for
> - * the DTB leaves rest of the free RAM to the initrd starting at 0x02700000.
> + * satisfies this constraint again. Reserving 1M at 0x02c00000-0x02d00000 for
> + * the DTB leaves rest of the free RAM to the initrd starting at 0x02d00000.
>   * Even with the smallest possible CPU-GPU memory split of the CPU getting
> - * only 64M, the remaining 25M starting at 0x02700000 should allow quite
> + * only 64M, the remaining 19M starting at 0x02d00000 should allow quite
>   * large initrds before they start colliding with U-Boot.
>   */
>  #define ENV_MEM_LAYOUT_SETTINGS \
>  	"fdt_high=" FDT_HIGH "\0" \
>  	"initrd_high=" INITRD_HIGH "\0" \
>  	"kernel_addr_r=0x00080000\0" \
> -	"scriptaddr=0x02400000\0" \
> -	"pxefile_addr_r=0x02500000\0" \
> -	"fdt_addr_r=0x02600000\0" \
> -	"ramdisk_addr_r=0x02700000\0"
> +	"scriptaddr=0x02a00000\0" \
> +	"pxefile_addr_r=0x02b00000\0" \
> +	"fdt_addr_r=0x02c00000\0" \
> +	"ramdisk_addr_r=0x02d00000\0"
>  
>  #if CONFIG_IS_ENABLED(CMD_MMC)
>  	#define BOOT_TARGET_MMC(func) \

Any ideas?

Regards,
Salvatore
