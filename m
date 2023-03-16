Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5DA6BD361
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCPPXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCPPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:23:49 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEF9D5A78
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:23:33 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5419d4c340aso38144747b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678980212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COAEuX4852H70FVvwYK4VYA78apPYBZc0pQhcVye60o=;
        b=RKdk7b/R4htRKAS7tQNcupg7rUrN2OFmNW9swqUP5uKdx8rovhGuKXfbebkP9MGxLl
         o67PTS0QghHZVHiTQumeay47Fk0eDO09xxb5HM5gwWnykgxD1D4iDp+M/XgBC/jQ3d2w
         4af8u2d9CrGfmtnmmCsEpv1SFi2idlll06xrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678980212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COAEuX4852H70FVvwYK4VYA78apPYBZc0pQhcVye60o=;
        b=B6hnZ3mf/yoObu0Di53oB/364Ir9Oh5/bYMBvlCegNsRW/cOqJcOsGOEUzD64rPkrF
         gEnleZB1xNMmrCvQIcg039kfDSR14yFJrBhgokw38mAX8fcL4EkX6EWigOrHb1xc7Wik
         iXEUurtQkrdBV8cRAYwqcWHAIwfm+cRCh2LqSyGIuMmmziS6F3wF0r7MaWSYD09ejxFH
         Vebpfz7lPJmbIfx9S7NoCI3mGVeDsfuElZU1auGARmgEcfI/13p9naGbP+vHMXshbLtp
         dUMjW0tqZHpmhenQx0x9HBWFfXCuypdh39i4/BHHYOBNt9GO3tUKaDxai7LXkDQcXTpm
         wHAg==
X-Gm-Message-State: AO0yUKUS8W25qjh7ZVFsVXr1BbBXDWvO5xEf3L18LvueakzqBuxuLdNO
        Qt0Hh14XEGhwmWJw4P0gGrHyrh/Gf6GQ7KuxS34aLA==
X-Google-Smtp-Source: AK7set+8TRlChz2VgPHoBRSwjSgIUk6X24QYYlwoQpAksp9+1tC3fVEZUsVX6PMHE7AEetqVlov69RG8jyPAWjCxmFQ=
X-Received: by 2002:a81:c749:0:b0:541:753d:32f9 with SMTP id
 i9-20020a81c749000000b00541753d32f9mr2651951ywl.9.1678980212500; Thu, 16 Mar
 2023 08:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230315181902.4177819-1-joel@joelfernandes.org>
 <20230315181902.4177819-7-joel@joelfernandes.org> <20230315190753.GC3024297@mit.edu>
In-Reply-To: <20230315190753.GC3024297@mit.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Mar 2023 11:23:21 -0400
Message-ID: <CAEXW_YQBV26RUVBBwBB3DaJtrc0PyARuAbfqyEiDMoSXDguniA@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] ext4/super: Rename kfree_rcu() to kfree_rcu_mightsleep()
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 3:07=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Wed, Mar 15, 2023 at 06:18:54PM +0000, Joel Fernandes (Google) wrote:
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >
> > The kfree_rcu() and kvfree_rcu() macros' single-argument forms are
> > deprecated.  Therefore switch to the new kfree_rcu_mightsleep() and
> > kvfree_rcu_mightsleep() variants. The goal is to avoid accidental use
> > of the single-argument forms, which can introduce functionality bugs in
> > atomic contexts and latency bugs in non-atomic contexts.
> >
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: Lukas Czerner <lczerner@redhat.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Acked-by: Theodore Ts'o <tytso@mit.edu>
>

Thanks!

 - Joel
