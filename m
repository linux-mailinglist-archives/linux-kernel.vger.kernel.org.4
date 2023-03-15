Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4465D6BB4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCONfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjCONew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:34:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F121495BCE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:34:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so1006258wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678887273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+IN+0w9H9a4+otP7ZW52d0IIe4ikF35g1Dk7apewm8=;
        b=CFesjd9v5SM0U0dyyqbIZC9h4Equ3ylFSxE7o/FT5L+lkaEVjbswT9OTZhDD/gLnw1
         2d+MZ6H0upkI3TwPRIliYCl1/AFoyPkr7zPjfiY4NcZ3O8Cbib6kkThSyLnVrisEc4SY
         V2CD4RPid+IbFec/1eqzaE40sg1MgKWTOAaDv/TIKKjc1GCNNBmwjniQi59HO/epJ7/W
         n9rMdfQVZ051rxgw6q1uiaH9dwgapJa9gj7zq5TLEcgArPoVkVtRFX6AxudHBPfgjeJ4
         vqsR6DMs9tNmwGyVw/COJzMB7/4IE4nHMCy3Qm7Epty/9zOqbOkafqIQgQlqifFLVGwU
         FbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+IN+0w9H9a4+otP7ZW52d0IIe4ikF35g1Dk7apewm8=;
        b=1Tbes2mJPegQopwr4SJpihpVGYGzlwY6iu8sdkQP0sAaQS3SAkQfh9DYP3Kazf+2pg
         tdo5+Sop6kM2D4R/sAj4XRCp7+NBU5XdQDV0tTDXWN8tphHDhFAIVfddYU1UVw9GkZZY
         +0jfSEw5w2BlOPKigMNYM1jfrzrTmE7MUuR5ynmPzf61+rUyG5yQLMdFOx+z4ebR0R0q
         WDq368Q6ag3CA3Pyt5VVB/dmqm8cPF4gG5u9YvZaW0WDRtZ7mdTJtRUj7aTb1frr2P1k
         voVOw9BqTeUx5LpMqiAwMxdiPsMQ332AgFjGc9ZPHpqVmN41ysfbzCc/F0qzz3wpCduH
         rOUQ==
X-Gm-Message-State: AO0yUKUYLDct8D2DdwH8lS3KZ8J8vJXlp0pNPHWT7rIAWHJ8JM6WATWE
        JrYFC4zaOHGWHr3HNfuNAJE=
X-Google-Smtp-Source: AK7set9Bzw+No5SlaJ+OfOgSKIo8hvzFPztkh8ZEhCQZlhSOh5WiPqg2c86ZkBsFGgyM8rLBSiQ6Fg==
X-Received: by 2002:a05:600c:1e0b:b0:3ea:d610:f059 with SMTP id ay11-20020a05600c1e0b00b003ead610f059mr19596586wmb.4.1678887273092;
        Wed, 15 Mar 2023 06:34:33 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c234100b003e00c453447sm1830725wmq.48.2023.03.15.06.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:34:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Date:   Wed, 15 Mar 2023 14:34:31 +0100
Message-ID: <16148020.1MiD057Pog@suse>
In-Reply-To: <ZBG699SriXWy1I2K@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine> <ZBEJ+8DbhADSBTLr@aschofie-mobl2>
 <ZBG699SriXWy1I2K@khadija-virtual-machine>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=EC 15 marzo 2023 13:32:55 CET Khadija Kamran wrote:
> On Tue, Mar 14, 2023 at 04:57:47PM -0700, Alison Schofield wrote:
> > On Tue, Mar 14, 2023 at 10:31:21PM +0100, Fabio wrote:
> > > On marted=EC 14 marzo 2023 21:43:40 CET Alison Schofield wrote:
> > > > On Mon, Mar 13, 2023 at 11:07:10PM +0500, Khadija Kamran wrote:
> > > > > Module parameter, read_timeout, can only be set at the loading ti=
me.
> > > > > As
> > > > > it can only be modified once, initialize read_timeout once in the
> > > > > probe
> > > > > function.
> > > > > As a result, only use read_timeout as the last argument in
> > > > > wait_event_interruptible_timeout() call.
> > > > >=20
> > > > > Same goes for write_timeout.
> > > > >=20
> > > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > > > ---
> > > >=20
> > > > Looks like this is [PATCH v5] and needs a changelog.
> > >=20
> > > Alison,
> > >=20
> > > In fact, this is only the second patch that addresses Greg's suggested
> > > refactoring.
> > >=20
> > > Khadija moved from v3 of "staging: axis-fifo: remove tabs to align
> > > arguments"
> > > to v4 of this completely independent patch. And then back to v1, beca=
use
> > > (at
> > > the time of v4) I pointed out to her that she had started working on a
> > > project that has a completely different purpose than the previous one.
> > >=20
> > > The best course of action would have been to ask Greg to drop the=20
previous
> > > patches and then reset the numbering of the new job to v1. Unfortunat=
ely=20
I
> > > did not pay attention to how she then managed the numbering following=
 my
> > > observation.
> > >=20
> > > What would be the best course of action at this point?
> >=20
> > My guess is that this patch gets ignored because it has a lower version
> > number than a previous patch.
> >=20
> > Take the feedback given here, and rev to
> > [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
> >=20
> > Be sure the Changelog, below the --- explains the journey.
> >=20
> > Changes in v5:
> >=20
> > Changes in v4:
> >=20
> > Changes in v3:
>=20
> > Changes in v2:
> Hey Alison!
> Based on Nathan's feedback I am trying to recompile and send a patch
> without any warnings.
> As suggested by Fabio, I am running "make w=3D1 -jX" command to see if I
> get any warnings. But it is taking a lot of time, is there any way of
> speeding it up?
> If this doesn't work then I have to follow the steps to reproduce in lkp
> mail as you said before.
> After dealing with these warnings I will send a [PATCH v5], following
> your instructions above.
> Kindly, let me know if I am on the wrong track.
> Thank you!
>=20
> Regards,
> Khadija
>=20
> > > Fabio

Aside from what I said and asked for with the other message of this same=20
thread, please take note that you can build a specific module if you prefer=
=20
not to re-build the whole kernel and other modules at the same time.=20

I'm pretty sure that the instructions to do so are in the OutreachyFirstPat=
ch=20
tutorial.

If they are not there, please let us know.

=46abio



