Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392FE6C1A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjCTPsg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 11:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjCTPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:47:54 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD9F72B8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:39:52 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id x1so13521704qtr.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knDpxN/J+logq/gYSas38uHqDy6FJ5gT1auehUzIlVk=;
        b=POwTFTow5lvu/xFmyYKr1nmsJoK72N8vzZllnWWKqMkGqitpaI3raML/kUp8daRnOI
         BH4S/s4GWhMtusfq84qEZWyjhzYLiXLZXdLtL+oxxWPTpmctNuU9pRq8js9Ms5ox2PxC
         DGN4QQFKBA5lZCHKUW0BSLPqSFFeeBP88oYtYNj5WK4fmdIh9wlA4dDmjaHbb03bETe4
         XiDAG5Jmotx67Py+3EP3HM1T2wO2CYOebgrMr/hxLsSdNqolP8HXM/INei2MQdSzIVWY
         H4pH+XKPc8/mU+tOBdjiBVwNPZmu7PNle20B6RArjQKZj7DsXu6q9pCW9heqH+S78I9a
         hNOQ==
X-Gm-Message-State: AO0yUKUFdh1oIcz7XWn1/8xXlDnG/IhyM6O5MvG0op/ZfudRy+OZSm66
        ktqJ+MAxZLelmoUQ5vms2i7mdDFlLWTsnQ==
X-Google-Smtp-Source: AK7set/8LTHTjUIr0IPZnF1xlr3tDWs91QBv9zIUNsa1rERi2DQoWgAeleFRUvLgArZ0YLLn4NXpRw==
X-Received: by 2002:a05:622a:14c:b0:3bf:d193:1b0 with SMTP id v12-20020a05622a014c00b003bfd19301b0mr28370771qtw.48.1679326790844;
        Mon, 20 Mar 2023 08:39:50 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a228a00b00745b3e62006sm7498594qkh.23.2023.03.20.08.39.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:39:50 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5418c2b8ef2so231200487b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:39:49 -0700 (PDT)
X-Received: by 2002:a81:bd51:0:b0:541:9b14:949e with SMTP id
 n17-20020a81bd51000000b005419b14949emr10558480ywk.4.1679326788920; Mon, 20
 Mar 2023 08:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <af0a1f2194fc9a6f8a95cf6c82277b8b0377d029.1679311226.git.geert@linux-m68k.org>
 <CADUfDZocrTZq2MPKFFNuJc5yBabG48EiEURwn7-t2UBuVZxCWg@mail.gmail.com>
In-Reply-To: <CADUfDZocrTZq2MPKFFNuJc5yBabG48EiEURwn7-t2UBuVZxCWg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Mar 2023 16:39:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWMih6kqSZaKq5p+UVOjTOCWdeUeif2y2ugtgcVOPmzyQ@mail.gmail.com>
Message-ID: <CAMuHMdWMih6kqSZaKq5p+UVOjTOCWdeUeif2y2ugtgcVOPmzyQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Fix implicit padding in struct nvme_tcp_term_pdu
To:     Caleb Sander <csander@purestorage.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Arnd Bergmann <arnd@arndb.de>, linux-nvme@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caleb,

On Mon, Mar 20, 2023 at 4:34 PM Caleb Sander <csander@purestorage.com> wrote:
> The nvme_tcp_term_pdu definition needs to be updated anyways to match
> the spec. FEI is at offset 10, so it isn't 4-byte-aligned. I think we
> have gotten away with this so far because the NVMe/TCP driver never
> sends H2CTermReq and doesn't interpret C2HTermReq.
> Mirroring numdl/numdu in nvme_get_log_page_command, the definition
> should look something like:
> struct nvme_tcp_term_pdu {
>         struct nvme_tcp_hdr hdr;
>         __le16 fes;
>         __le16 feil;
>         __le16 feiu;
>         __u8 rsvd[10];
> };

Great, so it was compliant only on m68k? ;-)

> On Mon, Mar 20, 2023 at 4:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > On m68k:
> >
> >     drivers/nvme/host/tcp.c: In function ‘nvme_tcp_init_module’:
> >     include/linux/compiler_types.h:397:38: error: call to ‘__compiletime_assert_723’ declared with attribute error: BUILD_BUG_ON failed: sizeof(struct nvme_tcp_term_pdu) != 24
> >
> > Indeed, on m68k the minimum alignment is 2 bytes, not 4 bytes, thus
> > triggering the check added in commit 7e87965d3807ab1f ("nvme-tcp: add
> > nvme-tcp pdu size build protection"), and indicating that NVMe over
> > Fabrics TCP on m68k must be incompatible with other platforms.
> >
> > Fix this by adding explicit padding.
> >
> > Fixes: fc221d05447aa6db ("nvme-tcp: Add protocol header")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  include/linux/nvme-tcp.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
> > index 75470159a194d97f..ba8f82672e39730f 100644
> > --- a/include/linux/nvme-tcp.h
> > +++ b/include/linux/nvme-tcp.h
> > @@ -115,6 +115,7 @@ struct nvme_tcp_icresp_pdu {
> >  struct nvme_tcp_term_pdu {
> >         struct nvme_tcp_hdr     hdr;
> >         __le16                  fes;
> > +       __u8                    rsvd2[2];
> >         __le32                  fei;
> >         __u8                    rsvd[8];
> >  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
