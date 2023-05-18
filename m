Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59208708633
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjERQrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjERQrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:47:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C0E6A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:47:35 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f39600f9b8so11489721cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684428454; x=1687020454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EO246ZqiVBRxZDxMtJpAios9D2U+bi/JcOcYKYzfYJ8=;
        b=C0SkUL7LTPqYi++TtcB64tB2yY2rMEzGkd4D9JFvGhePfWVTDkxBuKx/m+Hi4c+sDI
         hthy6WeL3lc3ehF7bnAH2sXSAyXRLjoRbfpr0fYpkylrx6wNHoDwqSJVFZPj9RkEKkbh
         2/FmwnPZrd/lh5lbL8RpbmOjKrPaqlsOOUbPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684428454; x=1687020454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EO246ZqiVBRxZDxMtJpAios9D2U+bi/JcOcYKYzfYJ8=;
        b=eT+MaQW38WQ6+AYvj0Qf7gW9DMRBGO0ws4NhYM9WYM5fD9u52d8QI3NZ4KakYtmZkv
         B8fxTwwRkZBz/aiyV3uGdHfs+aBkoSgiq16UDbV1zkACrdFy4IxEVgio5WvSXxAhplU0
         YApEKtebugjI+EEN5vpWjimYDgcafzQ0oDYkJEH84oUESe3bRkBynQIttM2yDnBnCVCj
         IwT+nyppD1e0f09Tru5W/vGIf5/R/bDI7afVBoH38qyE3VKv8ncVP1llv+bRh5/Q8nlv
         I3pwihbkjFFBRV9FULhN052V8pjVJCnbL9UDvaf+OQvOnkTUY1zTvGxODMz8avHZxBuP
         h7hw==
X-Gm-Message-State: AC+VfDzGIwJlL2qyfzJnThVOOO4IrpH5StNAdOHyVVEvGb30gWoUluo4
        iwHy07Y6IOIQu+H1XGVa01LkRPV14VqX5XplxmLg2w==
X-Google-Smtp-Source: ACHHUZ5C8U/4R0hjO7Jl5obKdU8v3+0pW5C3Prfqf33Ma5bKHHByD+VEYyCANUA7CHqRjEdt9Y7ADQpAwi48muRxbW0=
X-Received: by 2002:a05:622a:189e:b0:3e6:2e9e:58f1 with SMTP id
 v30-20020a05622a189e00b003e62e9e58f1mr434517qtc.59.1684428454207; Thu, 18 May
 2023 09:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230515142552.1.I17cae37888be3a8683911991602f18e482e7a621@changeid>
 <ZGQ9Y+vqWhQLHAQh@google.com> <CAMaBtwHxaevxLY7zWNDU8zbyWx=puLkeeRAjFtovvrA5pjtJ4w@mail.gmail.com>
 <ZGWBhEMmo2lStTg9@google.com>
In-Reply-To: <ZGWBhEMmo2lStTg9@google.com>
From:   Tim Van Patten <timvp@chromium.org>
Date:   Thu, 18 May 2023 10:47:23 -0600
Message-ID: <CAMaBtwFtE=vjuhVy7rw9zCe9WV0dRyeBWj88JH2j3bkbh2BkXA@mail.gmail.com>
Subject: Re: [PATCH] [v9] platform/chrome: cros_ec_lpc: Move host command to prepare/complete
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, robbarnes@google.com,
        lalithkraj@google.com, rrangel@chromium.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, Garrick Evans <garrick@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 7:38=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Wed, May 17, 2023 at 09:56:59AM -0600, Tim Van Patten wrote:
> > > I can understand the patch wants to notify EC earlier/later when the =
system
> > suspend/resume.  But what is the issue addressed?  What happens if the
> > measurement of suspend/resume duration is not that accurate?
> >
> > Please see the following:
> > - b/206860487
> > - https://docs.google.com/document/d/1AgaZmG70bAKhZb-ZMbZT-TyY49zPoKuDD=
bD61dDBSTQ/edit?disco=3DAAAAws1enlw&usp_dm=3Dfalse
>
> I have no permission to access the doc.

Since you work at Google, please request permission to access it, so
the owners can grant it.

> Please put the context in the commit
> message.

Done in the next patchset.

> It's usually helpful if you could put the corresponding EC FW
> changes.

Why are you assuming there is EC FW with this change? Any and all of
the EC changes related to this have (obviously) landed long ago.

> > The issue is that we need the EC aware of the AP being in the process
> > of suspend/resume from start to finish, so we can accurately
> > determine:
> > - How long the process took to better gauge we're meeting ChromeOS requ=
irements.
> > - When the AP failed to complete the process, so we can collect data
> > and perform error recovery.
>
> Is it a new feature?

No, it's not.

> How could the *error* recovery do?

I don't understand what this is asking.

> > > What about other interfaces (i2c, spi, uart)?  Do they also need to c=
hange
> > the callbacks?
> >
> > We aren't concerned about those devices, because they aren't being
> > used on the devices we're seeing issues with. If devices using those
> > ECs want this change, they can pick it up as well, but we don't have
> > any way to test changes on those devices (whatever they may be).
>
> This doesn't sound good.  As I would suppose you are adding some new EC F=
W
> features regarding to EC_CMD_HOST_SLEEP_EVENT, you should consider the
> existing systems too.

Again, why are you assuming there is new EC FW for this? This is only
changing when an already-existing host command is being sent. Nothing
is being added or removed.

> What happens if a system uses older kernel (without this patch) to
> communicate with new EC FW via LPC?

The message is being sent regardless of whether this patch lands or
not. This patch just changes when they are sent, so there is no risk
from that perspective.

> How about adding a new EC host command for your purpose so that it won't
> affect the existing systems?  I knew this was discussed in some older ser=
ies
> but I didn't follow the thread.
>

No. The necessary host command already exists and is being sent. There
is no additional command being sent with this change. It is only
changing when the command is being sent.
