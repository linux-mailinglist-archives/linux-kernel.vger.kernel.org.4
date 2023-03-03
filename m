Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1BF6A8DC0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCCAMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCCAMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:12:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A6355539;
        Thu,  2 Mar 2023 16:12:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PST185lsbz4x1R;
        Fri,  3 Mar 2023 11:11:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677802320;
        bh=y8wWNYars5Wp25KTgB4IaQUGxk80vrVSQ9DCSBUaDpQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nCx/NlLyhE7MIPjtBUMoILPKlGudC5d2X4jiywJrXt2G2IbBAq3FuwrzyeIV1XsQ/
         NJhxQxGiIyBkyMp8QrPWxWlSps7uA0HF0VhGHR8xtsyc5kcZdN8wLecb13lRYyN5Hz
         JvK4CU2orYG4IpG++/9+SS5Tnbgxt4LZ7o7S0eHrjAY8/NH1bGMEfge/UGx+342qiA
         8n1Mfv5d3ZTVAJoN4lBQczBMy4E8yRwtygE/uOKh0UeJvdODbBM5s6hm+TCpqKu5ID
         j22U/sK3TyINj7wezs+YeHg9OQFhmM2QorjVFKz4640ZVitj5YmZ1+DCSX/d+VPxM1
         nK5PnlzmxfGRw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 5/5] of: address: Always use dma_default_coherent for
 default coherency
In-Reply-To: <B43602D1-89D4-465F-83B1-CD106E07CB29@flygoat.com>
References: <20230223113644.23356-1-jiaxun.yang@flygoat.com>
 <20230223113644.23356-6-jiaxun.yang@flygoat.com>
 <20230301130613.GC467@lst.de>
 <B43602D1-89D4-465F-83B1-CD106E07CB29@flygoat.com>
Date:   Fri, 03 Mar 2023 11:11:56 +1100
Message-ID: <87356mlmlv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiaxun Yang <jiaxun.yang@flygoat.com> writes:
>> 2023=E5=B9=B43=E6=9C=881=E6=97=A5 13:06=EF=BC=8CChristoph Hellwig <hch@l=
st.de> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>> - select OF_DMA_DEFAULT_COHERENT if !NOT_COHERENT_CACHE
>>=20
>> Doesn't powerpc need to select CONFIG_ARCH_DMA_DEFAULT_COHERENT now,
>> or even better should be doing that in the patch adding that
>> symbol?
>
> If I read the code correctly for powerpc OF_DMA_DEFAULT_COHERENT is only =
selected
> with !NOT_COHERENT_CACHE, which means non-coherent dma support is disable=
d=E2=80=A6.

I think you're right, but it's not easy to understand.

powerpc's NOT_COHERENT_CACHE selects:

  select ARCH_HAS_DMA_PREP_COHERENT
  select ARCH_HAS_SYNC_DMA_FOR_DEVICE
  select ARCH_HAS_SYNC_DMA_FOR_CPU


Then in your patch 3 you do:

 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-bool dma_default_coherent;
+bool dma_default_coherent =3D IS_ENABLED(CONFIG_ARCH_DMA_DEFAULT_COHERENT);
 #endif

So for powerpc if NOT_COHERENT_CACHE=3Dn, then none of those ARCH_HAS
symbols are defined, and so CONFIG_ARCH_DMA_DEFAULT_COHERENT is never used.

But like I said it's not very obvious, and it also seems fragile to
future changes.

So it seems it would be more future proof, and self documenting for
powerpc to just have:

        select ARCH_DMA_DEFAULT_COHERENT if !NOT_COHERENT_CACHE


cheers
