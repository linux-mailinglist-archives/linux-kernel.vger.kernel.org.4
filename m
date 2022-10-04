Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DBF5F4AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJDV2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJDV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:27:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAE76CD17
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:27:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d10so14201847pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3VFr5OP2d6ygeFDGeEC4VzTwLct6Eu3GUxTvgi6DA4Y=;
        b=TdZC5qmT7VzpeMCBC0Yj60M8wtuGHz3It6CUlaM1hSF6maGr91wsVkqZluGIipVBSG
         CPI6yrRr7UD2uuOxpHUmt2iaaOmxF8IPH5SgkQbp+nto7IRPUNByCh37CzSpeqsizmyZ
         0012tspDelv0TJDP0oiZ2q1rtyAeVPMleMA1zyTr7JutGkjAWt5TGCY9kDNCmIWG1cG+
         ueyQn7ZpLpLJj7rU7PG0MTrRboH99ylUagU1tEXdPXJ4c0Y42OMF+XSFwlVprGhNUeOo
         rkVcAulwEhtNIqHrKsB7yjCxT3RQwIRsGSLeD2UZ6DPySw6e1L0bU7ObhnYNXTtkzoHM
         fMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3VFr5OP2d6ygeFDGeEC4VzTwLct6Eu3GUxTvgi6DA4Y=;
        b=JYxlSzw1SmEaPydTzV0GhUiWibTA2SL1RyVEe0f8X0FatCgPmrzH6ynGqpKWXOreJZ
         RQOKAqZysmuPp3sADmTFVEjoLUZAKjBuBiKOktQQ2ui3i1KDmgDJS5Bbp/ZSyfnQX3v+
         wLn28EcA+irlb3kWRvMoDWKHmerAmT27RaDYoSlPJ8wF/Pk/3YWE8p/nLS/Zwav7eL1h
         Lmr56T8ZeKeSWiq4c2lBER6C5KAgowdkMq9aUo0WSrV0gDov/tymowMBpqUGX2X7szzW
         YakjBrIFkf14ci+8ZF3qX7NkK9fnOiAoEVq9y1fotgIVBZHJ82SGsJOxZSy0LRO2Crw0
         KZdw==
X-Gm-Message-State: ACrzQf0RxpThFRMFGj5bDq+60vy6577E3+69Qnmy4mDDRFGtjo6Z5mcS
        YLy02P8af70B5vY6NaGT0UMPhhghg4aoxP+5rzQ=
X-Google-Smtp-Source: AMsMyM5beCcApJovOPEuUcl9v/fyKqLDZbYIlEjt5FLGSLTwDEL6p7MhW4XeVniUb8HOiJmXGX31aJB78IdSUfF1I4I=
X-Received: by 2002:a63:555e:0:b0:43c:4f2e:dd25 with SMTP id
 f30-20020a63555e000000b0043c4f2edd25mr25548847pgm.131.1664918865587; Tue, 04
 Oct 2022 14:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221004202414.216577-1-Frank.Li@nxp.com>
In-Reply-To: <20221004202414.216577-1-Frank.Li@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Oct 2022 18:27:32 -0300
Message-ID: <CAOMZO5DAjszTX9OSxbi8Bth7rB1kee7TWfDBz48SHRp9TNL0mg@mail.gmail.com>
Subject: Re: [PATCH 1/1] irqchip: irq-imx-mu-msi: fixed wrong register offset
 for 8ulp
To:     Frank Li <Frank.Li@nxp.com>
Cc:     imx@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, colin.i.king@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On Tue, Oct 4, 2022 at 5:24 PM Frank Li <Frank.Li@nxp.com> wrote:
>
> Offset 0x124 should be IMX_MU_TSR, not IMX_MU_GSR
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

You missed passing Reported-by and Fixes tag.
