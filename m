Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B67C5FCE64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJLW2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJLW2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:28:19 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F33FFFF8C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:28:18 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1370acb6588so354592fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9BN0Pk/K+PCpDcgg2tmeghFGpuxVnyr+nUJEj9O/iOg=;
        b=PG8Sv/Yka8Yp9Rz2YLwXRoCSk3ohLBk553apBMHs77bHj0q0NFj7kkqwZ0TBSsCYPk
         SGrv+k5MFvW+V0pa+FgG02mjEH0rkI/8l48hyyjlU3KRTTUBIeZRKDumRoLz0T0pgk91
         bPxfYJXWhXwseUvfKSSj2+OuNifFSdfr8kQU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BN0Pk/K+PCpDcgg2tmeghFGpuxVnyr+nUJEj9O/iOg=;
        b=2srsBELhlvWC+tx9EE5TszTSFch82Ti5aXwaipbxbqw0MHUg3Glperw4JHgE/y/IFq
         jMNhIWpP+K0gSF1ITrEO42F8rqx46LceKQnkBOtOFmv5XgYAZK6moYb3hpRxxZsn7h7n
         2QBJxELaxmjtFAbg4GzGRRhvTCD3GCknrlwruJUGHeeSp2u0oYJxNqbEm5VYCGO/jOLa
         0l5bGcJXFOI+01zutLtLvkCBsG+164xipI1ibOXWVeOs1NNuYuFQS3jb3DuY3A7BBjuA
         tS0uEgNe6gjFKbwHervrsZiNgpEOTqlLpFdMWBEuHKrvumeEXslD1lMmoaUvIcEPBc9k
         WY8g==
X-Gm-Message-State: ACrzQf2wxqX/c1dyeU7Ia1LOtNCCuyVC9sVoRQxmOmN0bG0zG3OoxOrd
        gFar/v+6BbGG6pnRyyb00y/VJDfEE4o9Cw==
X-Google-Smtp-Source: AMsMyM6Ck194KRzVgAebDzhMfjw+nFgdX1Mia7fc1nnG5kR0C6RwQXVGSA7SGkxJqPaf/NLPNW28cg==
X-Received: by 2002:a05:6870:430d:b0:136:7f6a:9429 with SMTP id w13-20020a056870430d00b001367f6a9429mr3847572oah.271.1665613697235;
        Wed, 12 Oct 2022 15:28:17 -0700 (PDT)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id j15-20020a056830270f00b00661a05f2a97sm3692939otu.61.2022.10.12.15.28.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 15:28:15 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id s125-20020a4a5183000000b0047fbaf2fcbcso143009ooa.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:28:15 -0700 (PDT)
X-Received: by 2002:a05:6830:4421:b0:661:8fdd:81e9 with SMTP id
 q33-20020a056830442100b006618fdd81e9mr10083311otv.69.1665613694769; Wed, 12
 Oct 2022 15:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221012220312.308522-1-mst@redhat.com>
In-Reply-To: <20221012220312.308522-1-mst@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Oct 2022 15:27:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjennbcJPkVy5fk5Hwv9uZvuzJzi9CN0gEwNs5j-psKyA@mail.gmail.com>
Message-ID: <CAHk-=wjennbcJPkVy5fk5Hwv9uZvuzJzi9CN0gEwNs5j-psKyA@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: use irq to detect interrupt support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This seems to happen because pci_dev->pin is not populated in
> pci_assign_irq().

Yeah, I have to say, I wonder why it was looking at pci_dev->pin in
the first place.

I was curious, as this is fairly odd.

Of course, I only did a fairly strange 'grep' for this thing, so I
might have missed some other use:

    git grep -e '->pin\>' $(git grep -l 'struct pci_dev')

and the above will possibly find other uses of 'pin' as a member than
the 'struct pci_dev', so I'm not going to claim the above is
exhaustive, but looking at the results, I do see how ACPI has somewhat
similar logic, and acpi_pci_irq_enable() does this:

        ...
        pin = dev->pin;
        if (!pin) {
                dev_dbg(&dev->dev, "No interrupt pin configured\n");
                return 0;
        }
        ...

but in the end that seems to be because it's then later using the pin
to do the actual PCI IRQ routing table lookup, and then it uses that
value to actually look up the IRQ number:

        dev->irq = rc;
        dev->irq_managed = 1;

and in fact all this code also has a "have I already looked this up"
and then it doesn't do anything (but somewhat illogically, it does
that *after* having tested for that "!pin" condition - I think it
would make more sense to go "oh, I already have this interrupt mapped,
I shouldn't care about the pin", but I suspect it doesn't matter in
practice).

And I really think that that is basically the only time you should use
that 'pci_dev->pin' thing: it basically exists not for "does this
device have an IRQ", but for "what is the routing of this irq on this
device".

There's also some testing of dev->pin in drives/pci/pci.c and
drivers/pci/probe.c, but it seems to be very similar: it's actually
doing the irq lookup, and the pin swizzling that goes along with it.

IOW, I think that yes, this patch makes sense, and virtio_pci was
doing something odd. That virtio_pci driver at no point actually cares
about the PCI pin, will not do any PCI irq routing lookup with it, it
will just do

        err = request_irq(vp_dev->pci_dev->irq, [...]

using the pci_dev->irq that has already been looked up.

So the patch makes sense to me. If there is some problem with
pci_dev->irq, then it's up to request_irq() to complain about it (ie
we have things like IRQ_NOTCONNECTED etc, which is a more modern-day
version of the old NO_IRQ thing).  Again, not something that
virtio_pci should check for itself, I think.

But I don't really know the virtio code. I can only say that "check
the pin" pattern seems entirely wrong and should only be done by code
that does actual irq routing, and "just check the irq" is what
everybody else does.

                    Linus
