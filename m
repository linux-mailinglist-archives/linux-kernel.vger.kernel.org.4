Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FD96BDDA7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCQAbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCQAbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:31:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1D68090B;
        Thu, 16 Mar 2023 17:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC9C36215A;
        Fri, 17 Mar 2023 00:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB99C433EF;
        Fri, 17 Mar 2023 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679013076;
        bh=Nhpqn/sIr/rBSfz125kjIVwRa7eO52ZCanweMIXsACs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=t99MJSpQjkHLLinT2SDWYyww8YndV1+LNMc1y6rcb/ITB4wOs/v9wAxspC/xsfoRL
         qowGVw3MIFrIxYU+gSIGNyWvCsTkXhdIuPCONp1/giHLQRYRzuRe/7GrHWTgy4dJCb
         uOjjHdjM8zmVM38MlElxzj9iCr1d1PO9lD9e+zhGV6vjDLhqF9Zz2txeoWEiN0PZ2M
         ffcMrCIbx/D5HvDCNY3l7dibKAgd+ExyGrMM+gG+AWYu2cVZ/SXTmEd4A28m+nln1E
         JJdrgyQe2U3t19uOg21vNe7D6RxgCaaFeBz1nU71rFIeQmpxikB7/HrMncmBZd/k4a
         51g6hP5lmL2bA==
Message-ID: <4a9b2ed78ed80c15bb8089e2fccaf1b3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230316154850.wxwiztump5de3xt4@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-16-u.kleine-koenig@pengutronix.de> <20230316150144.2aap5otmgblj24ty@bogus> <20230316154850.wxwiztump5de3xt4@pengutronix.de>
Subject: Re: [PATCH 15/30] clk: scpi: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Thu, 16 Mar 2023 17:31:14 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-16 08:48:50)
> Hello,
>=20
> [put the clk maintainers in To:]
>=20
> On Thu, Mar 16, 2023 at 03:01:44PM +0000, Sudeep Holla wrote:
> > On Sun, Mar 12, 2023 at 05:14:57PM +0100, Uwe Kleine-K=EF=BF=BDnig wrot=
e:
> > > The .remove() callback for a platform driver returns an int which mak=
es
> > > many driver authors wrongly assume it's possible to do error handling=
 by
> > > returning an error code. However the value returned is (mostly) ignor=
ed
> > > and this typically results in resource leaks. To improve here there i=
s a
> > > quest to make the remove callback return void. In the first step of t=
his
> > > quest all drivers are converted to .remove_new() which already returns
> > > void.
> > >=20
> > > Trivially convert this driver from always returning zero in the remove
> > > callback to the void returning variant.
> > >
> >=20
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >=20
> > Let me know if you want me to pick up instead.
>=20
> Honestly I don't know. I expected that the series is applied completely
> via the clk maintainers, but the samsung patch was already taken
> individually.
>=20
> Michael and Stephen: It would probably be helpful if you shared your
> thoughs about this. For me both options are fine.
>=20

I will pick up whatever isn't picked by SoC maintainers.
