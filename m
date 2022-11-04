Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E916619F41
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiKDRw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiKDRvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583CE43AFD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667584252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WCtW6Z0aIHoHYYkUcnKPD24UVWnFrm8fe3F2Ogq9ddY=;
        b=EsYgzNcr1G81/jXwxUltdCUK7Ehelzm+xuL/ZsHyCykJ1eEmxM4Ju5unZPBdbXY0Y/y0B8
        wvvSjSqY8XV14wjCrLdwBSKAH1TJ4MWtMeNvgUq9sy9P6HVCG+P45JsTEDrqax0yyBb70b
        fxj9LrKldP1SsW38ZIfO8YzsUr0+xNg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-0oGayg2bNpKs1mWagHZu5Q-1; Fri, 04 Nov 2022 13:50:51 -0400
X-MC-Unique: 0oGayg2bNpKs1mWagHZu5Q-1
Received: by mail-ed1-f70.google.com with SMTP id y18-20020a056402359200b004635f8b1bfbso4094841edc.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCtW6Z0aIHoHYYkUcnKPD24UVWnFrm8fe3F2Ogq9ddY=;
        b=k68Jf9iGjGbCvE5g8iP0JczM6ZSDnnyrtrEpjs49CQ8hVZaVG0bShycuBL8ikZRsNG
         gK1WV74bdTgwDhET45YMxfNn20iL5YbwLviGb6Bd/JO8qCWP6DNMoV/gZHDi1C+FAOhj
         oofy7ISl7n00yTKk6LZfm5vllwIu7GDg14Jtj+gx1tqofZFct63k+XX+y9m7Gwc5wMwI
         ZnRP63W0geFPAkur8OgPNPsmW3GtNmfYGrSRuNJo4jM8gS5G148yb06OVFw+yxxSuP3c
         hj1lGxVZ4SOCyXv1RpgW9rxD0YVr7guha9RJ++5+IvcEpd9wK4ayiQ9+d2mOe2ujiXke
         qpog==
X-Gm-Message-State: ACrzQf25tkNRjCYF/rM7ttpexJ3vHQXGPvlQxkgFGMt6XfwbTRu731zo
        O8sh7ec71+JKUPClavnGCTRmBwj4X/+4hpY7V8gEYgG2bPquW/i5o3jkInYFikrjijCDe0xy2eH
        J82kCyz8Sg9GH1N2SDsWz38lOysq3X504b1QLItUi
X-Received: by 2002:a05:6402:5409:b0:44f:1e05:1e8 with SMTP id ev9-20020a056402540900b0044f1e0501e8mr37092973edb.373.1667584249903;
        Fri, 04 Nov 2022 10:50:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7PyQYtc1pZF9HFgpahtxyPNMIaDnM0gYNhb8bkIf8av1uiWhRAbIvVtBduhQj1LzYg429/mQQkHsACEIwKVNE=
X-Received: by 2002:a05:6402:5409:b0:44f:1e05:1e8 with SMTP id
 ev9-20020a056402540900b0044f1e0501e8mr37092959edb.373.1667584249716; Fri, 04
 Nov 2022 10:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <202210111305.743F591@keescook> <Y0XQsqdRzlrSpgOh@mail.google.com> <Y2ScZqWnJKe7J6NR@mail.google.com>
In-Reply-To: <Y2ScZqWnJKe7J6NR@mail.google.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 4 Nov 2022 13:50:38 -0400
Message-ID: <CAK-6q+g37Ycmn5Etbj9Pk9iZXGCdyYc9pH18jowiS1DtTqp_EA@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v5] [next] dlm: replace one-element array
 with fixed size array
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 4, 2022 at 1:00 AM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
>
> On Wed, Oct 12, 2022 at 09:23:14AM +1300, Paulo Miguel Almeida wrote:
> > One-element arrays are deprecated. So, replace one-element array with
> > fixed size array member in struct dlm_ls, and refactor the rest of the
> > code, accordingly.
> >
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://github.com/KSPP/linux/issues/228
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
> > Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/
> >
> > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > ---
> > Changelog:
> >
> > v5: use preferred sizeof style. Req: Gustavo Silva
> > v4: resend patch using the right version number. Req: Gustavo Silva
> > v3: replace one-element array with a fixed size array. Req: Kees Cook
> > v2: patch resent as I had an issue with a <CRLF> char in my mail client
> > v1: https://lore.kernel.org/lkml/Y0ICbf8tCtXMn+W0@mail.google.com/
> > ---
> >
> >  fs/dlm/dlm_internal.h | 2 +-
> >  fs/dlm/lockspace.c    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> > index e34c3d2639a5..94fadb619ba0 100644
> > --- a/fs/dlm/dlm_internal.h
> > +++ b/fs/dlm/dlm_internal.h
> > @@ -670,7 +670,7 @@ struct dlm_ls {
> >       void                    *ls_ops_arg;
> >
> >       int                     ls_namelen;
> > -     char                    ls_name[1];
> > +     char                    ls_name[DLM_LOCKSPACE_LEN + 1];
> >  };
> >
> >  /*
> > diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
> > index bae050df7abf..9479c8110979 100644
> > --- a/fs/dlm/lockspace.c
> > +++ b/fs/dlm/lockspace.c
> > @@ -473,7 +473,7 @@ static int new_lockspace(const char *name, const char *cluster,
> >
> >       error = -ENOMEM;
> >
> > -     ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
> > +     ls = kzalloc(sizeof(*ls), GFP_NOFS);
> >       if (!ls)
> >               goto out;
> >       memcpy(ls->ls_name, name, namelen);
> > --
> > 2.37.3
> >
>
> Christine, David,
>
> Just following up on this patch. Is there anything that either of you
> want me change for this patch to be merged?
>

I think it's fine. I am working on DLM and the current upstream
process is more per release where I resend a huge patch-series to get
it upstream into dlm/next based on a recent rc... It just takes time.
Then your patch will of course be applied on.

- Alex

