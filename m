Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7EE6F23A6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjD2HtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjD2HtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:49:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413381BF3;
        Sat, 29 Apr 2023 00:49:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso658126b3a.3;
        Sat, 29 Apr 2023 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682754547; x=1685346547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6pvjzdnd5gnbP4mkYTooIPMSHKs+RTnV2W0N64by8Pw=;
        b=UOETjtlz3CdVYolmMtxD0e1nV9O93OzGGSlMMQ4HKXnk5ksrbCZSM95qpN3PBjlVnj
         i7H2bAOPW8QJzpwuXetkNjl1w6OHbBaT+b87Bcw7SGdbeZ4a9KZP/djdQhWPLBq27NJE
         0FxRD5WOLunZKeHFlQmTpltSODGdAcofplaoeUINEanRSQr2Drbyh0vQc+lVosh+rn1L
         FPcgztbNQuLCzmQ1JaEbBvMqOi0EQTa2Gc88OPFCPEDVXHBNTEj9UxbJs0F4pG/Pq5nZ
         vO57ngeFHd639As3dQhofpmJzHaUhsMkdFHvwJIxk711J1hDbNshHOv1ho3GCRgKv4nW
         pQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682754547; x=1685346547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pvjzdnd5gnbP4mkYTooIPMSHKs+RTnV2W0N64by8Pw=;
        b=PiI8pCrlfHDqQEyJ2Djngz7/8ZSsG964+ceO4HSVjyDCdu4A9l/A9WHvb7NEGbPOYU
         zAZ6ZxW92+GFvxLQfeTMdP/h4dorCtt3/EyWVcwO5LwI0gzidopbBgyScJQwEx12jeVs
         QDy1yXFt8/OAWRt3a4YZu3j1eImvgPtTOiNuWlxQ3RDogtF0lfx5XkP9zUlnz3Tqck+N
         IEqqxrp5AFRzK7etj7Eu0YvRfOEX5mBwygNvbb4fZJgH9CT9q/KHiM2hvOEQAU5ZIY8s
         DiH/wLu5TesaJ+BWg7Tr1Wt9di//pmDepQSqw6ZvI86gxOyeV9fmU3FVXJz3byI24J+l
         GQgA==
X-Gm-Message-State: AC+VfDzc/JII75lqLrwZNBOOe1j1NLkIYOGX6NbkX/Y7rHAlL+PyPKCv
        IOI5rqQyxwM4IcJiu6eDCzs=
X-Google-Smtp-Source: ACHHUZ4FfXYDtx3YiwCcG2AEidoElcs+0BfbQb1bL46mNdL6SKJCzyBq9SZhF0a9fwTUILh63UfeBg==
X-Received: by 2002:a05:6a00:2e91:b0:63b:5496:7b04 with SMTP id fd17-20020a056a002e9100b0063b54967b04mr12072767pfb.9.1682754546733;
        Sat, 29 Apr 2023 00:49:06 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-88.three.co.id. [180.214.233.88])
        by smtp.gmail.com with ESMTPSA id b21-20020a62a115000000b0063b64f1d6e9sm15245795pff.33.2023.04.29.00.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 00:49:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EA1B0104FED; Sat, 29 Apr 2023 14:49:02 +0700 (WIB)
Date:   Sat, 29 Apr 2023 14:49:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 00/15] 6.2.14-rc1 review
Message-ID: <ZEzL7kukPM0FhGjq@debian.me>
References: <20230428112040.137898986@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 01:27:44PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.14 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

Successfully built and installed bindeb-pkgs for my computer (Acer E15,
Intel Core i3 Haswell).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
