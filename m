Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5233A700A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbjELOqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbjELOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:46:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47581FCE;
        Fri, 12 May 2023 07:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D13261AE0;
        Fri, 12 May 2023 14:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943E5C433A4;
        Fri, 12 May 2023 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683902768;
        bh=TtzZfksZi7cPRv2uBglEdZgsW/josdyvw+39El6H74o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I3MwLbThAIKauAODJShSdIAUTbLO9KXbaKS12uU2H84QX/aBzsg+8qRPRSYX67Pxr
         Y3PgjeaPumQPZUJRvvY/vTwlXu7MwHeQ7hQEA7yAFltnO+FsFj+U3B/3w0eNepu5Kc
         a8+j6w50lzEt0knhXZECaRhFVu8J3lW4mwrQDltbdak7vHDcioV5vkBh+V0ad6CYxK
         lgTpCtSDRVZFJ8UkD0oGBND20VYmf2u32rGpnw/pgouQS1Q5qemPf6wfassdrXfaMV
         PF9wWUoTz9cBiZZ2/KoS/Pa4YsKFQpjr7GgTGXlf2AOHFPLIgbRZ7Oc3nnu/NU6ViZ
         EeIFbaTgCfU5Q==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ac87e7806aso95430711fa.3;
        Fri, 12 May 2023 07:46:08 -0700 (PDT)
X-Gm-Message-State: AC+VfDzSlgPaAgskwGzJJq4QRacJXsfZ2OprhXndJckFF/W43t9CYrKt
        px3eRo1NQHihPTNMEfU7PkwpAODLWJqFNm7jw6M=
X-Google-Smtp-Source: ACHHUZ4CyOmSB8RuDLq2WBdAIYYpC9F8H1OU8ZRHZrcZvHWcbXltZjHl8pYK1trcA3PaGAiYbfvgL6Rsjk4Phw5niHE=
X-Received: by 2002:a05:6512:3767:b0:4ea:e0e7:d12d with SMTP id
 z7-20020a056512376700b004eae0e7d12dmr3191082lft.1.1683902766600; Fri, 12 May
 2023 07:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230215100008.2565237-1-ardb@kernel.org> <87y1nvng1s.fsf@mid.deneb.enyo.de>
In-Reply-To: <87y1nvng1s.fsf@mid.deneb.enyo.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 12 May 2023 16:45:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGXCFFQQObtkGje=Hym0GuEgR3h85MX8d1_hBb=b3Fxdg@mail.gmail.com>
Message-ID: <CAMj1kXGXCFFQQObtkGje=Hym0GuEgR3h85MX8d1_hBb=b3Fxdg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Retire IA64/Itanium support
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 at 23:56, Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Ard Biesheuvel:
>
> > The IA64 port of Linux has no maintainer, and according to a report from
> > its only remaining user [0], it has been broken for a month and nobody
> > cares.
> >
> > Given that keeping a complex but unused architecture alive uses up
> > valuable developer bandwidth, let's just get rid of it.
> >
> > This supersedes my patch proposing to mark it as 'dead', which received
> > no replies from anyone that wants to keep it alive. [1]
>
> Is this still going ahead?
>
> In userspace, ia64 is of course full of special cases, too, so many of
> us really want to see it gone, but we can't really start the removal
> process while there is still kernel support.

I brought this up again [0] in the context of GRUB (which has similar
issues related to EFI the the kernel has) and Adrian suggested to
raise this discussion more widely, perhaps on the distributions
mailing list, among other places.

Do you have any recommendations for a venue where we might find the
right mix of people who can drive this to a conclusion one way or the
other?

Thanks,


[0] https://lists.gnu.org/archive/html/grub-devel/2023-05/msg00068.html
