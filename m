Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E896ACC85
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCFS2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjCFS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:28:16 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3028074A48
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:27:49 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-53852143afcso200400137b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678127267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psGH5B9Sb1b6yS7TN6M5gak5lp84Nps9Af7SyZtTyAE=;
        b=Zfk/Pzxp5iQAZ1/kbvQf7M2f7/uH6HMj3EGkQffqZW76AiVhKrSe4je7FyTZBcf7h8
         LxcTZUGO8IrNYVloJ9RGCowLUoAUhrEhn5N79S4IYeH7iUzUX2hdHucPJIXBAG1rp9eM
         uUYA0JWDpwSOLLxP+uhC8Y6nGS7BuJVb5lj7FkmSfiCYHtoWzQ6v/tOOK13IT+K8bzfK
         /hJQRk6TAauVEWDXgT9MXGYO1h+cyjftvzEMzGrYJ8Ag98x6qUzy/guUpQa5iVhqV8fk
         pXxZ0g/ofsWMWy3aNDcGuPRvcXgvmAkwRyb2gMuIOgP8vVtfDQGFOsroxTbcrr9JO5Pf
         IjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678127267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psGH5B9Sb1b6yS7TN6M5gak5lp84Nps9Af7SyZtTyAE=;
        b=HCX+v5Z2sb+HCrwhAH5bOCSI4UK1xwSqlxrBC7CWj7ILU4RFTulgOUZuA3l1ZAetpj
         lBfGt6uKVZeVsYPkpT6lgYMaTkUbycjLKGM3KJADL0gG3HzFaCddM1XkybK8sP28aXMD
         vEQTMTonp1iBTDNaG8zSFZy7HT0qom7P8ci88AGK2r9nYCrMYNF6JpBRzRV0xlGnIBxZ
         W0IrAEU4nbUlhHamfmv37EiTp7iOLGgsJ04yLVy/OXUtSDRQAipGujSTp8CC1oCysHDG
         zAlSVo14anxmb+euLrN8Yg5Fg1IhV0hHYMzgAhNDPEU8EZdQVWgXdBEgKAtVP/JvFGJr
         KWGg==
X-Gm-Message-State: AO0yUKU2TcVK4FrY13ogu5gNh87DXLIcOsY54TsjniUehyyynHlwT8nd
        PojAnK9X4YvCsPRTCEh1ViQey8XWrUtFR3avou0C
X-Google-Smtp-Source: AK7set9pPdkfzt5EdkzDElabkh/uyn5Vhif6wFJRKX7NhgybnUT05hUsBgbWpljllHDwumPpRFWFepQXnZjMVeberlM=
X-Received: by 2002:a81:b243:0:b0:52e:d380:ab14 with SMTP id
 q64-20020a81b243000000b0052ed380ab14mr5807303ywh.3.1678127266628; Mon, 06 Mar
 2023 10:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20230302062741.483079-1-jstultz@google.com> <20230304031029.3037914-1-jstultz@google.com>
 <20230305113632.26de0a4d@gandalf.local.home>
In-Reply-To: <20230305113632.26de0a4d@gandalf.local.home>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 6 Mar 2023 10:27:34 -0800
Message-ID: <CANDhNCp3OZv8KvBMLAAYj-qN+36AdVs7Ow8kPBP6h5KGxw9KGw@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: Revert pmsg_lock back to a normal mutex
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        =?UTF-8?B?Q2h1bmh1aSBMaSAo5p2O5pil6L6JKQ==?= 
        <chunhui.li@mediatek.com>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 5, 2023 at 8:36=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Sat,  4 Mar 2023 03:10:29 +0000
> John Stultz <jstultz@google.com> wrote:
>
> > This reverts commit 76d62f24db07f22ccf9bc18ca793c27d4ebef721.
> >
> > So while priority inversion on the pmsg_lock is an occasional
> > problem that an rt_mutex would help with, in uses where logging
> > is writing to pmsg heavily from multiple threads, the pmsg_lock
> > can be heavily contended.
> >
> > Normal mutexes can do adaptive spinning, which keeps the
> > contention overhead fairly low maybe adding on the order of 10s
> > of us delay waiting, but the slowpath w/ rt_mutexes makes the
> > blocked tasks sleep & wake. This makes matters worse when there
> > is heavy contentention, as it just allows additional threads to
> > run and line up to try to take the lock.
>
> That is incorrect. rt_mutexes have pretty much the same adaptive spinning
> as normal mutexes. So that is *not* the reason for the difference in
> performance, and should not be stated so in this change log.

Good point. Apologies, I was trying to describe the *behavior* being
seen in the traces by switching between mutex and rt_mtuex, but I do
see how it reads as a description of the capabilities of the
primitive.

thanks
-john
