Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8632273B719
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjFWMYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFWMYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4606483;
        Fri, 23 Jun 2023 05:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95ECD61A43;
        Fri, 23 Jun 2023 12:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB5DC433C9;
        Fri, 23 Jun 2023 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687523082;
        bh=9QiOf6qH4XnQzo7TTnAIieZs1DEpVgYd0lypn1ely/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSha6iZzPSfi13u534mCB7gH52LyolCeBRYwXLX8GscGHt37xr8ihXJRO6HQ3rFBx
         xLYuq5sSD948PvTEHqTi/FSfTf20uLepazpxKnkKuCXKw9J999Pv4gl3GnrbSQoFaE
         CuJ7aliSeSxNFqqk16S9Qc9uogdfyBWFM+QwXn/0qlrF5BtGqHV0XEdZVsJ9DTGD30
         wS1jLrZWyMatcxGUr7McOixUFIPlT0ERuAM6vTTacnDxmoZpCxGczH5KKTQRxmwUEV
         YBrFM6OgyKkhUCum2ZpQR7H+chapbSx93+gfk+4OlIvmVMxqJ2vu9etMWtjJLVRy2m
         tq5qrm6t1eLzA==
Date:   Fri, 23 Jun 2023 14:24:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230623-baldigen-eisstadion-38bd00a856fb@brauner>
References: <PH0PR11MB51262F07CD4739BDCB920483D322A@PH0PR11MB5126.namprd11.prod.outlook.com>
 <CAJqdLrpFcga4n7wxBhsFqPQiN8PKFVr6U10fKcJ9W7AcZn+o6Q@mail.gmail.com>
 <CAJqdLrrVfQx4fWJjpf0Nz7AdiNshdFi7xgXis_iO1jgU0YeGXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJqdLrrVfQx4fWJjpf0Nz7AdiNshdFi7xgXis_iO1jgU0YeGXw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:23:57AM +0200, Alexander Mikhalitsyn wrote:
> On Fri, Jun 23, 2023 at 10:34 AM Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > On Fri, Jun 23, 2023 at 12:28 AM Von Dentz, Luiz
> > <luiz.von.dentz@intel.com> wrote:
> > >
> > > Hi Stephen, Alexander,
> >
> > Dear friends,
> >
> > >
> > > Looks like we have a similar problem as to:
> > >
> > > https://lore.kernel.org/lkml/20230524081933.44dc8bea@kernel.org/
> > >
> > > That said for unix socket it was decided to not allow it to be build as module, which is something I don't think we are willing to do for bluetooth, so we have to find a way to get around pidfd_prepare, which seems to be called due to the use of scm_recv (it is also used by netlink btw).
> >
> > Ugh, yep. That's bad and we can't workaround it like we did for unix sockets.
> >
> > Originally, Christian had objections against exporting the
> > pidfd_prepare function [1]
> >
> > [1] https://lore.kernel.org/all/20230523-flechten-ortsschild-e5724ecc4ed0@brauner/
> >
> > +cc Christian
> 
> Idea. (-: We can introduce a new function like "scm_recv_light" that

Seems fine to me.
