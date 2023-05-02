Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839E66F3B46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjEBAP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjEBAPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:15:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6913C30;
        Mon,  1 May 2023 17:15:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b46186c03so3628475b3a.3;
        Mon, 01 May 2023 17:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682986516; x=1685578516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O66y4EhLiB3zI7CJaRKSoh2ZCuKs43N5L91HnMbMbKU=;
        b=nMNY6/iFzb+DwbSmpUGsvL/7P3CfgSjME4ZM65Fj67Z4OvK+UJ6nBeGIwzYJCTTVhC
         VHbocC+MOPPRAiBY0SNsqB+pVMEBtt6qcpYW39hEfEbweah3/FiOxEvscInkoNrYAh9X
         lKnfhY/ysJ7JYIE2QQ3A3KjToE8krJG46Tbu9qab+EeBAnlkM7giTKurpsNJYPLPwJKn
         bRUo6JXLHXSk0rvZUW++TFN8cZO3b5fI5KLbDIoQKynY8zsZXHuYIpoDTua/ujcQW+Xc
         WEgUioosxpjY5WUxLwUi3egveftgbE/JBiRbvjhYejYrCpEB3pFS1cx2ObLh2PnFintd
         dSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682986516; x=1685578516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O66y4EhLiB3zI7CJaRKSoh2ZCuKs43N5L91HnMbMbKU=;
        b=Ir+QACQzdPlWgu6lcGvJK0HUS/HKo7GiNNlq1oeTCAiFws2rDrEwtFZlbVDIFhpgGE
         bRaFBa8dBLcv6nRLXxe6YgBJdnqkrlh1iwqneabThdcfAyzfALXGHpKMuUDFLbPlD0Nc
         Ep87XcXs2IQ3+IZ9DKhjfAmkbiLkO1nqJhnnfiATVxQ85bQhUfyav/r1hkOhZU3UMDSx
         8L6X8pVtlOHPaVpjHD4SuV1xcWg7uWob5WGKrjMXkxdX5uTsG79av8kN5ApBI/9MJHcn
         x/5fnq3X9zTqGUysDBc6O07+hGNa8ouK8Qm02XvaGfajzdX5IVBst3lNioC/1In68H01
         8/JQ==
X-Gm-Message-State: AC+VfDypcUIrXiRFnsvZXuwbfjRPlj9p98yRvBmjJBxfBxvuvXWdk2LQ
        D4VOHnId6igTomkIytGnVnc=
X-Google-Smtp-Source: ACHHUZ4zvtKdDBoGtcRHdoYPOndXjeiLzD1YzvJcApBvZ4Dh59FChQj0BRcsOkrGVR90B9wVw4xolA==
X-Received: by 2002:a05:6a20:a68d:b0:f0:929c:e8c5 with SMTP id ba13-20020a056a20a68d00b000f0929ce8c5mr16980344pzb.35.1682986515960;
        Mon, 01 May 2023 17:15:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id ei55-20020a056a0080f700b0063efe2f3ecdsm11394805pfb.204.2023.05.01.17.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 17:15:15 -0700 (PDT)
Date:   Mon, 1 May 2023 17:15:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Maximilian Weigand <mweigand@mweigand.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 2/6] Input: cyttsp5 - remove unused code
Message-ID: <ZFBWEEzix/sZxiLO@google.com>
References: <20230501113010.891786-1-mweigand@mweigand.net>
 <20230501113010.891786-3-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501113010.891786-3-mweigand@mweigand.net>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 01:30:06PM +0200, Maximilian Weigand wrote:
> The removed lines are remnants of the vendor driver and are not used in
> the upstream driver.
> 
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> Reviewed-by: Alistair Francis <alistair@alistair23.me>

Applied, thank you.

-- 
Dmitry
