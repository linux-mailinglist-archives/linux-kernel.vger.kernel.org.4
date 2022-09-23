Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655315E8038
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiIWQ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiIWQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:56:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F8F147A25;
        Fri, 23 Sep 2022 09:56:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b75so702782pfb.7;
        Fri, 23 Sep 2022 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gDnFtBDWnaQb0EZfSvmlT1Y3CSzxSfSbrFYVrNHAlWY=;
        b=nJpGVmrJ8LFWr4YUd4tyLXEHdzNuawescNn1exeJPfczG6PC37lX5/GTSli4NZecto
         4pnOno2T5PrkErzkc4X5e69SOjBA5jQ8WaaqgsI3sLdGQOxYi3b8hxuqdLZ+R/TrlyrB
         8zr4NXsc8lo4BMNOzmyq4ctow2JZ6xDv+nIWhzG7rRuEqGmy8xYTnx5qIQyaF+XellfY
         6uroIJFr3XbT/DMmSyxujV90ZfLsUjnpJUmWAo1/1H/46fQ8cKv7CBLPSoPj2BOTPTQi
         29DO0TFMN/Vg0R3zsABeugYJk98eo7OGS6wumj2oaQwnPbIPRQPgtSkdnYWy21XJi9Vl
         /dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gDnFtBDWnaQb0EZfSvmlT1Y3CSzxSfSbrFYVrNHAlWY=;
        b=OhVrclAI2+E1/V+qygmmAjTBoRJIVYl485/eUn6NN8pJ6TqXtzyWohOdRZLJacC+Pp
         mTPLWu8FKfGAtW0NK2xv+zzsjjO/3a8GQpoFsmAnt7nsJJPFRnstOsfoJc2B47Uy3gD8
         suv2OZlv1lPDFxZO8MLjBDSCWW5k6eQwYY1xvVoBFLx1KZI4bcrZk8hL5+016e8VGW/p
         FieDtukMLe2re6VxaztNZLGT6P7tvI3gZeg+OZqoF7+5FIPHOZnPXlLLNiE9BL7VJL6c
         ePFbnNJH5wXAYF5Y88BDkElczpHCmQSs5dC6vt7OdKV8PY7EpoxFpUFGDQu5Mro10Pwp
         SC9g==
X-Gm-Message-State: ACrzQf28H8NPq1jM5N5rnsuYglJ8Txo6ycPs4m1juGCIrsGK32mBBXqA
        dpwkFH9EGqOzALyg+l0vbnA=
X-Google-Smtp-Source: AMsMyM50i0r9WGAhxGu1gLkNa+7qktNFTXLcKOMTnuhEF1HBG19CZLdyZ/1mb/GIgb/zMu1LnQkPuA==
X-Received: by 2002:a05:6a00:1892:b0:540:acee:29e8 with SMTP id x18-20020a056a00189200b00540acee29e8mr10125222pfh.1.1663952184685;
        Fri, 23 Sep 2022 09:56:24 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b0016909be39e5sm6311778plb.177.2022.09.23.09.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 09:56:24 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:56:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yunlong Jia <ecs.beijing2022@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Bob Moragues <moragues@chromium.org>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: input: touchscreen: elants_i2c: Add
 eth3915n touchscreen chip
Message-ID: <Yy3lNem7Uh4I6+LF@google.com>
References: <20220923083657.v5.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
 <20220923083657.v5.2.Ic4e8f03868f88b8027a81bc3d414bae68978e6b7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923083657.v5.2.Ic4e8f03868f88b8027a81bc3d414bae68978e6b7@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:47:17AM +0000, Yunlong Jia wrote:
> Add an elan touch screen chip eth3915n.
> 
> Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> 

Applied, thank you.

-- 
Dmitry
