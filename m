Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D1572C6B3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbjFLN5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjFLN5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:57:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F087A10D3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:56:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5162d2373cdso7803307a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686578169; x=1689170169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HGBKm3rUtk6a6owuw8xAw+5Ji2XRPu2JkI1sZuIh9k=;
        b=ctiFz0wrZVxoVIYHAxLdpZvVeRju3O/N9QEOb4hhxc0DuNhINWZkTBcb76mZDTmcsk
         xESgVYM2kE0PLpndQc90p5Wr6uuoJsMjte0EYjq8d0QrU2aZ2bHNmKayxBxN1WT3qd9W
         yg+hdXEn4sMOq9StjXc7QWhn8FHfmR61uV7hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686578169; x=1689170169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HGBKm3rUtk6a6owuw8xAw+5Ji2XRPu2JkI1sZuIh9k=;
        b=k+ep+EThltyuuWS62hUwgAwgURtNZtT4D0m7rmzOlqUgqvantGPCcwJ+VEYXqj0dZ/
         OxL59riK2WVvtC9t711A0Oh5WppbWeWJjx8r5ae81yu09AYkc/UaUoUWG7n4Wno2c0Jo
         6i+8/pnV0tEc/XgZlU5aAMqbCd2FjcK6FCuDg2uy1ryZkavf9bd8DiQ+m5e7Pcj8vtXu
         tUtwP4HF1NTQ52Xq8+PeLyEvSPgffRzDDS0s5lhWGUanQca+7XvGHFNz1Qu34OMsZxkw
         HfLfDbaCRc5sQr15+1rmlLxDNSpMiwzDE2bJkgfqLN/WitnbJJX/TwGMnw6lApRoW502
         1oNw==
X-Gm-Message-State: AC+VfDwVatIqH/RsOfM66ojCGFk1wLr0m/tEjXL3t6AmeWgG4dwUXPzz
        zqMJsyWRPHbV2XofYOuG815cExw4gcKkazmstIKIbQ==
X-Google-Smtp-Source: ACHHUZ7lftmLf8k+bh64KzoyBjRtfbABeZL68xyZW/tzs0h5avcaTCBAywk2EY+ArKEmBVSdSj8jpw==
X-Received: by 2002:aa7:cd95:0:b0:514:a0a7:7e7f with SMTP id x21-20020aa7cd95000000b00514a0a77e7fmr5124801edv.2.1686578169670;
        Mon, 12 Jun 2023 06:56:09 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id i17-20020a05640200d100b005183673f2fcsm1885668edu.69.2023.06.12.06.56.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 06:56:09 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f7f7dfc037so96425e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 06:56:09 -0700 (PDT)
X-Received: by 2002:a50:9fad:0:b0:505:863:d85f with SMTP id
 c42-20020a509fad000000b005050863d85fmr200065edf.4.1686578149114; Mon, 12 Jun
 2023 06:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.15.Ic55cb6f90ef5967d8aaa2b503a4e67c753f64d3a@changeid> <ZIb0hd8djM+jJviF@FVFF77S0Q05N>
In-Reply-To: <ZIb0hd8djM+jJviF@FVFF77S0Q05N>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Jun 2023 06:55:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyLKygSsArCaSzid47Rz5=ozR6Yh9L6Q3JStpzF9Tn9w@mail.gmail.com>
Message-ID: <CAD=FV=WyLKygSsArCaSzid47Rz5=ozR6Yh9L6Q3JStpzF9Tn9w@mail.gmail.com>
Subject: Re: [PATCH v5 15/18] watchdog/perf: Add a weak function for an arch
 to detect if perf can use NMIs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Mon, Jun 12, 2023 at 3:33=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Fri, May 19, 2023 at 10:18:39AM -0700, Douglas Anderson wrote:
> > On arm64, NMI support needs to be detected at runtime. Add a weak
> > function to the perf hardlockup detector so that an architecture can
> > implement it to detect whether NMIs are available.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > While I won't object to this patch landing, I consider it part of the
> > arm64 perf hardlockup effort. I would be OK with the earlier patches
> > in the series landing and then not landing ${SUBJECT} patch nor
> > anything else later.
>
> FWIW, everything prior to this looks fine to me, so I reckon it'd be wort=
h
> splitting the series here and getting the buddy lockup detector in first,=
 to
> avoid a log-jam on all the subsequent NMI bits.

I think the whole series has already landed in Andrew's tree,
including the arm64 "perf" lockup detector bits. I saw all the
notifications from Andrew go through over the weekend that they were
moved from an "unstable" branch to a "stable" one and I see them at:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=3Dmm-non=
mm-stable

When I first saw Anderw land the arm64 perf lockup detector bits in
his unstable branch several weeks ago, I sent a private message to the
arm64 maintainers (yourself included) to make sure you were aware of
it and that it hadn't been caught in mail filters. I got the
impression that everything was OK. Is that not the case?


-Doug
