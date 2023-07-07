Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA10074B9FC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGGXT2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jul 2023 19:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGGXT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:19:27 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC41FF0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 16:19:24 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6686708c986so1989034b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 16:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688771964; x=1691363964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Q03hEYj8PS8pSjA/d96lqRNMExS5ZCZbqQ5e1bfGn0=;
        b=NqbFNuZsV6r2/nqdzYlpXKD+K3nID7hBk/gS2KbcjB6U5sJ9p1ZGtMWYeZ/+dir0QD
         Dekatas2uoRGoz3Fqx3YGlNzU8zdW4Ic3mfPbMzGdHSzzU2OAIhGWkn0M5zx6ShYhJdt
         XGuhqYwA0G3C8ivY0oTliYwnnC3DJOLof8rbxnjp0Hy0RTv+lGs16yJsXWp1ppWeKssd
         Nf2/nwz2A2dB/5gViBnca8yGAUFrGRne46xMEPPrdhkcTW4fCBkKE/eJ4u94qEvJbJEa
         yWyqwSRvZvLQXrNmWZsA/CPKUF6hTa5KiY4gWMZtEfv6xA5ANmrjA/laZXLbgyJYG6qA
         baKQ==
X-Gm-Message-State: ABy/qLbNpiDDu6QtTA3mvjRto1SV7h6mHt1fyDAEQvum6e0DvGUQMe73
        idSdC5W7/DjLtYSVAfAouLQ88iFpJccydDyo6ZLeJw==
X-Google-Smtp-Source: APBJJlHdtp0F7BvrZimD7Rod63Rgcvus89CJl1q4+GwzKoN7cYejUG6CpdeRXXxEI4oWSn7ZA2W4KII/6SyPcZpOPUk=
X-Received: by 2002:a05:6a00:2307:b0:67e:18c6:d2c6 with SMTP id
 h7-20020a056a00230700b0067e18c6d2c6mr7621889pfh.5.1688771964092; Fri, 07 Jul
 2023 16:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230706145154.2517870-1-jforbes@fedoraproject.org>
 <20230706084433.5fa44d4c@kernel.org> <CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
 <20230707151206.137d3a94@kernel.org>
In-Reply-To: <20230707151206.137d3a94@kernel.org>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Fri, 7 Jul 2023 17:19:12 -0600
Message-ID: <CAFxkdApnEo8RPOQ3zVjAZBeTtH2UbaT2798gQ5w0SA5e-dtZng@mail.gmail.com>
Subject: Re: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 4:12 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 7 Jul 2023 11:50:16 -0500 Justin Forbes wrote:
> > > On Thu,  6 Jul 2023 09:51:52 -0500 Justin M. Forbes wrote:
> > > > The rmnet driver is useful for chipsets that are not hidden behind
> > > > NET_VENDOR_QUALCOMM.  Move sourcing the rmnet Kconfig outside of the if
> > > > NET_VENDOR_QUALCOMM as there is no dependency here.
> > > >
> > > > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> > >
> > > Examples of the chipsets you're talking about would be great to have in
> > > the commit message.
> >
> > The user in the Fedora bug was using mhi_net with qmi_wwan.
>
> Hm, if anything mhi_net should not be sitting directly in drivers/net/
>
> I don't think this is a change in the right direction, just enable
> VENDOR_QUALCOMM? Or am I missing something?

Enabling it is not a problem, but it seems that if devices not hidden
behind VENDOR_QUALCOMM are able to use rmnet, then it is incorrect for
rmnet to be hidden behind VENDOR_QUALCOMM. I have already enabled
everything for Fedora users, so I am not worried about how to support
my users, just a matter of correctness, and the fact that Kconfig deps
are more difficult for people to understand in general.   Someone
reading online hears they need to turn on rmnet, so they add an entry
for it, and don't realize that the entry is ignored because
VENDOR_QUALCOMM is not enabled.  Either all devices capable of using
rmnet should be hidden behind VENDOR_QUALCOMM or rmnet should not be.

Justin
