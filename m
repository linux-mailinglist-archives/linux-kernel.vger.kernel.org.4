Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C62728C6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbjFIA1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjFIA1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:27:49 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA0E132;
        Thu,  8 Jun 2023 17:27:44 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33b22221da6so5503475ab.1;
        Thu, 08 Jun 2023 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686270464; x=1688862464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Po9Dy9wSvVitTC0WGqOFPWrqIn2b/C1fHPDDyFi+lIY=;
        b=DDzm2sWUh49bSRGtl7BBbKtxFMd/l7wAzJoSBmrRe0cmiXpgDMlr/fcOC0pZnjDAJB
         QW8CJu3jW6VBhCK8hJ4DBb4isx+sO4R1E1ow7nyCH5YdO/9VxPr/6fqPgJ/WoprMVG0n
         Z+ZcuogQM0U94iNa6Q3mbQx6CZpoQuZg4ECUCEn9ZSlOVNTvn03J6t8hr1eyFh4iAFrn
         /94+j4sSFDqtKnK+Nz+Z/h6Pbll7TlgUHpK0DVIRfbiFe//Ev31v9bIXdVrrTPu2H74q
         GJlsMfQYdiYFbqheMVzhsBXWqG6lykOZ7upY/mCTKM3Rwlw7/8E6hv+AllbMWG934lAe
         SVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686270464; x=1688862464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Po9Dy9wSvVitTC0WGqOFPWrqIn2b/C1fHPDDyFi+lIY=;
        b=BHJFUci5cKdrENw91x1iYinyoWt+BLskODJaZ3jIvyJArh+beSSZyUzjZ6rQepns6t
         Nk7y8XezIlUx2goxUyEaKfnbwAgfD7aY+tw2UNUmd7v4riIkTKZJ3Ixuln2zcWUgf3O5
         rTGwN0VxQt9ZUYF+ZK+O2J1GJ7kI+y20FDmiAZbLxGdazs/EfKidmziBUS2m992pSE9U
         Nn2+6agx6KVn/2vBGTVondBAdR2qCWBoL+tn9iPQt0mzZApIx69Nb2SOfpmEyac3n5cu
         7erIt9irS+y69f45YNmkdXjBNOnB4DWgcFJFYl/PGO0D9xkbYUPxtIVLiYN3mOLnISfB
         c2cg==
X-Gm-Message-State: AC+VfDzkU42prsFIli6/LVeHoZxHqNKu7jQKgj2Os8VeWKwL4fd5GjDj
        Vfm4tnDUHB6jHzd7jPC853b6Jv/Nzjo=
X-Google-Smtp-Source: ACHHUZ4SVvYC6WrqxmkcahYuGNedbdY5nBQEAVvsZlnRy3l6EP8YXQFYn06X+EJKTvy4L1IqRreFbA==
X-Received: by 2002:a92:cad1:0:b0:33c:b395:a89d with SMTP id m17-20020a92cad1000000b0033cb395a89dmr169905ilq.14.1686270464113;
        Thu, 08 Jun 2023 17:27:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b0063d47bfcdd5sm1600578pfu.111.2023.06.08.17.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 17:27:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Jun 2023 17:27:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/120] 5.10.183-rc1 review
Message-ID: <c6a21be5-1991-4975-aec9-f4e84f5266be@roeck-us.net>
References: <20230607200900.915613242@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
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

On Wed, Jun 07, 2023 at 10:15:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.183 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 162 pass: 162 fail: 0
Qemu test results:
	total: 485 pass: 485 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
