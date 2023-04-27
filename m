Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0586F0309
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbjD0JJa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbjD0JJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:09:29 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F261A6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:09:27 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-b97ec4bbc5aso6444905276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682586567; x=1685178567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNpdm3UdM662v+PkmhOF4xRqFKPDMD0thDZpGLd8lkw=;
        b=RYBXg2XeFOsaEcpqwGfu07IRRZA/vEeZz/Q/D8AW0rBdXP/q9lnZOHTogNZlqbXBBB
         RjSjLRIjIJ6orI0+dKxDWnuneRn/UbyXILQ5iK8b1OQc16QJvyN6TTTbgFC07fS9qrZR
         /01quT45K1FTyoiNqNod3suSGiifv/D9hoDMHVMtoFaHbOIFHGTyuUzJtxzIS/KvMgws
         7j7CnygdcFUV2M64WyeOtL2gaVkS1exmHbTNy6tGC3puJnWnota76IqjdF7IAqqSzUNo
         viszIRFkcoQvoqptMLWUfPxqN7pLaJGbMvdS3mZDHbl++WWfmB8Fz8VXtxdl6/paukJJ
         8pGg==
X-Gm-Message-State: AC+VfDwNdZOo3RuRzLdTBKIAK3otuamtLeFmK3WO6JcZi4126VHdnx0I
        RBY6plqDRm5AF4cXbiw+Gur69K1prgbzdQ==
X-Google-Smtp-Source: ACHHUZ7vBG66evaalj4r7uTzVn5QrXGyG7Dt8Jr9KlvsDQCfiXsMNJt7QUp/3QOiG4ZiVwTd7o4d4Q==
X-Received: by 2002:a0d:e857:0:b0:541:8810:8d7b with SMTP id r84-20020a0de857000000b0054188108d7bmr808241ywe.15.1682586566468;
        Thu, 27 Apr 2023 02:09:26 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id o144-20020a0dcc96000000b00555e6c655f1sm4653603ywd.103.2023.04.27.02.09.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 02:09:26 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-54fb89e1666so64220217b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:09:26 -0700 (PDT)
X-Received: by 2002:a81:4654:0:b0:52e:f109:ba7a with SMTP id
 t81-20020a814654000000b0052ef109ba7amr655899ywa.51.1682586565812; Thu, 27 Apr
 2023 02:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-3-quic_kriskura@quicinc.com> <dde01219-57f7-3cc2-c4fb-5b6a38bd7a9c@quicinc.com>
 <CAMuHMdXdP6fPPQxvAdQCz2P_SPnCLjEpqiTHerF05e7tJmWHFg@mail.gmail.com>
 <2070d2fc-9bdc-57f8-d789-4fa6412fc7ed@quicinc.com> <CAMuHMdUKqo6paF5efFVr0tmA3mpOAraZORoKyVFi8Pkt=H4z6Q@mail.gmail.com>
 <592c2095-a6dc-de4b-713d-a9a582f966e0@quicinc.com>
In-Reply-To: <592c2095-a6dc-de4b-713d-a9a582f966e0@quicinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Apr 2023 11:09:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW4whkqdj+CXbSbnJK+hA+ePf81O_1gh+VP-saY6-e=HQ@mail.gmail.com>
Message-ID: <CAMuHMdW4whkqdj+CXbSbnJK+hA+ePf81O_1gh+VP-saY6-e=HQ@mail.gmail.com>
Subject: get_maintainer.pl wrong and undeterministic? (was: Re: [PATCH v2 2/2]
 usb: gadget: udc: Handle gadget_connect failure during bind operation)
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

CC Joe and lkml

On Thu, Apr 27, 2023 at 10:44 AM Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
> On 4/27/2023 1:23 PM, Geert Uytterhoeven wrote:
> > On Thu, Apr 27, 2023 at 5:49 AM Krishna Kurapati PSSNV
> > <quic_kriskura@quicinc.com> wrote:
> >> On 4/26/2023 2:48 PM, Geert Uytterhoeven wrote:
> >>> On Wed, Apr 26, 2023 at 3:17 AM Krishna Kurapati PSSNV
> >>> <quic_kriskura@quicinc.com> wrote:
> >>>> Hi Alan, Geert,
> >>>>
> >>>>     Can you help review and provide comments/approval on the following patch.
> >>>
> >>> I don't know why you are addressing me, as I never touched the affected
> >>> file, am not listed as its maintainer, and don't know much about USB UDC.
> >
> >>    Apologies. I must have caused some confusion because of same name. I
> >> must have specified clearly whom I was referring to.
> >>
> >> I CC'd and was referring to Geert Uytterhoeven <geert+renesas@glider.be>
> >> for comments.
> >
> > That's actually me, too ;-)
> >
> >> As per the output of get_maintainer.pl
> >>
> >> ./scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c
> >>
> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB
> >> SUBSYSTEM,commit_signer:6/6=100%,authored:1/6=17%,removed_lines:2/26=8%)
> >> Alan Stern <stern@rowland.harvard.edu>
> >> (commit_signer:4/6=67%,authored:3/6=50%,added_lines:36/45=80%,removed_lines:17/26=65%)
> >> TaoXue <xuetao09@huawei.com> (commit_signer:1/6=17%)
> >> "Rafael J. Wysocki" <rafael@kernel.org> (commit_signer:1/6=17%)
> >> Geert Uytterhoeven <geert+renesas@glider.be> (commit_signer:1/6=17%)
> >> Colin Ian King <colin.i.king@gmail.com> (authored:1/6=17%)
> >> Jiantao Zhang <water.zhangjiantao@huawei.com>
> >> (authored:1/6=17%,added_lines:6/45=13%,removed_lines:6/26=23%)
> >
> > Interesting, I don't see me listed when running that command (on v6.3 and
> > next-20230425), and I never authored any change to that file.
> > What is the tree (commit sha1) you are running ./scripts/get_maintainer.pl on?
>
> I checked it on linux-next a couple of weeks back and it showed me this.
> But when I synced latest linux kernel, it didn't show it today 😅
> Not sure, what is the diff here.

Interesting:

    $ git checkout next-20230425
    Updating files: 100% (7386/7386), done.
    Previous HEAD position was 198925fae644b009 Add linux-next
specific files for 20230329
    HEAD is now at f600e0bbde8562a0 Add linux-next specific files for 20230425
    $ scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c
    Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB
SUBSYSTEM,commit_signer:11/11=100%,authored:3/11=27%,removed_lines:5/73=7%)
    Alan Stern <stern@rowland.harvard.edu>
(commit_signer:4/11=36%,authored:3/11=27%,added_lines:36/182=20%,removed_lines:17/73=23%)
    Badhri Jagan Sridharan <badhri@google.com>
(commit_signer:2/11=18%,authored:2/11=18%,added_lines:107/182=59%,removed_lines:44/73=60%)
    Elson Roy Serrao <quic_eserrao@quicinc.com>
(commit_signer:1/11=9%,added_lines:27/182=15%)
    Sebastian Reichel <sre@kernel.org> (commit_signer:1/11=9%)
    Colin Ian King <colin.i.king@gmail.com> (authored:1/11=9%)
    Jiantao Zhang <water.zhangjiantao@huawei.com>
(authored:1/11=9%,removed_lines:6/73=8%)
    linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
    linux-kernel@vger.kernel.org (open list)
    $ git checkout next-20230329
    Updating files: 100% (7386/7386), done.
    Previous HEAD position was f600e0bbde8562a0 Add linux-next
specific files for 20230425
    HEAD is now at 198925fae644b009 Add linux-next specific files for 20230329
    $ scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c
    Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB
SUBSYSTEM,commit_signer:8/8=100%,authored:3/8=38%,added_lines:5/48=10%,removed_lines:5/29=17%)
    Alan Stern <stern@rowland.harvard.edu>
(commit_signer:3/8=50%,authored:3/8=38%,added_lines:36/48=75%,removed_lines:17/29=59%)
    Geert Uytterhoeven <geert+renesas@glider.be> (commit_signer:1/8=12%)
    Sebastian Reichel <sre@kernel.org> (commit_signer:1/8=12%)
    Heikki Krogerus <heikki.krogerus@linux.intel.com> (commit_signer:1/8=12%)
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I, Sebastian, and Heikki never touched this file...

     Jiantao Zhang <water.zhangjiantao@huawei.com>
(authored:1/8=12%,added_lines:6/48=12%,removed_lines:6/29=21%)
    Colin Ian King <colin.i.king@gmail.com> (authored:1/8=12%)
    linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
    linux-kernel@vger.kernel.org (open list)
    $ scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c
    Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB
SUBSYSTEM,commit_signer:8/8=100%,authored:3/8=38%,added_lines:5/48=10%,removed_lines:5/29=17%)
    Alan Stern <stern@rowland.harvard.edu>
(commit_signer:4/8=50%,authored:3/8=38%,added_lines:36/48=75%,removed_lines:17/29=59%)
    "Rafael J. Wysocki" <rafael@kernel.org> (commit_signer:1/8=12%)
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Heikki and I are gone, but Rafael is new and also hasn't touched this file?

    Colin Ian King <colin.i.king@gmail.com>
(commit_signer:1/8=12%,authored:1/8=12%)
    Sebastian Reichel <sre@kernel.org> (commit_signer:1/8=12%)
    Jiantao Zhang <water.zhangjiantao@huawei.com>
(authored:1/8=12%,added_lines:6/48=12%,removed_lines:6/29=21%)
    linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
    linux-kernel@vger.kernel.org (open list)

You can see the differences when running the following multiple times:

    $ diff <(scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c)
<(scripts/get_maintainer.pl drivers/usb/gadget/udc/core.c)

Looks like scripts/get_maintainer.pl (a) shows wrong committers (they
did provide other e.g. Reviewed-by tags), and (b) is not deterministic?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
