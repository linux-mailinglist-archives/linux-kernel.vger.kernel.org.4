Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE957318C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344868AbjFOMQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbjFOMQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725CC2D59
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686831299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5404QqJ9PwKRp/L4j64ezHhwogh+Ie4zcQIBW4EmEI=;
        b=FKT8GQs0OrZh6NcrXdcqLcuVo6dxo6ID6IONHtGhPhfXobUYO9xOq0K1dlUS1+CJ5S7XCt
        vWuR/+CZG1zhgbZprBDhZsILT+5hsyZsYw8srIAm0aZAeHTDLuN1WphTHvXW/HZ/QBkwIO
        pFLzeUdH9Al0MiL5O5U+IBFRrd4uJCw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-c80rTqFAPdKrSUSazglP7Q-1; Thu, 15 Jun 2023 08:14:58 -0400
X-MC-Unique: c80rTqFAPdKrSUSazglP7Q-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-56ff697b86cso24374917b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831298; x=1689423298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5404QqJ9PwKRp/L4j64ezHhwogh+Ie4zcQIBW4EmEI=;
        b=L47crp7CVXgXK+qIkeodaJn18W6AwT3LAFVrmsE+SI+rgzEgf8x32TEN1qskYuM1U/
         k+7G8UPSGXglA0yw9sbAtTwYjYr4OpPiokIADe+jgqbPM2PjU76P23Mf6BvXG+V77mbk
         kOivWQGPBo8hvTEuN1al+gmLg8bYqgNqjYSwtAapKShcJKHMs9AVGtu6N6L15bBrTsKG
         ViMmSK+myxqaPVRlVlqowfFbOzGnti5OBPsn8yC6myGzGm8AT/s9SmCInH8o9MombmcP
         XFx5n6mrGYZENbFennWZytKmzJXmcmSP0IORiTk4kA6TouAEUcHVbNKnFTBIgloolfbW
         8wFw==
X-Gm-Message-State: AC+VfDydjlcP8eI+yqazlrd3yOaWHs37MfXdxw88h3eAyZRJ2zmRrtmn
        T6ClESp/uUgCwzgFqtv42CPRm6pqU65owdCkIf3Fk6Vfd4YDzSI95jsjedsE1ANwPhFvc6hgfjJ
        JWvFcjNE30i/jScxuTvYmgkx5O3zBDAM0EEF+2bhU
X-Received: by 2002:a25:4c89:0:b0:bce:81a4:d01d with SMTP id z131-20020a254c89000000b00bce81a4d01dmr4167329yba.34.1686831297930;
        Thu, 15 Jun 2023 05:14:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bt74dQwyhmZGqxPQPhFJX2M7hWAKu0bEofTYEYlV2Y09Sb6Pvk3LWyGxUJFROME74Om5rnH1uFS9h/QV5Bss=
X-Received: by 2002:a25:4c89:0:b0:bce:81a4:d01d with SMTP id
 z131-20020a254c89000000b00bce81a4d01dmr4167310yba.34.1686831297638; Thu, 15
 Jun 2023 05:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
 <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com> <CACSyD1P=RtUtVOQrY9NVwn79=80zgC92NJyaqbjHXdrhZONx1A@mail.gmail.com>
In-Reply-To: <CACSyD1P=RtUtVOQrY9NVwn79=80zgC92NJyaqbjHXdrhZONx1A@mail.gmail.com>
From:   Fabian Deutsch <fdeutsch@redhat.com>
Date:   Thu, 15 Jun 2023 14:14:41 +0200
Message-ID: <CA+PVUaS5FhNksVUL-7+Ts6qyEd=tCV8e_2ig7pLwZa8hvhzwHg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     Yu Zhao <yuzhao@google.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:00=E2=80=AFPM =E8=B4=BA=E4=B8=AD=E5=9D=A4 <hezho=
ngkun.hzk@bytedance.com> wrote:
>
> > While looking at this in the past weeks, I believe that there are two d=
istinct problems:
> > 1. Direct zram usage by process within a cg ie. a process writing to a =
zram device
> > 2. Indirect zram usage by a process within a cg via swap (described abo=
ve)
> >
> > Both of them probably require different solutions.
> > In order to fix #1, accounting a zram device should be accounted toward=
s a cgroup. IMHO this is something that should be fixed.
> >
> > Yu Zhao and Yosry are probably much more familiar with the solution to =
#2.
> > WRT per-cgrou-swapfile, to me this is addressing #2, but I agree with Y=
u Zhao, that there are probably better solutions to this.
> >
> > Lastly, this patchset, while it will possibly not address the swap issu=
e (#2) completely, is it satisfying the needs of #1?
> >
> > - fabian
>
> Thanks for your reply, fabian. According to the previous design and
> test results, this patchset can meet the need of  direct and
> indirect usage scenarios=EF=BC=8Ccharge the compressed memory to memory c=
group.

As said, I can not speak about the indirect swap case, but if it is
addressing the direct case, and putting the memory accounting on the
cgroup - then this would address one of the use-cases I have in mind.
Thanks!

- fabian

