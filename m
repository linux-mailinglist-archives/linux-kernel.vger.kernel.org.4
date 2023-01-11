Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611B1665FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjAKQCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjAKQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:02:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4A710B48
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=yspqmV8n8uMxBrXLAo4qukTZST08VUL+ZwdMf7CyN3U=; b=T1ZN/6U7jNW9xGgPClMK03QJwy
        uyjiqhJ8YwgiJ6Eiz0EJ5C/w4I3ofNgkkacNSzJtrwNhjDg3urx1sJyBHEZsQRigWHcWmw9WK6BQC
        1pm0Sgn2yHvdXz9PGAZ9vpGeV5XmBi2UCOihMZxWBXNXDzl6K/PHjwrfH9i92XsT+KNBfKwWHGxvI
        cDzRk98KLWz7TfGLdf7wVm3phZkwXvCWFa6K2IxNlHf0SPNEgByZoK2ydJxplaCJH6rqSwmWoXX+t
        UzHq6NquaYLhmbCS9svpbsiOYe6KZ6gqWHvrfO3Je81q/g+ytGz177g9/sqlqBc4jYYPMYkIcEs3b
        MXBXXIGg==;
Received: from [2601:1c2:d80:3110:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFdXw-00C5iF-IT; Wed, 11 Jan 2023 16:01:48 +0000
Message-ID: <5d8e3316-54bb-40c4-a8a4-dd1b10d1e1a6@infradead.org>
Date:   Wed, 11 Jan 2023 08:01:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: usb.c:undefined reference to `qe_immr'
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Li Yang <leoyang.li@nxp.com>
References: <202301101500.pillNv6R-lkp@intel.com>
 <a0e325d2-a9c5-ffca-b2d6-5eea60f9ad3b@infradead.org>
 <87lem9h64t.fsf@mpe.ellerman.id.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87lem9h64t.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/23 23:39, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
>> [adding Cc's]
>>
>>
>> On 1/9/23 23:59, kernel test robot wrote:
>>> Hi Masahiro,
>>>
>>> FYI, the error/warning still remains.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   5a41237ad1d4b62008f93163af1d9b1da90729d8
>>> commit: 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
>>> date:   8 months ago
>>> config: powerpc-randconfig-r026-20230110
>>> compiler: powerpc-linux-gcc (GCC) 12.1.0
>>> reproduce (this is a W=1 build):
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>         git fetch --no-tags linus master
>>>         git checkout 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
>>>         # save the config file
>>>         mkdir build_dir && cp config build_dir/.config
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    powerpc-linux-ld: powerpc-linux-ld: DWARF error: could not find abbrev number 74
>>>    drivers/soc/fsl/qe/usb.o: in function `qe_usb_clock_set':
>>>>> usb.c:(.text+0x1e): undefined reference to `qe_immr'
>>>>> powerpc-linux-ld: usb.c:(.text+0x2a): undefined reference to `qe_immr'
>>>>> powerpc-linux-ld: usb.c:(.text+0xbc): undefined reference to `qe_setbrg'
>>>>> powerpc-linux-ld: usb.c:(.text+0xca): undefined reference to `cmxgcr_lock'
>>>    powerpc-linux-ld: usb.c:(.text+0xce): undefined reference to `cmxgcr_lock'
>>>
>>
>> .config extract:
>>
>> #
>> # NXP/Freescale QorIQ SoC drivers
>> #
>> # CONFIG_QUICC_ENGINE is not set
>> CONFIG_QE_USB=y
>>
>>
>> This is caused by (drivers/soc/fsl/qe/Kconfig):
>>
>> config QE_USB
>> 	bool
>> 	default y if USB_FSL_QE
>> 	help
>> 	  QE USB Controller support
>>
>> which does not depend on QUICC_ENGINE, where the latter build provides
>> the missing symbols.
> 
> So QE_USB should depend on QUICC_ENGINE no?

Yes, that would make sense, but I don't know enough about the
hardware. I.e., could CONFIG_PPC_EP88XC have QE_USB without having
a full QUICC_ENGINE?

thanks.

-- 
~Randy
