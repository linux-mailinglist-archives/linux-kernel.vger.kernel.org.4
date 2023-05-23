Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F0D70E9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbjEWXyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjEWXyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:54:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD2B119;
        Tue, 23 May 2023 16:54:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a516fb6523so2469865ad.3;
        Tue, 23 May 2023 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684886053; x=1687478053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fGiwkDKraznRyKW1dHr3SPz8az5q9g0yfOqKKZGiTM=;
        b=BY4J4pvnlDk61hWplzCxd0wsPIi3br/wLSkhqcJL1E/z2/biCsoKdTRHLa2zT241j8
         kkX26uAw0cpgy0hFeZvrNDPax3Dkh7GjCZWRD7b9qU7NBtzsVt/rHq8w6Dfhp2D6iZO7
         wRCid1gIgIezxcG0m+gs58MsNDxqUBhmwSkjK+LWHBr8hg/9FdOQ+RpxquqwdH/odGBE
         vvjDN1GmEtHWzIr/Vk5JSdTlnF7IfdbUoq8fFsUM4MqERDsyf7uJzbr7P5wtC/KRQAoM
         tk46BnMenh6WjSakT7sgsmYmgBhlC8w++de9uwYp0vSVWMs7xp0q7vQ42v1YsbCQASlm
         a1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684886053; x=1687478053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fGiwkDKraznRyKW1dHr3SPz8az5q9g0yfOqKKZGiTM=;
        b=FZgGDvPPFxh7gDZwsXo09EXlHMpvELOCHEKC6aL8XjOWtVxII4vu5Rw+XDkzc3587P
         WnDe7S/1aLxWjaDXlVaYjfx8C+RLSpaz1BSibexIaAodFbzLvaEGzoSLAhiNwLezsXVJ
         Fn24jVdE6RzogtM9/orjbTWEoYVZTLmhXupZtTyvnHOGRmvAuHmDFybDYX8iIh1gVY6Y
         sUH4TZbH4vu7Z+AgUQb8aOJGGgIsNDU2ofGUx6NTB3zRdfYMAlZHW6eTo3/yd2kPZEr7
         ZB8l36u9cnx0z4xG1jvAQgj11R9+l6ZL6bbKauX9qKEIbv20zuKkcNxCHMRONzjR9Ryn
         74DQ==
X-Gm-Message-State: AC+VfDz5YYBPsUJi3+X5hvnX/E3P4S4P8fLZZ09BzQ21r26kdasmczTT
        LPTLfiTKnaH3bfVpY7NXJak=
X-Google-Smtp-Source: ACHHUZ4k1k9AaQovyVOjaGE0BCq7wngWO0MDKRy61Xln9RYJpGVHK22N51JxTCeaBzGS/jge7DbL0A==
X-Received: by 2002:a17:902:f2cc:b0:1ac:72ff:9853 with SMTP id h12-20020a170902f2cc00b001ac72ff9853mr12610289plc.30.1684886053134;
        Tue, 23 May 2023 16:54:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902714800b001acacff3a70sm7399525plm.125.2023.05.23.16.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 16:54:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 May 2023 16:54:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/292] 6.1.30-rc1 review
Message-ID: <2ca3a858-b165-4236-8a8f-32741d365779@roeck-us.net>
References: <20230522190405.880733338@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
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

On Mon, May 22, 2023 at 08:05:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.30 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 519 pass: 519 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
