Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1243774F076
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjGKNly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjGKNlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637A2E74
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689082864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvnb7JiwKvSnMAgyEjcswiUDuBLsnC0rp2JWm3dcW0o=;
        b=bWL35WPz81GAY9D7D8s1Cuyv63QW7IWS/P4QCAh1YpH7GuoSEZyYLujZ/+DdWmyxDPQkbL
        PmgpmO5y93238y1JHoQepULNB+ZWczi2A3JfoxrA+g1nB3eQlCcWQUk88G6bRAqOMhUrMg
        U6JTCvj07lx+HxQ3kYyc6bMfla8Vepc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-7abNTeUOPuGma0Fm1367sg-1; Tue, 11 Jul 2023 09:41:03 -0400
X-MC-Unique: 7abNTeUOPuGma0Fm1367sg-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-c5cea5773e8so6815861276.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689082862; x=1691674862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvnb7JiwKvSnMAgyEjcswiUDuBLsnC0rp2JWm3dcW0o=;
        b=h0Ifrs5WKJItinUEBuGOL/aIRVyvlnEU8CunrLmh2rG5SW3/n+VKYfQedF2MKlZk2x
         vjTQ+zM1wvo34unFLKXrffm7hVAYlKdf5VScV+qE3QRBnw5ImGwpIGM+IgeAS1afiRTV
         eKsEjs+FjhLp77bZL6RAlHdPmrna6ipxGEfOU5iFYVlLe/6InKoW7FSsvser+VfZwng/
         /iBF0zZliYOJvrG/2lxWp67BgP6BtRdCDAE/6RPNdDTBEJoOv204HZ7tBkf2LzqpTvrB
         sj3A5/BkBSZ8Ov8mxHnhsZjpX9ZPO0Rb3Loj7Yl0z27uruFPCjJugcpGafd3mhxeCOhJ
         fTwg==
X-Gm-Message-State: ABy/qLbIXc60ciUP2EvYAb3iU0u3WjHR9Kbj/Rn637jDZzi6vqjQf6HT
        kfgRaJrDcn/5KEhVIULdLnkNu+AyZX/OTHZnD23hOKXSDru3KsrGxQX5qXs3No9vswwUqo8IBtT
        zViKMvCp+5m+nuclzwkIEojO2bt2h7jNWLSZIZcKf
X-Received: by 2002:a25:23d1:0:b0:c69:cf1f:ec0a with SMTP id j200-20020a2523d1000000b00c69cf1fec0amr13124359ybj.15.1689082862667;
        Tue, 11 Jul 2023 06:41:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE4ZLOqIjO/yyFhHoIBVoAPEbGrTyKrYmJlC4AJrQfREkKw9AcsD5OXndLzLtud1cBfWt6TWIx1ymEODA6SenA=
X-Received: by 2002:a25:23d1:0:b0:c69:cf1f:ec0a with SMTP id
 j200-20020a2523d1000000b00c69cf1fec0amr13124347ybj.15.1689082862425; Tue, 11
 Jul 2023 06:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com>
 <2023062156-trespass-pandemic-7f4f@gregkh> <qbvmv3eexohswyagmllfh3xsxoftwa3wbmsdafmwak2bxlnlft@jz74dijlfxlz>
 <31ce32e018a9fa410e9e1f3e5900621b16a56091.camel@hadess.net>
 <CAO-hwJLFSUJaGK5DAOz30+YyC1hGgHnbeJbc5iQ47jxBcbRSCg@mail.gmail.com> <cfa28818-9eaf-0dc9-cb4a-1b3de318e627@leemhuis.info>
In-Reply-To: <cfa28818-9eaf-0dc9-cb4a-1b3de318e627@leemhuis.info>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 11 Jul 2023 15:40:51 +0200
Message-ID: <CAO-hwJLc0wzv2a3JARkPDW+ZgbnvwggfRHcAJmWsKy_FMA13=g@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: rework one more time the retries attempts
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 3:10=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 26.06.23 16:02, Benjamin Tissoires wrote:
> > On Sun, Jun 25, 2023 at 10:30=E2=80=AFAM Bastien Nocera <hadess@hadess.=
net> wrote:
> >> On Fri, 2023-06-23 at 10:37 +0200, Benjamin Tissoires wrote:
> >>> On Jun 21 2023, Greg KH wrote:
> >>>> On Wed, Jun 21, 2023 at 11:42:30AM +0200, Benjamin Tissoires wrote:
> >>>>> Make the code looks less like Pascal.
> >>>>>
> >>>>> Extract the internal code inside a helper function, fix the
> >>>>> initialization of the parameters used in the helper function
> >>>>> (`hidpp->answer_available` was not reset and `*response` wasn't
> >>>>> too),
> >>>>> and use a `do {...} while();` loop.
> >>>>>
> >>>>> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when
> >>>>> device is busy")
> >>>>> Cc: stable@vger.kernel.org
> >>>>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >>>>> ---
> >>>>> as requested by
> >>>>> https://lore.kernel.org/all/CAHk-=3DwiMbF38KCNhPFiargenpSBoecSXTLQA=
CKS2UMyo_Vu2ww@mail.gmail.com/
> >>>>> This is a rewrite of that particular piece of code.
> >>>>> ---
> >>>>>  drivers/hid/hid-logitech-hidpp.c | 102 +++++++++++++++++++++++--
> >>>>> --------------
> >>>>>  1 file changed, 61 insertions(+), 41 deletions(-)
> > [...]
> >
> > Some people on the Bz were able to reproduce with multiple reboots.
> > But it's not as urgent as previously, and we were close to the 6.4
> > final when I sent it. I'll make sure this goes into 6.5 and gets
> > proper stable backports FWIW.
>
> Did that happen? Doesn't look like it from here, but maybe I'm missing
> something. Where there maybe other changes to resolve the remaining
> problems some users encounter sporadically since the urgent fixes went in=
?

No, there were no other changes that could have solved this. I guess
the randomness of the problem makes it way harder to detect and to
reproduce.

I'll send a v2 of that patch with the reviews today or tomorrow and we
can probably get it through the current 6.5 cycle.

Cheers,
Benjamin

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>

