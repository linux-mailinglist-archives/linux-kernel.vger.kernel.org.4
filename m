Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF246F8F33
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 08:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjEFGcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 02:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjEFGce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 02:32:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853A9A25D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 23:32:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so4606530a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 23:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683354734; x=1685946734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh+rLv64T/XKdExtopYbn1p2e3mwdhjXoRnI90UeXPc=;
        b=Cw0ZoCrla02smvOEcplDOfZp3uMEhtdCu5BQfK22OXgCeI2LrkCiqDj7uFJRqGZl0W
         yWRmT4X1Ave0TGei0TcIxSB/wUIisf5cuRMf7KHnabqeb3kFz6lC4BIBK7Dxkv97jgAM
         Bn9wzpVHObuoOZWHG6zsKpVa8nvwgwLgt9/5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683354734; x=1685946734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh+rLv64T/XKdExtopYbn1p2e3mwdhjXoRnI90UeXPc=;
        b=TfePTiErnA1tei53d3hNUN81IfcNZxZRHBKrO1hXcLdWtxuKCkamOv7+spk5ZoMuYI
         6qTS8ajDFyIbHyKvYYBWkGBcXF2v++aK5EGLkkU0SlE6FgPaMDFjCf/4FA3hu/asuXFs
         VCweJU1mp/htP6ZcTU1ZjFEF3UK/BzDsoGW4D4O5Zzeyk5c4AUQz2QA02Smh5wIPklgq
         oHCSLSsXtQAFp1bWJu89+CudVtzwf7RDPkoTIvnDY3HfYrq3beEscddrnISDQ/jDuDiq
         2nq2Bm8VcoWlfanltDuzHDf2QGziX7Of4muqYh2J3GUNKnGTADwlmD3Qql4RM9B2NY/9
         zRag==
X-Gm-Message-State: AC+VfDwC0K9SE8z0egu1QR0EeGs+D7uCi8KBx/5dbrW83sKzIY9FhygO
        tKFkqsNfgzwvp4ZxkxR7Z9coodeFvZEoPvO88p1R9A==
X-Google-Smtp-Source: ACHHUZ49lLaiO0buFBePac28VZVZZ5J4y63mNd4+sXRBHhN0wwrJ6PD3jFK0pFSF8IgYJk2lmVOifSuBIwb8CLlZkRk=
X-Received: by 2002:a17:907:9605:b0:93e:fa12:aa1a with SMTP id
 gb5-20020a170907960500b0093efa12aa1amr3601469ejc.1.1683354733732; Fri, 05 May
 2023 23:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230420004850.297045-1-sarthakkukreti@chromium.org> <20230420004850.297045-5-sarthakkukreti@chromium.org>
 <ZFAP5yQ0mwE4F6Vg@redhat.com>
In-Reply-To: <ZFAP5yQ0mwE4F6Vg@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Fri, 5 May 2023 23:32:02 -0700
Message-ID: <CAG9=OMNh8w9hmkU6ZHBm8bN0NGCL4NaKv7XAEQrFvTKKNcXLLg@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] dm-thin: Add REQ_OP_PROVISION support
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniil Lunev <dlunev@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, ejt@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 1, 2023 at 12:15=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> w=
rote:
>
> On Wed, Apr 19 2023 at  8:48P -0400,
> Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
>
> > dm-thinpool uses the provision request to provision
> > blocks for a dm-thin device. dm-thinpool currently does not
> > pass through REQ_OP_PROVISION to underlying devices.
> >
> > For shared blocks, provision requests will break sharing and copy the
> > contents of the entire block. Additionally, if 'skip_block_zeroing'
> > is not set, dm-thin will opt to zero out the entire range as a part
> > of provisioning.
> >
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  drivers/md/dm-thin.c | 73 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 68 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > index 2b13c949bd72..58d633f5c928 100644
> > --- a/drivers/md/dm-thin.c
> > +++ b/drivers/md/dm-thin.c
> > @@ -1891,7 +1893,8 @@ static void process_shared_bio(struct thin_c *tc,=
 struct bio *bio,
> >
> >       if (bio_data_dir(bio) =3D=3D WRITE && bio->bi_iter.bi_size) {
> >               break_sharing(tc, bio, block, &key, lookup_result, data_c=
ell);
> > -             cell_defer_no_holder(tc, virt_cell);
> > +             if (bio_op(bio) !=3D REQ_OP_PROVISION)
> > +                     cell_defer_no_holder(tc, virt_cell);
>
> Can you please explain why cell_defer_no_holder() is skipped for REQ_OP_P=
ROVISION here?
>
I recalled seeing a BUG in dm-prison-v1 if I allowed
cell_defer_no_holder() for REQ_OP_PROVISION, but from additional
testing, it looks like it was left behind from a cleanup in v4.
Dropped in v6.

Thanks
Sarthak

> Thanks,
> Mike
