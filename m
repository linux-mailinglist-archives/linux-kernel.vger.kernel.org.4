Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383AE744653
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjGADat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjGAD30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:29:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72D4C0A;
        Fri, 30 Jun 2023 20:04:43 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-557790487feso1676224a12.0;
        Fri, 30 Jun 2023 20:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688180683; x=1690772683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZrQKm7bBhs1JNxT56rA5/OMhAsHxnnLLFgOEAX9YEY=;
        b=mNkw0gyPEJBzXoGXV8ITCeVHKREluoEZIQaHXJSUaviY0PN8caDveTSlGqUQdDJRMh
         azhNOC0gWQaZLgZOE2VNOunkzABbPbo0ey2r4WgbWnzyUCA+WPUQqeWmaY+swEIFQ2zr
         liWd3/K/Gytgn7518CrQxVl6q/zqjoIqC+mwLQs2GRX7atOfT4pfOKbik3dgkg9WK9Ht
         AIsHfOmJmUSMl5LZQmo4QaRFa7I7k1l0+tYA5Cd5Bc2hx+PgTyWkHnGH6u9qlAFNbQUp
         cVCjvXU/PCrnvQvZkd3OgcqV07aYaOkGWSBgD/pIic1OXiQxZURR4iXmPg5Ei3bm9Dh2
         hKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688180683; x=1690772683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZrQKm7bBhs1JNxT56rA5/OMhAsHxnnLLFgOEAX9YEY=;
        b=W7fRrEZj+NmW2TCabrVm5fcij/k30cuUHES3c6pAz4KZ3wIQglwBo5kwXHMK1sJS12
         ogObCwqekxdxaiKWX9P61peSW2kUkbagUW5qVWqP9hRh1vvUNfjRO+Rv20ThykNq1FFB
         K4MqaDwKShrriITxRM9PECDidXfjKoUSH3NzmQk/JgLlrRHvuL01I/ODi3cWYvjCbY+6
         MeZYU80nctiUN54xfsB5VFWMXPSF6/upFaQ+hx7NlasYZP84sTk5Ycqi4yg9gsH81xGb
         IWEVapN1ehFL4sIZRFMXyT4LklBqCke6pI2ybZ1xe2CXAfwc4yoff0hvOJbLEghbBPD5
         M1XA==
X-Gm-Message-State: AC+VfDyF4PC6fbM15ESYRbVBNmaRHHkdQ1C37xkBGdSHSgDMUaPGBHjR
        pHQZdevDSU1dmF6HhZ7WCHiQurBf0i4=
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
