Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E189744634
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGAD1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGAD0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:26:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D27C3;
        Fri, 30 Jun 2023 19:52:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b80f2e6c17so19533035ad.0;
        Fri, 30 Jun 2023 19:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688179929; x=1690771929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZrQKm7bBhs1JNxT56rA5/OMhAsHxnnLLFgOEAX9YEY=;
        b=j7buJZI1tllQElQ7lW82B6r/q3aELO4o3bXeTMfvCLmBUClZF11He8U+HP7t3NWIpQ
         Dzp15vxvhsmW/VvG5S7iw+DUjtZRaFOI7E4hqs2LbeMhMqi1vmzd7febyh1nAs0Dt5jA
         bj9FVHTlm6Je3sP09cY79j2Lb6tjvy7Shh+v/q0g706+3Amc16SPhdUvC8sIDe/HNQZ+
         AsADPLzIPna2TDjOKHxMOxbIQeltFBz2p8vwKQXaicY67c0DgD7aSnokTULgwFKKIUb4
         06tZdUVnEvRojoZ6S88RrSIeavGKPdPLxkpEJwGqW7AH2e8Tkk/cfB3sRDlx38GIaKkw
         qivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688179929; x=1690771929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZrQKm7bBhs1JNxT56rA5/OMhAsHxnnLLFgOEAX9YEY=;
        b=ihGnFZeOUeYAvxeLiT9gFxC/WuxISz2tLHx9Wgg2NHL7t/NMF5ksAPN+LkiLLpGXjI
         pi/kh2IifJ7dBkWcHBydWt+/0HYUQmbQoGWZnfqKGbv/45fximIk5Sg4uqoIy3ksUhGC
         rEoAu6P4WOzP3u+2ctXizOolaACwdSG8DhabTt9tnAtUn2BSELK8Q6k1K6UD91Sw/7F9
         FMIE+wNPpfuoYWVNvtbiP+hN5JtJQOwV/lVCgEXv5aalur7scPRw1XigAK0M8fYGuDmU
         Fd7Ll+6DBQ2JF5aSl9W1KY6THflxKwAJuygSzf0UqDiknFFHQe0NcuR8q9ClhPTCW3jE
         0OFw==
X-Gm-Message-State: ABy/qLYA8zvWz9sRjwQqOlfXZeAhr4+X5OkWNcsn2hvsAaJ8bnVSOjEu
        SPsrj3Zl37jPVkQNjT8KQuI=
X-Google-Smtp-Source: APBJJlEnlU5gBGG2cEbXdoOjLSasJyyrzY8KAvqodbohdJ+Naj4Ioy2mmdSY9OxQcJC0QhQYO2QCjA==
X-Received: by 2002:a17:903:1c9:b0:1b7:d23f:8a57 with SMTP id e9-20020a17090301c900b001b7d23f8a57mr4520822plh.24.1688179929366;
        Fri, 30 Jun 2023 19:52:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902bd8100b001b540e334b0sm11334997pls.298.2023.06.30.19.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 19:52:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Jun 2023 19:52:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.3 00/32] 6.3.11-rc4 review
Message-ID: <f75e9488-c88e-4a83-bff6-ba2c0058432e@roeck-us.net>
References: <20230630072120.689306958@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630072120.689306958@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:33:36AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.11 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Jul 2023 07:21:08 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 520 pass: 519 fail: 1
Failed tests:
	xtensa:de212:kc705-nommu:nommu_kc705_defconfig

Guenter
