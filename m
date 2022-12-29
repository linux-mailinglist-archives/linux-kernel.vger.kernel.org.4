Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDA5658996
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 06:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiL2F6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 00:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiL2F6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 00:58:09 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2EF12AD8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 21:58:06 -0800 (PST)
Date:   Thu, 29 Dec 2022 05:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1672293484; bh=2oenb/kN5pBS8hqh35Ct7FrTf1XoGDzcXM6kZ3RuzwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4DNfR50NLl4iJ2X6MUGiZJNPdzytuZ9er0KhYd5SiBOtgwPYY1sToN7amgiekjUo
         P7YwNTy4M7Y4gj0q3t2O1u93XGO1yvaDAVnZJ5LkNBmxsn9Y1cG65ygm9idIDLJ2AX
         ZCV/ekmfcHZskaNincaL3L2qtdvlvUlf64Ks9rGo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux@weissschuh.net, peterz@infradead.org,
        Rong Tao <rongtao@cestc.cn>
Subject: Re: [PATCH v2 5/8] objtool: reduce memory usage of struct reloc
Message-ID: <20221229055713.7eqozt57aknqujjl@snowball.t-8ch.de>
References: <20221229022622.khboqwfe23e7u2en@snowball.t-8ch.de>
 <tencent_61428759F197532A46AF38A338882C06D108@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_61428759F197532A46AF38A338882C06D108@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rong,

On Thu, Dec 29, 2022 at 11:29:07AM +0800, Rong Tao wrote:
> Hi, Thomas:
> 
> In /usr/include/elf.h has:
> 
> #define ELF32_R_TYPE(val)		((val) & 0xff)
> #define ELF64_R_TYPE(i)			((i) & 0xffffffff)
>                                        ^^^^^^^^^^
> 
> So, I still feel that keeping 'unsigned int' is a good option. Can we just
> use __attribute__((packed)) for wasted padding bytes?

As the struct contains addresses, packing it will create a ton of
compiler warnings and will be much more likely to break than reducing
the width of 'type'.

Given that reducing the width of 'type'

* is currently absolutely safe,
* is unlikely to break in the future, as the elf designers seem to be
  actively trying to stay within this range anyways,
* saves 8 bytes from a very heavily allocated struct, having a
  measurable impact on the build process,

I continue to propose this aproach.

Let's let the maintainers decide.

Thomas
