Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051B3720BFC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjFBWfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbjFBWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:35:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD6D1BC;
        Fri,  2 Jun 2023 15:35:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6549df4321aso7908b3a.2;
        Fri, 02 Jun 2023 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685745314; x=1688337314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLJK6B/t+AAazpXMbTyXCw5/1FSBnILSO8TGv60LISA=;
        b=X2Y9WRhRev8Mer+bWy4/ZXO+UBVfEXhpIgg4tDk1mymCLoW/95KNZg3BmwPNEfuEnB
         XaDgyiRQqwDmtimavdXYrY10RqtThR3V5lORoFcOp/p9pwlh/W0GZNjLZfMaXKh0KrfL
         YWg3MQtalqplVXoc0GooswVQkQxbjNblNyk/GiNjuGdDCN3Dm+94kB/Z9J8+DrRqU7YC
         8Zy0AQdoBaEKjzzvugXLKO8ytogmyRJ1SG8XDBxn1u1VEgwsx9WvyFcY7sg/Yft7CggO
         DvDzDS6Bzmm+dZTXYjxDrQOnXpQPBIRLoxRQZSlH1El0cVG4EeKOqVIwk+Zud5FGJ4A6
         FVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685745314; x=1688337314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLJK6B/t+AAazpXMbTyXCw5/1FSBnILSO8TGv60LISA=;
        b=O8/ANgDi8h4rQm45KLKPxYES5xW5BSFZ2xMx46yh7qIUeB4QXiQ6bF5ju+00MTTyPU
         rfVSMsJ233OAsC/h0NFOhF5Tu97rFf68huTGTbTY2X87B0Ni4MSvRdaGUQwuWiZDiE9F
         ApXQKDJGDXiuc6+ye62keqka4zVYeai82RcghSJM4UlOMXr2BX9d83asbOqAyP03Z7kG
         zKXurF1NbSxJX7vEEoApWfxzIrtydArzrjWm8glIXJ5QJY+8DV4HH6qbJMnRiomBj0t5
         7NYDB1HoixdWamZ9ldU5oZmspbM2TNsaehGfPyffBThPxo3wALW6dXCzuOj44PYRNKgd
         X+iw==
X-Gm-Message-State: AC+VfDy5yPeqKl5BRyG+QxIIKUX31IJGZcnhdbyQsNKf/C9d+RozNdI8
        tzD13Xy3A+oLmY04znLURK8=
X-Google-Smtp-Source: ACHHUZ69DuAaHeEdVPpsfXXv7jhZr6QdUIa8tsksClAfXzsW/LwuseadU7HpvVOWHIDoOiZiBd/i+w==
X-Received: by 2002:a05:6a20:4293:b0:d5:73ad:87c2 with SMTP id o19-20020a056a20429300b000d573ad87c2mr14415696pzj.56.1685745314173;
        Fri, 02 Jun 2023 15:35:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y5-20020a63ce05000000b005346b9a7fe5sm1723201pgf.22.2023.06.02.15.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 15:35:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 2 Jun 2023 15:35:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
Message-ID: <fb6afe92-efe8-4bd9-86b7-879e2b5cc80c@roeck-us.net>
References: <20230601143331.405588582@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601143331.405588582@linuxfoundation.org>
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

On Thu, Jun 01, 2023 at 03:36:06PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 14:33:22 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 158 fail: 2
Failed builds:
	s390:defconfig
	s390:allmodconfig
Qemu test results:
	total: 499 pass: 494 fail: 5
Failed tests:
	s390:defconfig:nolocktests:smp2:net,default:initrd
	s390:defconfig:nolocktests:smp2:virtio-blk-ccw:net,virtio-net-pci:rootfs
	s390:defconfig:nolocktests:smp2:scsi[virtio-ccw]:net,default:rootfs
	s390:defconfig:nolocktests:virtio-pci:net,virtio-net-pci:rootfs
	s390:defconfig:nolocktests:scsi[virtio-pci]:net,default:rootfs

Failures as already reported by others.

Guenter
