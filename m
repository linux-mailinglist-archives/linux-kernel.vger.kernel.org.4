Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69E6720BFA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbjFBWef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjFBWed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:34:33 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C88A1A2;
        Fri,  2 Jun 2023 15:34:32 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3982f09df74so2134777b6e.0;
        Fri, 02 Jun 2023 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685745271; x=1688337271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqgmYGczNFZ/NxuK8wUSUG9yqFsVwQYuKEfZ0hxfcuI=;
        b=Pau58WkbrvLUeyPHeliMwhF+v3NSg8tdaG+Vil9evApTw24yHFmLPSaahDwHCSfsPQ
         DPadvrd19GnU3ftpTfTexEQXmRQ7nurdfZOrSgjSNjWRzHRlMWIQS7kiz83rWBYmswg2
         fVx5opTMhbWbKC5I4vGiiXeSsK3wyQeO3CitBiPbOsH3dL/KYwtbkhRAKagU+b+fLAfG
         GgpfBvaCtcsfwxm4iIKmgwEzpqATHCiJvOGrpEjVUYS+cR0dVGUkB6sgv1TYr2tEYQpc
         MBkleYRU+llEQ8SUk/YnU0JALSL1WObhKg6UuoTSg4jc6QEZCEEYfcVnkS6D90BZENES
         yXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685745271; x=1688337271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqgmYGczNFZ/NxuK8wUSUG9yqFsVwQYuKEfZ0hxfcuI=;
        b=DwlgsmfeFkA3fe2U+CFhQHpXwtm6/sVJDnKXoHCnmIbCdc2ehdFiDA/4TN7amWLilY
         8g2W3LUpEg4VSU8eIxzCbQGNzyyM4wl/e4bnAP/dcmZcLjvJmIJLmFWDdyITJzymRZTr
         Tyj8145UKQ+3Wyu8eIDJERKzQBM2J8I8LtMatuwUu3w3uOL9+tx/f/UeapaLVH72Wxor
         3D7K1+32+MuljTIelb+jqkK/JKDK/OZoVcHvHMkHchxfh4V/zzjgLWVo3Z+UAm6hRmW5
         mZ0/b8yI8FEWfBaE7sgDOvylY24cn98eSlGiK8QZOeYElYi3ZsqH+M3aioUop+M6S+Op
         fvug==
X-Gm-Message-State: AC+VfDwokW1w2ExvyMMDZcQpx9+prtmuoSCByCGBj9qKGsVbRZXbanwW
        1kpm42/BAjz8jCAz/wEfdng=
X-Google-Smtp-Source: ACHHUZ4XJbgsdVwI44qv7xOu9RXIrKEn8UqTb1mGi7hqfdPEll6EBUbtwK0kfYR/CLFF6KVUi1ZUgA==
X-Received: by 2002:a05:6808:3a4:b0:398:f84:2862 with SMTP id n4-20020a05680803a400b003980f842862mr1067523oie.52.1685745271635;
        Fri, 02 Jun 2023 15:34:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v6-20020a62a506000000b0065007825f51sm1425344pfm.79.2023.06.02.15.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 15:34:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 2 Jun 2023 15:34:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 00/22] 5.10.182-rc1 review
Message-ID: <6f7030fa-e931-478a-8eca-31208e2d1769@roeck-us.net>
References: <20230601131933.727832920@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601131933.727832920@linuxfoundation.org>
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

On Thu, Jun 01, 2023 at 02:20:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.182 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 485 pass: 485 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
