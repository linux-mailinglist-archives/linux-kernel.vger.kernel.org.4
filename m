Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A8D6DE5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDKUup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDKUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:50:43 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82654212
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:50:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54c17fa9ae8so280847277b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681246242; x=1683838242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90ZS3RARJn1pbosQkkwGD6uVjXJlR/yMXJuGr/i+428=;
        b=F3u8l12T7i1wa5vz4VQOIMOj40AUXc6G7TeBT2r7LrKiIp8Cu9GPL4sEEull5USmzY
         cX/NKqrQBX6iI7wQ9rmU00QKhNx9p75nr0/lPefFCjxIMpsnpF0S0IpmP/txPbEH4Mpr
         YPHhYzGH3DNA0b6fXz5g5VexU+gZJ4UggufPqGb5p72KxSPdkYSaZjMY0HOffvbeFaPR
         fCOTCsxWEMiWgJ4Sqs5LWxNV2i9nWrvMU9XHEnv5HBVKSnp4XlSEROJAHwqKNFQRT41l
         g/CcJ+SBx9RNdiFzL6lvdTeR69lzK8ftGE7PNlBoNtHm/whUQtImQFOuQianz6Itu5JJ
         yKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681246242; x=1683838242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90ZS3RARJn1pbosQkkwGD6uVjXJlR/yMXJuGr/i+428=;
        b=VIebDZCzw7/L3EJdT8OvazgxbNqw1M0DeeZcC5F2NK7OjzIYtJBJErYq76gBiX14vH
         gncoWP3taSp6wx5Hi94Lgmt0/61qsm0pbubd8/L9izeqnGs1uiAZZC87Ns/rVQYYRcue
         SnC7oKLknqdLaAXUjT+jA+cSiSRA2DVim5ISPe71Dd+juyBWKgJZ0rgWgKsVtIbZ34QD
         hxJz4sSoTLJHF9y8qExDU4hIMX+f56sAkQ/mJYQaLoPbwgmrjQjP+hnAdj8DoN7kyVDH
         ubh++2Ckm5YH2yjR6VYuTpovbCAJ4HnIiXn9CPSoYaXEfGjX8/41aadKCNfOZpi2dkk4
         dLAw==
X-Gm-Message-State: AAQBX9d/5N4XZ5WIIkHWibMXBQqOGdSesq0rtVftmciaxtL14ZPEsMFq
        +XZuF8eonHnCtp76wEXKMAr8ccV85JLY7+16Zt5Vlw==
X-Google-Smtp-Source: AKy350ZS21K7AikZG9EHCozWg6+zhROxDkhWHtGf+2xSC4asYa679e1dqtlvlD90zpgF6GjEG0JXEw==
X-Received: by 2002:a81:5b89:0:b0:543:1dc1:828b with SMTP id p131-20020a815b89000000b005431dc1828bmr11398781ywb.33.1681246242008;
        Tue, 11 Apr 2023 13:50:42 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id j19-20020a25d213000000b00b7767ca7487sm3886829ybg.36.2023.04.11.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:50:41 -0700 (PDT)
Date:   Tue, 11 Apr 2023 14:36:23 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/2] gpio: 104-dio-48e: Implement struct dio48e_gpio
Message-ID: <ZDWopwozNjFg/9NX@fedora>
References: <cover.1679323449.git.william.gray@linaro.org>
 <ca710d14a710fee44f7911f2a84b6a55570561ee.1679323449.git.william.gray@linaro.org>
 <571b4df1-91ea-481c-9797-842974dfa922@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U8bW8/8WuuNm+L45"
Content-Disposition: inline
In-Reply-To: <571b4df1-91ea-481c-9797-842974dfa922@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U8bW8/8WuuNm+L45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 09:23:55PM +0100, Mark Brown wrote:
> On Mon, Mar 20, 2023 at 10:50:15AM -0400, William Breathitt Gray wrote:
> > A private data structure struct dio48e_gpio is introduced to facilitate
> > passage of the regmap and IRQ mask state for the device to the callback
> > dio48e_handle_mask_sync(). This is in preparation for the removal of the
> > handle_mask_sync() map parameter in a subsequent patch.
>=20
> What's the story with this patch?

Currently dio48e_handle_mask_sync() uses the map argument in its
implementation. Once the map parameter is removed, the current
implementation of dio48e_handle_mask_sync() will no longer build, so we
must adjust the implementation to no longer depend on map.

The reason for this particular patch is to keep the reimplementation of
dio48e_handle_mask_sync() separate so that the handle_mask_sync() map
parameter removal patch is simple. This keeps the git history clear
and allows us to address any possible regressions to 104-dio-48e
separately without affecting the handle_mask_sync() API.

William Breathitt Gray

--U8bW8/8WuuNm+L45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZDWopwAKCRC1SFbKvhIj
K/klAP0RkCm4BErLS4tTTLEWJk3HbRLesstQCvHYBOJikpHA4AD/VLLCn37yeW5D
2v1D9rFD2XkEGF5lvJTWppJl4zQnPgs=
=rYW8
-----END PGP SIGNATURE-----

--U8bW8/8WuuNm+L45--
