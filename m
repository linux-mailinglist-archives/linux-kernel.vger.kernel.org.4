Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE86884C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjBBQsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBBQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:48:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113A730E80;
        Thu,  2 Feb 2023 08:48:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFA51B826EE;
        Thu,  2 Feb 2023 16:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28E8C433D2;
        Thu,  2 Feb 2023 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675356494;
        bh=zXiQuKoym7NRi7lcy38mAnxrVWR77CSOjEB+TFWteRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MHElBPi1uMOh0unO60ZuSE6hBs8urJ0dUBNrNNgfuA7QVbYdEsroNReDP+A5WVRQA
         gZDNeb8R3799DOdBVJyM48NgU9Ju65xwgwy0sKMIIefVM3FraEsOgHViN+bgG8Uc6e
         h0oyOBzbCxBIobupZ1cGQ6dCh9P7PvzKgM2ydjAMRQVL37NrgpP9UatE4lsjNDBTt8
         bX5Q6DLrWYdQpTkyEa+Zcb/S4PE+flS2E3sZ40UOrx4kz4xu33n8mgnEJSRXadAaFn
         axsPWeE9SD0qGORfbXNSiYxtrKxp46sOZQWse7QwtMNnWOsmvYnmybmcTWr45ATzi1
         px3GswoMI3/sw==
Date:   Thu, 2 Feb 2023 17:02:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrea Merello <andrea.merello@iit.it>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adis16480: select CONFIG_CRC32
Message-ID: <20230202170212.0cc6273d@jic23-huawei>
In-Reply-To: <2c8c64f95569a3bfb142761bad7a948c71a8d266.camel@gmail.com>
References: <20230131094616.130238-1-arnd@kernel.org>
        <2c8c64f95569a3bfb142761bad7a948c71a8d266.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 11:23:10 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2023-01-31 at 10:46 +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > In rare randconfig builds, the missing CRC32 helper causes
> > a link error:
> >=20
> > ld.lld: error: undefined symbol: crc32_le =20
> > > > > referenced by usercopy_64.c
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 vmlinux.o:(adis16480_trigger_handler) =20
> >=20
> > Fixes: 941f130881fa ("iio: adis16480: support burst read function")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
>=20
Applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks,

Jonathan


