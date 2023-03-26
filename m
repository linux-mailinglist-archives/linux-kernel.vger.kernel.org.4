Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977DC6C97F9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 23:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCZVNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 17:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCZVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 17:13:23 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30D95259
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 14:13:22 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-545ce8e77fcso58894867b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679865201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8F1bPVXXV4xIf8rTIiWOuXJZOQOnAzCoZb2gtyfVG1k=;
        b=eEi4mN1ifGfJY7+0b8y3SZsLIF0xWt00MBSvDklScSp9b9wk1ykG7b++GPCC1KHF14
         RQViyq9mhox8y2tzT/vu09qYj16Cbm1C4XOQMmUjDyaBBsKZVvHSTGvMsqYI5bRFWLyv
         LUQcyry4IlnAITJ5J4Sc4qs0sLlAI6ztv3zcp8RDx473feeFdLQ2sIZ0jWk5hsheYKXE
         sPU4OwgJZhkAjJ7s1ESL4crUdpKPg27aKxstqvv2/UAFifWkICu84WhqL3mAyhbpRd+g
         pOTVvNjEOvNbnHeVj+2xZv840wJyy3Hd8dOs7AYMm5TdhK2IYDTfQMdYoAyQNQ2CU+03
         SXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679865201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F1bPVXXV4xIf8rTIiWOuXJZOQOnAzCoZb2gtyfVG1k=;
        b=WnBTaVkgWRWOccHVU7pl56VGfxv8WbjAcqbwojsDtNFCXCl9Cn3VrTMJvl+/y5Jjd9
         YB8yMZhjH3WEvZpA59r0XbG3fXaQlAMY9p7uz0Y0BfwT/hrLf/Qk4j2wc7z/nZ2iZqvM
         rpTxWSqJ++7zL5EdWqcjxsOIKPRCKlGZjKtWIXi5ZbEEJRfNuqWl4hSmlYBpQyh5FRvP
         OmF3DLFZsPR6Jbky23OWQt7m/XeQRTohiFLZaS4wCplBlETE/7q3I6TqbeRaF9UV/VKy
         7sZkHblNt8zJTT4KNC7ZEwegFCF25ULDjh5UFrILdpMHpaE2RKTnkZfRTvJHc+Fdsy6X
         wFkw==
X-Gm-Message-State: AAQBX9d5bd7eCrNznVSioeojNDUGV+0ubnfb9Q2UTmDVAQtDJYRlmvO5
        /zSjl9WqV6IXC0DlxHRILekMXg==
X-Google-Smtp-Source: AKy350ZUklvuXpG/TVmgpH3Zi3KwYxjqvrRWLvfNvJS030p6UApvbjN5NVOirP1Z8b+o5CKWs0wq7A==
X-Received: by 2002:a81:d348:0:b0:539:4475:ff64 with SMTP id d8-20020a81d348000000b005394475ff64mr10144773ywl.40.1679865201591;
        Sun, 26 Mar 2023 14:13:21 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id dc8-20020a05690c0f0800b00545a08184besm1640929ywb.78.2023.03.26.14.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 14:13:20 -0700 (PDT)
Date:   Sun, 26 Mar 2023 17:13:18 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] iio: addac: stx104: Migrate to the regmap API
Message-ID: <ZCC1bhdHymSBMQOX@fedora>
References: <20230324030916.396569-1-william.gray@linaro.org>
 <20230326164920.1e4575f9@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1hFa8m5aSKcaoSMl"
Content-Disposition: inline
In-Reply-To: <20230326164920.1e4575f9@jic23-huawei>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1hFa8m5aSKcaoSMl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 26, 2023 at 04:49:20PM +0100, Jonathan Cameron wrote:
> On Thu, 23 Mar 2023 23:09:16 -0400
> William Breathitt Gray <william.gray@linaro.org> wrote:
>=20
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver.
> >=20
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> I would have preferred slightly if you had avoided reording the probe
> (previously gpio chip was registered before iio device and now it is afte=
r)
> but it make no real difference so I'm not that bothered.
>=20
> A few other minor comments. Biggest one being that the defines should be
> prefixed.
>=20
> Thanks,
>=20
> Jonathan

Hi Jonathan,

I'll be submitting a v3 soon addressing your comments as well as some
minor fixes to v2; I'll make the regmap_read_poll_timeout() change as a
follow-up patch as suggested.

Regarding the GPIO code reordering in the probe, I decided to move it
after the iio device registration so that all the IIO-related code is
grouped together and finished before we deal with GPIO-related stuff.
Given that all the original gpio chip code is removed anyway in this
patch, I figure this is a minor enough cleanup to perform here. If you
aren't too strongly opposed to this change I'll keep it in v3 as it
avoids the hassle of creating a separate patch for such a trivial
change.

William Breathitt Gray

--1hFa8m5aSKcaoSMl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZCC1bgAKCRC1SFbKvhIj
K3gKAP4im9weEqAgUf5gXPQ5DqmrLHtP+vf1hUdjwMTWuLxulwD+Nxc7CxSgYBky
olZG9H8YrFmtmtgBft7xrYp1AoTWWQw=
=8rwi
-----END PGP SIGNATURE-----

--1hFa8m5aSKcaoSMl--
