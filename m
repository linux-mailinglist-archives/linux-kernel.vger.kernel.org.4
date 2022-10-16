Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383AA600119
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJPQMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJPQMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7882E34711;
        Sun, 16 Oct 2022 09:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14F7360BD3;
        Sun, 16 Oct 2022 16:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CB9C433C1;
        Sun, 16 Oct 2022 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665936734;
        bh=iqAp/YHu/glSlr25ZGPThYVBQS5BLf/Zs/N3NVYls8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rk7EssxISGNxKZdccZ7pgEj0QyVenjhMrsu47wjeUqeLUiLMWazeuKxosnMd5D/X1
         OubGbfX+017NS3XHNE5WxFBdHXZOhfM4bbgIp6dheqp8ekW84f2daVIZCCrS5AB0it
         aFxqWNYDOwaRNAW/6ZlAEzweD2bfUk1RFyEvLxLu1i5KZCp+WNfSFCOVSoAdFpx87U
         XAxtKo4rvLtFq9z7mqCHcZWSMySR8DXZHTOG0LDn2QyxH2vjauDxmN4XqYMRFEMuSN
         +PHxXT9Nn7MV5vxqoBwOXP8trM3VbWTU0G0xXscigCHK1PbqgxEvnv39BUtCV/465/
         z9588jgH+63Mg==
Date:   Sun, 16 Oct 2022 17:12:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/14] iio: ad7476: simplify using
 devm_regulator_get_enable()
Message-ID: <20221016171243.415bed2f@jic23-huawei>
In-Reply-To: <SN4PR03MB6784256C4BFB84607498376799799@SN4PR03MB6784.namprd03.prod.outlook.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <33070d66b9b976acac1cee5570facef9278b6b61.1660934107.git.mazziesaccount@gmail.com>
        <SN4PR03MB6784256C4BFB84607498376799799@SN4PR03MB6784.namprd03.prod.outlook.com>
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

On Tue, 30 Aug 2022 11:44:28 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Matti Vaittinen <mazziesaccount@gmail.com>
> > Sent: Friday, August 19, 2022 9:20 PM
> > To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> > <matti.vaittinen@fi.rohmeurope.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Jonathan Cameron
> > <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH v3 10/14] iio: ad7476: simplify using
> > devm_regulator_get_enable()
> >=20
> > [External]
> >=20
> > Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> > add_action_or_reset(regulator_disable)' and use the
> > devm_regulator_get_enable()
> >=20
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >=20
> > --- =20
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Applied
