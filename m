Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28DE7365FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjFTIWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjFTIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944ADB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687249312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5XHdbMNys0EMjfbiSdwj8lWyGP51R68NotGh4ls9XCg=;
        b=GktkLPERUZkxkruZZxsklEQXEHNoLA3aNPSHYWXk2FzCp20YzSFfFVvri5DpuwGl6TCBaD
        Q5iZWVRK1hnDmRYoNghwoJak+8YkSNEX3F6jDVekJzXhv9fy068/uh1oN9XEXj4PRjyXZO
        Bnke85b16b4IL3Al94JROr1CjANmBd8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-DHNnL6O0PoOX-_3jeDwo5g-1; Tue, 20 Jun 2023 04:21:49 -0400
X-MC-Unique: DHNnL6O0PoOX-_3jeDwo5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 918E73806739;
        Tue, 20 Jun 2023 08:21:48 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B95A2166B26;
        Tue, 20 Jun 2023 08:21:46 +0000 (UTC)
Date:   Tue, 20 Jun 2023 16:21:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        chenhuacai@kernel.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
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
        arnd@arndb.de, rmk+kernel@armlinux.org.uk,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        anshuman.khandual@arm.com, ziy@nvidia.com, masahiroy@kernel.org,
        ndesaulniers@google.com, mhiramat@kernel.org, ojeda@kernel.org,
        thunder.leizhen@huawei.com, xin3.li@intel.com, tj@kernel.org,
        gregkh@linuxfoundation.org, tsi@tuyoix.net, hbathini@linux.ibm.com,
        sourabhjain@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 02/13] x86/kexec: refactor for kernel/Kconfig.kexec
Message-ID: <ZJFhlsFN6DxnWsQE@MiWiFi-R3L-srv>
References: <20230619145801.1064716-1-eric.devolder@oracle.com>
 <20230619145801.1064716-3-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619145801.1064716-3-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 06/19/23 at 10:57am, Eric DeVolder wrote:
......
> +config ARCH_SUPPORTS_KEXEC
> +	def_bool y
>  
> -config ARCH_HAS_KEXEC_PURGATORY
> -	def_bool KEXEC_FILE
> +config ARCH_SUPPORTS_KEXEC_FILE
> +	def_bool X86_64 && CRYPTO && CRYPTO_SHA256
......  
> +config ARCH_SELECTS_KEXEC_FILE
> +	def_bool y
>  	depends on KEXEC_FILE
> -	help

I am a little confused about this ARCH_SELECTS_XX adding. Wondering what
limits us defining the ARCH_SUPPORTS_KEXEC_FILE like below? I have limited
knowledge about Kconfig, please correct me if I am wrong. Thanks in
advance.

 +config ARCH_SUPPORTS_KEXEC_FILE
 +	def_bool y
  	depends on KEXEC_FILE
  	depends on X86_64 && CRYPTO && CRYPTO_SHA256

> -
> -	  This option makes the kexec_file_load() syscall check for a valid
> -	  signature of the kernel image.  The image can still be loaded without
> -	  a valid signature unless you also enable KEXEC_SIG_FORCE, though if
> -	  there's a signature that we can check, then it must be valid.
> -
> -	  In addition to this option, you need to enable signature
> -	  verification for the corresponding kernel image type being
> -	  loaded in order for this to work.
> -

