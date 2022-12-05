Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706CA643617
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiLEUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiLEUwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:52:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67E2935D;
        Mon,  5 Dec 2022 12:52:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id n20so1559070ejh.0;
        Mon, 05 Dec 2022 12:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUw6Hd+Tb+y6+h8IPlKOEXxbYBmUXjkCM3BqWwxBlG8=;
        b=Tu0y2YsPn1xteSCPzD/5LdsrIuEIAlXs+99JqYe67QKzQW9c1ZbI6s6ujYamITNDtN
         fNKvydO8AlCHSYhDHPCsITas0Rz0ZV6NDz3uFJW3jZgHzsm9vSzBwaE/7RWcRLaGmnSJ
         YBwoHkRvfYRVdNYhwRYGPgAl28cYKv77KViE+Zi9YPB/L4PrEbHivc00W0RlXJPxPDN5
         12/9Gxb77g23va8VGt+558SCRm5WjlOSlseXI7EV/e61rHArn9Ww6wDZxqbKHo1dKmCd
         c0lSgQBBaK982lqTBd32DdwR62vZgMenBDxvWwtM2QfZK/1nJDIxOJhazKvWRJK72G3O
         aopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUw6Hd+Tb+y6+h8IPlKOEXxbYBmUXjkCM3BqWwxBlG8=;
        b=Rya5nML5L9nyUL045+b8ILk0Q3Dm0BBwjRTcN0FxfjLojR1GzLqJHMDmZC3FbdKo0T
         tfUbiILWEYXXKLcQ/wVuqAt6tNqTdFv7e7XP2UqHHA2dTs7VMadVOX2gx7gjrkPbeMeJ
         +m+j1n20AviOYjxhFzPhMlVBMBZB5eqxF5abGgc1AiGAx8N1v8TZJxVLBqhOQJacmIpC
         STa0HI6BNvIPR1vaMCm/rsR1Innxc4Uf4HgnHIe5W27lto6cbh4HnwbU2C/8RMcia1d6
         E5D+vyRGmqNwlrR/GznJcoAYDLxDa3dSMuLftVrbbI3B5KGJBCndnUdsVF2iPT+FsIwZ
         iE/g==
X-Gm-Message-State: ANoB5pl+k+D4gOPqTjYP6Z8T/FmoOdtIWXUheg6gONzQec6PNHHd71w7
        QAEPQ1XZeHjUXOizJn0DbzQ=
X-Google-Smtp-Source: AA0mqf5GnVmcrBfMG8tVYmiTkS2qjOw6eiBPylS67ujMkmT01we801GcaVxVM/HsmWm1ZFJQfC2r1g==
X-Received: by 2002:a17:906:6dd7:b0:7a1:1c24:e564 with SMTP id j23-20020a1709066dd700b007a11c24e564mr58800700ejt.629.1670273539855;
        Mon, 05 Dec 2022 12:52:19 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906285a00b007af0f0d2249sm6645367ejc.52.2022.12.05.12.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:52:19 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     paul.kocialkowski@bootlin.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     mchehab@kernel.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] staging: media: Remove surplus dev_err() when using platform_get_irq()
Date:   Mon, 05 Dec 2022 21:52:18 +0100
Message-ID: <4229852.ejJDZkT8p0@kista>
In-Reply-To: <20221129012923.111691-1-yang.lee@linux.alibaba.com>
References: <20221129012923.111691-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 29. november 2022 ob 02:29:23 CET je Yang Li napisal(a):
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> ./drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c:390:2-9: line 390 is
> redundant because platform_get_irq() already prints an error
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3274
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


