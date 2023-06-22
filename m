Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E88739E87
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFVK0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVK0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:26:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A096107;
        Thu, 22 Jun 2023 03:26:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-987c932883bso848763266b.0;
        Thu, 22 Jun 2023 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687429568; x=1690021568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5akIJbyUW4zT8U4Rlaz6Os1Xyv6VeF2w/hYIIjFJCRQ=;
        b=WcG4sojjRL/I7b4d0UOTcz8bFofYvlIhpg4/JJLacgbhtGF7PjFll3wFdTHvl6m163
         yoe5nO0s2XtK/zkcszsD4upJvjPjurJ+bSeijiKnIFXzabjoAN5CargsyvB8EdjSSpkL
         ePQlwfP6Bzb1v6E48+kNlhbVsyVtS5+w4V54wBz7nyL0yPqlBoMRh3BIoaD2QsIR+6vM
         PppoIhNgES+RErrY96S2vfENusNtlrki45uApsapqAQ7LV5PegXjC/Q29rHpVksqEbPO
         9JDh0KCk63XC5DpIcecymEtD5L4erioGLJfM4pPDzJrorcoWWN64MvKc7edneoyQIt7k
         Mklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687429568; x=1690021568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5akIJbyUW4zT8U4Rlaz6Os1Xyv6VeF2w/hYIIjFJCRQ=;
        b=KR4EUV7rmaYJtAHjuLLtx1UfckTTlQ96RWzlO+V8ycYJizhjzVksh3nm0iNzFwo2Y6
         qHdU7Z3LYRSQCD4hLT7Zc4ikWONBM676QzRl+iiBlgYVrPmz1Eb9qehKtj4DkSZnBtEG
         ayddF94xe0uXrikFibbanTWBxYUQePXQ1/F4bzM9dNSEh5SESegE751CHSHJK0cVYqf8
         EBe4KGadCT6KC1ZQx18iuqzmpc3K6wXMeyAL5LyIuUG3znBmec2atEsRmQNpXT8UENFC
         SeMoYrwhDVmB7rob8bo/f1zk0jjo2/EStigrb+Cur3OFBRDgSVMa5pwb7vSuP5H1Sdh4
         N80Q==
X-Gm-Message-State: AC+VfDyh8zTeGva+jvWdCAgw3aQsDLsmoJPHpHbTilOpXrH31MTX2q02
        GJPqTWhDdC/5T6AlM2O4ByU=
X-Google-Smtp-Source: ACHHUZ7gdj3MTdlhw6Kh64TMH4jIz5OyIr1Z8j7MvYu956Njq0HYYQKJnc/9pxZlkUwjWi70EP0xpA==
X-Received: by 2002:a17:906:ef0b:b0:97a:e0c0:2f91 with SMTP id f11-20020a170906ef0b00b0097ae0c02f91mr17256008ejs.8.1687429568283;
        Thu, 22 Jun 2023 03:26:08 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906c08400b009788d51e4b9sm4484359ejz.130.2023.06.22.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 03:26:08 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     lkp@intel.com
Cc:     alexander.stein@ew.tq-group.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mka@chromium.org,
        oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org
Subject: Re: [PATCH v5 1/3] usb: misc: onboard-hub: support multiple power supplies
Date:   Thu, 22 Jun 2023 12:26:01 +0200
Message-Id: <20230622102601.2244054-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202306221742.xnLvAlnW-lkp@intel.com>
References: <202306221742.xnLvAlnW-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 at 11:29, kernel test robot <lkp@intel.com> wrote:
>
> Hi Benjamin,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on 45a3e24f65e90a047bef86f927ebdc4c710edaa1]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Bara/usb-misc-onboard-hub-support-multiple-power-supplies/20230622-161859
> base:   45a3e24f65e90a047bef86f927ebdc4c710edaa1
> patch link:    https://lore.kernel.org/r/20230620-hx3-v5-1-319c9c4c846f%40skidata.com
> patch subject: [PATCH v5 1/3] usb: misc: onboard-hub: support multiple power supplies
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230622/202306221742.xnLvAlnW-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230622/202306221742.xnLvAlnW-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306221742.xnLvAlnW-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    drivers/usb/misc/onboard_usb_hub.c: In function 'onboard_hub_probe':
> >> drivers/usb/misc/onboard_usb_hub.c:262:58: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
>      262 |                 return dev_err_probe(dev, -EINVAL, "max %d supplies supported!\n",
>          |                                                         ~^
>          |                                                          |
>          |                                                          int
>          |                                                         %ld

Thanks Mr. Robot, seems like I forgot to compile with Werr :/
I will wait for other feedback and fix this in the next round.

Sorry for that...

best regards,
Benjamin
