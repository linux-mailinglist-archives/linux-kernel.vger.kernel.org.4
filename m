Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8914266D322
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 00:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjAPX1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 18:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjAPX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:26:41 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E7F44A8;
        Mon, 16 Jan 2023 15:15:56 -0800 (PST)
Date:   Mon, 16 Jan 2023 17:15:45 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1673910954; bh=RLDSTPnPnUMlQ5fscvAGVTKu2geiX04GKJwiLMdAyl4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ooYSJe9e5WrAWeaJVjY7OIpE9IEJyLegP5WD/UQJSxE1RP0YWc/acL+JNH/kzPZRL
         eASG6BegK5Zf5Kf88yRV5pW+ZBe9lUd+1NnF5uke71IP8PbueGKHHt3nqpBmADaSZs
         TkC4X9CPLpuFYSagLN+IcnKpxHcAJUPdTFBczuWs=
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Amy Parker <apark0006@student.cerritos.edu>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Message-ID: <cad69928-92a2-472a-9ef4-99d3b74c0ab1@t-8ch.de>
In-Reply-To: <CAPOgqxFtH4Ezb1xVm3kOLBnOnQfpbs4==Kpefhaxz4JhOObqOA@mail.gmail.com>
References: <CAPOgqxFva=tOuh1UitCSN38+28q3BNXKq19rEsVNPRzRqKqZ+g@mail.gmail.com> <20230116195357.2jq7q262tongxw52@t-8ch.de> <CAPOgqxFtH4Ezb1xVm3kOLBnOnQfpbs4==Kpefhaxz4JhOObqOA@mail.gmail.com>
Subject: Re: Kernel builds now failing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <cad69928-92a2-472a-9ef4-99d3b74c0ab1@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jan 16, 2023 17:10:34 Amy Parker <apark0006@student.cerritos.edu>:

> On Mon, Jan 16, 2023 at 11:54 AM Thomas Wei=C3=9Fschuh <linux@weissschuh.=
net> wrote:
>> I expect this to be due to a change in make 4.4 that ignores SIGPIPEs [0=
].
>> So programs called from make will not receive a SIGPIPE when writing to
>> a closed pipe but instead an EPIPE write error.
>> `find` does not seem to handle this.

> Thank you so much for the clarification! I've also seen reports of
> other tools not handling it (such as `yes').

Even bash os affected.

>> This behavior in make is new and I can't find a reasoning for it.
>> It also breaks other softwares builds.
>
> Are you aware of active discussion regarding this on Savannah, or
> should I go and report the effects there?

I got a pointer to the discussion after my first mail:
https://savannah.gnu.org/bugs/index.php?63307

It will be fixed in 4.4.1, testing the linked prerelease version would be g=
ood.

>> For now you can disable CONFIG_IKHEADERS and the build should work
>> again.
>
> Alright, thanks. Did that, and re-ran my kernel build (allmodconfig).
> All works now.

Nice.

>> [0] make 4.4 was packaged for ArchLinux on 5th of January, so it would
>> fit the timeline.
>
> Yep, running Make 4.4.

Maybe it makes sense to ask for a backport for the fix for the ArchLinux pa=
ckage.
