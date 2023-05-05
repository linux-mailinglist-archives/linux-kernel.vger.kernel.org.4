Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474736F8743
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjEERME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjEERMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:12:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC27A11B6F
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:11:58 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-74cebbb7bc5so180504085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683306716; x=1685898716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1cIC+TdX4DHh2bD3zyRHqDOXb1jCNxEJqMG31slbWU=;
        b=i3nvIBg8jtq/2/yDdOZ1yntE10m0JQuer0vjd8hSHwxYx3BYQeYjiNxJOI4CkBk3d4
         nAFF31r70GxoLzWoa8HhH5sfQK6ootL6Y3i2CDFHnDSA58JN9c/ZXyxVvDyCIWZv7Y9X
         /oq00K8mQzae/3HNAcj8/8cB7tf6VJWIJPkkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683306716; x=1685898716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1cIC+TdX4DHh2bD3zyRHqDOXb1jCNxEJqMG31slbWU=;
        b=SSyNV1810+Ww1/u2zykrpIP0BCj848b1rzp/o6knqYOn5VVwPtLI9y9Zi6JSdIXkqF
         Lqmob4itJXZjmLr5TMbwGDzXbaeSdssjCqTnTh1L2g9oiGICfchKDPBhQZva7Uvfm+a/
         ooFb5PMUtQwZXTBKmckFMoudR3zOwg2WXAGLX03AedxDh0MXjq7bw6SnjbBy2IJHVgIW
         CpCvDKhS/eaPKYBWkg58/qVgVKFoEwOOjXTHHlEPWetXrH9OMQe/N8BaIXjaMBFZUA79
         JcdkPngRC6+bxn4rAWbXD7WH9wSLi4F4PNOvxWNuVW1obyVEJm1FSnIM4E4xk7zBckoh
         FiSA==
X-Gm-Message-State: AC+VfDzHBIg6oEEvkoZoqR19Blv5YGOv+m2Dp9Wj9x1pmMbOhnyH7o5N
        WimJvSrBKJdG9esahlcD92sEoWVCdwJ99k/4VyU=
X-Google-Smtp-Source: ACHHUZ4UIooA3gtWRN4O3bWo41M0mdoeEZI/Xlu/2npClut95mCs5F/9ea9AVZA0I3C0Ak1MXfVCtg==
X-Received: by 2002:a05:6214:29ea:b0:5ef:5049:f49a with SMTP id jv10-20020a05621429ea00b005ef5049f49amr3450784qvb.32.1683306716680;
        Fri, 05 May 2023 10:11:56 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id x26-20020a0cb21a000000b0061b608dc4c1sm722649qvd.94.2023.05.05.10.11.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 10:11:55 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1101551cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:11:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1ba2:b0:3f0:af20:1a37 with SMTP id
 bp34-20020a05622a1ba200b003f0af201a37mr294288qtb.15.1683306715201; Fri, 05
 May 2023 10:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230428135414.v3.1.Ia86ccac02a303154a0b8bc60567e7a95d34c96d3@changeid>
 <20230430085300.3173-1-hdanton@sina.com> <CAD=FV=WLHZfNN5cGMUEnvv17obVK-MLmWHJHx=MV55Q1YxczOA@mail.gmail.com>
 <20230503014500.3692-1-hdanton@sina.com>
In-Reply-To: <20230503014500.3692-1-hdanton@sina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 May 2023 10:11:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWLswc8A1zgV20V1eboaq18i0js3d-VjNQtFeytPT1xw@mail.gmail.com>
Message-ID: <CAD=FV=XWLswc8A1zgV20V1eboaq18i0js3d-VjNQtFeytPT1xw@mail.gmail.com>
Subject: Re: [PATCH v3] migrate_pages: Avoid blocking for IO in MIGRATE_SYNC_LIGHT
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 2, 2023 at 6:45=E2=80=AFPM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On 2 May 2023 14:20:54 -0700 Douglas Anderson <dianders@chromium.org>
> > On Sun, Apr 30, 2023 at 1:53=3DE2=3D80=3DAFAM Hillf Danton <hdanton@sin=
a.com> wrote:
> > > On 28 Apr 2023 13:54:38 -0700 Douglas Anderson <dianders@chromium.org=
>
> > > > The MIGRATE_SYNC_LIGHT mode is intended to block for things that wi=
ll
> > > > finish quickly but not for things that will take a long time. Exact=
ly
> > > > how long is too long is not well defined, but waits of tens of
> > > > milliseconds is likely non-ideal.
> > > >
> > > > When putting a Chromebook under memory pressure (opening over 90 ta=
bs
> > > > on a 4GB machine) it was fairly easy to see delays waiting for some
> > > > locks in the kcompactd code path of > 100 ms. While the laptop wasn=
't
> > > > amazingly usable in this state, it was still limping along and this
> > > > state isn't something artificial. Sometimes we simply end up with a
> > > > lot of memory pressure.
> > >
> > > Given longer than 100ms stall, this can not be a correct fix if the
> > > hardware fails to do more than ten IOs a second.
> > >
> > > OTOH given some pages reclaimed for compaction to make forward progre=
ss
> > > before kswapd wakes kcompactd up, this can not be a fix without spott=
ing
> > > the cause of the stall.
> >
> > Right that the system is in pretty bad shape when this happens and
> > it's not very effective at doing IO or much of anything because it's
> > under bad memory pressure.
>
> Based on the info in another reply [1]
>
>    | I put some more traces in and reproduced it again. I saw something
>    | that looked like this:
>    |
>    | 1. balance_pgdat() called wakeup_kcompactd() with order=3D10 and tha=
t
>    | caused us to get all the way to the end and wakeup kcompactd (there
>    | were previous calls to wakeup_kcompactd() that returned early).
>    |
>    | 2. kcompactd started and completed kcompactd_do_work() without block=
ing.
>    |
>    | 3. kcompactd called proactive_compact_node() and there blocked for
>    | ~92ms in one case, ~120ms in another case, ~131ms in another case.
>
> I see fragmentation given order=3D10 and proactive_compact_node(). Can yo=
u
> specify the evidence of bad memory pressure?

What type of evidence are you looking for? When I'm reproducing these
problems, I'm running a test that specifically puts the system under
memory pressure by opening up lots of tabs in the Chrome browser. When
I start seeing these printouts, I can take a look at the system and I
can see that it's pretty much constantly swapping in and swapping out.


> > I guess my first thought is that, when this happens then a process
> > holding the lock gets preempted and doesn't get scheduled back in for
> > a while. That _should_ be possible, right? In the case where I'm
> > reproducing this then all the CPUs would be super busy madly trying to
> > compress / decompress zram, so it doesn't surprise me that a process
> > could get context switched out for a while.
>
> Could switchout turn the below I/O upside down?
>                 /*
>                  * In "light" mode, we can wait for transient locks (eg
>                  * inserting a page into the page table), but it's not
>                  * worth waiting for I/O.
>                  */

I'm not sure I understand what you're asking, sorry!

-Doug
