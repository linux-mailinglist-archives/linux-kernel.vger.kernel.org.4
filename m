Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44426CB103
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjC0VwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC0VwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:52:23 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E7FD9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:52:22 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-545e907790fso80144077b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679953941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgEFPHZ5FNm31dc7cd26AOHdzoRri5eOn0eLmGYTA08=;
        b=h/9W31YOT+PvdIlxAnyAPA1QiC/uQ1XkIUo1FSzZ2tYdbqzqLXMzHOwz7lGu/D4jSP
         G4KTpDmTt+S0QONKg6aPCJkc799j9Z/B1PCLsTVW6ftS8PXhmvvv4rukYd4wWavQgEEf
         998AUloAOZoRr3iIaRfSUU8tZpPvOGJAtdzviIRoOn/IaRx/i7+VIr9tCJGs0qIfXBnX
         qL2DI9UvMeDJD+pqlejTAJ77rCRJcFuF8gjT1cV3NRXUfYH6VPIDeRZPsR942JZeiS9J
         AKSJgzBbX7420Oq36SqQ2jubL/YjOk9dUjAb2Xz2XszuY0a4j54p3+WE/2OakOXjeiLB
         m40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679953941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgEFPHZ5FNm31dc7cd26AOHdzoRri5eOn0eLmGYTA08=;
        b=FsZbMi/0UIyC7U9Bqxnu4Uz/u+5gwwrenAGiDZq7wxCaB7jHn2ZiNeQztVpVxylEtg
         2ns4QoXVjCCBXygE0Vv8NVlNT58+u4SeQaVijqjYh5p1TQCXDvtkM9n4rOxgGa39Iirh
         AlxOK2sjFVnAL1zvQH3DPGrGVI3Mk7DBdf+HRledXlZkar0Hqf1XiA04dSP17/pmHltj
         ngjH/SANfQhZeiSFzVIvrkvt0GENio7bL4bIsExYWViFG8qlGPCkC67hmnkGVSfTSepY
         ldxrPQLwuD7NYEpDtC+ih9Wr1pDoMA1uxRmC+sT8F2uVGyxH6T5gBrVLI6HvWGLQ3V7i
         ALlw==
X-Gm-Message-State: AAQBX9cN3JPbmcbczKbJ9Ud/u9os9nazcV/bl0vrypyt/CwuQtN1lt/f
        c4oE4oxy/Ksa104YxboB0c7clJXx+C8=
X-Google-Smtp-Source: AKy350azmEnjGlyqXkA0XfdJaEuZLoUJqwWRTQqC6kWqTgtEXmrlWXaqjowmMC+woS3+xHOvDElQHA==
X-Received: by 2002:a0d:e808:0:b0:543:53c:e3c with SMTP id r8-20020a0de808000000b00543053c0e3cmr14296769ywe.2.1679953941071;
        Mon, 27 Mar 2023 14:52:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dc8-20020a05690c0f0800b00545a08184b8sm2117197ywb.72.2023.03.27.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:52:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Mar 2023 14:52:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: Linux 6.3-rc4
Message-ID: <607887b2-2ec2-4bf9-b35a-d3cc285bad1e@roeck-us.net>
References: <CAHk-=whcaHLNpb7Mu_QX7ABwPgyRyfW-V8=v4Mv0S22fpjY4JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whcaHLNpb7Mu_QX7ABwPgyRyfW-V8=v4Mv0S22fpjY4JQ@mail.gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 03:03:35PM -0700, Linus Torvalds wrote:
> Things are looking pretty normal for this time of the release process.
> All the stats look very regular, and the diffstat mostly does too.
> 
[ ... ]
> 
> Let's hope things stay normal. And, as normal, testing and reporting
> issues is appreciated,
> 

Build results:
	total: 153 pass: 147 fail: 6
Failed builds:
	alpha:allmodconfig
	csky:allmodconfig
	m68k:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	s390:allmodconfig
Qemu test results:
	total: 520 pass: 520 fail: 0

The remaining build failure is:

Error log:
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
drivers/media/i2c/imx290.c:1090:12: error: 'imx290_runtime_suspend' defined but not used [-Werror=unused-function]
 1090 | static int imx290_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/media/i2c/imx290.c:1082:12: error: 'imx290_runtime_resume' defined but not used [-Werror=unused-function]
 1082 | static int imx290_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: [scripts/Makefile.build:252: drivers/media/i2c/imx290.o] Error 1

The fix is in the pending-fixes branch of linux-next, so it should hopefully
find its way upstream soon. Copying Mauro for comments.

Guenter
