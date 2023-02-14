Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB16E695572
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 01:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjBNAif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 19:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjBNAid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 19:38:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4BA76B4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 16:38:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PG2Pf5dzrz4x5V;
        Tue, 14 Feb 2023 11:38:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676335110;
        bh=T1F2pZeG1ldMeSSVPu4kQeJnciWkRpmYkaU4fy2Qh/A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ULeCSKpnro+LjaSUqVmwkl7J3Af9L3nFy7TiPybY/8aUqIoOfDWgpv4wiyfoLyX9h
         5Ji8qhcyKrPWZjTvmmAR54tpmKij78H5B0//hSXqi0uF5/CBxuAA60AkKghuHquOkq
         L/tHy00uafQwTNgkE2UvOqJ1yWov8vuKTaA6x0EGPgYtb2JGpydCscqtT65meeV4Au
         SgxOy+OUWgbkAnVjA3BgiVlpgFQ6648gdip3hgGY969vQ9Oy7fHxLnOlcRFgGbGMwU
         gTHwk2hw/T31/NZn06BB/6Jg2E8jtsxblol9WwAwTlhyVgJ0Q5sUvp9f1V+1M3oajJ
         Es6PsRTa8Dtpg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org
Subject: Re: Build regressions/improvements in v6.2-rc8
In-Reply-To: <7154f87-ca35-4d13-7a7c-1e29105d3b8c@linux-m68k.org>
References: <CAHk-=wj1=T1KzpPWbhqfFWOEp5Wf_kj3JjTHSHmEngf0-Vv7aA@mail.gmail.com>
 <20230213100542.328169-1-geert@linux-m68k.org>
 <7154f87-ca35-4d13-7a7c-1e29105d3b8c@linux-m68k.org>
Date:   Tue, 14 Feb 2023 11:38:26 +1100
Message-ID: <875yc56pz1.fsf@mpe.ellerman.id.au>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> On Mon, 13 Feb 2023, Geert Uytterhoeven wrote:
>> JFYI, when comparing v6.2-rc8[1] to v6.2-rc7[3], the summaries are:
>>  - build errors: +11/-1
>
>    + {standard input}: Error: unrecognized opcode: `dcbfl':  => 5736, 4743, 4327, 4476, 4447, 5067, 4602, 5212, 5224, 4298, 5594, 4315, 5050, 5195, 4464, 5079
>    + {standard input}: Error: unrecognized opcode: `dlmzb.':  => 2848, 18800, 2842, 2383, 106, 2377, 3327, 112
>    + {standard input}: Error: unrecognized opcode: `iccci':  => 204, 163, 510
>    + {standard input}: Error: unrecognized opcode: `lbarx':  => 570, 196
>    + {standard input}: Error: unrecognized opcode: `mbar':  => 887, 558, 1172, 539, 516, 837, 1457, 1125, 815, 7523, 1100, 1385, 368, 703, 662, 468, 441, 1410
>    + {standard input}: Error: unrecognized opcode: `mfdcr':  => 3589, 4358, 3565, 3493, 3614, 128, 3445, 276, 3518, 3541, 3469, 4413
>    + {standard input}: Error: unrecognized opcode: `mtdcr':  => 265, 4402, 4430, 4375, 4388, 4347, 117, 4443
>    + {standard input}: Error: unrecognized opcode: `stbcx.':  => 196, 570
>    + {standard input}: Error: unrecognized opcode: `tlbwe':  => 475, 476, 477
>
> powerpc-gcc11/ppc64_book3e_allmodconfig
> powerpc-gcc11/powerpc-allmodconfig
> powerpc-gcc11/corenet64_smp_defconfig
> powerpc-gcc11/powerpc-allyesconfig
> powerpc-gcc11/44x/fsp2_defconfig

That was me updating the GCC 11 toolchain from 11.1 to 11.3 (and more
importantly binutils 2.36 to 2.38), so not an actual regression.

I've backed that change out for now for powerpc builds.

cheers
