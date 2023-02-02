Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C116F688776
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjBBTUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjBBTUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:20:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9FD7B7AE;
        Thu,  2 Feb 2023 11:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1586DB827CB;
        Thu,  2 Feb 2023 19:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC752C433B4;
        Thu,  2 Feb 2023 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675365618;
        bh=GW+/PPknO/L/X81AhOAvMB1ckLEie9QjfLbxFOYKFMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dBeeShQkGJe7DDOf55DzcM2giWAc7gn+Rhuifqe6QxhE9Ez1nhQJi917uHb6aUjK2
         ivw/SBC1O8Pnr44rx/0omgfG3N02C1IFXiTIiaDYFnDuO9r7WzQAPxzSWfMg1FFdxc
         1XFkv06gbclznnpBRKUwZY6ZECXeGXNOy/jDLsiiYvTWLYTX0yCd/L0B/ZoXjgDoax
         F2nzKOtYspRd2EoA6MyURYoeb5tfKDTddyQls3CWjnbl5vYetQsUEYzZaa12ph7/NU
         ie6QfU94hLvQVsQ4LTL/GiC9Thm7GX9rDmaGpGDIeva6OSZv+dzBktHDwX/ovGGiJq
         sBaWo1uesMctQ==
Received: by mail-lf1-f49.google.com with SMTP id b3so4500341lfv.2;
        Thu, 02 Feb 2023 11:20:18 -0800 (PST)
X-Gm-Message-State: AO0yUKV6mWOSvHb4GoLC8kqvA8HChNUgCPBqR9y/QVPfeJYWJHqKD6JK
        PdnMMMYqdQelbnsV8bGugvbAHLMVVlPBo+7Mftk=
X-Google-Smtp-Source: AK7set8f/y1tDqDb8um8dkpVuXWlMd7cPiWojFc/RDUlBXn9F2x4UAKk0tGsfdESMBoK9BDxmjY865izBQ0xCKgQYCc=
X-Received: by 2002:ac2:5b9c:0:b0:4d8:767b:8b6b with SMTP id
 o28-20020ac25b9c000000b004d8767b8b6bmr1440315lfn.63.1675365616510; Thu, 02
 Feb 2023 11:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20221101222520.never.109-kees@kernel.org> <20221101223321.1326815-5-keescook@chromium.org>
 <CAMSo37W3gRkP02tSCxGX71ZDAt3WgPZrkTRTM6J1iQ4gvUS9vg@mail.gmail.com>
 <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com>
 <63dbf04a.630a0220.2608a.0149@mx.google.com> <CANDhNCoJJs_jSAdr6uved=cK=-6+nzSJq3e_E3HgtiXHZXkVww@mail.gmail.com>
 <63dc0a89.170a0220.49507.0091@mx.google.com>
In-Reply-To: <63dc0a89.170a0220.49507.0091@mx.google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 2 Feb 2023 20:20:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHTwFH-OADZ5nZXfZyuH-x7XJL3DMyiz2Tr_nCuup+xFA@mail.gmail.com>
Message-ID: <CAMj1kXHTwFH-OADZ5nZXfZyuH-x7XJL3DMyiz2Tr_nCuup+xFA@mail.gmail.com>
Subject: Re: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
To:     Kees Cook <keescook@chromium.org>
Cc:     John Stultz <jstultz@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 at 20:10, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Feb 02, 2023 at 10:56:29AM -0800, John Stultz wrote:
> > That said, making sense of the error message isn't completely trivial
> > either. I've been seeing a few cases recently of some of the new
> > compiler tooling (I pinged you earlier on a CFI one) causing errors
> > that developers aren't really sure how to address.  I know sometimes
> > it's not easy to surface the errors with context to what was wrong,
> > but at the risk of intense bike shedding, is there some way to provide
> > something like "Likely array bounds error" instead of just "BRK
> > handler: Fatal exception"?
>
> Yeah, this is a result of the size trade-off that resulted in config
> CONFIG_UBSAN_TRAP -- there ends up being no message about what went
> wrong. I'd really like to have cleaner handling of this -- perhaps what
> was done for KCFI could be applied to UBSAN as well, though this is an
> area I don't know well myself. (i.e. encoding "this was a UBSAN trap"
> in the trap itself.)
>
> Sami or Ard, is this something that could be improved for arm64?
>

-ENOCONTEXT, so I am going to assume this is about runtime
instrumentation that needs some kind of 'panic' function which it will
invoke if some condition is met that should never occur?

We already use brk with different immediate values in the opcode, so
the arch layer already has what we need. Is this a limitation in the
compiler, perhaps, where it always emits the same brk opcode?
