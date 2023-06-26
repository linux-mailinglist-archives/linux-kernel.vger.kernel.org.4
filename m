Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501CD73E4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjFZQWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFZQW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:22:28 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F015230FD;
        Mon, 26 Jun 2023 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6LUH4ra8Yl1TDl+4XlqQ5U8p0CDLO89uve3Fr0Kil4w=; b=aahUR+KLg6KR/ffBfCW3f0faE4
        VhUU2i+bfpTo53kVwnECUFjwpF1EGV+Gx9CskK7sGzgmpCGABJvbXoa+RkeEc4un1fvySa27Y40qi
        fjXCivPyV9Mcyx+rc7jA3Oyjl9f+aiUZoiZIE3/oGx1urWhrCUUZDGaqZcQu/BYegttXt8r+Pk2P7
        fyOyanSohw66Bp92VtuMcFMdWp1kW4PoqsDzIWleylfE2wsWFAS+fUZFEJrLRAhWYz9lDFUDY5P9X
        RALSI8H3FOncO+4t4XcD2SzaVKfw24qCDZneUGP5tZpnJqY6swVzkk+VlcLeWsHchgPLv31AgsG1o
        EoMKBeww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56504)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qDovx-0003A4-10;
        Mon, 26 Jun 2023 17:19:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qDovh-0004oC-LQ; Mon, 26 Jun 2023 17:19:05 +0100
Date:   Mon, 26 Jun 2023 17:19:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        geert@linux-m68k.org, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, kernel@xen0n.name, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, hpa@zytor.com, keescook@chromium.org,
        paulmck@kernel.org, peterz@infradead.org, frederic@kernel.org,
        akpm@linux-foundation.org, ardb@kernel.org,
        samitolvanen@google.com, juerg.haefliger@canonical.com,
        arnd@arndb.de, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        kirill.shutemov@linux.intel.com, anshuman.khandual@arm.com,
        ziy@nvidia.com, masahiroy@kernel.org, ndesaulniers@google.com,
        mhiramat@kernel.org, ojeda@kernel.org, thunder.leizhen@huawei.com,
        xin3.li@intel.com, tj@kernel.org, gregkh@linuxfoundation.org,
        tsi@tuyoix.net, bhe@redhat.com, hbathini@linux.ibm.com,
        sourabhjain@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v3 01/13] kexec: consolidate kexec and crash options into
 kernel/Kconfig.kexec
Message-ID: <ZJm6eS6LiSApYVTC@shell.armlinux.org.uk>
References: <20230626161332.183214-1-eric.devolder@oracle.com>
 <20230626161332.183214-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626161332.183214-2-eric.devolder@oracle.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 12:13:20PM -0400, Eric DeVolder wrote:
> +config KEXEC
> +	bool "Enable kexec system call"
> +	default ARCH_DEFAULT_KEXEC
> +	depends on ARCH_SUPPORTS_KEXEC
> +	select KEXEC_CORE
> +	help
> +	  kexec is a system call that implements the ability to shutdown your
> +	  current kernel, and to start another kernel. It is like a reboot
> +	  but it is independent of the system firmware. And like a reboot
> +	  you can start any kernel with it, not just Linux.
> +
> +	  The name comes from the similarity to the exec system call.
> +
> +	  It is an ongoing process to be certain the hardware in a machine
> +	  is properly shutdown, so do not be surprised if this code does not
> +	  initially work for you. As of this writing the exact hardware
> +	  interface is strongly in flux, so no good recommendation can be
> +	  made.

Is this last paragraph still true? Is the hardware interface still
"strongly in flux" ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
