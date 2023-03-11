Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E6E6B5FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCKSfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:35:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6FA2B299;
        Sat, 11 Mar 2023 10:35:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E7D60DDD;
        Sat, 11 Mar 2023 18:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA48C433D2;
        Sat, 11 Mar 2023 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678559730;
        bh=Kg/cV10l+I1kuQnlPkLBgAp4BnCsK8rgK3Rclji9aUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J0ey2a3NfTt8OYSrTjkkF5CvbBSZ7kmOPjQssKW1LgItrkqbtzhyimiBgc6yCfwZ9
         tZY/75P2Eq5nS2m+oDLATBnzY0Dk/UgF2/G+wl64GPenOApKgbT9lhNOTKAgt3bpKC
         O2gJ4H0LIFg9Slm2vC/RsHwVhKGWrbLuGF8Ax6GYn4m/Kt/083QPUnX9SRf00RNerT
         hGcSPJNuEIzGqUrh4/LFFIp711k3NrD7J1ums0FxyUULvKYAjqF3P0V6JB1vy7Zu4B
         GUf9Yx7TL8KYyQlIC080t7FMuF3fSBuXQmjWj8fe04WDBYE7+dcP63eywijkjef4Y6
         A39AZW/9ewAgg==
Date:   Sat, 11 Mar 2023 18:35:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: light: max44009: add missing OF device
 matching
Message-ID: <20230311183534.1d0dfd64@jic23-huawei>
In-Reply-To: <8f448bc9-2f2b-77cb-ffe2-895593a6047e@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
        <20230311111457.251475-3-krzysztof.kozlowski@linaro.org>
        <20230311122619.2d8bfaf5@jic23-huawei>
        <8f448bc9-2f2b-77cb-ffe2-895593a6047e@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 13:28:17 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 11/03/2023 13:26, Jonathan Cameron wrote:
> > On Sat, 11 Mar 2023 12:14:56 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> >> The driver currently matches only via i2c_device_id, but also has
> >> of_device_id table:
> >>
> >>   drivers/iio/light/max44009.c:545:34: error: =E2=80=98max44009_of_mat=
ch=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
> >>
> >> Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =20
> >=20
> > Don't use of_match_ptr() unless you are absolutely sure no other firmwa=
re
> > route will make use of the of_match_table.
> >=20
> > In this particular case ACPI using PRP0001 is broken by that macro. =20
>=20
> It's not broken because there was no matching via PRP0001 due to missing
> table.
>=20
> >=20
> > So good to set the of_match_table, but make sure to always set it
> > and hence you don't need the __maybe_unused. =20
>=20
> So you want to add PRP0001? We can, the fix is for different issue, thoug=
h.

There is nothing to add.  You need to do less than you have done in this pa=
tch.
Drop the of_match_ptr() and the __maybe_unused and PRP0001 based matching w=
ill just
work. The PRP0001 path just uses the of_device_id table and needs no
specific support in a driver - it doesn't need an ACPI id table or anything=
 like
that.

It's a long story, but hindsight says that of_match_ptr() should never have
existed as it only serves to stop things working that otherwise work for fr=
ee.

Jonathan


>=20
> Best regards,
> Krzysztof
>=20

