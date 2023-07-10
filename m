Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D315A74D977
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjGJPDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjGJPDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:03:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E926D135
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:03:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so7254052e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689001391; x=1691593391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+/YcQCRVAMC3uxlTAjtK+T4rp7Ar9BSkj3c7yhcSws=;
        b=CA2qjHQmp/6RINVxFfCvkZrngo9AeGbQmh1m2SDfYL/4+ka+WXjGyZc+VqcDpywAoU
         k4p8xod0o5kFrmQb5Hbp2gZVbJOhRMoMRK9XvN453JVQp0OfauCaCOmExXexqE+2/oD8
         dHjGZg7NH/EkSk4uoIaDRgO61ql9AF3ckszzeLkJ18C/ulIzSkydPlpHwayufit8elIo
         UnXGn1jEDtP1bcob1aAuCgI0RcGaURVQAPywLR9phHNos2/9nsp5FQxvRQQo2zUwq400
         PIHQkX+kILeq2t6ZW5gToXMIujrUcKJJmxVG+AC5AWwb9v1m3uYK62PyRHoH1MIFXcsN
         j6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001391; x=1691593391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+/YcQCRVAMC3uxlTAjtK+T4rp7Ar9BSkj3c7yhcSws=;
        b=Smu+dwMaouJTSRw3gMtiCYux6n1TZc8IVpKZKlPhMGu0M5qt5V4ms+5IFfpNtxrC2Q
         rgffqRKi4v9hxhS5034s/5ajf1NFfVxlewdhcARxviGF93fXKA2ZyTRCz4pQFunmYST/
         wGN3KAxN8xLlgptUxsRunmDWLpqS9wdGuB02XY8MSXQ4v8l0ZytD6h1Pfmj0YuHYxEw5
         Nw69pB2t+zxEpzZ5ZkHc2BrFEtSjAHlPkAscs0luEzKelKOw2pp6g/br42EqNCPyLZ4f
         QltAbMBPBPdaSe1NSORaqBDjF8rCtwlLsWsn+OZi5OQOm9YyNhRb0tZ0yF+QBRe42/VY
         dHbQ==
X-Gm-Message-State: ABy/qLZjRtNikieO/L9l/NJHaj6/n/Ss1O6omziNxsjhhM0DsbM+abjB
        hYvzLcRcNJRr1jKEy/wBWQgA0hG84hBWsPjv189CbQ==
X-Google-Smtp-Source: APBJJlFLbhTtQKrCqFuTG7r02TuoUgKXehZFEjH+TFvc1qPH2HREFAU/lFAZbgRtulNUaOvSi1AF1w0crnDRY48jkZw=
X-Received: by 2002:ac2:4e88:0:b0:4fb:8ee0:b8a5 with SMTP id
 o8-20020ac24e88000000b004fb8ee0b8a5mr9216185lfr.46.1689001390958; Mon, 10 Jul
 2023 08:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230707044613.1169103-1-hezhongkun.hzk@bytedance.com>
 <ZKfFVfZovt4PnMsy@dhcp22.suse.cz> <CACSyD1M9rSadO7xb8-H0dU2-xtrZnJMBgqEMTSHhE6M5vFgC-Q@mail.gmail.com>
 <ZKgk0HfuuxsyBBXI@dhcp22.suse.cz> <CACSyD1NX7sfPu2Wi1ep0gJ-wt1O8-+++321Uhw4YK1Uz4rxj-g@mail.gmail.com>
 <ZKvgTTqwTnUXiY3m@dhcp22.suse.cz> <CACSyD1NkvXuyjUEc_pb_89B-5XyBd8sSSD1XmKKkDBssMV5FhA@mail.gmail.com>
 <ZKwI9LYDFkDd0+9O@dhcp22.suse.cz>
In-Reply-To: <ZKwI9LYDFkDd0+9O@dhcp22.suse.cz>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Mon, 10 Jul 2023 23:02:59 +0800
Message-ID: <CACSyD1OqPJnZnx5OKv9wccgU2oeBNOS6Sh1rY3TFt6FQ-uwDLg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/2] zram: objects charge to mem_cgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
        yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 9:35=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 10-07-23 21:16:42, =E8=B4=BA=E4=B8=AD=E5=9D=A4 wrote:
> > >
> > > OK, this is an important detail to mention. Also have tried to get so=
me
> > > numbers of how much excess is happening for a mixed bag of compressib=
le
> > > memory?
> >
> > Yes, I've done the test many times.  The numbers of excess depend on th=
e
> > compression ratio only. The maximum amount will not exceed 400KB,and wi=
ll be
> > smaller than the hard limit finally.
>
> Again, important data point for your changelog.

Thanks,  more data will be added in the next version.

>
> --
> Michal Hocko
> SUSE Labs
