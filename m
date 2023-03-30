Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E5D6CFA6F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjC3E4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjC3E4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6272F46B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680152129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AyTbRFMs97cAScAt4h83Kngqndm2W6jMyHVf8nQ7nPc=;
        b=dQDHGpPuLCN00hw3XJqoij0LwNB88MKXgstw7zg3fqtWkPITHLdy2Arfk1kpU5nJ7lAdQK
        zrHhtBjfXmQyPvYxHj+f/ECPCtsIG4kOsbUkIE2rLrHGwaO6Oirhtbl7b58fBmDDSBk1D5
        6utp4tUI1kTVki0d2relto2NyDJ1p5Y=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-08UqUbOiPj-daejRVn20WQ-1; Thu, 30 Mar 2023 00:55:20 -0400
X-MC-Unique: 08UqUbOiPj-daejRVn20WQ-1
Received: by mail-pg1-f197.google.com with SMTP id bc19-20020a656d93000000b005072b17a298so4992036pgb.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680152119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyTbRFMs97cAScAt4h83Kngqndm2W6jMyHVf8nQ7nPc=;
        b=k7Brj2b6XkhIUKy5lPjo7ADp7G28MZS6M+4paMNDFRUd7Q0r0hS10u61nq1BxefBlg
         CGF6yAOc1cIzO4RW5tGjUruooOM9eU8CDN1aya7CeKEiMgU2/whE+38UBa5rJKK4Cicu
         3fzH0mnPQqsR9JpTDeEoNl9NhU4puZ+RA3GWmAtEHdNDKOCrT3iHIs5BSZb66EJHtEpe
         PVp6lfUiI6yLez2x+tb2Vl71uwKeUNCbI5kYRTM+YoqgujR8KIATfpLlmzhmhCx2GWiI
         4myOYuANV2vD3IUNNq+gOpIVeNI8Ls2KFLafP8uoRRB/jLvFkU1hfmzZpEmvjkwfka0L
         /4wQ==
X-Gm-Message-State: AAQBX9dLy1aDMcs7OxVRC8kO5Ql0Jn2dH1H71xdGQiaPiotoEqF8OEYA
        TEHX42N2tE00NsR9cW0XbQjm3NMudMearvOosoNtvz92/OaEHAFkAHBRpitahSgq0OKM5pSlBlA
        /Xx8HiROzKL3muCp2kG90uz0AZyR8owTEaYyfuMon19pUbiWimqe8AQ==
X-Received: by 2002:a17:903:455:b0:1a2:6e4d:782c with SMTP id iw21-20020a170903045500b001a26e4d782cmr1824098plb.13.1680152119327;
        Wed, 29 Mar 2023 21:55:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZYn0YlGsE5d5/SvE3Xa4cQ9vWiHdShQwzms32z6+pM0mJhEaSXBrBGrhkAmiD4sB8++tb6bmQuv0Phxtq0AvQ=
X-Received: by 2002:a17:903:455:b0:1a2:6e4d:782c with SMTP id
 iw21-20020a170903045500b001a26e4d782cmr1824087plb.13.1680152118983; Wed, 29
 Mar 2023 21:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
 <CALTww2916uiO8_ViJQXutO2BPasFmiUJtfz8MxW0HKjDzwGFeQ@mail.gmail.com>
 <167945548970.8008.8910680813298326328@noble.neil.brown.name>
 <168012671413.8106.6812573281942242445@noble.neil.brown.name>
 <CALTww28X1NQecTY3Jbkz_wbHc_N7GOw3hJLEyb2YnxAmQ8PRFw@mail.gmail.com> <168014613094.14629.7292916705339147692@noble.neil.brown.name>
In-Reply-To: <168014613094.14629.7292916705339147692@noble.neil.brown.name>
From:   Xiao Ni <xni@redhat.com>
Date:   Thu, 30 Mar 2023 12:55:07 +0800
Message-ID: <CALTww29CN4iqmneiAG31kZDBubCMop=gg299hdW-TXCNq1c4gQ@mail.gmail.com>
Subject: Re: [PATCH - mdadm] mdopen: always try create_named_array()
To:     NeilBrown <neilb@suse.de>
Cc:     Jes Sorensen <jes@trained-monkey.org>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-raid <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nikolay Kichukov <hijacker@oldum.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:15=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Thu, 30 Mar 2023, Xiao Ni wrote:
> > On Thu, Mar 30, 2023 at 5:52=E2=80=AFAM NeilBrown <neilb@suse.de> wrote=
:
> > >
> > > On Wed, 22 Mar 2023, NeilBrown wrote:
> > > > On Wed, 22 Mar 2023, Xiao Ni wrote:
> > > >
> > > > >
> > > > > Second, are there possibilities that the arguments "dev" and "nam=
e" of
> > > > > function create_mddev
> > > > > are null at the same time?
> > > >
> > > > No.  For Build or Create, dev is never NULL.  For Assemble and
> > > > Incremental, name is never NULL.
> > > >
> > >
> > > I should clarify this a bit.  For Assemble and Incremental, "name" is
> > > never NULL *but* it might be an empty string.
> > > So:
> > >         if (name && name[0] =3D=3D 0)
> > >                 name =3D NULL;
> > >
> > > might cause it to become NULL.  So you cannot assume there is always
> > > either a valid "dev" or a valid "name".  "dev" might be NULL, and "na=
me"
> > > might be "".
> > >
> > > NeilBrown
> > >
> >
> > Hi Neil
> >
> > The input argument name should be the metadata name. For incremental
> > and assemble, why are there possibilities that the metadata name is
> > invalid? A raid device should have a valid metadata name, right?
>
> "should" do, yes.  But you can never completely trust data on disk.  It
> is safest to be prepared for "name" being "".
>
> NeilBrown
>

That's right, thanks for this explanation :)

--=20
Best Regards
Xiao Ni

