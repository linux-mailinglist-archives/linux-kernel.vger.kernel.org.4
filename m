Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE4472EFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbjFMXKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbjFMXJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:09:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3319A5;
        Tue, 13 Jun 2023 16:09:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b3be39e666so23724275ad.0;
        Tue, 13 Jun 2023 16:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686697782; x=1689289782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T60JVgCYXCr8Rq9RWZr9/GJaBu6kr4Qnjf8Vn23FBLQ=;
        b=h9BZLBSJ3D7cz1UDCF7vZfnupgsX0r4pN08GaDsEK+skUmlREMs2NDaiK0kBdVLANs
         fe3G7RDSO010gJD+oktEzVxLe5fHgaFReWlE/vTe54lxP+k5xrliPX7kTt0Jj73/AKPW
         6OJC5I0aMK7WX6wWTUKGGeu3FgVldb13DNP4SocCzZWMuXMqVa0Jj+JjIKXPxIkBe2ud
         oaIfxmGaEIp7RinRA/l9Jea70h9vzedr0lqE6ZB5gRV6cWKRMyWm80qqQOGPitEmSs/P
         aE1LF5TfmHuiX+m3f0HhHkLZ3+HGohjNcCu6zzF3zTybrX729thxM5lpJKnbUD5UkRTz
         weKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686697782; x=1689289782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T60JVgCYXCr8Rq9RWZr9/GJaBu6kr4Qnjf8Vn23FBLQ=;
        b=iMfHYzIMMt2fGdaVfXhrYKaMf7Mt7jj47iBd0bGdO8jdFPWnTvmfsl+LVYF1UDomQX
         l4NyEEjn9J/hWrlKWRVQHHQMKvjh7BkY0zrnLjgF7k2cTnebBDu9FH+dQhCpsHZnr7sc
         E0DJ25LcP4k/wfa3VFGV2KLWa/TzgRs8sCbZnXTTBQthYwtsf8SuPokvUuT1oJF6sVL8
         HD5urQJmdEihTCEk1QJgQorhA9iKkSnzYNBR+e4rLWCa0rFPAdMqDuiJGBfZZuhHOtW6
         79NUn70GMPPxIipyhmtlg35Krn+XEnbkb/0Kd95Qje6uFteno1OnJzXJ9508M1ArWeuC
         ueMA==
X-Gm-Message-State: AC+VfDxWUfFInbWcSyL3p0kKpKAh0a1kZdu0WyqPbzNsjiFKS5xf+CvY
        vnnnIY0l7VijQMdLW8ZwZ3I=
X-Google-Smtp-Source: ACHHUZ7G0/kGa0jAJDcr7NcNxq1ggihuhi6U4gzDm+xzjYRc9pOG5OS07ukX1bAtc9YMvqiETN2Pmw==
X-Received: by 2002:a17:903:1ce:b0:1b2:544b:3d54 with SMTP id e14-20020a17090301ce00b001b2544b3d54mr14258756plh.17.1686697782254;
        Tue, 13 Jun 2023 16:09:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k21-20020a170902761500b001b03f208323sm10761715pll.64.2023.06.13.16.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:09:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Jun 2023 16:09:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 00/68] 5.10.184-rc1 review
Message-ID: <08240a68-1ce6-4d58-bd20-9018749c90dd@roeck-us.net>
References: <20230612101658.437327280@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 12:25:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.184 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 485 pass: 485 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
