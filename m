Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19A9662E63
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbjAISMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbjAISMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:12:21 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F4C6950C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:09:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs20so9080205wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP7tDuMfFzk+ap02oIkyYl/Y02UtORu8S5nNrQvTLXA=;
        b=llDKlY926tKPpaN7HL3L1aqa5nUuIxuYAuYxrudEjgH9/xkkABLagRCPCrW3fbIeIz
         MM1C6EJ87cS2S24Up7vZrCcK5yWbxdsD4IcoMZTVy+NeiiRa/PwZjUblBRaaUlivM8F4
         n/FbAjfkspPJM2HdeQcFrHEyGdn6cQpYKoB7wN2lOtm1BvjPi6JZa0P1R8jVijNqo571
         m14YQt2/1/Wu9xVEyA4S1peCcYa6QnZhh4hwt3lXaKbej67zwe5vWRFrA5Me22WYLUra
         wiK9fB/RBp3zIxV8IFy2WLO5g3foHrui/SMl6quQ6/ORqH08E/bS9Z5EPVzZD+imQlJt
         6vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gP7tDuMfFzk+ap02oIkyYl/Y02UtORu8S5nNrQvTLXA=;
        b=q+prUBRnch1TLvIkwq7f8DFCkO5Ax8Dum22iEjELMDjPyNhcfFgmXaoNQ2uSFcai+0
         /D1JI8+IXB4pgLTnQJXK/Jo7gV3KCaPJ3vZ0ZcDiNsNAhw6GcwJN6h+XZ7URV5ea0utG
         fG/4Sgw6/C9FuMg1tjfGAMbzTwlbrw1+qJQ4wnvJruE2qujqmPvt5Jrvrg5QYJJDPJfH
         OW0NEA41y1h3rSHlV7kExDxPyoMknPHcJGd/geNnisz8LznnPCyrNzb1nDqbLE/hkxZo
         r6b5+7XKSepkqae33qEaY/lkoXXTiAhV27wBiEHPDOcbDtrCAeaIUfVnpJ7ZCqK7O+D4
         vI8Q==
X-Gm-Message-State: AFqh2krlAF9QUElrhjb0GW7ohkucX2Aq83H0IjZXT7PM+uDWXhgiP/dc
        iW9bqDfuFPGfvGDs5dWGxqY=
X-Google-Smtp-Source: AMrXdXuvtJvyNyH1b4NrXQZNdaThqb7thDEofk+TfdausqzfuSvNfETl+uLbULgNuwsL/VAG6KOEPw==
X-Received: by 2002:adf:f44f:0:b0:2bc:7ff8:fb83 with SMTP id f15-20020adff44f000000b002bc7ff8fb83mr1853073wrp.47.1673287788314;
        Mon, 09 Jan 2023 10:09:48 -0800 (PST)
Received: from suse.localnet (host-79-13-98-249.retail.telecomitalia.it. [79.13.98.249])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm6190224wrv.113.2023.01.09.10.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:09:47 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Fix two spelling mistakes in highmem.h
Date:   Mon, 09 Jan 2023 19:09:46 +0100
Message-ID: <2269967.ElGaqSPkdT@suse>
In-Reply-To: <Y7cCprZBVrNO3aZ9@iweiny-desk3>
References: <20230105121305.30714-1-fmdefrancesco@gmail.com>
 <Y7cCprZBVrNO3aZ9@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 5 gennaio 2023 18:02:30 CET Ira Weiny wrote:
> On Thu, Jan 05, 2023 at 01:13:05PM +0100, Fabio M. De Francesco wrote:
> > Substitute two occurrences of "higmem" with "highmem" in highmem.h.
>=20
> The change looks fine but for Andrew's benefit I believe this patch is ba=
sed
> on the other one you submitted to fix kmap_local_folio()?[1]  Is that
> correct?

Yes, it is.=20
I had completely forgotten that previous patch.
Thanks for noticing it and for providing its link to Andrew.

=46abio

>=20
> [1]
> https://lore.kernel.org/all/20230105120424.30055-1-fmdefrancesco@gmail.co=
m/
>=20
> With that note:
>=20
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>=20
> > Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >=20
> >  include/linux/highmem.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> > index 7b0085a61e67..ae1670ccdf45 100644
> > --- a/include/linux/highmem.h
> > +++ b/include/linux/highmem.h
> > @@ -86,7 +86,7 @@ static inline void kmap_flush_unused(void);
> >=20
> >   * virtual address of the direct mapping. Only real highmem pages are
> >   * temporarily mapped.
> >   *
> >=20
> > - * While it is significantly faster than kmap() for the higmem case it
> > + * While it is significantly faster than kmap() for the highmem case it
> >=20
> >   * comes with restrictions about the pointer validity.
> >   *
> >   * On HIGHMEM enabled systems mapping a highmem page has the side effe=
ct=20
of
> >=20
> > @@ -119,7 +119,7 @@ static inline void *kmap_local_page(struct page=20
*page);
> >=20
> >   * virtual address of the direct mapping. Only real highmem pages are
> >   * temporarily mapped.
> >   *
> >=20
> > - * While it is significantly faster than kmap() for the higmem case it
> > + * While it is significantly faster than kmap() for the highmem case it
> >=20
> >   * comes with restrictions about the pointer validity.
> >   *
> >   * On HIGHMEM enabled systems mapping a highmem page has the side effe=
ct=20
of
> >=20
> > --
> > 2.39.0




