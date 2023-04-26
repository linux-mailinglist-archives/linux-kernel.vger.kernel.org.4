Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B522C6EED6D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 07:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbjDZFIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 01:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDZFIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 01:08:37 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210902718
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 22:08:36 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54f8e823e47so75462187b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682485715; x=1685077715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvjgdQJdpTQ+G9Gb7ZcdZmOYROidA+1sc9WOXTl8hcc=;
        b=zxgU+PrPOEOiH5Zc1iV3zPqPwiliGrzWg5ASlGfxQawNkcUcMGHai4RqAVjRyaOEvB
         5EFsPOdhYLIzFZ4ApsKauwzgAg03woX7iq2IJ3pUoKeTgZf27SdlxrIV596Z9UTyeLVQ
         PO+xTAzyUTLbIvoqNGACPaBmdTnQ9IAHD4w5YaXCUZOLXS5NNK/3W205Em/uooXHG4Z4
         jSHWwL+PtuMHzgL5lraX+ulrH9QkiCX62eUP0HqPSSPvgNMDggL/WKx6bYFpM6z9R5eD
         Fkkznrs0z5PWQOJbXTd3gTwIY3594tBk/NkM7OFQSkCsULabLjvIxTL7a1QTUenB1caL
         4+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682485715; x=1685077715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvjgdQJdpTQ+G9Gb7ZcdZmOYROidA+1sc9WOXTl8hcc=;
        b=EYP6nMaCoVuyBX7he+7nyefwaPXtvNj9nERyydbNCcquM6jdjDi9rNTqMTn4Xgp54W
         LeOogV7DR57Ed/gH0r9Mqf4LALlR81ZU/l5IDyJC5afiOhgLyQtsq3qpXBuH6Jx+Wotn
         pm8PI9a3Dvk8IKAYWtPhpgzrlxApYrg9gI+s79u6++EwxFOSJpN38vv7KM7PWYcD+6Dv
         ukOzfN29RrWNxzkesGOGBr+WAlB8+B531SVndn97ebYmsil4H660qBwUPtNmmvjb+MtM
         krp62R0cOZDAcRdgGwubhSP940RX5V3f7LWXXEHq8RqPvobOK7dBjzAvsnNK+klIKtCl
         L1eA==
X-Gm-Message-State: AAQBX9dAAild3rex3KNqlRJNUTI/h3uo+W5tOrzliztaymKDUyvyv8Zw
        2ROiaM3//nmPkz54Oqq1wwkvXHERhjPYrcOPIpEObA==
X-Google-Smtp-Source: AKy350YycFQTQ+PYlvwN/KG88PKqxwhFKRdBu7y9D3aevNDvje9peHpttwhk1lXW1+laUXNo2O2L25y3PyB6cdIrOks=
X-Received: by 2002:a81:9c13:0:b0:541:9671:3164 with SMTP id
 m19-20020a819c13000000b0054196713164mr12728695ywa.12.1682485715229; Tue, 25
 Apr 2023 22:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpFiW7z01FTC2q3hR+h=MhWLwKj96U+MF3s_FjX-9JEqfw@mail.gmail.com>
 <20230426033144.15106-1-yang.yang29@zte.com.cn>
In-Reply-To: <20230426033144.15106-1-yang.yang29@zte.com.cn>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 25 Apr 2023 22:08:24 -0700
Message-ID: <CAJuCfpF88Xu_Xf3w5oM4xRmXphwGjMaLhusEHV7gtAFNXXnP2A@mail.gmail.com>
Subject: Re: [PATCH linux-next] sched/psi: avoid unnecessary resetting min
 update period when destroy trigger
To:     Yang Yang <yang.yang29@zte.com.cn>
Cc:     mingo@redhat.com, hannes@cmpxchg.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 8:32=E2=80=AFPM Yang Yang <yang.yang29@zte.com.cn> =
wrote:
>
> > On Mon, Apr 17, 2023 at 1:12=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
> >>
> >> From: Yang Yang <yang.yang19@zte.com.cn>
> >>
> >> Psi_group's poll_min_period is determined by the min window size of
> >> psi_trigger when creating new triggers. While destroying a psi_trigger=
,
> >> there is no need to reset poll_min_period if the destroying psi_trigge=
r
> >> not had the min windows size, since in this condition poll_min_period
> >> will keep the same as before.
> >
> > Nice optimization.
> >
> >>
> >> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> >
> > Acked-by: Suren Baghdasaryan <surenb@google.com>
>
> Hi, would you please take a review?

I guess this is a ping for PeterZ to queue this patch in his tree.
Peter, any issues with accepting this patch?

> Thanks!
