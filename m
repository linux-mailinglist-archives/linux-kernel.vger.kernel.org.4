Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B773E641184
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiLBXcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiLBXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:31:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7AE784B;
        Fri,  2 Dec 2022 15:31:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s7so6001479plk.5;
        Fri, 02 Dec 2022 15:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ov4BRsKxFLOmoIOFTpoh4nTwxKucanMMlraDUcWUrJQ=;
        b=nz7HjNemCQoy3/OfTajwDSbr1PeL8lqe0N2gxqGBJgbSe3q6p5fglY9X81U5J1Ddnc
         ywshZQfqnE/WJE68je7poQwiqlhc2iBfUVqHOCP2lMzj7cmCzfTcTRLnyGiuX2UzKKrV
         Hpm+iCREfEjsN8kOdtdukDZSIe6mApsmb0zu1MlzpTVW8ggt9p9pxB+VSDr33cEWQT8h
         i34jAYfGrY+esy599BRE6wPkkHVjxY1RfzAelWI9ywAem7fnTbOmHfms0A9H7IvMNAFh
         +BkL2vwJNxC1xdyGIjj39RqevrMWopYyHT3t7ZkTc5Q5Jxq5+H9BraP7IWOTBFSfWdF7
         sV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ov4BRsKxFLOmoIOFTpoh4nTwxKucanMMlraDUcWUrJQ=;
        b=EsDAzflAYlepyrDjBtyusAUzwMdEn/LJ6dKVayiwzka8Jo/gAp1HEF2TO+7QBhIIn9
         bqSjt+CwtE4iFbqqbHfR6dbqQT1OPXtn+CGCr1cBhC0zSrlgdYbD++BUnxK15bPU5hVj
         toodUGNiwuGba2wZM8o/wp3Ht9TmKGMbPohKUWUnmNvJTPKesd3HPW14bqctAf5oz4kI
         clPtD/4nhe9Djacs/KWh/QksBHxZbL4y9/CEX2oU/xWQryYp+JqAiGjjZ/3eFMh51m+r
         acz2hMvKZBkam8hcDtMnMjW+ixOq66Egug/OM14nfu1eIkkCUt3hKwlW41bIhTsxnRx7
         5NyQ==
X-Gm-Message-State: ANoB5plBA6kUToQyE7pFB/xXxoC7o3q4s5xFCkmlvOHF4omwl+zGenxP
        79KURHIGEEr68ETJgjiEKFg=
X-Google-Smtp-Source: AA0mqf6rWX+1ZqoRfjqTJWX9DFdAOUvBM3IUR8Snk2Bm/b2PM/7zZVO5+5uzZ88GxfQObmDKx0d8xQ==
X-Received: by 2002:a17:902:ef44:b0:185:40ca:68b8 with SMTP id e4-20020a170902ef4400b0018540ca68b8mr55516177plx.16.1670023915493;
        Fri, 02 Dec 2022 15:31:55 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:cc0e:e156:5def:3b2e])
        by smtp.gmail.com with ESMTPSA id c126-20020a621c84000000b005629b6a8b53sm5783624pfc.15.2022.12.02.15.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 15:31:54 -0800 (PST)
Date:   Fri, 2 Dec 2022 15:31:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-input@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andrew Davis <afd@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: input: Convert ti,drv260x to DT schema
Message-ID: <Y4qK537P/rM2wJ62@google.com>
References: <20221118174831.69793-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118174831.69793-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 06:48:29PM +0100, Luca Weiss wrote:
> Convert the drv260x haptics binding to DT schema format.
> 
> The only notable change from .txt format is that vbat-supply is not
> actually required, so don't make it a required property.
> 
> Acked-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Applied, thank you.

-- 
Dmitry
