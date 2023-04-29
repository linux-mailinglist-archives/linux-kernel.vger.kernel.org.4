Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278A06F239D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjD2HjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjD2HjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:39:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CB1FD9;
        Sat, 29 Apr 2023 00:39:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso581977b3a.2;
        Sat, 29 Apr 2023 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682753959; x=1685345959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GUn26TT+6QE4fhjQ462vLKoPFS6oTcj9n424rZaXnJQ=;
        b=m56y7+Ec0+XazAzTeGsnazVsGopYM8N2L/BhWOsolOQ95/zomtu1iSzHTHOsDiP0pZ
         axWWMjusFCak7GeN26RyJLT3mq7oHqdZwDgeAXLquD8pJFTQhlYlam8J/7KIWix5XRxK
         uzJ54LvmiHvXdIQXGzhnpNE3Cno1pO5g/n0o/xriVlg4LNl/yIyAs2X0bjuSwgiid9Fh
         Y+OmvaFX/6/RQftL5V1YJz1MMGpDzcEfpcf599+ozYE09sy7FjKxJkXNkOd1fuUMuFc1
         0JzehEKDy21gO2p4MNyCbzPbIQC2YfGoiAP+NoRaZToud0VbPEmKHmcacuVlN/Z9w2C6
         7BDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682753959; x=1685345959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUn26TT+6QE4fhjQ462vLKoPFS6oTcj9n424rZaXnJQ=;
        b=fXDOO9c212gY0E2H37gPoNHEIQAq9F30uXNlH1QiTk0pz5XqsW83rAEz0pS4RvSeyk
         IJ5XVXvlnVjvXe8/y56EDhh6Ja2BV4sCNNUnbHdF0OEhFdRye32FeYZ84KLp96UlouZW
         hnpIsyU2ZG0zpxePuovl4uwrUkOJIEYEZqGMHspPALLq4GobCpQverTWrtdhUGcxEKXA
         MqbgWFQueFPo/6WLBZzEiTeEO/nV3U2L0j/1x917sPofNSZb5vk9M0BOV+pb2oK/DML0
         UXVopePVhUSkImiYjpeW2/MU+5ILM/kwbhTsWwADb5NFwG9iSuMgELj6sJuHJS252v+N
         TSKg==
X-Gm-Message-State: AC+VfDy46hCjwu5J17UmqaicxJNgGMujN9lRHpCDSGeLwt1TQXeXRE7O
        CATTZcqXA8NBTeb9sL1bhvU=
X-Google-Smtp-Source: ACHHUZ5RNocAL/D/4xKZqi5OP/8HjeS5BW/BmbNq6J2b1bTK/Isc8rd8wNwKn/hto9oFdTQWFAy9eg==
X-Received: by 2002:a05:6a00:1347:b0:637:253a:531c with SMTP id k7-20020a056a00134700b00637253a531cmr11474267pfu.27.1682753958948;
        Sat, 29 Apr 2023 00:39:18 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-88.three.co.id. [180.214.233.88])
        by smtp.gmail.com with ESMTPSA id t1-20020a62d141000000b0063b8ce0e860sm16290414pfl.21.2023.04.29.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 00:39:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id ED2C91067DB; Sat, 29 Apr 2023 14:39:12 +0700 (WIB)
Date:   Sat, 29 Apr 2023 14:39:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 00/11] 6.3.1-rc1 review
Message-ID: <ZEzJoOueaYA/kJM9@debian.me>
References: <20230428112039.886496777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:27:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully built and installed bindeb-pkgs for my computer (Acer E15,
Intel Core i3 Haswell).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara
