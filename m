Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22AF737A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 06:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjFUEHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 00:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFUEHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 00:07:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8408F10C2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 21:07:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9881b9d8cbdso702003666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 21:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1687320461; x=1689912461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjpf2LNWAu5TESk6v0uIpuStTcjqIcl5DiVX9hjgHWA=;
        b=DQhlPZ06mDtfMmXJAdaGsE72NH09GVEauLAk948FEUB9UW+fQTfLehs9zCQIrH8kUc
         k/dkK1E2zpcoeUb3BJ8rqQElnKasK+fW8lCWFuFAZdOy7Ftwx9RzD4q4y5b5621HrrvQ
         oPWLTVP/f57dHQ0Q9FjGqPevJrLc+waSJlIIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687320461; x=1689912461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjpf2LNWAu5TESk6v0uIpuStTcjqIcl5DiVX9hjgHWA=;
        b=JtJLq1JEO2ZrbxVRnmbcP+FvKb9wbV8Y6rTdG1JUKL/nivhpCHozHbGuXFYXUekrsV
         2WsGDnHypUR9lBIDwqQ7w/eDrwFafCb1Z+KfnbvxbAahsiMgNN0e4oPhE9GwvDulOMF8
         Dh7NfpCkLmLsLxgyJqMYkp/WSd9i+36L2MWgcZc4jU+xSVHqecjdUO1i1aXsaSVhjN4a
         mim4n3ExHhaBeijwLrZkCTSbnfDOsVh0N+8EbEI3cOU32RNHzHGQFQf7klNJNI0EkLHZ
         RW3jH8JHb54xgSbAv2yA+O88EdBp3Piz7GcsMHh+G5BZRJcX71gM3X0L+n0gs9tAWTb0
         Nc9g==
X-Gm-Message-State: AC+VfDwYwpX4uDJfX5SmuSF5Pw4QpgfFHnOz/aZgqkGFvcpXFbZ0INNL
        PJbw44V9BWsXcj/06IMlBIiPSP8fFab6cvwY//DXqw==
X-Google-Smtp-Source: ACHHUZ6dlEzQGxviDNfRh9WULTYrGJlSL36wgKxkYrPejXJybbCPSPMh0GMhThTr9eaIHmPbUYpW8aJpGvyMjeOyZ0c=
X-Received: by 2002:a17:907:802:b0:974:fb94:8067 with SMTP id
 wv2-20020a170907080200b00974fb948067mr19736659ejb.23.1687320461511; Tue, 20
 Jun 2023 21:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230620151328.1637569-1-keiichiw@chromium.org>
 <20230620151328.1637569-3-keiichiw@chromium.org> <CAJfpegton83boLEL7n-Tf6ON4Nq_g2=mTus7vhX2n0C+yuUC4w@mail.gmail.com>
 <CADgJSGGDeu_dPduBuK7N324oJ9641VKv2+fAVAbDY=-itsFjEQ@mail.gmail.com>
In-Reply-To: <CADgJSGGDeu_dPduBuK7N324oJ9641VKv2+fAVAbDY=-itsFjEQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Jun 2023 06:07:30 +0200
Message-ID: <CAJfpegtNjAELur_AtqiGdO6LJRDyT+WQ1UKtG-o=Em0rAhOKMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] fuse: Add negative_dentry_timeout option
To:     =?UTF-8?B?SnVuaWNoaSBVZWthd2EgKOS4iuW3nee0lOS4gCk=?= 
        <uekawa@google.com>
Cc:     Keiichi Watanabe <keiichiw@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, mhiramat@google.com,
        takayas@chromium.org, drosen@google.com, sarthakkukreti@google.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
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

On Wed, 21 Jun 2023 at 00:53, Junichi Uekawa (=E4=B8=8A=E5=B7=9D=E7=B4=94=
=E4=B8=80) <uekawa@google.com> wrote:
>
> Hi
>
>
>
> 2023=E5=B9=B46=E6=9C=8821=E6=97=A5(=E6=B0=B4) 4:28 Miklos Szeredi <miklos=
@szeredi.hu>:
>>
>> On Tue, 20 Jun 2023 at 17:14, Keiichi Watanabe <keiichiw@chromium.org> w=
rote:
>> >
>> > Add `negative_dentry_timeout` mount option for FUSE to cache negative
>> > dentries for the specified duration.
>>
>> This is already possible, no kernel changes needed.  See e.g.
>> xmp_init() in libfuse/example/passthrough.c.
>>
>
> Thank you for the pointer!
>
> So reading libfuse/fuse.c, fuse_lib_lookup does a reply with e.ino=3D0 er=
r=3D0 (instead of ENOENT) with e.entry_timeout=3Dnegative_timeout,
> for each lookup (and there's no global configuration but that's okay) ?

Yes.

Thanks,
Miklos
