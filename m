Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B9C6E0F24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjDMNrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDMNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:47:45 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4269893
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:47:35 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 87D784DD;
        Thu, 13 Apr 2023 15:47:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681393650;
        bh=s04G4XxuMWQ+nKEOhb1ZLXuy6Yj1apumxlkBVsf+Zgg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vnReRED59+a6gaEZLFwX4WNVoUw7qeQVwzgi4QlweSZFTQsNz3ja9gx1BRPAWotlw
         3LW/rWly3bwiUfecthEqcEZNMa6hEdLVE4ONK9WbJS9aLcNnEnAkcddjpO+vFlxTQ9
         WBghqnHeJ6OU0SM+xCav2cx9h+sh6R4Vg3vqsovc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aed50785-3eaf-3e5c-d208-5e5ccbc51096@samsung.com>
References: <CGME20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b@eucas1p2.samsung.com> <20230412202516.1027149-1-p.raghav@samsung.com> <ZDdSd8iB2n6r/ccB@bombadil.infradead.org> <aed50785-3eaf-3e5c-d208-5e5ccbc51096@samsung.com>
Subject: Re: [PATCH v2] scripts/gdb: use mem instead of core_layout to get the module address
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, song@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Date:   Thu, 13 Apr 2023 14:47:30 +0100
Message-ID: <168139365042.2373830.5173244303178460397@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pankaj Raghav (2023-04-13 08:44:38)
> On 2023-04-13 02:53, Luis Chamberlain wrote:
> > On Wed, Apr 12, 2023 at 10:25:18PM +0200, Pankaj Raghav wrote:
> >> commit ac3b43283923 ("module: replace module_layout with module_memory=
")
> >> changed the struct module data structure from module_layout to
> >> module_memory. The core_layout member which is used while loading
> >> modules are not available anymore leading to the following error while
> >> running gdb:
> >>
> >> (gdb) lx-symbols
> >> loading vmlinux
> >> Python Exception <class 'gdb.error'>: There is no member named core_la=
yout.
> >> Error occurred in Python: There is no member named core_layout.
> >>
> >> Replace core_layout with its new counterpart mem[MOD_TEXT].
> >>
> >> Fixes: ac3b43283923 ("module: replace module_layout with module_memory=
")
> >> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> >> ---
> >>  scripts/gdb/linux/constants.py.in | 3 +++
> >>  scripts/gdb/linux/modules.py      | 4 ++--
> >>  scripts/gdb/linux/symbols.py      | 4 ++--
> >>  3 files changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/con=
stants.py.in
> >> index 36fd2b145853..471300ba176c 100644
> >> --- a/scripts/gdb/linux/constants.py.in
> >> +++ b/scripts/gdb/linux/constants.py.in
> >> @@ -62,6 +62,9 @@ LX_GDBPARSED(hrtimer_resolution)
> >>  LX_GDBPARSED(IRQD_LEVEL)
> >>  LX_GDBPARSED(IRQ_HIDDEN)
> >> =20
> >> +/* linux/module.h */
> >> +LX_GDBPARSED(MOD_TEXT)
> >=20
> > Should we just fill in the rest of the other sections too while at it?
> >=20
>=20
> I don't see them used in the scripts. Maybe we can add them when needed?

I think there's a runtime-cost to getting these constants, as we
interogate GDB to get the values.

Because of that, I think values should only be added when required,
unless the python code is only lazy-evaluating these.

--
Kieran
