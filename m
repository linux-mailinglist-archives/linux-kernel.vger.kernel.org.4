Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63731732979
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjFPIFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjFPIFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:05:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41362D6B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:04:59 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-982acf0a4d2so49896566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686902698; x=1689494698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXX6whrEOn2eQbzXPk3jhKKZQgf895lWSSyWx6pgZ/Q=;
        b=rfzoXUjKWJC8c0uQjpT5e2w67xqgQ7njy4eKPdn233HlreIfZxLqjcenWdO+XxoI/l
         1Ee14lfpEEGlUNkflK5dfrGnNaD1eBKu/tm2IIpEoc0jrELVV5BCGtPAeTRsJsNx4V5x
         4HNTisQ6lIYdZvJMkFkIkzz8A0CIVl7UhfKkis+by025pcmsT/Rh6qMeuU4npZnCnQqA
         ukY8zD3fqaA14g0EE/ZmmTehxbk+sR/i0RPBUwZGgUG6n2gA42fVGWAQCk0pezH8j6OU
         DbPYtVBut+/M2qHLl6Wj4l3K3FPC3PyhXk7ObRLb39/e8EZKoYFCYC14mqoyrDHTDTeL
         +rBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686902698; x=1689494698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXX6whrEOn2eQbzXPk3jhKKZQgf895lWSSyWx6pgZ/Q=;
        b=Q4czGm7eH95FlmsyTxrdejhS1WAGFeiPxAfwcLPBtNVtOq4ZecS7YhgVZmQG6xvZaU
         ykOYlDUKWGg4/vKiQCNDaUHwoFYS6p2+Q59XNiYS7e6PQO3lkGXAzaoONre/rV+1JJg8
         zD1FVj7tXQIFg0fybjZHgZqKPwHrGRvOMd/QCjmdtamDA5wx2Ty1Bu52azc3LMxAq+mH
         t/z9sl1NmHTQ7NERKHbfCP2r5p8D2DFzrzacFbF00HCarUu+CiHzF6dpErMdCDrULokI
         FxKrWOzzLAuUAMdFi9cpEi5YpovSrRmHBU9t3kavqBAMeJ0DRXUYYG48ep9biwPOzaaZ
         JXrQ==
X-Gm-Message-State: AC+VfDyfoO3CYNftv6+PsywRQPmyHy/yJvgDgore4KDeu5syrnyPGzfW
        lZp37gWqM5Yn2GF5DRd7o3DaKy2nwF2EHGf5AF/Sng==
X-Google-Smtp-Source: ACHHUZ61O0r9MfXSpz4gJIWkwrbq1lgMgPTPILCLWpXVKQYSPgM6Ed4rssqmEJDJ7x8tsVmz/iVjC1DCVxDsEv/jKQ4=
X-Received: by 2002:a17:907:7f13:b0:97b:e0bb:8c2f with SMTP id
 qf19-20020a1709077f1300b0097be0bb8c2fmr976886ejc.4.1686902698171; Fri, 16 Jun
 2023 01:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
 <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com>
 <CAJD7tka-=ppaheVxn2-f6u0egBp8kOHYAK0bBudC62SKkZPk5w@mail.gmail.com>
 <CACSyD1MepXm4EL3o6OscAjRKQhAWZZ5xZKS8a0TXLAazUE+MpA@mail.gmail.com>
 <CAJD7tka4Uc1DhNzKbrj71vGyVVA12bJivPUQU7P0DOinunLgGg@mail.gmail.com> <576b7ba6-4dcd-48c9-3917-4e2a25aaa823@redhat.com>
In-Reply-To: <576b7ba6-4dcd-48c9-3917-4e2a25aaa823@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 16 Jun 2023 01:04:21 -0700
Message-ID: <CAJD7tkaS-wRjGjKbmN-HfiKJNTX0+PDdtw83NefEQ8nYAFznog@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     David Hildenbrand <david@redhat.com>
Cc:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>,
        Yu Zhao <yuzhao@google.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Fabian Deutsch <fdeutsch@redhat.com>
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

On Fri, Jun 16, 2023 at 12:57=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 16.06.23 09:37, Yosry Ahmed wrote:
> > On Thu, Jun 15, 2023 at 9:41=E2=80=AFPM =E8=B4=BA=E4=B8=AD=E5=9D=A4 <he=
zhongkun.hzk@bytedance.com> wrote:
> >>
> >>> Thanks Fabian for tagging me.
> >>>
> >>> I am not familiar with #1, so I will speak to #2. Zhongkun, There are
> >>> a few parts that I do not understand -- hopefully you can help me out
> >>> here:
> >>>
> >>> (1) If I understand correctly in this patch we set the active memcg
> >>> trying to charge any pages allocated in a zspage to the current memcg=
,
> >>> yet that zspage will contain multiple compressed object slots, not
> >>> just the one used by this memcg. Aren't we overcharging the memcg?
> >>> Basically the first memcg that happens to allocate the zspage will pa=
y
> >>> for all the objects in this zspage, even after it stops using the
> >>> zspage completely?
> >>
> >> It will not overcharge.  As you said below, we are not using
> >> __GFP_ACCOUNT and charging the compressed slots to the memcgs.
> >>
> >>>
> >>> (2) Patch 3 seems to be charging the compressed slots to the memcgs,
> >>> yet this patch is trying to charge the entire zspage. Aren't we doubl=
e
> >>> charging the zspage? I am guessing this isn't happening because (as
> >>> Michal pointed out) we are not using __GFP_ACCOUNT here anyway, so
> >>> this patch may be NOP, and the actual charging is coming from patch 3
> >>> only.
> >>
> >> YES=EF=BC=8C the actual charging is coming from patch 3. This patch ju=
st
> >> delivers the BIO page's  memcg to the current task which is not the
> >> consumer.
> >>
> >>>
> >>> (3) Zswap recently implemented per-memcg charging of compressed
> >>> objects in a much simpler way. If your main interest is #2 (which is
> >>> what I understand from the commit log), it seems like zswap might be
> >>> providing this already? Why can't you use zswap? Is it the fact that
> >>> zswap requires a backing swapfile?
> >>
> >> Thanks for your reply and review. Yes, the zswap requires a backing
> >> swapfile. The I/O path is very complex, sometimes it will throttle the
> >> whole system if some resources are short , so we hope to use zram.
> >
> > Is the only problem with zswap for you the requirement of a backing swa=
pfile?
> >
> > If yes, I am in the early stages of developing a solution to make
> > zswap work without a backing swapfile. This was discussed in LSF/MM
> > [1]. Would this make zswap usable in for your use case?
>
> Out of curiosity, are there any other known pros/cons when using
> zswap-without-swap instead of zram?
>
> I know that zram requires sizing (size of the virtual block device) and
> consumes metadata, zswap doesn't.

We don't use zram in our data centers so I am not an expert about
zram, but off the top of my head there are a few more advantages to
zswap:
(1) Better memcg support (which this series is attempting to address
in zram, although in a much more complicated way).

(2) We internally have incompressible memory handling on top of zswap,
which is something that we would like to upstream when
zswap-without-swap is supported. Basically if a page does not compress
well enough to save memory we reject it from zswap and make it
unevictable (if there is no backing swapfile). The existence of zswap
in the MM layer helps with this. Since zram is a block device from the
MM perspective, it's more difficult to do something like this.
Incompressible pages just sit in zram AFAICT.

(3) Writeback support. If you're running out of memory to store
compressed pages you can add a swapfile in runtime and zswap will
start writing to it freeing up space to compress more pages. This
wouldn't be possible in the same way in zram. Zram supports writing to
a backing device but in a more manual way (userspace has to write to
an interface to tell zram to write some pages).

The disadvantage is that zswap doesn't currently support being used
without a swapfile, but once this support exists, I am not sure what
other disadvantages zswap would have compared to zram.

>
> --
> Cheers,
>
> David / dhildenb
>
