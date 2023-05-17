Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DF8707155
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjEQSyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEQSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C89FE
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00ED263B04
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15961C433EF;
        Wed, 17 May 2023 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684349638;
        bh=+nV7AD5yc8SFGB9+CLiAw9jnKXLbtK3VvYJuoM0ntT4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=owLL/OdV0KnOPxZoc0Qe/3k9OnRB6FRqrL1ix1teN0zMIYOZfySgsqTPoLvc1q99Q
         yqDiv6kX7lxgUVNPvcrKU4RKbjixC20Pg4Rh09+shn780q5ee6t7x4LwSGXRMwBJju
         8RtsYYmaiCxEHeBNDHm8hKYzCIK5iEBj3Qbt7m3roQOr9PYOrhhK7UQYj76R+p6sUx
         5+c3+X/3o6jK66l+5ez5zLqB83L467JcKFN3u7RR0P5EtLKXYLekqJgWEiIZ6D4R0/
         jeJybZ+ocEe6/jOxkztBBSA1WaNXyZLe/+qHBTWFyGW3quZIfGEFu1Q6avMKhS7PCR
         LonE96kFPhCXw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     David Hildenbrand <david@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        virtualization@lists.linux-foundation.org, linux@rivosinc.com,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 0/7] riscv: Memory Hot(Un)Plug support
In-Reply-To: <9aa7d030-19b5-01df-70c0-86d8d6ab86a6@redhat.com>
References: <20230512145737.985671-1-bjorn@kernel.org>
 <9aa7d030-19b5-01df-70c0-86d8d6ab86a6@redhat.com>
Date:   Wed, 17 May 2023 20:53:55 +0200
Message-ID: <87zg62eqm4.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 12.05.23 16:57, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> Memory Hot(Un)Plug support for the RISC-V port
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[...]

>
> Cool stuff! I'm fairly busy right now, so some high-level questions upfro=
nt:

No worries, and no rush! I'd say the v1 series was mainly for the RISC-V
folks, and I've got tons of (offline) comments from Alex -- and with
your comments below some more details to figure out.

> What is the memory section size (which implies the memory block size=20
> and)? This implies the minimum DIMM granularity and the high-level=20
> granularity in which virtio-mem adds memory.

It's 128M (27 bits) -- (like arm64 and x86-64?).

> What is the pageblock size, implying the minimum granularity that=20
> virtio-mem can operate on?

Nothing special AFAIU; MAX_ORDER is 10, so PAGE_SIZE (4K) * 1024. Hmm, I
realize that I need to look into some more details of virtio-mem! :-)

> On x86-64 and arm64 we currently use the ACPI SRAT to expose the maximum=
=20
> physical address where we can see memory getting hotplugged. [1] From=20
> that, we can derive the "max_possible_pfn" and prepare the kernel=20
> virtual memory layourt (especially, direct map).
>
> Is something similar required on RISC-V?

Yes! RISC-V is in the progress of getting proper ACPI support. Thanks
for pointing me in the these directions; Food for thought that I'll
digest for the next version.


Cheers,
Bj=C3=B6rn
