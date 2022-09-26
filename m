Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD215EA631
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiIZMcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbiIZMbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:31:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400B0D01FB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAB22B8010F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C4FC433C1;
        Mon, 26 Sep 2022 11:08:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KGaXaRmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664190526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OObOy+S69jXJ2m8R4UqnbrbT5rmgyhTY2SsHXjUDjcM=;
        b=KGaXaRmV64IQYu1htPoCX6pumEUv+uWCtXrf6T/a4FpdExAyp307byo5WPkvWPutMYQKTz
        F1pep/+jkSumXtjiXADTyiNXaOENdD8PcajHKun503XKTrMBX09igX2511ThJDeTpem61t
        iioJs3mbZ36cfqHYK6loss+G1ZxeZQY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id be0ef589 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Sep 2022 11:08:45 +0000 (UTC)
Date:   Mon, 26 Sep 2022 13:08:43 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v3 3/3] m68k: rework BI_VIRT_RNG_SEED as BI_RNG_SEED
Message-ID: <YzGIO4IK9WXFyXsD@zx2c4.com>
References: <20220923170340.4099226-1-Jason@zx2c4.com>
 <20220923170340.4099226-3-Jason@zx2c4.com>
 <CAMuHMdXPcXq_F0dQdJ5nV2io1eDhJs7BZf+TmXWPqGVn9xeLNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdXPcXq_F0dQdJ5nV2io1eDhJs7BZf+TmXWPqGVn9xeLNA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Sep 26, 2022 at 12:27:13PM +0200, Geert Uytterhoeven wrote:
> The approach LGTM, but given my doubts on [PATCH v3 2/3], I think this
> patch should be moved up, to not depend on [2/3].

I'll do that. But also, I'm not sure I yet agree with you about 2/3, so
we should keep discussing that. (I'll still move it to 3/3 though.)

> > -#define BI_VIRT_RNG_SEED       0x8006
> > +/* No longer used -- replaced with BI_RNG_SEED -- but don't reuse this index:
> > + *     #define BI_VIRT_RNG_SEED        0x8006 */
> 
> Please drop the space before TAB.

Ack.

> 
> > --- a/arch/m68k/include/uapi/asm/bootinfo.h
> > +++ b/arch/m68k/include/uapi/asm/bootinfo.h
> > @@ -64,7 +64,13 @@ struct mem_info {
> >                                         /* (struct mem_info) */
> >  #define BI_COMMAND_LINE                0x0007  /* kernel command line parameters */
> >                                         /* (string) */
> > -
> > +/*
> > + * A random seed used to initialize the RNG. Record format:
> > + *
> > + *   - length       [ 2 bytes, 16-bit big endian ]
> > + *   - seed data    [ `length` bytes, padded to preserve 2-byte alignment ]
> 
> While experimenting, I noticed this must actually be a 4-byte alignment,
> as data[] is an integral multiple of __be32 words:
> 
>     struct bi_record {
>             __be16 tag;                     /* tag ID */
>             __be16 size;                    /* size of record (in bytes) */
>             __be32 data[];                  /* data */
>     };
> 
> m68kboot[1] and kexec-boot[2] do implement the correct rounding,
> but qemu's BOOTINFOSTR()[3] and BOOTINFODATA()[4] do not.
> Sorry for missing that before, I guess I was misled by the existing
> bug in BOOTINFOSTR().
> 
> Consequently, both kexec-tools[5] and the m68k-bootinfo tool[6] cannot
> parse /proc/bootinfo if the size is not a multiple of 4, which can
> easily be triggered by changing the command line of the m68k virt
> machine.

In my brief experience in working with this structure, I've just made
sure that data[] is casted to (void*) or (u8*) or something, and then
everything is fine. But the tools you've linked to expect 4 byte
alignment. So, it sounds like what you're saying is that while we're at
it with fixing the constant, I should also make sure seed data preserves
4 byte alignment, and update the comment too? That's easy enough. I'll
do that for v+1.

Jason
