Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D14672315
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjARQZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjARQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:25:22 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0561711EAF;
        Wed, 18 Jan 2023 08:23:19 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1322d768ba7so35981383fac.5;
        Wed, 18 Jan 2023 08:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lenrwaJO4Fpw7+uqr9ZAJjqkVt/GKrLvaf2px/bduw=;
        b=R9gTgG3x6LKxZvmxUZYD1vtwzIHh11L/KFglWgo2Ux1vZxqDqStvoJtwsgQsgY+6nt
         Yew72zlnAscBhR8yMD88id7gI+RdPYpBDWrRU8BUTtqAZwyG+KeOmyh5oQTscgW0qaRd
         SnRiUlguNBNDPtAgzmXMGF94CMDF8L3tFLBDomefdpWvBLlG1p2Bs6fTPtkGpkuIQ9Vl
         ZMca5xAnilh1Ms7iRUf3JLBhFHuIGsBh18QetnY5L0aX+MNwaNCpzVszlO57+oeHPqKu
         gIjObrepBieFgQVCgivfPegE+YKqkPiF+1XBlyo/ELh1KSJU2aMAdIf5YztuTP72vBSC
         2+fw==
X-Gm-Message-State: AFqh2kpioZYu6m5/ofjSaMrHHfVy+I9yjdxoVtsHyUApK+E5eUKkCLOZ
        FdeW8Z93OSJxFsu5nrzfBg==
X-Google-Smtp-Source: AMrXdXtqnSfSfn+/fgltzvM3rhZOzeCfpfNUOhJYebLotLx5D6/xkTXsxfbm4sVWJTB+7CTr8QfLcw==
X-Received: by 2002:a05:6870:9e0c:b0:14f:f323:4b2e with SMTP id ps12-20020a0568709e0c00b0014ff3234b2emr4096964oab.47.1674058998247;
        Wed, 18 Jan 2023 08:23:18 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id kv17-20020a056870fb9100b0015f84d752ebsm1284542oab.39.2023.01.18.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:23:17 -0800 (PST)
Received: (nullmailer pid 113606 invoked by uid 1000);
        Wed, 18 Jan 2023 16:23:17 -0000
Date:   Wed, 18 Jan 2023 10:23:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] of/irq: add missing of_node_put() for interrupt parent
 node
Message-ID: <167405896149.112512.1632034797235809699.robh@kernel.org>
References: <20230117144929.423089-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117144929.423089-1-clement.leger@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jan 2023 15:49:29 +0100, Clément Léger wrote:
> After calling of_irq_parse_one(), the node provided in the of_phandle_args
> has a refcount increment by one. Add missing of_node_put in of_irq_get()
> to decrement the refcount once used.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
> 
> While debugging a refcount problem with OF_DYNAMIC enabled (which is
> actually the only case were node refcount are really used), I noticed that
> platform_get_irq() was actually incrementing the refcount of an interrupt
> controller node. Digging into that function shows that it calls
> of_irq_get() which calls of_irq_parse_one() and finally of_irq_parse_raw().
> Since it seems sane that the node returned in the of_phandle_args has a
> refcount incremented, I thought it is better to put the of_node_put() in
> the user even though it was hard to find any user doing so.
> 
>  drivers/of/irq.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Applied, thanks!
