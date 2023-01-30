Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9C1680531
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjA3EsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjA3EsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:48:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFDF5FC1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 20:48:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4wfQ5BWqz4xVG;
        Mon, 30 Jan 2023 15:47:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1675054078;
        bh=XQwYX+EMLbty1h8gVJYIE2S1CbsF6LntEO9AGkjzcsk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Tp4Ih8kFKV1XrkbSJJkEyoDtMjUCj36UCBX1nIFGeAFa6ystY84c4vxwft4kyzHs7
         EDohRBrL9U6JcPM3GNaRCFdrS1p4BXXMl4r5aGEqqB6yUQJjj/jI8SZon9k8gUwADv
         zVznMErqxQclF5O/jG8ixSYQtbJHCPLAj9A9niJLZ9SNO5FcgzMRQCCC+3eRItid7y
         GxOsLhy+JglNdlmbnqSzh/ETpX1XZA4gMGUt/IpyDd3GwfbgUDExt93LNU8LLluWzE
         s2kSiI3oxXTgPRrHmV3dIQATHmU5tnDlG56dv3GvddLxZRH0e/+2alz0Vb2iyIbkP4
         00mumgLRV3Rug==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dawei Li <set_pte_at@outlook.com>, npiggin@gmail.com
Cc:     christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: Re: [PATCH v2] powerpc: macio: Make remove callback of macio driver
 void returned
In-Reply-To: <TYCP286MB2323FA245F0C35C5D7486CC9CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2323FA245F0C35C5D7486CC9CAC09@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 30 Jan 2023 15:47:55 +1100
Message-ID: <87sffssk5g.fsf@mpe.ellerman.id.au>
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

Dawei Li <set_pte_at@outlook.com> writes:
> Commit fc7a6209d571 ("bus: Make remove callback return void") forces
> bus_type::remove be void-returned, it doesn't make much sense for any
> bus based driver implementing remove callbalk to return non-void to
> its caller.
>
> This change is for macio bus based drivers.
>
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
> v1 -> v2
> - Revert unneeded changes.
> - Rebased on latest powerpc/next.
>
> v1
> - https://lore.kernel.org/all/TYCP286MB2323FCDC7ECD87F8D97CB74BCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
> ---
>  arch/powerpc/include/asm/macio.h                | 2 +-
>  drivers/ata/pata_macio.c                        | 4 +---
>  drivers/macintosh/rack-meter.c                  | 4 +---
>  drivers/net/ethernet/apple/bmac.c               | 4 +---
>  drivers/net/ethernet/apple/mace.c               | 4 +---
>  drivers/net/wireless/intersil/orinoco/airport.c | 4 +---
>  drivers/scsi/mac53c94.c                         | 5 +----
>  drivers/scsi/mesh.c                             | 5 +----
>  drivers/tty/serial/pmac_zilog.c                 | 7 ++-----
>  sound/aoa/soundbus/i2sbus/core.c                | 4 +---
>  10 files changed, 11 insertions(+), 32 deletions(-)

I realise the patch has to be merged via a single subsystem, and powerpc
is probably the most appropriate, but please Cc the relevant lists for
the drivers touched.

AFAICS neither this version or v1 was Cc'ed to relevant lists, eg.
netdev, linux-wireless, linux-scsi, alsa-devel etc.

cheers
