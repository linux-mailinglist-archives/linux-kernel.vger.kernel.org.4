Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CDE6CD2C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjC2HQH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 03:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjC2HQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:16:05 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC28CE;
        Wed, 29 Mar 2023 00:16:02 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-544f7c176easo276877347b3.9;
        Wed, 29 Mar 2023 00:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680074161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRC1wc1HRmoSKP28Csbp1c2SyHFhwUwNxc/3v65hV78=;
        b=CQgQvB0OodMNi2LuXearNPzHgOTOpcS+6Qe1NZrEKybjNia+DXhq5JekSH+3F1D7j8
         cuwN4O2StQwHXQM1BLqB0u456xd4+tcYpbqMcHJ1XhRMYC3mk13mxSGN+XfngiKbwyc9
         M3Y7SUHv7G2ry+GTWD/bIWVGFBlt0pfsXwej6wUql6SHsm9s4cnzfGLtUPTU8deoks16
         uc94rZpN1KdByNLUkn2kkuZdZiBiuvHWSNKnRAm/efNr4SJQStsZR5MYbbEPwT9vOg7/
         p+I/UsO3cZX1RsZriE7PtYLByWxkgpCSuh6GwoPIxRXEFKhU+ikFkdLTfvyD4YutCgJL
         g3rA==
X-Gm-Message-State: AAQBX9exgDVGYE/1J00vzWNFzZkqIeNtBUMOnknfkG19SIh4v0vPyqXb
        WncxkrVk+PDblqJTGH4DBDIsLSTR/tGN2w==
X-Google-Smtp-Source: AKy350YxOgL8s6znm2mVrEmcaFNrIg8XghmU/kmJj+yvqEqnt/97Lavm3I0QsHii19fBXSLRGWDevQ==
X-Received: by 2002:a0d:ea04:0:b0:544:b872:77a0 with SMTP id t4-20020a0dea04000000b00544b87277a0mr1224739ywe.19.1680074161555;
        Wed, 29 Mar 2023 00:16:01 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id x15-20020a81f90f000000b00545a08184ebsm2856685ywm.123.2023.03.29.00.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 00:16:01 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5445009c26bso277024847b3.8;
        Wed, 29 Mar 2023 00:16:01 -0700 (PDT)
X-Received: by 2002:a81:b28a:0:b0:544:5fc7:f01f with SMTP id
 q132-20020a81b28a000000b005445fc7f01fmr8681031ywh.4.1680074161155; Wed, 29
 Mar 2023 00:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230316140912.1038404-1-desnesn@redhat.com>
In-Reply-To: <20230316140912.1038404-1-desnesn@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Mar 2023 09:15:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX=M+zQ+Y_DoYkHyfT0FCKWtKcAwhpze7jxQo_HXmH1aw@mail.gmail.com>
Message-ID: <CAMuHMdX=M+zQ+Y_DoYkHyfT0FCKWtKcAwhpze7jxQo_HXmH1aw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] scsi: smartpqi: fix DMA overlapping mappings asymmetry
To:     Desnes Nunes <desnesn@redhat.com>
Cc:     iommu@lists.linux.dev, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, linux-kernel@vger.kernel.org, hch@lst.de,
        martin.petersen@oracle.com, don.brace@microchip.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, jejb@linux.ibm.com,
        jsnitsel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Desnes,

On Thu, Mar 16, 2023 at 3:13 PM Desnes Nunes <desnesn@redhat.com> wrote:
> In summary, this series fixes an overlapping mappings asymmetry on the
> smartpqi driver due to a missing pqi_pci_unmap() call, while also adding
> the cacheline on debug messages of dma-debug debugging functions.
>
> Other minor non-functional updates are also provided.

Thanks for your series!

Unfortunately this v2 does not fix the build issues reported by the
bots, thus breaking linux-next on plain 32-bit.

I have sent a fix
https://lore.kernel.org/r/20230329071405.1568021-1-geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
