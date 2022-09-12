Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC85B62C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiILVcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiILVcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:32:33 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33053AE71;
        Mon, 12 Sep 2022 14:32:32 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1225219ee46so26961479fac.2;
        Mon, 12 Sep 2022 14:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Roc2QC7YVTJzM5a2RyZWr67Xni22cuKUydLs12PXj54=;
        b=sd9niCvTSTHRFLF5D85qbQr+LFVxTwbaIKnQEL0W7OKYbg6/aGLml4LTpfYa/wb04D
         ys+hCYrjnGMsAxBC3K5u2PbAtkxuUdTOQjBRrogzhYZ9720bVh62GajsbWKuxfR+8Lop
         rAVUk8gmTv7Kk41LxiBDZ931HNrDb91r2ak7c6b25BIWqqCRKbRsw/PDe93SRYjgMhmN
         WnRIyIF6qD4yXB9kqZZp1AxcEwCJ2YNCbLJLRQDyf0jOOOaSs6ZB8MlXkTJ6xwb7lVHs
         5GEcVYXyKsR6FgMm6v48oEiP9IbDIj8E0ghnlXFkzDcVOz3En+XdtA3lrfwGiFJRXMOV
         O6EA==
X-Gm-Message-State: ACgBeo3OdhqvQgZet8a1RNYjJN4aYJHBHeG8j7nzaSi6yz3+2AKA/UJR
        BsHTg1gMNPI4P3y6q26MGw==
X-Google-Smtp-Source: AA6agR6QQjTVq3zS7FssawJhSyCf4ceDH7ZMQW961ZzFYZY2zdZM7xqsAyBvD3s+ZdP3Mx4yjlITRg==
X-Received: by 2002:a05:6808:1201:b0:325:75e1:25a8 with SMTP id a1-20020a056808120100b0032575e125a8mr155943oil.18.1663018351974;
        Mon, 12 Sep 2022 14:32:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e5-20020a056808148500b003432bb4322esm4371012oiw.40.2022.09.12.14.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 14:32:31 -0700 (PDT)
Received: (nullmailer pid 1935725 invoked by uid 1000);
        Mon, 12 Sep 2022 21:32:30 -0000
Date:   Mon, 12 Sep 2022 16:32:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>, linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/4 v2] dt-bindings: memory: Factor out common properties
 of LPDDR bindings
Message-ID: <20220912213230.GA1935691-robh@kernel.org>
References: <20220907232914.243502-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907232914.243502-1-jwerner@chromium.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Sep 2022 16:29:11 -0700, Julius Werner wrote:
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
> 

Acked-by: Rob Herring <robh@kernel.org>
