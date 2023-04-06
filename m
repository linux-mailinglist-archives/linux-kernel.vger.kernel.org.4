Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7F36DA46B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbjDFVHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbjDFVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:07:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4DC15E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:06:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680815214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8nQERgw7YtZO2dqQmJe5wEgLvO/QyUuPIGGR9H4mYZI=;
        b=1LYT09hmKpp/0aCVGL4McOc+Rjn7AZadoRtB4wBqtB0Lr1F0iYZS2Jc4AH5TpHnbnvZkCH
        t0fJMvBGaTu5TJeVifIspYRT2RgRCTTgusK5Hl04MRh+xQS9/hL/+89wdAC5r2AInXgA2G
        sxGCw9Y6sUxGh1zCVpB2Odn4VWsMkiyjR/rWeljHn7kFttoLkroLhFk/80h98Ij79cqQX6
        961i6K1gudfDHE5XAxNLiHaEMMVvQYz27a1i1OZ0tO9tltl0nVPnFzhSm0G89BQTwT2/bO
        4kKmd787am95i8dEUoFERr/mO/HV5jdUhzNX/R3DgQ/dpj3JE0+pWH1ewdzFig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680815214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8nQERgw7YtZO2dqQmJe5wEgLvO/QyUuPIGGR9H4mYZI=;
        b=3zbtsgsfLhai8L9wUUlJneYAdrA2/+NhtNhsTVRSaqLADYyo/seJkXnFa3qs4RJe5Ycl4d
        WbVfwf5jmQcqHSCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: revert bab65e48cb064 PCI/MSI Sanitize MSI-X checks
In-Reply-To: <CAHk-=whd4w2wu13O9b5VRKE1b3MoUk89Q_WzhELyqXGAKmfqmQ@mail.gmail.com>
References: <caca6879210940428e0aa2a1496907ab@AcuMS.aculab.com>
 <CAHk-=whd4w2wu13O9b5VRKE1b3MoUk89Q_WzhELyqXGAKmfqmQ@mail.gmail.com>
Date:   Thu, 06 Apr 2023 23:06:53 +0200
Message-ID: <87bkk0ra8i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06 2023 at 12:35, Linus Torvalds wrote:
>> Previously it returned 8.
>
> Does just moving the pci_msix_validate_entries() down to below the
> hwsize update code fix it?
>
> IOW, something like this attached patch?
>
> ENTIRELY UNTESTED! This may be seriously broken for some reason, but
> it does seem like the current code makes no sense (that "Keep the IRQ
> virtual hackery working" comment seems to not possibly be true since
> the MSIX nvec has effectively been checked against hwsize by the
> pci_msix_validate_entries() code before).

Yes, that works too. But I rather remove the hwsize check from the
validation function as I explained in my earlier reply to Bjorn in that
thread.

Thanks,

        tglx
