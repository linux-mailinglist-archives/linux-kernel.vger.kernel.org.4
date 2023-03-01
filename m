Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE276A76FA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCAWph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCAWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:45:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6111C32524;
        Wed,  1 Mar 2023 14:45:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6966CE1E60;
        Wed,  1 Mar 2023 22:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C56AC433D2;
        Wed,  1 Mar 2023 22:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677710715;
        bh=3mXPGGvNPE55M7kc8dODyu5KJeDpvTT9zpBKLudWDK4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Wbv6I/PETUmB4uYc3XdiyHS9xeDU+JQk+SdjgD5UqmLgrr4k+aip74Wpuhr9GMn2b
         ZaODJsSP4EVOJCNerefdx0zQk0zAYzq/fT4sLUjbLUzzMAsPAUyOto6G0MDGlio5tJ
         H1F/8O1V15WUaeyJJjWsa9SKcjcy9ByXFlHFp6A4O0TtITb2x3v4U/UgDSI5PUH5f8
         czbqxjTFQVerwpno4JdiqJMsOPHKNd/hDANokp1hVXP7kfqiqGpdlETLyJs20UqOW4
         qFOqq+83c3TA6jq3qw0yC5lHKPQHW2kPCa94F2F61/xEdjDHWRzeiQF5YzjzEigL7f
         CGNiPXRoMRsTg==
Message-ID: <a3bde7aa1793c20638cbf2749f3209a2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGETcx82r-YC7cBUY5xa57FCEOUP_BeGNp2zURG=HUJkUMSVPA@mail.gmail.com>
References: <20230301012506.1401883-1-saravanak@google.com> <31ae9957edf319416d4551f14eba2071.sboyd@kernel.org> <7cca9a24b24d849565cd6a4f40ddbee9.sboyd@kernel.org> <CAGETcx82r-YC7cBUY5xa57FCEOUP_BeGNp2zURG=HUJkUMSVPA@mail.gmail.com>
Subject: Re: [PATCH v1] clk: Mark a fwnode as initialized when using CLK_OF_DECLARE* macros
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Saravana Kannan <saravanak@google.com>
Date:   Wed, 01 Mar 2023 14:45:12 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2023-03-01 13:25:13)
> On Wed, Mar 1, 2023 at 12:48=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > Quoting Stephen Boyd (2023-03-01 12:40:03)
> > > Quoting Saravana Kannan (2023-02-28 17:25:06)
> > > > The CLK_OF_DECLARE macros sometimes prevent the creation of struct
> > > > devices for the device node being handled. It does this by
> > > > setting/clearing OF_POPULATED flag. This can block the probing of s=
ome
> > > > devices because fw_devlink will block the consumers of this node ti=
ll a
> > > > struct device is created and probed.
> > >
> > > Why can't you use CLK_OF_DECLARE_DRIVER()?
> >
> > Ah I misunderstood. CLK_OF_DECLARE() _always_ prevents the creation of a
> > struct device for the device node being handled. The 'sometimes' threw
> > me off.
>=20
> The "sometimes" is because dependending on the macro we go back and
> clear the flag.

Ok. Maybe instead of this paragraph you can explain the problem being
fixed, specifically ux500 container node not being marked as
"initialized" and that preventing consumer devices from probing. That
would help the reviewer understand the specific problem you're solving.

>=20
> > >
> > > >
> > > > Set the appropriate fwnode flags when these device nodes are initia=
lized
> > > > by the clock framework and when OF_POPULATED flag is set/cleared. T=
his
> > > > will allow fw_devlink to handle the dependencies correctly.

This is the "what" and not the "why".

> >
> > How is this different from commit 3c9ea42802a1 ("clk: Mark fwnodes when
> > their clock provider is added/removed")? Do you have some user of
> > CLK_OF_DECLARE() that isn't registering an OF clk provider?
>=20
> So it looks like drivers don't always register the same node used for
> CLK_OF_DECLARE() as the clock provider. So, this is covering for the
> case when that's not true.

Please add this information to the commit text. Otherwise the patch
looks entirely unnecessary.

If the node used for CLK_OF_DECLARE() isn't the same as the node as the
clock provider then how are we certain that the CLK_OF_DECLARE() probe
function has actually registered a clk provider?

Should we simply remove the calls to fwnode_dev_initialized() in the OF
clk provider functions and put the call in CLK_OF_DECLARE() (and
specifically _not_ CLK_OF_DECLARE_DRIVER) as this patch does? What about
bindings that are registering clks early with CLK_OF_DECLARE_DRIVER()
and then probing something like a reset controller later with a platform
device created by an MFD matching the same compatible as the
CLK_OF_DECLARE_DRIVER() compatible?
