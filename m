Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0AA6FB856
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjEHUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEHUee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:34:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3839D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:34:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-643912bca6fso3954912b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683578073; x=1686170073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2TXVO3Qn0ZnUGYp0raU3hg8EYGwwYic/8hFVnmbHWs=;
        b=lS4HXOrdVEKBi/R0Q75reRHIeEjldMgx+0TeJj1PlEuFDUJyd4StX+cIDF4S72tYTI
         d8FHPYc3fN2VewD7Ysi/qz1FFyaVqSCyEdA4pGxmnY27Mr8y0uNMDK8C1hwGXzok73Jq
         IdJxQ/XO9a5X9z50ENag+UYuJdwAsTPsuy1Coxcjg3rWTqT8nX72k50Dd3GxuB/sdk3i
         US2/uHM4lgUOcBjEATwOGVKqk/pDt8bI6iasZa2Z0VhnZUF9gPC2UX0OI9vBOQPtu0mt
         L47VEd5D1lqFNPnw514tAgHEiaMvjfEgDKkIANdBwabdDBBtrCymrsyttxyg6mrqImVM
         /W3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683578073; x=1686170073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2TXVO3Qn0ZnUGYp0raU3hg8EYGwwYic/8hFVnmbHWs=;
        b=Q6vY9DJ6/djwmCAbaSlPWChNHog7Kr1UdoYWN6RNLsU1vCMmo6QykNDbBfi7rvsKYD
         lo8ZDdsLtduHKgBetjlwzspHxf4OFBHe3z4ZE0qLtUDk2V7ncHHab49sP2+x/dEQ5Ikw
         DDHMK5VyeLkLdJNnklgr+jak21S8YJgPJawijGU/RUYYSFhRRRSO+xGslW6kJBq75S9u
         uxKqN/YwrAkwGXcob+K0oCEhu8VgeRynhsOfLk3o95LCtk3LUtDb8ZUG3GeVmBCvyUl4
         R6Q+ag5Z0YHZy6G7Ph3WS3PSIYmPfOkwwF793rSiZV8je9fQCwAWQieSkQOIamlOo6Px
         gjgg==
X-Gm-Message-State: AC+VfDwUwbhDOJaslDoSDF38RZR1s0Uns3zN5QqpJepAGA36IFWf7f8F
        t/p9zbtMPnAPWty3JYj09QJDysKe2dY=
X-Google-Smtp-Source: ACHHUZ68Z82cnITJjjL6eVxbTPM9vzkvLiktkeW5JkC4MrpQwn+V+0vBurDAzgpm/3aj+dRO/t3R0w==
X-Received: by 2002:a05:6a20:4325:b0:100:ac13:9a57 with SMTP id h37-20020a056a20432500b00100ac139a57mr4739887pzk.55.1683578072970;
        Mon, 08 May 2023 13:34:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n1-20020aa78a41000000b0064550f76efesm396383pfa.29.2023.05.08.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 13:34:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 8 May 2023 13:34:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: Linux 6.4-rc1
Message-ID: <3b2e90bb-c28f-447a-abf8-2b5453da8092@roeck-us.net>
References: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUxm-NZ1si8dXWVTTJ9n3c+1SRTC0V+Lk7hOE4bDVwJQ@mail.gmail.com>
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

On Sun, May 07, 2023 at 02:18:22PM -0700, Linus Torvalds wrote:
> So here we are, two weeks later, with the merge window over, and -rc1
> tagged and pushed out.
> 
[ ... ]
> 
> Anyway, please do go test it all out,
> 

Build results:
	total: 152 pass: 146 fail: 6
Failed builds:
	arm:allmodconfig
	i386:allyesconfig
	i386:allmodconfig
	mips:allmodconfig
	powerpc:ppc32_allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 520 pass: 520 fail: 0

The build failure is

drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:
	In function 'mxc_isi_channel_set_inbuf':
drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:33:5: error:
	"CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0

The problem has been fixed in -next since April 18 with commit 9829ed20b019
("media: nxp: imx8-isi: fix buiding on 32-bit"). Hopefully that commit
should find its way into mainline in the near future.

Guenter
