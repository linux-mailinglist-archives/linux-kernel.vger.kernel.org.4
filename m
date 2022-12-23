Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8351B6549D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLWAlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLWAlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:41:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F90EDEAA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=imsK8yQRr0h6fwP6rbqJ2xAJ74fIuelOZhWGi3JmFe0=; b=EKxOx4MVQYqC0lg92BlH8jzFSG
        +7DxNNz3C3c5qW49jwK2ok+KRV5gBeoqcESqb+n8sch6NUG+uqfHAKjcHmyRRGqMEvAlh0Xqazzli
        tSY2MztQG8gkwG9CvnJvc7E5g6MOiGtE10CAGA8RZQbWFKPhVbzEAoy2zXo4omLERAGQVbAuK75DI
        BUYHufHxdfjBhgnoYlaaOI4rR/uIrx+IBniBqf+BN7I/6hfXuskWZC3Tf2WnXg02TkzHubhSFEUZR
        MoRL5QIpG2hj7DS+NRikZz6MsAYcGhPuMfrbuSSJ3O6HE7ezTp4cGsHVTkj0lIUz9kzjefLnGXj3F
        hKH70+dA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8W7K-001Miv-Hp; Fri, 23 Dec 2022 00:40:54 +0000
Message-ID: <77e77c4f-0cde-090d-5918-c1a5f85ea5fb@infradead.org>
Date:   Thu, 22 Dec 2022 16:40:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: ld.lld: error: undefined symbol: devm_ti_sci_get_handle
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <202212222201.6lgWXMZT-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202212222201.6lgWXMZT-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/22 06:45, kernel test robot wrote:
> Hi Philipp,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
> commit: a6af504184c981efd253f986e6fc54db57b1d39f reset: ti-sci: Allow building under COMPILE_TEST
> date:   8 months ago
> config: arm-randconfig-r046-20221222
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 98b13979fb05f3ed288a900deb843e7b27589e58)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a6af504184c981efd253f986e6fc54db57b1d39f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout a6af504184c981efd253f986e6fc54db57b1d39f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: undefined symbol: devm_ti_sci_get_handle
>    >>> referenced by reset-ti-sci.c:229 (drivers/reset/reset-ti-sci.c:229)
>    >>>               reset/reset-ti-sci.o:(ti_sci_reset_probe) in archive drivers/built-in.a

Two (2) patches have been posted for this build error (in chronological order):

2022-10-29:
  https://lore.kernel.org/lkml/20221030055636.3139-1-rdunlap@infradead.org/
2022-12-15:
  https://lore.kernel.org/all/20221215170036.2308972-1-arnd@kernel.org/

Can someone apply one of them or at least comment on them?
Philipp?

thanks.
-- 
~Randy
