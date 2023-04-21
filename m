Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33DD6EA9BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjDUL5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjDUL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:57:08 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B42525C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682078226; x=1713614226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0Ul1SNqBsekJ6dH0ZERjtw8a5XsIF9m8VEQ6n/tquQ=;
  b=o9IXBYecMJBn0g4zd8QlqhIotP0v3fjMMOP+lI8T7rGQZkqracXuhxt4
   Pi+hR2N+Llx2RmNz3JlWsfwQl/5ZtlIvJQjrj6q+9HjTHAjQ/9cP3hvZY
   SSyhOIE29M6GK8kiaEX/WXmr+qXubIMXxZijQXiZXziv6xIYMlRhh9jf1
   bLVSuE+UJDHoLQgv1D4CYLnjCUJZF1QhWiN4SBzRXj+GckwORRwySYxNm
   cKiI28+ESkoeFoeLtnUkP7e7+PUlhf1r84Ag57yOoJZ6G/TERI20zTo+6
   s1ugMGP4JIc+PqkefNtv0h82pOZVvEbnLVwUBaRs2Ym/7NEzCFBw8Xzik
   g==;
X-IronPort-AV: E=Sophos;i="5.99,214,1677538800"; 
   d="scan'208";a="30482480"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 21 Apr 2023 13:57:05 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 21 Apr 2023 13:57:05 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 21 Apr 2023 13:57:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682078225; x=1713614225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0Ul1SNqBsekJ6dH0ZERjtw8a5XsIF9m8VEQ6n/tquQ=;
  b=Zol1ArfWUjik00OLdicVeVkz2Vwt4XvFOUjxEXCQ1DI1AR4WiiyxHRCe
   wa2xq0ZCJaY9JFyJ7WuZvQbtjaALBG0bku96XYPx3e6qVQ886DIPATZ6d
   JNUrpqrgSvihcCP5nX7gpQTxmA25goMIVxt2I0frOUrVUhbAlaEd9NCnv
   WsfLy6WrdVZEbQPSzqlgL+7OJrUhwhZKuNURQWCQtRhexiz/+Zo9FrP0V
   Csn6IzlC9fl9jAgI1zrcGYdmqeOH0FnDaFsVIdes314TC1EgSuz1M225n
   c6On4q+k5Hvqt3ch3nXoBMu6mCU1Q7I5X1egdktyCZL8jkxxek5AmgS2P
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,214,1677538800"; 
   d="scan'208";a="30482477"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Apr 2023 13:57:04 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id C125E280056;
        Fri, 21 Apr 2023 13:57:04 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Date:   Fri, 21 Apr 2023 13:57:01 +0200
Message-ID: <3900361.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <7e44e0e2-b67c-96b4-3e8d-036650180201@kontron.de>
References: <20230310092857.3555187-1-alexander.stein@ew.tq-group.com> <1848012.tdWV9SEqCh@steina-w> <7e44e0e2-b67c-96b4-3e8d-036650180201@kontron.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 13. M=E4rz 2023, 15:38:52 CEST schrieb Frieder Schrempf:
> On 13.03.23 15:21, Alexander Stein wrote:
> > Hi Frieder,
> >=20
> > thanks for your comments.
> >=20
> > Am Montag, 13. M=E4rz 2023, 14:46:08 CET schrieb Frieder Schrempf:
> >> On 10.03.23 10:28, Alexander Stein wrote:
> >>> This fixes a copy & paste error.
> >>=20
> >> I would mention here, that this doesn't contain any functional changes
> >> as BUCK1_ENMODE_MASK is equal to BUCK2_ENMODE_MASK.
> >=20
> > That's a good idea.
> >=20
> >>> Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
> >>> Originally-from: Robin Gong <yibin.gong@nxp.com>
> >>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> >>> ---
> >>> This diff is extracted from a downstream commit authored by Robin Gon=
g.
> >>> I'm not sure if adding Originally-from: is enough here or I do have to
> >>> change From: as well.
> >>=20
> >> I never heard of "Originally-from:". Does this tag exist? Is it
> >> documented somewhere?
> >=20
> > Well, it's not documented, but it pops up occasionally in some commits,
> > e.g. 3fb906e7fabbb ("cgroup/cpuset: Don't filter offline CPUs in
> > cpuset_cpus_allowed() for top cpuset tasks")
> > I might be something only some maintainers accept though.
> >=20
> >> I think that your tooling (git format-patch) should add a From: tag
> >> automatically if you correctly pick up a patch from someone else.
> >=20
> > Well, it's not exactly cherry-picked, but extracted from an existing
> > commit
> > [1], so that's maybe why my name has been put into From: while extracti=
ng.
> > As the diff in this patch is not exactly the same as from the origin, I
> > did
> > not want to put Robin Gong into Signed-off-by. And I think having an
> > author in From: but not in Signed-off-by: tag should not happen.
> > Searching how I can still give credit I found Originally-from. If there=
 is
> > a better way to handle this, I'm ready to adapt to that.
>=20
> Ok, good question. I currently have a similar case somewhere else and
> I'm also not really sure how to handle it properly. I don't think we are
> ever allowed to add a Signed-off-by tag for someone else.
> Maybe "Originally-from" is correct for this case but I never really like
> to use tags that aren't generally accepted or documented somewhere.

Could some of the maintainers make a call here, how to address the original=
=20
author where the change is taken from? Note: It is not cherry-picked, but o=
nly=20
some hunks are taken.
Thanks

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


