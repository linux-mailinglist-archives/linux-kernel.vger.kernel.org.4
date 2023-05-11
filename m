Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286016FEE61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbjEKJLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEKJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:11:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E563155BB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:11:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f42c865535so28898355e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683796267; x=1686388267;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=qS//Df9U00LCWPM41r2Z8AzZYpYLl9rhy64v8Bwr+xo=;
        b=LcdiUV46Orw/riw/2eQ54NsWxawtLI7SHmpeFtL/xBNPEwieqR90FqpHpASP1Yc1QM
         B5AWCr4Yz9cYZp9fouCuW8usiGIEJj5WiQaeOcVfSHKj17pCd3jCLNO54XQB1z/t/WkM
         IJ9msy1PNOuvUJPr4HQwsimoK8a0VgT7LFr/nTCRp2c4Ule1aSn+ldMtU1MIka1hzNPR
         iAg6pHEN0802u1RsD/07p1d1kbNS8hjUpLK1Yo5LRLaSH7il5tBKKzagcLjd5G17IB54
         0/hnou5C3RKf/FjfczX2Coiwb+zaoKLe2juXnd0uTyla8TCvcF49x9/GGQdUcXs32nCP
         6NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796267; x=1686388267;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qS//Df9U00LCWPM41r2Z8AzZYpYLl9rhy64v8Bwr+xo=;
        b=MU1EH//bDXLSHgOq6nmO2BthImSqqAhYsFnyThdIkiv1lEONq6xTynh0yDXIIKOSNF
         KMjm8wssckdRf9Vc9RjnIbZcgjq2Y8imehyPHzu7YENib2p1ltdB/YWlOztM62eEBi36
         eY/W01HA3cuMmdTYpvrLMpQXwo2GyNB2LZ6+lP/gsI0mbDkmKcbn+qW6AtpDjtcymei3
         UTRday5oiu41jhhrHPkfu7P8G53+shit97j+NVJgLfmGI0eciViwD4/qjEjQeTAIZKdr
         P5zAoZDzkNzVZhBb2wpVc55avhthaQzNogGSub2S0c4Kt9YYZkRiYjK/NcpABIiOeijV
         1vOQ==
X-Gm-Message-State: AC+VfDyJWOp2UI3v4awlXBuxHLP6zhRZwy2XE5TmIipItXpqWeNZqHCV
        wktTNBPidH2BrvnnRiT5k1K0pbA28LA=
X-Google-Smtp-Source: ACHHUZ5kd7/sl4fEKhGPVeRz07uVOTb7o038Rc1V/Ryh7k8ghse1n0Ea6XT+Mho/mwZHnEzJBdO5EQ==
X-Received: by 2002:a05:600c:3658:b0:3f4:2374:3517 with SMTP id y24-20020a05600c365800b003f423743517mr9271074wmq.19.1683796267261;
        Thu, 11 May 2023 02:11:07 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id c22-20020a7bc016000000b003f4e3ed9912sm3094247wmb.46.2023.05.11.02.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:11:06 -0700 (PDT)
References: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
 <20230509110100.3980123-4-aidanmacdonald.0x0@gmail.com>
 <ZFxD01UQp6Q2T9n/@finisterre.sirena.org.uk>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] regmap-irq: Remove type registers
Date:   Thu, 11 May 2023 10:09:58 +0100
In-reply-to: <ZFxD01UQp6Q2T9n/@finisterre.sirena.org.uk>
Message-ID: <McPOosP8lKcKcEDPIdsfczJ27Z3lQsPB@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> On Tue, May 09, 2023 at 12:00:57PM +0100, Aidan MacDonald wrote:
>> No remaining users, these have been replaced by config registers.
>
> This doesn't apply against current code, please check and resend.

Apologies, I'll rebase on top of your regmap tree.
