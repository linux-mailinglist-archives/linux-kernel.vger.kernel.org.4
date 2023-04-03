Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1705A6D4ECC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjDCRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjDCRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:18:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F97272B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:18:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so31306986pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680542325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rW3em2VILxt0UnmLbwVBQSzkZ1Aze3c4iqs/OGaKgQ=;
        b=guWPpHelsN8D4CzukM+p9HwO+O0+t1EOvCaPqycmbYFVAXF5fCh073bwn6x3o4QTJ8
         nvtkG5glJFtW3S4SL/2DK7YRgBwk+QqDy3xPs4Kw6rNem+i65ZzqrnUrsjTndKoYZf59
         v4WwjYEg9iWwRy7SfoA6rNCTKPhWCa7iCNioJU2SCeYlNuZKbJSFkcVUAYhjUHoz2x0J
         AnVSZqfWtCrh0lphbxJh8bkGSrQTSw1DO0J5msp2Y4wJQjCsOBgFqh+MDN4w2+0wcb/w
         C/syvLGgPDe5gWG8EIACnyPSGNljH20EWGsAcw6+LaYSx+3o93zE2tnQXHcvuEZX+lWm
         xn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680542325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rW3em2VILxt0UnmLbwVBQSzkZ1Aze3c4iqs/OGaKgQ=;
        b=J1YcWoeOG/lPPQ6ymd6KGhVvb6MA+DQg2VQHQDuhljjPrq8J70Y5mhBMkoCNq6Jgo2
         7m002w7ofBJbxic/44srL5tA2ll5EA/siKSEnFuiGEtFrFb+VuFz2v6l9qOw8trHadYG
         Ky9FxKrmRLCtvO6weJ3oFclz/QDvJn2SSISgp9Z3f7WlsxqMYMdt0gIVlRquqRyCuiXk
         CPSAuTpfXxGS4+SpkcvBYlWulW+jo6Ql1JM0E4d4jJR2ZEthoCeDQPxlZ+mMIO5ErNyr
         FM41p+00z4Dptls6hrgHOMCq3004+tTG0T6DRDkzQe72zkeNBHWvR+21BG2aNcYY5GK2
         gZpg==
X-Gm-Message-State: AAQBX9fgZ8zlLroW5oHKBsl3jHV6cNhVbeVljYJHqU8w9CJs/X4Am8dF
        zF1ZzPAy/wd/rnWpx9pXOe0ZDQ==
X-Google-Smtp-Source: AKy350bMB5zNEq0ZE1UFYbMQNdutHQBU+wTgTdP/JcPYscsdxGvNCxZ7pEDBeiPHb5YKMtqVT/ZR9Q==
X-Received: by 2002:a17:90b:1b09:b0:23f:b609:e707 with SMTP id nu9-20020a17090b1b0900b0023fb609e707mr43389916pjb.2.1680542325652;
        Mon, 03 Apr 2023 10:18:45 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2a9e:349f:4c3:53c7])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a174300b0023f545c055bsm9837249pjm.33.2023.04.03.10.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:18:45 -0700 (PDT)
Date:   Mon, 3 Apr 2023 11:18:42 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: remoteproc: st,stm32-rproc: Typo fix
Message-ID: <20230403171842.GB3679607@p14s>
References: <20230403162423.3325968-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403162423.3325968-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 06:24:23PM +0200, Arnaud Pouliquen wrote:
> Fix "communnication" typo error.
> 
> Fixes: aca8f94e5b69 ("dt-bindings: remoteproc: stm32-rproc: add new mailbox channel for detach")
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> updates vs V1: address Krzysztof comments
> - Add missing "st,stm32-rproc" device prefix in subject
> - Drop line break between "Fixes" and "Signed-off-by"
> - Add Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/st,stm32-rproc.yaml        | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

And this one as well.

Thanks,
Mathieu

> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> index 66b1e3efdaa3..ff95648f4967 100644
> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> @@ -72,9 +72,9 @@ properties:
>                ready for shutdown
>        - description: |
>            A channel (d) used by the local proc to notify the remote proc that it
> -          has to stop interprocessor communnication.
> +          has to stop interprocessor communication.
>            Unidirectional channel:
> -            - from local to remote, where ACK from the remote means that communnication
> +            - from local to remote, where ACK from the remote means that communication
>                as been stopped on the remote side.
>      minItems: 1
>  
> -- 
> 2.25.1
> 
