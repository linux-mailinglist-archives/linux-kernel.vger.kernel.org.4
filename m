Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBBA5F6D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiJFRor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiJFRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:44:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B24B60C5;
        Thu,  6 Oct 2022 10:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0AE9B82115;
        Thu,  6 Oct 2022 17:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF72FC433B5;
        Thu,  6 Oct 2022 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665078273;
        bh=zpqNAiwFSOY6Evw5L8ftuPcfBHRM9za7gVzE2v8ixC4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QeUg4qMkAokW7hfVofJWsDlBURLfY4KSwjfn/VnHewKA/KF3i3hwBsUjYW2wPKlFV
         MzrhA1/xM90wX/UXoEmxdCWmd4wGVEldCV+tVS+h7lExQdoEkedJ0vwbDJdO0VtAad
         46yQEtxIKY1tkuVHpR6gyYt91uj7gKIBq6WQLNsexQT5imwoDKed60ADqDd+p1VKfF
         OIFkqPzxQnNh8qXFiJD+WU4X6QgdnadcyXEWvyuXtCvcQyk4/ksQqt6+UVWZfnbyft
         QSXhjmsqV3ZSl6RfVm0RfkT4em6v8BVVfmTiA4s2RQmnePsHFQfOhqMUi717vyPv6M
         5CCe8GrmrbN0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABgxDo+v1PHbgFwyyTFkT2WtxBUBO+Ygi9ncS0oNQzzxHAO7Ew@mail.gmail.com>
References: <20221005085305.42075-1-romain.perier@gmail.com> <20221005085305.42075-2-romain.perier@gmail.com> <20221005230214.1A24CC433C1@smtp.kernel.org> <CABgxDo+v1PHbgFwyyTFkT2WtxBUBO+Ygi9ncS0oNQzzxHAO7Ew@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 1/1] clk: mstar: msc313 cpupll clk driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
To:     Romain Perier <romain.perier@gmail.com>
Date:   Thu, 06 Oct 2022 10:44:31 -0700
User-Agent: alot/0.10
Message-Id: <20221006174433.AF72FC433B5@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Romain Perier (2022-10-05 23:58:32)
> Le jeu. 6 oct. 2022 =C3=A0 01:02, Stephen Boyd <sboyd@kernel.org> a =C3=
=A9crit :
> >
> > Quoting Romain Perier (2022-10-05 01:53:05)
> > > From: Daniel Palmer <daniel@0x0f.com>
> > >
> > > Add a driver for the CPU pll/ARM pll/MIPS pll that is present
> > > in MStar SoCs.
> > >
> > > Currently there is no documentation for this block so it's possible
> > > this driver isn't entirely correct.
> > >
> > > Only tested on the version of this IP in the MStar/SigmaStar
> > > ARMv7 SoCs.
> > >
> > > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > > Co-developed-by: Willy Tarreau <w@1wt.eu>
> > > Signed-off-by: Willy Tarreau <w@1wt.eu>
> >
> > Missing Signed-off-by Romain.
>=20
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
>=20
>=20
> It is okay, like this ?
>=20

Yes, please resend with that tag.
