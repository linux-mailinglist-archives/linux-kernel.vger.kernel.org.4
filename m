Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686C0714DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjE2QEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjE2QEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:04:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB60A3;
        Mon, 29 May 2023 09:04:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53f7bef98b7so1341395a12.3;
        Mon, 29 May 2023 09:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685376285; x=1687968285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZ24ryT4mYFqzQBBEdINLEcykUqRHLK1NE8Vta/D2to=;
        b=fWJLFBfYd4yjXH3TTmPRiGgmMMUqCnmVTMg70Si3uqy1izNF3RloMJTQ2LH5X/kYwv
         ThuDPBJBIGR7eLjMY78xvjvTtlZ3hWYMpHwqSc3PqO3NNfRnd5TMgfkNAKxn+wVwcega
         hy5Y++gRB3zEb5ouNMdfv+WAzKOID6nReqnz0WGP/3ZOePkNI2Snp+GMvCspm9hg1VHz
         /e31FWS7O9q94ACr7T3P7Bgti0tV2CnN3+siohH6cx0CU33rGbjhh8OA6vDmQJajz1bw
         4acqz7uluYR533vOVgPwzNqvoZCfvkNmXYnpTUDcXE8UmzDgdFy5avwU2vP5a9BkHLT0
         1LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376285; x=1687968285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZ24ryT4mYFqzQBBEdINLEcykUqRHLK1NE8Vta/D2to=;
        b=aMkTQGJDsD74XKeuo5rYP4wMCZ3HvJhxkbApZQYcxtuM7wC31sOadgUa+kYlfl1UZ+
         ESvg2JDTOH+I1FjN2jeel2ca2qCvqcmyRfx+cHzK8y0jPSyeZKun1i3If1zOW5Rc3QSe
         K3BLtgd2UlhezU00WCGmOiKmckiyAbLApXw2at9hIARVb2wTMS55GXCFLmb0xkzDGfUZ
         54YCeQ55jLo1jR7rknzxdRUzak3M+cLeQn3MJwpmYJn2NMxk1UzJzTQEUOkCmS8RHhPB
         Hsk4WGIf6n5Ei6hxzzQex+gxV48icOSDyVN9X4vd56bhlLiZt16zr4ywr3H8fHsrSnG/
         3dtQ==
X-Gm-Message-State: AC+VfDz/xfsXBhJfpxhqdD9zcQux7iHxssb9Ja9x4G2QnNoNVqdUKtuk
        ++iF7vsc32BhH370XCK5f8E=
X-Google-Smtp-Source: ACHHUZ5B7cBKll+ivuMK2msk+d8FDPmjto7UtUostiBKxYrOEx7raCK1rnCQ18LbuBIdxk9CYwzOYw==
X-Received: by 2002:a17:903:32ca:b0:1b0:1095:f4f6 with SMTP id i10-20020a17090332ca00b001b01095f4f6mr13824037plr.24.1685376285150;
        Mon, 29 May 2023 09:04:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090282c700b001ac896ff667sm8374969plz.204.2023.05.29.09.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 09:04:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 May 2023 09:04:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 4.14 00/86] 4.14.316-rc1 review
Message-ID: <5198ae0f-1172-4306-88c1-80d162f011d3@roeck-us.net>
References: <20230528190828.564682883@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
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

On Sun, May 28, 2023 at 08:09:34PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.316 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 168 pass: 168 fail: 0
Qemu test results:
	total: 430 pass: 430 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
