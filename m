Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA165F6D62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiJFSNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiJFSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:13:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B0125022;
        Thu,  6 Oct 2022 11:13:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so2529377pjo.4;
        Thu, 06 Oct 2022 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8ABriGxdAdRRDvUHYr/gAwn7wVwHz43N2tvfb4QIis=;
        b=Wx4/CFUAKrc8nHs5KnFu4GnNl9xH2kc27XPJn9I/lWQ/+gU8q7uHdXD7fa7i+t9shv
         AnZHDlETi/dMvWNmlA9ffgYk0/aQKv55ybhPsdiGepJXSx0t1UxmIeR4ijmsypryZoIc
         eFD65yo/Mcx+x3ZQGGRNjf3gUsKSK74T/UV8KQ1y7JB4xI6gOwDH0F2RxXdRYUSxoFDw
         zsbYJWhlgIGenQV5Zp1A8QyHzvcGYGkTlsAk/s3V6aiP0dtke2D0iORbPbYGGT2Km6ov
         rnbqLH2VMFlTNFGsJQUak4k8oIQhi8JzYZlcjbbyBLq+W5p8frbzwcNxVn9zqya+oVmJ
         BTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8ABriGxdAdRRDvUHYr/gAwn7wVwHz43N2tvfb4QIis=;
        b=8NUmnjui0P1Yx27TtYvtnRsrQpW0enUO0sYJdthI1OzYK5+fzy2UiebffZJNC6J5s7
         HJ5tXQBRwb47wQXmL9VxMKO94rVgguz3D26o5C+0jt8q3EsuSEd0EJYq04nIADdMWJtp
         oB4FRJxsAXx9WmmW8HNbo5rY/HeSTuKPd6vS0l2PJ8dFNi6kMsyl4+QsYkDUBRkcY5uI
         k+Xr/6mG1C68sLMGUoaGvRbh8Ulxqu86LVI+b4tneWjMxHQRommrMY/e9SUiqnI7RRsg
         akcBau3JMt7MZ00dEdnGYyQS5ZR3CiiELCJ6ZASMNZCjrhFc7QLvaGovHgAoA5egjV51
         7XjQ==
X-Gm-Message-State: ACrzQf03cBImbUCxaPJq2U/NxQnNGRfw4J3b+64EaGPcHmxq7ggfFRPE
        SjT/u3MzPLsXUL+k+MG9apLLfe8TMmI3XA==
X-Google-Smtp-Source: AMsMyM70i40gYKPUyK8N43ZxIcPOvPBUJSAW2HPlvZAJoGJ+VknU5vkMhTW+zN8TAsr0TKOi4x4CBQ==
X-Received: by 2002:a17:903:186:b0:178:2ca7:fae5 with SMTP id z6-20020a170903018600b001782ca7fae5mr654697plg.173.1665080022166;
        Thu, 06 Oct 2022 11:13:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r18-20020aa79632000000b00561c3ec5346sm5411180pfg.129.2022.10.06.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 11:13:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 6 Oct 2022 11:13:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6/8] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6795
Message-ID: <20221006181340.GB761987@roeck-us.net>
References: <20221006120715.24815-1-allen-kh.cheng@mediatek.com>
 <20221006120715.24815-7-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006120715.24815-7-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 08:07:13PM +0800, Allen-KH Cheng wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Add the mediatek,mt6795-wdt compatible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Co-developed-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 34c634d3eb67..3daf754fc99c 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -23,6 +23,7 @@ properties:
>            - enum:
>                - mediatek,mt2712-wdt
>                - mediatek,mt6589-wdt
> +              - mediatek,mt6795-wdt
>                - mediatek,mt7986-wdt
>                - mediatek,mt8183-wdt
>                - mediatek,mt8186-wdt
> -- 
> 2.18.0
> 
