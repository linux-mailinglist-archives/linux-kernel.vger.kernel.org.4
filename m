Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB67971A219
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjFAPLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjFAPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:11:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511921709
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:11:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6a6b9bebdso92235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685632262; x=1688224262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/ZDCbaS5BasDGweOpypX69jqZRIVn168PE8kkE06BM=;
        b=pbm6sStAd9k4icSNrF8FKrRnjXhNVxOIBj6hWYKhyhV+GCAJXTJAFfmp/Yd2Su7y03
         KRX4UNkQAu+CKX9EoN9lq/kpGH8I5dRMeSjXYKyofzyJwziDRD+HqWBEp00zpvUEtvve
         cvCjoPBMoPmB53JpaY3hEYQDCHg7QJu/bWbNwL4r81gSB6rg+mznOi24+75t7t3TKos1
         9JweGRXEHiU0BgCAUICByA2yFUdGc42PFMzdKDfFzuIQUaw4y9X3c35C/BA1LMmOZJwy
         uyQcq+yBYhyWfCiJHnJdBgMjg0pRYRhxhwLD3yQKxsfVb2/uw5w8XOteqmZpILZS69Jb
         rp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632262; x=1688224262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/ZDCbaS5BasDGweOpypX69jqZRIVn168PE8kkE06BM=;
        b=iwefVu9zEjLCg2Cc/qngfAW4lz25VQMOk+SK94JYhmvptcdbSmHjwg/MTI+U8vlXZ/
         fiAcWaMUJn4r4+3pJ5/USARl/LItDP0O7By7H9P7fjes4WwQaguUTuQVgbh2NdZVPdrQ
         AIeeX2bMNH/9F5WJvasoWfQD/9LxsjLIUnxh+1LnfM8b3i9SgWN+gQ//vLQ+ndKR1EE6
         CgNfuWhfjE3DB+h87zcot6Z9I5Hme2TVxBv56d6Da1p+N4ycOTUmluslR0WK5qeLfcxG
         TDIPAkUP2/AwoIjmkpJz/+JcEQ7FgH6G2vRKOPARwU+xsVwLkBXiGWbP0GUa8MDnH2cW
         7bxw==
X-Gm-Message-State: AC+VfDzArWOtRL4RcAC2ujI//aaPKcLQRDr2PWL8/NjhxOqBdsDv0JAr
        sulVOqQfzC3gbFQzNVf1ntdcP4J41wR9fNi4EX/nnA==
X-Google-Smtp-Source: ACHHUZ5ar1qnATBRV5jmIEbk1dpCTLMW7l75k70ElwEbGikS91c/JcyvRCKiLiVHbjPOHX5sXJV6qUGyXa8ITwr1SkU=
X-Received: by 2002:a05:600c:3ac9:b0:3f1:6fe9:4a95 with SMTP id
 d9-20020a05600c3ac900b003f16fe94a95mr239669wms.4.1685632262377; Thu, 01 Jun
 2023 08:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230531141556.1637341-1-lee@kernel.org> <CANn89iJw2N9EbF+Fm8KCPMvo-25ONwba+3PUr8L2ktZC1Z3uLw@mail.gmail.com>
 <CAM0EoMnUgXsr4UBeZR57vPpc5WRJkbWUFsii90jXJ=stoXCGcg@mail.gmail.com> <20230601140640.GG449117@google.com>
In-Reply-To: <20230601140640.GG449117@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 1 Jun 2023 17:10:50 +0200
Message-ID: <CANn89i+j7ymO2-wyZtavCotwODdgOAcJ5O_GFjLkegqAsx4F5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
To:     Lee Jones <lee@kernel.org>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 4:06=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Wed, 31 May 2023, Jamal Hadi Salim wrote:
>
> > On Wed, May 31, 2023 at 11:03=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Wed, May 31, 2023 at 4:16=E2=80=AFPM Lee Jones <lee@kernel.org> wr=
ote:
> > > >
> > > > In the event of a failure in tcf_change_indev(), u32_set_parms() wi=
ll
> > > > immediately return without decrementing the recently incremented
> > > > reference counter.  If this happens enough times, the counter will
> > > > rollover and the reference freed, leading to a double free which ca=
n be
> > > > used to do 'bad things'.
> > > >
> > > > Cc: stable@kernel.org # v4.14+
> > >
> > > Please add a Fixes: tag.
>
> Why?

How have you identified v4.14+ ?

Probably you did some research/"git archeology".

By adding the Fixes: tag, you allow us to double check immediately,
and see if other bugs need to be fixed at the same time.

You can also CC blamed patch authors, to get some feedback.

Otherwise, we (people reviewing this patch) have to also do this
research from scratch.

In this case, it seems bug was added in

commit 705c7091262d02b09eb686c24491de61bf42fdb2
Author: Jiri Pirko <jiri@resnulli.us>
Date:   Fri Aug 4 14:29:14 2017 +0200

    net: sched: cls_u32: no need to call tcf_exts_change for newly
allocated struct


A nice Fixes: tag would then be

Fixes: 705c7091262d ("net: sched: cls_u32: no need to call
tcf_exts_change for newly allocated struct")

Thanks.
