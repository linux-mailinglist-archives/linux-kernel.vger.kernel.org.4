Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916172F5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbjFNHPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243362AbjFNHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:15:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5A1BD3;
        Wed, 14 Jun 2023 00:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80215631CA;
        Wed, 14 Jun 2023 07:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5F3C433C8;
        Wed, 14 Jun 2023 07:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686726910;
        bh=zyZH42aXqG4T+xIeHbAIIC8FQj3AEHXo9kyg0o/p9e8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nnzy8ag/pdkXgBgjbVHcJy4hzrZXR0VKCwMkligt/B8JjGqsxIhNEySNuakEdxAvN
         R4qJHpGb2VnU/KiGoBwbuiiYNhl//GMviR2ce2zvgMBei0cIW0CtPzabpKCZSuZWz6
         xCeUTlgtosoLBqLlVYMGdr3+WgXfA/Xbk9iF2CeHsF0MksnNJDf3zPXxsD+w0/T5Ro
         qB3tQZdpBCqAd0pK1gxlbYGKLnqoCn8XcXK/Ddw4jn05MT8ik0YpEieyTQVRWvxIim
         vMiUOck+wcJlRPvRjiS0ex0VqktJoqBXU3brUJffUD2AstZSZheFWiM0vH+Jo8UfbW
         gkW0adBweJ33Q==
Date:   Wed, 14 Jun 2023 08:15:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Markus Burri <markus.burri@mt.com>, linux-kernel@vger.kernel.org,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1] iio: ado: ad7192: Add error check and more debug log
Message-ID: <20230614081510.63602edd@jic23-huawei>
In-Reply-To: <0ee291f54c38b9c88c9fd5bac15f7421663c7276.camel@gmail.com>
References: <20230613054250.472897-1-markus.burri@mt.com>
        <b38cb68185b078fe346727b6dceb17967a56c18a.camel@gmail.com>
        <0ee291f54c38b9c88c9fd5bac15f7421663c7276.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 10:46:30 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2023-06-13 at 10:19 +0200, Nuno S=C3=A1 wrote:
> > On Tue, 2023-06-13 at 07:42 +0200, Markus Burri wrote: =20
> > > Print read and expected device ID as debug warning.
> > > Add error check for ad_sd_init() result.
> > >=20
> > > Signed-off-by: Markus Burri <markus.burri@mt.com>
> > > --- =20
> >=20
> > You have unrelated changes but they are easy enough to go in same patch
> > (at least for me). Hence:
> >  =20
>=20
> Actually, consider my tag valid after fixing the typo you have in the com=
mit
> message...
>=20
This is also v2...  So patch title should reflect that.
(well v3 for next version with the typo fixed)


> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >=20
> >  =20
>=20

