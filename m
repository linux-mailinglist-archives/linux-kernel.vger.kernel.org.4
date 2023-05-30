Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556957171D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjE3Xju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjE3Xjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:39:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152EF9;
        Tue, 30 May 2023 16:39:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E188632F3;
        Tue, 30 May 2023 23:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACF8C433D2;
        Tue, 30 May 2023 23:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685489986;
        bh=+BiZbz9ta2gOLBhRs7L9YQtEb6Ydyw/DhO9Lzb0xCq4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IfPAAgtwayXb6eCV863iVrlPs2nQghkvmi/L6XrNWxUz4mrr4WKzkGnaBUcr27vlF
         yKoR/25zxOdQN8DFJ26AzXElYvaqSSJImDeYg4eo5YNrIoqdtnh9pvXwgDycbxIonA
         6JGSn7Qxwh5IRBeZ/CUNpg/hPmXO36rr5bbVJWDhBzlUByuytnHLmOjyHIvTPlg9fD
         8vQRNwgk0msG4Vb2GTLvvd19RgksMtJrJ2zyoA308JG1hxU2T6Sn3ev8xp+MZhsLp8
         z5Btm7iGWOnOitVZEIdkmbob0ESiUke7vGhYEmoJGtmRmwWuY8zCXbpAr1ZPhehuXg
         F+cxn7wWoHRmA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f5021faa16so3250872e87.2;
        Tue, 30 May 2023 16:39:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDzuhh8bnemxst6nDF5sskKuQfnt4suWVCNQD4rgblyiGkTBb+cR
        +RKlPGxfKRYvqjpws0edR0GsCDg4gyEB44BYTKI=
X-Google-Smtp-Source: ACHHUZ77hf6fLy8U+T9F9TzuiI0V32hxJtAUGDkLS8yoWRMn5b7cCdQa8hy9FoDzgJIMsXlfpzoV7iG1+nmWshVeodU=
X-Received: by 2002:ac2:4a69:0:b0:4f5:1ac9:ab1b with SMTP id
 q9-20020ac24a69000000b004f51ac9ab1bmr162937lfp.23.1685489984847; Tue, 30 May
 2023 16:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230522212114.gonna.589-kees@kernel.org> <CAPhsuW5ibONdyyJq0zVCEHuM38GUocn8A1abi4mTa9gUHH1hHQ@mail.gmail.com>
 <202305301600.EEF0BAAD@keescook>
In-Reply-To: <202305301600.EEF0BAAD@keescook>
From:   Song Liu <song@kernel.org>
Date:   Tue, 30 May 2023 16:39:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Z73azgqXVekYtibqOSKsx8XPU1FVwvZ7XOU5Qee7oAQ@mail.gmail.com>
Message-ID: <CAPhsuW4Z73azgqXVekYtibqOSKsx8XPU1FVwvZ7XOU5Qee7oAQ@mail.gmail.com>
Subject: Re: [PATCH v2] md/raid5: Convert stripe_head's "dev" to flexible
 array member
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 4:00=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, May 23, 2023 at 10:43:52AM -0700, Song Liu wrote:
> > On Mon, May 22, 2023 at 2:21=E2=80=AFPM Kees Cook <keescook@chromium.or=
g> wrote:
> > >
> > > Replace old-style 1-element array of "dev" in struct stripe_head with
> > > modern C99 flexible array. In the future, we can additionally annotat=
e
> > > it with the run-time size, found in the "disks" member.
> > >
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: linux-raid@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > It looks like this memory calculation:
> > >
> > >         memory =3D conf->min_nr_stripes * (sizeof(struct stripe_head)=
 +
> > >                  max_disks * ((sizeof(struct bio) + PAGE_SIZE))) / 10=
24;
> > >
> > > ... was already buggy (i.e. it included the single "dev" bytes in the
> > > result). However, I'm not entirely sure if that is the right analysis=
,
> > > since "dev" is not related to struct bio nor PAGE_SIZE?
> > >
> > > v1: https://lore.kernel.org/all/20230517233313.never.130-kees@kernel.=
org/
> > > v2: use new struct_size_t() helper from
> > >     https://lore.kernel.org/lkml/20230522211810.never.421-kees@kernel=
.org/
> >
> > LTGM. Thanks!
>
> Thanks!
>
> > I will hold this for a while until struct_size_t() merged.
>
> Since my tree will introduce struct_size_t(), I will just carry it
> there.

Sounds good! You can add

Acked-by: Song Liu <song@kernel.org>

Thanks,
Song
