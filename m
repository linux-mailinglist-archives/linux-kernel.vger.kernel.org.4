Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7104D748393
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjGEL5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjGEL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:57:05 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C441723;
        Wed,  5 Jul 2023 04:57:00 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-47e25709402so1453090e0c.0;
        Wed, 05 Jul 2023 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688558219; x=1691150219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYzFOXrpHjMbau6LdBUr//Enq3hi9M8IF1iSIElak94=;
        b=g6COHjjX6H1jp8F3+hb7jSPsaJqivsIH24rJGOJVcEtbKhzNF5ISzY8ii3ouLDdwcP
         YlKNvcDTJHCk49YdLyZcOxvHeeP1GYrPIXXrzQSzOqPCWEllvjfGlhZ1eK/7+j1hTBLW
         eAOtb8dY6Lv70Z4+i6oaKkkTLheyO0o2pBUemkz9wq/RBZ6FSL/l7TjLLYcSnfId9ebn
         yAHVH3t1kYwr/2R1FfLOO5ZNsKP4yonuPzzw5D6Dybr1CeP5QpPpY6m9zac/uLpWBq7W
         lDihrjhQ8hF/Qd9ro0sv26veYR8HAuvbB9gk9I+3vX8BuZZmGA4464B3fwy2NXEIK4AU
         PzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688558219; x=1691150219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYzFOXrpHjMbau6LdBUr//Enq3hi9M8IF1iSIElak94=;
        b=MisjJZYCb66BMiLxeNKsZOedgB7dUmO6qox/37JBIEFyVcXC5H2JyZK80wMLvgaVzi
         GPRa9DUCut3VRhnXYFHxUSR9UKlX8BeV15OvFUTkPnolpnfEzrOUpUtxQXSdAE+CIi1d
         k4zvzxfJ+gOe+o9/mcRYn8UJBcCDf7gXaRWdRHXMdsd5nYsaz3MLP5CqbiICY7CiGFTk
         yuUso9ihSzMOgUfNUU1TbdN2hBhj0EuWsA2gASCgTM+W/fGYGoNcqKSQCyr39bWvBHbV
         IFdqlvvD850fwOnYqGdbuUuu+IqL7oybfRsctROn10/sTE8WsXBZPv2gIDx4LB8JNhTd
         yrow==
X-Gm-Message-State: ABy/qLa2JphGAgRFzoI8KoyFhqwB7otNoypU72tHdr2ZE9BBEPE7OTnm
        YruDwa2oZo1mJwRb42g/mVsWz5AV+1KL1EA0V289nu48HaTWZb8q
X-Google-Smtp-Source: APBJJlFFhOiBBRrEk3tyW0G/UO66q38pjXFSGKhoVHIsv25St86l3kpyWAQnFh8VA2c8QwfNLNINF3KnHnHTkCORxnE=
X-Received: by 2002:a1f:4ec6:0:b0:47e:3f56:e91e with SMTP id
 c189-20020a1f4ec6000000b0047e3f56e91emr3134115vkb.15.1688558219280; Wed, 05
 Jul 2023 04:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230429020951.082353595@lindbergh.monkeyblade.net>
 <CAAJw_ZueYAHQtM++4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com>
 <ZE0kndhsXNBIb1g7@debian.me> <b9ab37d2-42bf-cc31-a2c0-a9b604e95530@gmail.com>
 <CAAJw_Zug6VCS5ZqTWaFSr9sd85k=tyPm9DEE+mV=AKoECZM+sQ@mail.gmail.com> <7fee3284-b9ba-58f4-8118-fe0b99ae6bf7@leemhuis.info>
In-Reply-To: <7fee3284-b9ba-58f4-8118-fe0b99ae6bf7@leemhuis.info>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Wed, 5 Jul 2023 19:56:48 +0800
Message-ID: <CAAJw_Zu=MPtGPARgCB2fteP+7F793YDFXE9RuzSH8EqYBS-OOw@mail.gmail.com>
Subject: Re: Linux-6.5 iwlwifi crash
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 4:37=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi! Thanks for your report.
>
> Side note: is there any relation to the thread[1] you posted this in?

Sorry, I was just posting to the same email list that I had reported
about a different wifi list earlier. No relation to this, but it's a
new wifi issue.

> Doesn't look like it from here.
>
> Side note: discussing multiple unrelated issues in one thread increases
> the risk a lot that some or all of them are ignored:
> https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-k=
ernel-bug-reports-are-ignored/
>
> [1] https://lore.kernel.org/all/ZE0kndhsXNBIb1g7@debian.me/
>
> On 05.07.23 09:24, Jeff Chua wrote:
> > Latest linux-6.4
>
> What do you mean by that? From later in the mail it sounds like you mean
> latest mainline -- is that correct?

It's from linux git pull. It's 6.5-rc but I didn't write that way
becuase Linus's branch is still 6.4 ... that 6.5-rc0 or rc1 should
have more appropriate.

> > after June 27 crash my whole linux notebook once
> > iwlwifi is loaded. Anyone seeing this?
>
> I haven't heard of any such problems, but that doesn't have to mean much.

> > Bisect? Or there's a patch for this?
> >
> > # modprobe iwlwifi
> > ... Whole system frozen!
> >
> >
> > Here's my system before the crash ...
> >
> > # dmesg
> > cfg80211: Loading compiled-in X.509 certificates for regulatory databas=
e
> > Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> > iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
> > iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
> > thermal thermal_zone1: failed to read out thermal zone (-61)
> > iwlwifi 0000:00:14.3: Sorry - debug buffer is only 4096K while you
> > requested 65536K
> >
> > # lspci
> > 00:14.3 Network controller: Intel Corporation Alder Lake-P PCH CNVi
> > WiFi (rev 01)
> >
> > # linux git log
> > commit d528014517f2b0531862c02865b9d4c908019dc4 (HEAD -> master,
> > origin/master, origin/HEAD)
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Tue Jul 4 15:05:12 2023 -0700
> >
> > # lsmodModule                  Size  Used by
> > iwlmvm                397312  0
> > mac80211              626688  1 iwlmvm
> > iwlwifi               307200  1 iwlmvm
> > cfg80211              413696  3 iwlmvm,iwlwifi,mac80211
> >
> >
> > Bisect?
>
> If none of the others CCed comes up with an idea within the next few
> hours then yes please!

I will wait for a day, then bisect.

Thank you!


> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
