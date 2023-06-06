Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2374A724974
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbjFFQpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjFFQpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:45:14 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D310D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:45:12 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565a3cdba71so77130837b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686069911; x=1688661911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMWbmsvDdp6iq9RUXlYKvqFegC2cKlPpAbpd2+OqowY=;
        b=FQYrfd1EcvWG1GCeVG656zyHDTlShdaieYYpKe+/l6Aehh+n2AmLUOgF+Ll7MImYrl
         MZsCpyPiDggrosRsFYQhILfblG8mhk1AoQ+40asFh8gKRJRBkW029anExzI8+pvj4eLG
         b6+qTvmoVlzOoZJxkOZCMr4TqcFletykuad6UZVkMDBqcfseyHcgRX8wIX7T+iArP7uV
         AjwZqCgLhXACwFlDtDus48C7/qe5s5BKE4xsJKdBjL2KTQNxkOM1itGhULn1XmfFBeLL
         pgQRSZuLHw2eqd+MKG5gMyRP1mtNxHj2ykjp6cpt0f++zCLa0JcEjNZDSuyWCs7xfvYj
         H2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069911; x=1688661911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMWbmsvDdp6iq9RUXlYKvqFegC2cKlPpAbpd2+OqowY=;
        b=LGuRArUQEst/qhoFHK6YLScVvN8GK8rLFN9qdNCN/MdiBK2adeHYHm26UJ6/yDnjT9
         ZCOQ9k264+i7L2oByYsJIwzsy58fDR/6fPTuVGrDRysi0aVq+Ztp0FlPvVYrsqluPl7f
         Y1grSUO2Q1zv7jvK25UpYWPqvcE1Y0YOEmpYTADzD0T2cyur8aHWcGUEgHDwoZQBAttH
         jDdPKIFXkNQhWBaowxFAmmT9JGHuh5oIiyEv+UEatlrWtFzxx12l7ZAJ9i46sSkKRZPX
         WLPqxWIVOUBefLeOZrIX1/glNxdts5uKaUjuB2u3YfHd/6L8wXdAd1ylfERoVT8Q3fwi
         UBxA==
X-Gm-Message-State: AC+VfDwrybNQHYu9Z/UaPNEEfKeAbzlJVhpzw7UKDOVEY/fV3lig4n58
        RCk3obmHdruLOWZC4UpSNMxn5YzegBeiOiiIiL78
X-Google-Smtp-Source: ACHHUZ4L5Xl6f7wlNvBLaoqH7P/WZmYFqZv0qJvx8f5RIJaiTp3gZOgpRiPaCaNFH1JigQ8aUHcxAOvAg8rkJlB0azI=
X-Received: by 2002:a81:6a87:0:b0:568:fe3a:46b3 with SMTP id
 f129-20020a816a87000000b00568fe3a46b3mr2984174ywc.28.1686069911506; Tue, 06
 Jun 2023 09:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230602054527.290696-1-gongruiqi@huaweicloud.com> <20230606032844.GA628899@mail.hallyn.com>
In-Reply-To: <20230606032844.GA628899@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Jun 2023 12:45:00 -0400
Message-ID: <CAHC9VhT8k87SdD4_JQFwXShwJeBb3KU7C+R5ABAOhDGvvC0X+w@mail.gmail.com>
Subject: Re: [PATCH] capability: erase checker warnings about struct __user_cap_data_struct
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 11:29=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Fri, Jun 02, 2023 at 01:45:27PM +0800, GONG, Ruiqi wrote:
> > Currently Sparse warns the following when compiling kernel/capability.c=
:
> >
> > kernel/capability.c:191:35: warning: incorrect type in argument 2 (diff=
erent address spaces)
> > kernel/capability.c:191:35:    expected void const *from
> > kernel/capability.c:191:35:    got struct __user_cap_data_struct [noder=
ef] __user *
> > kernel/capability.c:168:14: warning: dereference of noderef expression
> > ...... (multiple noderef warnings on different locations)
> > kernel/capability.c:244:29: warning: incorrect type in argument 1 (diff=
erent address spaces)
> > kernel/capability.c:244:29:    expected void *to
> > kernel/capability.c:244:29:    got struct __user_cap_data_struct [noder=
ef] __user ( * )[2]
> > kernel/capability.c:247:42: warning: dereference of noderef expression
> > ...... (multiple noderef warnings on different locations)
> >
> > It seems that defining `struct __user_cap_data_struct` together with
> > `cap_user_data_t` make Sparse believe that the struct is `noderef` as
> > well. Separate their definitions to clarify their respective attributes=
.
> >
> > Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
>
> Seems ok.
>
> There's still so much noise in the make C=3D2 output even just for
> kernel/capability.c that I'm not sure it's worth it, but no
> objection.
>
> Acked-by: Serge Hallyn <serge@hallyn.com>

I'm guessing you would prefer if I pulled this via the LSM tree Serge?

FWIW, if that is ever the case for future patches, just add a note
when you ACK something and I'll pick it up.

--=20
paul-moore.com
