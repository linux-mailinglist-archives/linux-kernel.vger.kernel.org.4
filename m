Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BB46EA109
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 03:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjDUBgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 21:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjDUBgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:36:15 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2D440C5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:36:14 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 18BFB3F212
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682040971;
        bh=GFqFeIgBeBfIMjsdM/PG1AbNPQ06ux7wVgm4vh+l6CQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ltcxdRB0BT8BMBZ5+IN+THcQUTyOljM+OqnPpyvtUVY0ADxGbgXj5vNjoDjkQF3wx
         HNyK5lD3Jt0JtdfCb+2giO+99C5sZvSgxgMJfdE2n8J3PJpkzUDDHYnD4E0KKMxJg/
         lT2VO4up6NH5kuI+X1bdOTN+BpHWS7yU2YFB11KbpxP7faEF9Ncyp7QhpElkYOPKWn
         GNg2whDLAkJCdvuY9Q/qOa/v36V7oSuso/jL9lQvdF6/Wsumb/SIPhic1uqObZzajb
         hXp+aR6c2HgBT5d1VUYNVQyZmqD9n90nIxu8J21iIkK41xSVqgv5BKnPuh/GVl59A7
         mcZrXOrwEChog==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-63b79d8043eso8835081b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682040969; x=1684632969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFqFeIgBeBfIMjsdM/PG1AbNPQ06ux7wVgm4vh+l6CQ=;
        b=Lzsti4LytnkZN1LwJVMhg0e2KD8Yg0n1GL2vLZk/yWLnXoNfXr2gsffSme4/ASBxnk
         uYBz30NY14uvoiN7ajNVLWhnq+Ue8nOIoBgxPp7NnAozUhRCJf3z1j225tn7ArjybDWo
         +ZY76j19/rKXdurPgRzzzfg8K7Fxd3VXLLHNkTXLdozJg9UuT+h3LboM4jCmsoVnL/D7
         aHQvjBbZZ+FRg/2WrbUjb+WqIDkUSFiHxMeRv2J7w3yymJDQA89gcSi28IqCihAaTR3Y
         VzoNYi/2iGx3+Wmj0qXZ0a+yL9seorHoJyTWM4ocHQMgxbvaUUyudu3cSSBmRe8vcYus
         LMRg==
X-Gm-Message-State: AAQBX9dGbBJlQg0QvvVG3GTmj8RRfrRCkpuD18NqWWh3f666lxgpvsYu
        fCKVpHaHgpt89uVpljZed/Cex4go1hG0G1fSZECSUCaYQt379kkG+f++PLZleu52BZeZIU/nKGJ
        7jSC0JoyNhNxpvvKRE9oFKUKMmKGW+s/br3ImhNFzSzcA6riS7Cz4nPK5bGbSeK22CvQw
X-Received: by 2002:aa7:8554:0:b0:63d:40bb:a88b with SMTP id y20-20020aa78554000000b0063d40bba88bmr7557419pfn.14.1682040969596;
        Thu, 20 Apr 2023 18:36:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350b2xP3YmNZIWdRV0zAYilKxnDQ7vmaReYFn438x/9kxQ7TczTauhzjWuADT5iy34bcGqwr/oOSjupwaQyNReW0=
X-Received: by 2002:aa7:8554:0:b0:63d:40bb:a88b with SMTP id
 y20-20020aa78554000000b0063d40bba88bmr7557399pfn.14.1682040969234; Thu, 20
 Apr 2023 18:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230420125941.333675-1-kai.heng.feng@canonical.com> <e84eda25-dbe9-a108-c4d4-ee3fa746d9ca@linux.intel.com>
In-Reply-To: <e84eda25-dbe9-a108-c4d4-ee3fa746d9ca@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Apr 2023 09:35:57 +0800
Message-ID: <CAAd53p4hYR9f_Mh9cxGfBVnK_akLQMBACLDBnEHHzacJ5OZEGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PCI: Keep AER status in pci_restore_state()
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sathyanarayanan,

On Thu, Apr 20, 2023 at 10:39=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Kai,

It's Kai-Heng :)

>
> On 4/20/23 5:59 AM, Kai-Heng Feng wrote:
> > When AER is using the same IRQ as PME, AER interrupt is treated as a
> > wakeup event and it can disrupt system suspend process.
> >
> > If that happens, the system will report it's woken up by PME IRQ withou=
t
> > indicating any AER error since AER status is cleared on resume.
> >
> > So keep the AER status so users can know the system is woken up by AER
> > instead of PME.
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
>
> Any history on why it is cleared before? Is it done to hide some resume
> issues?

It was introduced by commit b07461a8e45b ("PCI/AER: Clear error status
registers during enumeration and restore").
The justification is quite reasonable so I think maybe we should keep it as=
 is.

Kai-Heng

>
> > v3:
> >  - No change.
> >
> > v2:
> >  - New patch.
> >
> >  drivers/pci/pci.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 7a67611dc5f4..71aead00fc20 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1778,7 +1778,6 @@ void pci_restore_state(struct pci_dev *dev)
> >       pci_restore_dpc_state(dev);
> >       pci_restore_ptm_state(dev);
> >
> > -     pci_aer_clear_status(dev);
> >       pci_restore_aer_state(dev);
> >
> >       pci_restore_config_space(dev);
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
