Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6A773E348
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFZP2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFZP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DAAC7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687793257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhVNEcGfHP6r7iYI6uK5UQkeoNFVEouUiPU/UXitWVk=;
        b=eD6npWnCEeJgpDrZY1RVtZk1Aee7zfY2D7zM49K2+HXysFYZKOGCcw86KJdtc4uUc8/w9q
        /Bp2e6/QDY2njXn3papOZXWGDzx/0BM4b/ThzDbY/nrLZCN+jzAv0COcQM7ncMf7bm4SlH
        AKv9fh5+1WsH106Trg/I88rzXxVQc0k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-Hw8UCdwrOB6KKCGe5wQdYw-1; Mon, 26 Jun 2023 11:27:36 -0400
X-MC-Unique: Hw8UCdwrOB6KKCGe5wQdYw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-401e07ebf2dso5104941cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793256; x=1690385256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhVNEcGfHP6r7iYI6uK5UQkeoNFVEouUiPU/UXitWVk=;
        b=ZnpwWn+88p8v+fDJQVfzw5sQK6+phand2ZZg7Iuzo1C+1BQ+AKVvo3XpVqXZMOMo+p
         UlzP72C9Hi/ZVxwQTvNf8nb8g4d3MdE+CuBN7qO8FaDGHUpM4dujTwub8+WVa4F5goRw
         meEczz1XPaHZ+sd78tqV6A668T8Owpav+pE1wNnSb7c72mIBgNZK9s7y967baoUsy2+n
         E4mqo5seOoyqf6f/kEk1aqXQTUWeNAASUxaNhC1x6erw4CVxDDL5iFGho0sCDiXBP02z
         dYzTcoGrqkvN38addAZQIFPFlU12TWIE6FuXB/h3Ct56xvZpmKew2f7MUZ+BlyrCyX2e
         /RXA==
X-Gm-Message-State: AC+VfDwhYeKQrp6kffnrKJTFQwzOYPhpJ/pl/p4vgb+qjxy94Vb7MBfh
        sk02Oo12glnTh1g6q90nd4vmrF2POpEhrR9WPzVHLiU/6xhkv1m167LcBfnnWn5lJhdrqLNOYmm
        bzKLTWkQis1hMqvt35WOrgULVQeberAbOPXX8IkkX
X-Received: by 2002:a05:622a:50f:b0:400:8fb3:8647 with SMTP id l15-20020a05622a050f00b004008fb38647mr8721391qtx.6.1687793255828;
        Mon, 26 Jun 2023 08:27:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TwvuXDKy9e+gI/3I+HhSR4c5+nrW+tY8HR6PT1g2FTGTp5mDJpijnD1fEtWSWZiFto+eJ4Zptasa++w84gzk=
X-Received: by 2002:a05:622a:50f:b0:400:8fb3:8647 with SMTP id
 l15-20020a05622a050f00b004008fb38647mr8721377qtx.6.1687793255624; Mon, 26 Jun
 2023 08:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230418171524.274386-1-npache@redhat.com> <881c1f7e-6740-478d-2512-11a5a99563ec@amd.com>
In-Reply-To: <881c1f7e-6740-478d-2512-11a5a99563ec@amd.com>
From:   Nico Pache <npache@redhat.com>
Date:   Mon, 26 Jun 2023 11:27:09 -0400
Message-ID: <CAA1CXcDMghE4xv7+QS8hVpC5gm34d=GUfDNhKL7iDx_ZPA4LKQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: drm: make DRM buddy test compatible with other
 pages sizes
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ddutile@redhat.com, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Thanks for the information! I am not very familiar with the inner
workings of DRM, so I'm not really in a position to make any large or
systematic changes to the test regarding the points you made. I am
mainly trying to allow the tests to be run on more diverse hardware.
From the looks of it this test has been adapted from an older test, so
perhaps this rule was set in place in the past.

Either way, I dont think my changes are going to break anything, so
for the time being I think this small change is the best approach.
Please let me know if you think otherwise.

David, do you still have this on your radar? We've been carrying this
as a RHEL-only since I originally posted it and have not noticed any
issues due to it.

Cheers,
-- Nico

On Wed, Apr 19, 2023 at 4:30=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 18.04.23 um 19:15 schrieb Nico Pache:
> > The DRM buddy test uses a fixed 12 bit shift to covert from pages to
> > bytes. This number is then used to confirm that (chunk_size < PAGE_SIZE=
)
> > which can lead to a failing drm_buddy_init on systems with PAGE_SIZE > =
4k.
>
> Since the buddy allocator is used for resources which are independent of
> the CPU PAGE size the later check is actually the broken one.
>
> E.g. neither in the buddy allocator nor in it's test cases we should
> have any of PAGE_SHIFT or PAGE_SIZE.
>
> Otherwise the allocator wouldn't work correctly on systems with a
> PAGE_SIZE different than 4k.
>
> Regards,
> Christian.
>
> >
> > Fixes: 92937f170d3f ("drm/selftests: add drm buddy alloc range testcase=
")
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   drivers/gpu/drm/tests/drm_buddy_test.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/t=
ests/drm_buddy_test.c
> > index 09ee6f6af896..a62b2690d3c2 100644
> > --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> > +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> > @@ -318,8 +318,8 @@ static void mm_config(u64 *size, u64 *chunk_size)
> >       s &=3D -ms;
> >
> >       /* Convert from pages to bytes */
> > -     *chunk_size =3D (u64)ms << 12;
> > -     *size =3D (u64)s << 12;
> > +     *chunk_size =3D (u64)ms << PAGE_SHIFT;
> > +     *size =3D (u64)s << PAGE_SHIFT;
> >   }
> >
> >   static void drm_test_buddy_alloc_pathological(struct kunit *test)
>

