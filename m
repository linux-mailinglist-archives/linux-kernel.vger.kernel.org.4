Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0176A60D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjB1VBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjB1VBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:01:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9720A22DF9;
        Tue, 28 Feb 2023 13:01:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6082DB80E9E;
        Tue, 28 Feb 2023 21:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B43C433EF;
        Tue, 28 Feb 2023 21:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677618102;
        bh=PuulFyV4awQbeaORv2ji+l8CrYcwr4rOBMH1Tmw+dtE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Avt+N/dHfyW7DzInBLT270f21nSYylFNKA/0Iv5W5TLARLIkzgle0VUkpFUBUCA+e
         HS8r/UciJYdPwkRQhFVwVMvrPjh5pIcjn5cPcgAEy4BuTlOEZEZ9Uhv6xbZkqAOAej
         9Y1snhlVSSP9wNoq6omx6gUP5WzPOaJ3qzGdw+Yde0PhxDHrDty2WDjkPeleROklIg
         U2FUM2UBpv72NLnXSZp7qusAZFSfzbar6OPn9nd5j8x2fDpal0Ga9bJQTcOpacJg61
         u5iQkA+MYjbiYbazNh3OAXedYMtET1cQqH6XtUaOMt2v2seQYb7EN1CP77U0WfSSaT
         oQ0f3zsNd3sMA==
Received: by mail-vs1-f54.google.com with SMTP id x14so17144794vso.9;
        Tue, 28 Feb 2023 13:01:41 -0800 (PST)
X-Gm-Message-State: AO0yUKU+4zedN9y7WyF4BHDO4XgUiMEW0+MUj638oCBBKL/4fMwcuFPh
        1EgSpP+0xtrXb7G/qyIADbsO++K0RInr7qaCXA==
X-Google-Smtp-Source: AK7set+knSmnKI9hZHw/GCydiY5YXrF1T3UuE2jhcpYZSRIm0PWl9GdSn7NK6uvej168lpg2EjqKn6El4YYdjuqeaj0=
X-Received: by 2002:a67:e003:0:b0:414:d29b:497c with SMTP id
 c3-20020a67e003000000b00414d29b497cmr2801654vsl.6.1677618100932; Tue, 28 Feb
 2023 13:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20230228174019.4004581-1-jjhiblot@traphandler.com> <CAGETcx-w4A3fz_DPqJG+9P6ETGAPv547DcnsO52gqTO1_vijsw@mail.gmail.com>
In-Reply-To: <CAGETcx-w4A3fz_DPqJG+9P6ETGAPv547DcnsO52gqTO1_vijsw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Feb 2023 15:01:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL6qFDC5uC_0PgyM_8OVEwFq+o=gPk2=PRKBDTp9XTzOw@mail.gmail.com>
Message-ID: <CAL_JsqL6qFDC5uC_0PgyM_8OVEwFq+o=gPk2=PRKBDTp9XTzOw@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add missing of_node_get() in parse_interrupt()
To:     Saravana Kannan <saravanak@google.com>
Cc:     jjhiblot@traphandler.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:07=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Tue, Feb 28, 2023 at 9:40=E2=80=AFAM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
> >
> > From: Jean Jacques Hiblot <jjhiblot@traphandler.com>
> >
> > As all the other parsers do, parse_interrupt() must increase the refcou=
nt
> > of the device_node. Otherwise the refcount is decremented every time
> > parse_interrupt() is called on this node, leading to a potential
> > use-after-free.
> >
> > This is a regression introduced by commit f265f06af194 ("of: property:
> > Fix fw_devlink handling of interrupts/interrupts-extended"). The reason=
 is
> > that of_irq_parse_one() does not increase the refcount while the previo=
usly
> > used of_irq_find_parent() does.
>
> Thanks for catching the issue Jean!
>
> This feels like a bug in of_irq_parse_one() to me. It's returning a
> reference to a node without doing a of_node_get() on it.
>
> Rob, Marc, Do you agree?

I think you are right. If we look at the 'interrupts-extended' path,
it just calls of_parse_phandle_with_args() which does a get.

> Jean,
>
> If they agree, can you please fix of_irq_parse_one() and add a
> of_node_put() to existing callers (if they aren't already doing a
> put()).

I think it is not that simple. The correct thing for callers may also
be to hold the ref. We wouldn't want to just blindly do a put that is
clearly wrong just to keep current behavior. But not having the put
means we're leaking refcounts as calling the APIs originally had no
side effect. For example, IIRC, of_irq_get() is called again on each
deferred probe. There is no of_irq_put() because Linux IRQ numbers
aren't (or weren't?) refcounted.

Really, I'd like to get rid of exposing of_irq_parse_one() in the first pla=
ce.

Rob
