Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3AC5B9C34
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIONom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIONoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:44:13 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0886B7FFB9;
        Thu, 15 Sep 2022 06:44:09 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-127dca21a7dso47495656fac.12;
        Thu, 15 Sep 2022 06:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oCyp3WBgjIcitSSb9wr/8UkAtHdq9lu4DABTHKK7MiY=;
        b=ejlbYrCKC1dTevKWF+2itVqknGnTUjn16U9MearqwRJRZp2UKd0Mbm1C0O6tKIgHOQ
         c7cbf40jgTD0CilT/RuOhXT8YlkIj3RWvlkQ5Wk3FnuIgwtuohUIW6i5PRJxEIftoBhi
         12MWRUWXHD7m4GmsPKQ2gG3QIlCossk3Ztq+CHP+Yjgcm72ib3ErLwxfJaFOKCIdbn3e
         ebJBg18HLs6nKtPD4Ofmk7qEnnRJTVd21BrHNJTZ+svjSmS0QOOnOGIgWELkqFev0gZN
         7d6VN3I0YRkf0hkHOUlwnuUmIVHh0Tg1aWoFiRMJHWJ6t41HTgcgGcZFWwMDMWTb+QiL
         zG9g==
X-Gm-Message-State: ACgBeo1XVEKsH4GnN6Tc96xoG7R/uPnWmT5iCooe+Q0k5CLHQY/MIEOB
        H085Aj9jMjrbE/H4Al8tEQ==
X-Google-Smtp-Source: AA6agR4vteugqQOF6xZmA3f3tZZztiVNfcWKmN5TUiBcI4FcLbIElqXNX+e4dbTiM/vztkMXOFeiSQ==
X-Received: by 2002:a05:6871:29a:b0:127:6381:9bbc with SMTP id i26-20020a056871029a00b0012763819bbcmr5540932oae.77.1663249448091;
        Thu, 15 Sep 2022 06:44:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id en8-20020a056870078800b0012c52bd4369sm779894oab.19.2022.09.15.06.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 06:44:07 -0700 (PDT)
Received: (nullmailer pid 1169162 invoked by uid 1000);
        Thu, 15 Sep 2022 13:44:07 -0000
Date:   Thu, 15 Sep 2022 08:44:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Jian-Jia Su <jjsu@google.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 1/4 v4] dt-bindings: memory: Factor out common properties
 of LPDDR bindings
Message-ID: <20220915134407.GA1168889-robh@kernel.org>
References: <20220915003222.1296421-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915003222.1296421-1-jwerner@chromium.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 17:32:19 -0700, Julius Werner wrote:
> The bindings for different LPDDR versions mostly use the same kinds of
> properties, so in order to reduce duplication when we're adding support
> for more versions, this patch creates a new lpddr-props subschema that
> can be referenced by the others to define these common parts. (This will
> consider a few smaller I/O width and density numbers "legal" for LPDDR3
> that are usually not used there, but this should be harmless.)
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../ddr/jedec,lpddr-props.yaml                | 52 +++++++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr2.yaml  | 40 ++------------
>  .../memory-controllers/ddr/jedec,lpddr3.yaml  | 32 ++----------
>  3 files changed, 60 insertions(+), 64 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
> 
> Changelog:
> 
> - v2:
>   - removed minItems
>   - reordered io-width enum from lowest to highest
>   - moved `$ref` below `mainainers`
>   - removed part about undeprecating manufacturer-id
> - v3:
>   - no changes
> - v4:
>   - removed quotes from schema $ref strings
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

