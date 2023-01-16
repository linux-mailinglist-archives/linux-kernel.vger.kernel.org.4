Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93F666BDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjAPMgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjAPMgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:36:38 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261071E299
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:36:36 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:ca8:1fb3:6247:f214])
        by albert.telenet-ops.be with bizsmtp
        id 9Qca2900R3ai2CG06QcacG; Mon, 16 Jan 2023 13:36:35 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pHOj4-005TSs-Ln;
        Mon, 16 Jan 2023 13:36:34 +0100
Date:   Mon, 16 Jan 2023 13:36:34 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     linux-s390@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.2-rc4
In-Reply-To: <20230116122924.116745-1-geert@linux-m68k.org>
Message-ID: <46ba7912-3df6-dff9-792-49f4eaadefec@linux-m68k.org>
References: <CAHk-=wgcOEWvT-WjmRf-zCCXyFJaVVFH=26BPQ+N1OFTTnN=RA@mail.gmail.com> <20230116122924.116745-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.2-rc4[1] to v6.2-rc3-8-g1fe4fd6f5cad346e[3], the summaries are:
>  - build errors: +1/-5

   + /kisskb/src/include/linux/fortify-string.h: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]:  => 57:33

s390x-gcc11/s390-allmodconfig

/kisskb/src/arch/s390/kernel/setup.c: In function 'setup_lowcore_dat_on':
/kisskb/src/include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' reading 128 bytes from a region of size 0 [-Werror=stringop-overread]
    57 | #define __underlying_memcpy     __builtin_memcpy
       |                                 ^
/kisskb/src/include/linux/fortify-string.h:578:9: note: in expansion of macro '__underlying_memcpy'
   578 |         __underlying_##op(p, q, __fortify_size);                        \
       |         ^~~~~~~~~~~~~
/kisskb/src/include/linux/fortify-string.h:623:26: note: in expansion of macro '__fortify_memcpy_chk'
   623 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
       |                          ^~~~~~~~~~~~~~~~~~~~
/kisskb/src/arch/s390/kernel/setup.c:526:9: note: in expansion of macro 'memcpy'
   526 |         memcpy(abs_lc->cregs_save_area, S390_lowcore.cregs_save_area,
       |         ^~~~~~

Looks like this was "'__builtin_memcpy' offset [0, 127] is out of the bounds
[0, 0]" before.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
