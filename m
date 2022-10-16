Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047D060012E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJPQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJPQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680DA3B720;
        Sun, 16 Oct 2022 09:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0482C60BD3;
        Sun, 16 Oct 2022 16:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A569C433D6;
        Sun, 16 Oct 2022 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665937090;
        bh=m3LYKi4QF1dK67Q9dyFYJl+Pk8h5LwmOPS1K/m5Go2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AfoDb2ACUZLkxtnZxuTmL7m6n6PEteKKxOLixOR9uVs2kf5klsLYen+wmiskV62qk
         B0+55jEuqFFYfkwO2kRiM6oAXG6ml0r6d+3Q/Fhl8b5OVhDm0svn1NM4Xv8vvlLxHw
         33Un2yBal/Uo9GzgrCVvJu444kFGaKNW4ilHajFRBTm2HO102hV8mK5ALXOYv+jNfu
         eN3phi3XCh8F+0a4Ti5liFwxJeSXTfNVOqBFhkrQwZCiHJVPvKfO/6vYW9pIFTR3Ke
         OQGMDRw9rKn0ghzVrtIfWeMU4GYqvWDKiRQ0FeOpLK27vSnMhxUyLmnJ6l8ue3f0ph
         GBamap/sH9/Ng==
Date:   Sun, 16 Oct 2022 17:18:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/14] iio: max1363: simplify using
 devm_regulator_get_enable()
Message-ID: <20221016171838.22669a2a@jic23-huawei>
In-Reply-To: <SN4PR03MB6784244D8746B352AC7F411999799@SN4PR03MB6784.namprd03.prod.outlook.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <1286ea127d190e5708a0aaff271819b2d3f8802d.1660934107.git.mazziesaccount@gmail.com>
        <SN4PR03MB6784244D8746B352AC7F411999799@SN4PR03MB6784.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 11:50:05 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Matti Vaittinen <mazziesaccount@gmail.com>
> > Sent: Friday, August 19, 2022 9:21 PM
> > To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> > <matti.vaittinen@fi.rohmeurope.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>; Matti Vaittinen <mazziesaccount@gmail.com>;
> > Alexandru Ardelean <aardelean@deviqon.com>; linux-
> > iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH v3 13/14] iio: max1363: simplify using
> > devm_regulator_get_enable()
> >=20
> > [External]
> >=20
> > Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> > add_action_or_reset(regulator_disable)' and use the
> > devm_regulator_get_enable() and drop the pointer to the regulator.
> > This simplifies code and makes it less tempting to add manual control
> > for the regulator which is also controlled by devm.
> >=20
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >=20
> > --- =20
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Applied.
