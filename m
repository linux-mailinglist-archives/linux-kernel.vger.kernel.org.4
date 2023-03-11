Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C26B5FC8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCKSbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKSbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:31:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2EC5ADD3;
        Sat, 11 Mar 2023 10:31:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26AA7B80066;
        Sat, 11 Mar 2023 18:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735B2C433EF;
        Sat, 11 Mar 2023 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678559476;
        bh=e3pDlo/dqmywM4HTT3dwrpN6C06Lxci0w3JGSujSUAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JUTa8xjvRiyaDPOB74RGHCfFuJJI5xfQXyhgLf08aEEmydx6I1jRf8An0Vs/sO7/o
         W49foSTyE7XQFoypg76VltOiG06rITAaNbUH4x3SB0ext9JiF5jqXYaaUhhDBH0HuL
         K8sDcvy0Zk4djUJwgJDYNN4cVgITVTfoOY4F3B9pkykk2qt1fPGPGyu7vOcCsiuRWV
         Q+5Kp7ddjG0sEDlOTe9ZT2ZN44jG1um+7OaQA4KkFIAghTkAgh21oDLFslzmDtILdc
         iZj1MuhIwW94akoDdylZaEoKEObq+RRbxZY1eAejowhHTDGRdZz0meKGuqwafhR6YA
         8/wa14MiGoNvA==
Date:   Sat, 11 Mar 2023 18:31:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: dac: ad5755: mark OF related data as maybe
 unused
Message-ID: <20230311183121.577eb52b@jic23-huawei>
In-Reply-To: <68e9c7d9-1087-0454-6122-a88c7339ab3c@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
        <20230311111457.251475-2-krzysztof.kozlowski@linaro.org>
        <20230311122208.059a81cb@jic23-huawei>
        <68e9c7d9-1087-0454-6122-a88c7339ab3c@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 13:25:33 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 11/03/2023 13:22, Jonathan Cameron wrote:
> > On Sat, 11 Mar 2023 12:14:55 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> >> The driver can be compile tested with !CONFIG_OF making certain data
> >> unused (of_device_id is not used for device matching): =20
> >=20
> > It should be used for device matching I think, so I'd rather see
> > it assigned for that purpose than hiding the issue. =20
>=20
> That would require testing and changes. The device matching is via SPI
> table which has device data. Probably adding OF matching would require
> bigger changes to for handling the match data.
>=20
> This was intentional design in this driver, so we are not hiding here
> anything.

I doubt it was intentional. Mostly people do this because the magic
fallbacks to find the spi_device_id entry work.

If we'd noticed at review time it would not have gone in like this.
Note that the spi_match_id() use of_modalias_node() which has stripped the
vendor id off the compatible then matches against the spi_device_id
table.

So it 'should' just work.  Now ideally we'd switch to
spi_get_device_match_data() but that needs more significant changes.
Though simple enough ones that review would be enough.

Just need to use pointers to the ad75755_chip_info_tbl entries
rather than the enum in both the spi id table and the of one - this
avoids the issue with the enum value of 0 counting as a failed match.

>=20
> >=20
> >  =20
> >>
> >>   drivers/iio/dac/ad5755.c:865:34: error: =E2=80=98ad5755_of_match=E2=
=80=99 defined but not used [-Werror=3Dunused-const-variable=3D] =20
>=20
> >  =20
>=20
> Best regards,
> Krzysztof
>=20

