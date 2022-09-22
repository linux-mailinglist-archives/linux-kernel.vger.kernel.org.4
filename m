Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885EA5E5EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiIVJiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIVJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:38:15 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9E7D4336
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:38:14 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 520B7E000D;
        Thu, 22 Sep 2022 09:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663839491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0xAyR/z9kzEyc6l4rQYrC2hkKALiKd5mU2hx/nI+Uk=;
        b=mvM1T46YqDoRduskd3WW4ydTPEiu+tRk5QHmT2YgEMf6m2zHsANT2rbNiOI6pOoi62SZpo
        MLD6aeFF2ag2jC8LHR+cSotskK3Ms3Or7YBBj/dUCa/P/VUMI65O5khV4J2Vh2GdtJYrx7
        WHR8aYYeJ7FxAsIm7oHf4/m1/TS9DIW+lVIsnscD1E9TricLminKpeYDO8dbATfXLeybUd
        Y42swM5TVprnhsiSZmqNe2UY6N8TW227V+16VxfI4Yrw9FGEYRGwvSh9aK2l71RxSzkhdn
        uR9E/vkW0hyU9guFbME31iR0bW85xmlL9UQZQPhIuQbF/Jg/2BucZEIopPu0Lg==
Date:   Thu, 22 Sep 2022 11:38:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Valentin Korenblit" <vkorenblit@sequans.com>,
        "kernel test robot" <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
Message-ID: <20220922113809.0a4d3d35@xps-13>
In-Reply-To: <b7e5ebb4-0de8-4958-9bc4-fe06ec4c3635@www.fastmail.com>
References: <202209210641.MziHAbW7-lkp@intel.com>
        <20220921104002.226ff3f6@xps-13>
        <ffde44bc-d4ae-4052-c60c-35c8775a5101@sequans.com>
        <7074197c-aa8d-f763-cb0f-03ea5335b923@sequans.com>
        <20220921164720.6bbc56d5@xps-13>
        <ef9a2618-2dd0-4d1b-b9d2-37d59506f004@www.fastmail.com>
        <20220921183807.241e2518@xps-13>
        <b7e5ebb4-0de8-4958-9bc4-fe06ec4c3635@www.fastmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> > ioread64_rep is then only defined if CONFIG_64BIT. As it is based
> > on readsq/writesq() and those must be defined (as you said), I don't get
> > why the *64_rep() helpers are not defined in all cases. Maybe because no
> > 32-bit system _should_ need them? But then compile testing gets more
> > difficult. =20
>=20
> Both readsq/writesq and ioread64_rep/iowrite64_rep must be defined
> for 64-bit architectures and cannot be defined for 32-bit ones.

Yeah, ok.

> >> - For a FIFO, you cannot use readq() but have to use __raw_readq()
> >>   to get the correct endianness. You cannot use this for an
> >>   MMIO register with side-effects though, as this needs the byteswap
> >>   and the barrier in readsl(). =20
> >
> > I'm not sure about the true definition of "FIFO" as you say. I guess
> > you just mean reading from a BE device?
> >
> > In this case I guess we need the barrier+byteswap helpers. =20
>=20
> The difference is that a register has a fixed length, and gets
> accessed with a device specific endianness, which may have to
> be swapped if the device and the CPU disagree.
>=20
> A FIFO register is what you use for transferring a stream of
> bytes, such as reading a file system block from disk. The
> first byte in the register corresponds to the first byte in
> memory later, so there must not be any byteswap while copying
> to/from memory. If the data itself is structured (i.e. an
> on-disk inode or a network packet), then the byteswap will
> happen if necessary while interpreting the data.

Ok, I fully get what you mean, I was just not used to the word FIFO for
this definition as I use it as a more generic term, but it completely
makes sense. Thanks for taking the time to explain.

Thanks,
Miqu=C3=A8l
