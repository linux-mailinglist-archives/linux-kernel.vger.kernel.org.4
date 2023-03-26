Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CE6C934F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCZJJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCZJJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:09:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A949032;
        Sun, 26 Mar 2023 02:09:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t10so24117544edd.12;
        Sun, 26 Mar 2023 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679821763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CWz+kM84jjmBibW+1U4/kJJyzwolvMd6Soxllt73RkQ=;
        b=TezzMXLQPDFEMNmCPeVOOce+gMuzyTStYHZN3wFEC+H1b1dSc+orudckLqx/Rrlyr3
         DB33/sl9ZKdeUPlwgWB3IQBuZg3r8H4nis4C5LpnwT5fFqo9LmJGukEpW4p0dNafy8R2
         W5VpGKgRgkuw5qeWA4Mf8sBzDwAHxZCWfmlVgQWc3J76yeP/wyhehtCMilfia9Ril5Uy
         qIpxSa6lLcFW8N5WqPtu/T5aHs/nwuACRLf159bmcZQAWSXQczuAzk3JkW53wtpsSndR
         fM0oupziVdJ/4F8VEoXemYQuFmMxMau/GBIXnNXrz+uwGnWVWlG3E37JT5f6qn29f+Ui
         x9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679821763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWz+kM84jjmBibW+1U4/kJJyzwolvMd6Soxllt73RkQ=;
        b=BrgZzZfvZiN7J0YCMxazOeJr3d1bBufjNazguk2sGiLBb//B1/apPNKztI3M1kP1tN
         KZJD1tEBId3zorVdKPLkoj4pUoowIrLw1ZMLvfmY0jgO8tq6LF39XLY3DdMhI0Sbe4Zt
         UH5pvR7xCJ1rMkRc3xmmGIrWJsLzAKKDpYgQJabLglpTtobHTdpIGkoxHS2KcFoDYc2i
         K8qpKfKrZEbhhpgOZdw0e+Az3+GEMCq2DbeHWP3ga3USkGoa/p3c7d80dXH3zDI4C/Kk
         x7bdGUA1FZf9DUVaGapQ0yn/mtIqa5Q+E5A4cGlncHVVcLn4zhq8dcduSBLSYqcdCtiB
         bUug==
X-Gm-Message-State: AAQBX9fT9ZKFHBfs7LReF7YE5o1GjTnZcAWuWsInE9bPciul1JTMFO09
        1sPyMilvLOgLICu3jeKw4+4mfncsJWCvk+9hbVA=
X-Google-Smtp-Source: AKy350ZutC1LFLhZ+pc81GNrJON1TxYnwf9GxzFCzarL3co8kVdNkLqvXn/fWnnmVzf5lZ8GhqqbcQz3W9Fa12CHllQ=
X-Received: by 2002:a50:f692:0:b0:4fc:fc86:5f76 with SMTP id
 d18-20020a50f692000000b004fcfc865f76mr4126134edn.6.1679821763185; Sun, 26 Mar
 2023 02:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230307224627.28011-1-linux@zary.sk> <202303181955.41922.linux@zary.sk>
 <d16b4b27-f1d3-bf05-e062-516e7c708fa2@omp.ru> <202303221310.44235.linux@zary.sk>
In-Reply-To: <202303221310.44235.linux@zary.sk>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 26 Mar 2023 10:08:47 +0100
Message-ID: <CADVatmORsN4ZdOZ+u0AfUy320UV77PuNn7UiV0Kx1nRX03YJTQ@mail.gmail.com>
Subject: Re: [PATCH 00/32] pata_parport-bpck6: rework bpck6 protocol driver
To:     Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 at 12:11, Ondrej Zary <linux@zary.sk> wrote:
>
> On Sunday 19 March 2023 21:02:43 Sergey Shtylyov wrote:
> > On 3/18/23 9:55 PM, Ondrej Zary wrote:
> >
> > >>> This patch series simplifies bpck6 code, removing ppc6lnx.c file to match
> > >>> the simplicity of other protocol drivers. It also converts the direct
> > >>> port I/O access to paraport access functions. This conversion revealed that
> > >>> there's no 8-bit and 16-bit EPP support in parport_pc so patch 11 implements
> > >>> that.
> > >>>
> > >>> Tested with Backpack CD-RW 222011 and CD-RW 19350.
> > >>>
> > >>> Signed-off-by: Ondrej Zary <linux@zary.sk>
> > >>> ---
> > >>>  drivers/ata/pata_parport/bpck6.c   | 452 +++++++++++++++++++++++++++--------
> > >>>  drivers/ata/pata_parport/ppc6lnx.c | 726 ---------------------------------------------------------
> > >>>  drivers/parport/parport_pc.c       |  20 +-
> > >>>  include/uapi/linux/parport.h       |   3 +
> > >>>  4 files changed, 370 insertions(+), 831 deletions(-)
> > >>
> > >>    OK, it's finally clear I can't keep up with reviewing 32 patches posted
> > >> at once...  Luckily, all those patches seem to be dealing with parallel port
> > >> control), not the PATA control! Of course, when I volunteered to review the
> > >> PATA driver patches, I didn't expect such patch volumes -- I mostly expected
> > >> some odd fixes, not a massive driver rework... :-/
> > >
> > > So you're going to review the (P)ATA parts (if any) only.
> >
> >    I saw no PATA parts in this patcheset...
> >
> > > Maybe Sudip (as parport maintainer) could review the parallel port parts?
> >
> >    I have no objections! :-)
>
> Looks like Sudip does not care. What needs to be done so this can be merged?

oops.. sorry. I missed it.


-- 
Regards
Sudip
