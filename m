Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FE3735C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjFSQsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFSQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:48:09 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E8A102;
        Mon, 19 Jun 2023 09:48:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 62AE449B;
        Mon, 19 Jun 2023 16:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 62AE449B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1687193287; bh=8mEQ2qVV3NQ4ryWzZHEZukEHUKHAb2sehmACRxBJOtA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VL5sJ1X0jkd152hPF9+Ibi6d/g3SjtNhHWIXDYGjhSEs8A3W+4o7Hjw+KkuZlkcCu
         35G3rTcG76vCRJ9itFN4aVqaVRk/nRrcHGAYBj50dafgxCaEajW2SvX4GvKIOKqb3k
         GossMbnM+Ht9Jo3ZqqNe4eUZ5a3ZV6vQXT6IYb5IiTSPnzndlV92CfF8Fgjc+UI2kb
         CqVt4JG6lNzFO5I2SNMP0h47va+q2VR3T/pEoRaU8f2B0BNJatxvdD85iG4wklVxOX
         EdyOPbuJV3bTmnvk28yRvjCkjq+P4zsAMT8Di0g4n/iTAfTfQW7WMjJGQOopuSyJ5D
         nVDRiuSzxvfdQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
In-Reply-To: <20230619-sponge-armful-6beeaf4a8624@spud>
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
 <20230619-kerchief-unmixed-cfdbeb1cf242@wendy>
 <CAHVXubjV=0HNyc0-UMAQRQfi4ZUnwH8dmghV-BGogZsJiumtZA@mail.gmail.com>
 <20230619-sponge-armful-6beeaf4a8624@spud>
Date:   Mon, 19 Jun 2023 10:48:06 -0600
Message-ID: <87r0q7v1o9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> writes:

> On Mon, Jun 19, 2023 at 04:04:52PM +0200, Alexandre Ghiti wrote:
>> On Mon, Jun 19, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor.dooley@micro=
chip.com> wrote:
>> > On Mon, Jun 19, 2023 at 11:47:04AM +0200, Alexandre Ghiti wrote:
>
>> > > diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot=
.rst
>> > > new file mode 100644
>> > > index 000000000000..b02230818b79
>> > > --- /dev/null
>> > > +++ b/Documentation/riscv/boot.rst
>> > > @@ -0,0 +1,181 @@
>> > > +.. SPDX-License-Identifier: GPL-2.0
>> > > +
>> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > +Early boot requirements/constraints on RISC-V
>> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > Please use "title case", here and elsewhere in the doc.
>>=20
>> You mean using "title: " instead of "=3D=3D=3D=3D"? Or using uppercase f=
or the
>> first letter of each word? FYI I followed
>> https://docs.kernel.org/doc-guide/sphinx.html?highlight=3Dtitle#specific=
-guidelines-for-the-kernel-documentation
>
> The latter. That's weird, I guess it would be nice to see what Jon
> thinks about that.

I have Never Been Fond of Excessive Use of Capital Letters, so my
preference would be capitalization as in a normal sentence.

That said, I don't really feel that something like this is important
enough that we need to define and enforce a policy around it.  If the
maintainers for specific subsystems feel differently, then I guess
that's up to them.

Thanks,

jon
