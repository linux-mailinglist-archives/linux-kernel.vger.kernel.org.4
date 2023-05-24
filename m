Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8C710108
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjEXWfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238335AbjEXWfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:35:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761F4E4B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:35:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so26195e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684967707; x=1687559707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B6lMA8fNeW/gE2ngmr6HzgniDM22RVaujvMzuMnMlY=;
        b=IESF4unk72BCei8C/w6JtEMISo7965mY+cHI6Nj80JeG5+XXzC39bDWhEe4TeEvyv5
         i6LZ8SpaB7xNE3oqyQAjTyQnO+tLNBIxOktB9LgnhEsgZ/olOWXdYV3Q+yeE5KzwFsxL
         uSMC1v6XMxXKpKpmXSJuC2hr7Gt6PtEuN1Eqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684967707; x=1687559707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B6lMA8fNeW/gE2ngmr6HzgniDM22RVaujvMzuMnMlY=;
        b=cDeUgMvAFGVb51UvbH6BwrT9l0WgARes4lBNIdK8QmInHMBQ8w9HHb5DtnjQ9A7VQF
         OU6kV7s7fYrOhyyTSWRfDUcc6WPnmJ1FfYvpYt/eQwU9o8cJNS40AMFUnNW07GPf63yk
         87lgEUE05PYOAPrBcOWNlyqXzEvZ9TJGDB3glL1GTCGRUYZkOogP1EWPcS8KEmHN3aY0
         KxoJjr4bOl04OT/J8KJ6ypgYq933hje+kE0I5fjOtsbeC6tftGW3m92FCsOD2AjxNGTC
         6MtilsmrLHMLlxDmWiqoE6VrChWZ4PnEGulkySxmbtMhAA9DFqxHa/qTzfdsOvicN4iG
         BV6Q==
X-Gm-Message-State: AC+VfDxBbOw7LaeZBgsNvWk65mTvYh1qvQ8ImrqWxJyb991ZBwl/F/5D
        kaMppEHZQbdDItEcoSZcuCX6kDI5AAQDM2u0eYAG6Q==
X-Google-Smtp-Source: ACHHUZ4kSYulxWJdqL3pmNyCJWNSacql845TBXpP7lD7xJykrXx7wkSJ8/1UOdgGq8LtySP9MrJYiTyoLDc+zDkWyKo=
X-Received: by 2002:a05:600c:1c93:b0:3f4:2736:b5eb with SMTP id
 k19-20020a05600c1c9300b003f42736b5ebmr11744wms.1.1684967707316; Wed, 24 May
 2023 15:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230518072657.1.If9539da710217ed92e764cc0ba0f3d2d246a1aee@changeid>
 <CALs4sv2+Uu=Bry=B3FYzWdNrHjGWDvPCDhTFcNERVpWTjpmEyA@mail.gmail.com>
 <CANEJEGuzoBa_yYHRCa0KygUe=AOhUkSg4u6gWx+QNCuGtKod2Q@mail.gmail.com>
 <52cfebaf-79f6-c318-c14b-3716555d0e8f@intel.com> <SJ0PR11MB5866456B9007E3DC55FD8728E5419@SJ0PR11MB5866.namprd11.prod.outlook.com>
 <CANEJEGsOU3KkG5rQ5ph3EQOiBvPXmhUk7aPvM3nj5V5KudP=ZA@mail.gmail.com> <82a3de3f-acef-c8d9-000c-8a54c2276b77@intel.com>
In-Reply-To: <82a3de3f-acef-c8d9-000c-8a54c2276b77@intel.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Wed, 24 May 2023 15:34:55 -0700
Message-ID: <CANEJEGtXQpSqd-k7YJZHMAqbbnWL4kUQmbQwNBjqUo_r3ec6xQ@mail.gmail.com>
Subject: Re: [PATCH] igb: Fix igb_down hung on surprise removal
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     Grant Grundler <grundler@chromium.org>,
        "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        "Neftin, Sasha" <sasha.neftin@intel.com>,
        "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
        Ying Hsu <yinghsu@chromium.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 3:22=E2=80=AFPM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
> Hi Grant,
>
> On 5/24/2023 2:01 PM, Grant Grundler wrote:
> > On Wed, May 24, 2023 at 5:34=E2=80=AFAM Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com> wrote:
> >>
> >> Good day Tony
> >>
> >> We reviewed the patch and have nothing against.
> >
> > Thank you for reviewing!
> >
> > Can I take this as the equivalent of "Signed-off-by: Loktionov,
> > Aleksandr <aleksandr.loktionov@intel.com>"?
>
> Unless a tag is explicitly given, I don't believe one can be inferred.

Yes - that's what I thought and was asking in case that's what
Aleksandr meant (and could easily confirm)

>
> > Or since Tony is listed in MAINTAINERS for drivers/net/ethernet/intel,
> > is he supposed to provide that?
>
> Assuming there's no comments/issues brought up, I'll apply it to the
> respective Intel Wired LAN tree for our validation to have a pass at it.
> Upon successful completion, I'll send the patch on to netdev for them to
> pull. Hope that helps.

Yes - that's what I needed to know. Thank you Tony! :)

Ying Hsu will apply this patch to Chrome OS kernels:
   https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel=
/+/4548800

cheers,
grant

>
> Thanks,
> Tony
