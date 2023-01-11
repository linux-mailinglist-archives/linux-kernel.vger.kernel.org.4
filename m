Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0C7665540
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjAKHjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjAKHjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:39:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBE010FCE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:39:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NsKMB5Gm2z4wgq;
        Wed, 11 Jan 2023 18:39:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1673422777;
        bh=PUC4l7Fl/CYIwqAtVD801/4BMGg7ktBI9zLEQEpluMA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RrSr59lPcKMMbBRFNah0TBy4jWHYK+OAp0ldEdZrhxHrj9fqUi3YjxqVs8D2LmUPZ
         C6XvY25KTWziL2MY964rkXsMaCYC0kaLRdyO1ZPcRvasepS55tvcLTH3YMOvALoulu
         njFE0TxSKQ/Yq1k2cZc7muh3oBebitI+efc8CxqPF++EiY76ZWDD69qZFL7IBjmCwN
         CwF7c3tGuapY1S1rI/jXx8RZ+U7qRUP/CjKxu2qCOyibxWoyS26RyVxE8Q2tj9dsKM
         4Zinmz9uTmH9JmUv4S1Ibp5MicKUwxm98ice6UaD2qrIMfx4LVxR86SSpOhUf9fXQb
         /8QMIDCGPUvVQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: usb.c:undefined reference to `qe_immr'
In-Reply-To: <a0e325d2-a9c5-ffca-b2d6-5eea60f9ad3b@infradead.org>
References: <202301101500.pillNv6R-lkp@intel.com>
 <a0e325d2-a9c5-ffca-b2d6-5eea60f9ad3b@infradead.org>
Date:   Wed, 11 Jan 2023 18:39:30 +1100
Message-ID: <87lem9h64t.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> [adding Cc's]
>
>
> On 1/9/23 23:59, kernel test robot wrote:
>> Hi Masahiro,
>> 
>> FYI, the error/warning still remains.
>> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   5a41237ad1d4b62008f93163af1d9b1da90729d8
>> commit: 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
>> date:   8 months ago
>> config: powerpc-randconfig-r026-20230110
>> compiler: powerpc-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
>> 
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>> 
>> All errors (new ones prefixed by >>):
>> 
>>    powerpc-linux-ld: powerpc-linux-ld: DWARF error: could not find abbrev number 74
>>    drivers/soc/fsl/qe/usb.o: in function `qe_usb_clock_set':
>>>> usb.c:(.text+0x1e): undefined reference to `qe_immr'
>>>> powerpc-linux-ld: usb.c:(.text+0x2a): undefined reference to `qe_immr'
>>>> powerpc-linux-ld: usb.c:(.text+0xbc): undefined reference to `qe_setbrg'
>>>> powerpc-linux-ld: usb.c:(.text+0xca): undefined reference to `cmxgcr_lock'
>>    powerpc-linux-ld: usb.c:(.text+0xce): undefined reference to `cmxgcr_lock'
>> 
>
> .config extract:
>
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # CONFIG_QUICC_ENGINE is not set
> CONFIG_QE_USB=y
>
>
> This is caused by (drivers/soc/fsl/qe/Kconfig):
>
> config QE_USB
> 	bool
> 	default y if USB_FSL_QE
> 	help
> 	  QE USB Controller support
>
> which does not depend on QUICC_ENGINE, where the latter build provides
> the missing symbols.

So QE_USB should depend on QUICC_ENGINE no?

cheers
