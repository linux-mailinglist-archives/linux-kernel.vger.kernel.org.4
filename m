Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4516F7C15
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjEEEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjEEEvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:51:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3AD124A4;
        Thu,  4 May 2023 21:51:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51b33c72686so835564a12.1;
        Thu, 04 May 2023 21:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683262267; x=1685854267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YooAtw31lGxcIUhMg0BPeeMyIWHgmiQZvQRtd4wuZao=;
        b=dCBYWfDpPELasq2WVOGKy6/gkOf2OC924S1QjMBcH9uHwRkf94RKNmntd2XUdo1BSM
         K7aQSaLiE2IK0D9tst5n9iM/iAsvOiXQihEQZA+DkfgCRSON1COxYD/Ap+7XucWqMTY4
         2S0swD0kDpffBnfJTyumA4a+lNTax/7VTqU18z3cf4ofbLpqPnPKtaO5ENIRSUj16Rum
         3hb4kUxeSRm7rFMXn4Ppd7f51YdidJqTQyHIo9LxdQtdhQUwR84ZNdVgGj3hK/nNBeqy
         Zf0iRqJUQ2uzVHSHSjH+XYbdLjuLQ+92L/tl4BiUJxYnO3F5qOnU8JX/0zQEGKyqiq9f
         AhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683262267; x=1685854267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YooAtw31lGxcIUhMg0BPeeMyIWHgmiQZvQRtd4wuZao=;
        b=DWQfjO3i20i1mdDYR/fvK1uGmdeRhGvOZIsPj6HK5cPOt/fgkj/Chx9a2GHsikVi4H
         JVmcKov9Q4lhXdLykBC+sSz7dZYLnVzlB1HZ4+tc2UioWpkEbUbzQ95k8Tbz2cEdX1Gr
         XF1+f5S4OO/4DjlnFKe2eFqnV7ACs68xUU/2gnZPiZbYUi9rqx8AyFN3wC0M+8yjeUja
         zd2QdF1w9arw0RU5HCsxJVXrX9+hHDBvcXCJWf7HnGcINr3pap9OIY2JDnM0zOkyaiwi
         xEha8WreSXzxf1CQ8pZXBLQeakKCsHFWshWvd8v6NO+RiO5pMQuMc8MSMEluhvozxr+h
         OSaQ==
X-Gm-Message-State: AC+VfDwy8qZ9/0lXgvnH8rjxhNuPVUNKU9+T90WzsMUjwMOH4TTUjSjU
        9Act79kq2c3AOJVBSQkZfsE=
X-Google-Smtp-Source: ACHHUZ4pWwKVZoUBzdsksfoWiCbmgttPdGcK6wDv7QKrRhr+jZ4SPaSB+i6gKkkXkndq7gPQ9VNh/Q==
X-Received: by 2002:a17:902:d491:b0:1ab:26a8:5401 with SMTP id c17-20020a170902d49100b001ab26a85401mr203140plg.31.1683262266824;
        Thu, 04 May 2023 21:51:06 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-25.three.co.id. [180.214.233.25])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902bb8b00b001a6d08eb054sm562502pls.78.2023.05.04.21.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 21:51:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B4586106861; Fri,  5 May 2023 11:51:03 +0700 (WIB)
Date:   Fri, 5 May 2023 11:51:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 07/11] Documentation/hwmon: Revise sysfs interface
 specification
Message-ID: <ZFSLN6KmGgfW4YzE@debian.me>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-8-james@equiv.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="85j7XFAgyxDylWtE"
Content-Disposition: inline
In-Reply-To: <20230504075752.1320967-8-james@equiv.tech>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--85j7XFAgyxDylWtE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 12:57:48AM -0700, James Seo wrote:
> +**RO**    Read-only value.
> +**WO**    Write-only value.
> +**RW**    Read/write value.

Why are the permissions be emphasized?

> +| | ``pwm[1-*]_auto_point[1-*]_pwm``        | **RW** | PWM temperature c=
urve definition    |
> +| | ``pwm[1-*]_auto_point[1-*]_temp``       |        | for chips that as=
sociate trip       |
> +| | ``pwm[1-*]_auto_point[1-*]_temp_hyst``  |        | points with PWM o=
utput channels.    |
> ++-------------------------------------------+--------+------------------=
-------------------+
> +| | ``temp[1-*]_auto_point[1-*]_pwm``       | **RW** | PWM temperature c=
urve definition    |
> +| | ``temp[1-*]_auto_point[1-*]_temp``      |        | for chips that as=
sociate trip       |
> +| | ``temp[1-*]_auto_point[1-*]_temp_hyst`` |        | points with tempe=
rature channels.   |

Dunno if replacing line blocks with bullet lists should improve the semantic
of three sysfs files having the same description.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--85j7XFAgyxDylWtE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFSLNwAKCRD2uYlJVVFO
o/iiAP9iRiM37NSCrYnWxOpiAozg/UqXIm4W8AZVo/2uFptc/gD9Fc/hfDLuhUXw
J0N/LrUM66JwC/CC6kQm8Sd9buz6TgM=
=J291
-----END PGP SIGNATURE-----

--85j7XFAgyxDylWtE--
