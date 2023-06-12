Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8435D72D02E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbjFLUHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbjFLUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801B210F5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686600422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X+0noFHcj2yLtNYh9uCwW0uaG8SfjbhqsP5is69vjY8=;
        b=WeJt4j25Om96lRixplm5tBL8F5wkR+5bZnyD9XG+xBV3JL5qzA5R38wqkE+lhtP9PvQ6Ff
        5IxLyf28YR4HhjA02RtBkIpMYbEo7vhKV2sI+7o4eje7pzHQVZTQxZMT6rbjwS1LwZt/FX
        9vNbWCEwCvXieUXjUICH2P4Jz1IwoXM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-1m-ii9l_Pk6L3Ua9xjr34A-1; Mon, 12 Jun 2023 16:07:01 -0400
X-MC-Unique: 1m-ii9l_Pk6L3Ua9xjr34A-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-561ceb5b584so77217637b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686600420; x=1689192420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+0noFHcj2yLtNYh9uCwW0uaG8SfjbhqsP5is69vjY8=;
        b=IAdx+GIyJdGVThJyfkzyi6mPvEOzmyUxKOCrDb8tAm5qfQrRJA4QmpTZ51ypVsUrtH
         +U+JFc7im/C0RN2mBCQgPtsJdrONTpfra7s7sEwn6EfV13COIE8ooAJTdKOGqloHgYCu
         2s2CaVBSLLLaMSGhp6YD32F7eCz52sOUTKiM7uTmnL+AncnI7T0j352Kx14yFf0ERsmJ
         Pflss+I/WIwdI1pn0+GE5/dotd07GMzzOoI/D4iOkGzRsnTpuZU+M3OLZHM6tIvtyive
         eBrn/Ptsc9jKngQbM/uEUU7pcWgdZqanZeMZsSYWZTjIt+r6CPWzo+d/jnNfqtX7NH0h
         a9eg==
X-Gm-Message-State: AC+VfDxJ+KmXrTBlhYQz/gzCUeOClrkm2DFaF9QKrH2Emwjl16dANgic
        2LTEgURq2iFj8hFmuzWwssbx8VTOMlHkKjHRU5rUgk3JmkxjIO1ATqpCliSp1DCQx8wueuNmAkr
        tJcNTk6SQWXNfu8nVwBo/B4aD
X-Received: by 2002:a0d:d142:0:b0:569:feee:3950 with SMTP id t63-20020a0dd142000000b00569feee3950mr12226029ywd.2.1686600419882;
        Mon, 12 Jun 2023 13:06:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PzolWatF3tOgmfa9XBAGwXjOlATUx5vSje4PclwYgketu3avPNRnBzek6n0LaOUY30qXC9g==
X-Received: by 2002:a0d:d142:0:b0:569:feee:3950 with SMTP id t63-20020a0dd142000000b00569feee3950mr12225997ywd.2.1686600419621;
        Mon, 12 Jun 2023 13:06:59 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::45])
        by smtp.gmail.com with ESMTPSA id m14-20020a819e0e000000b00568e7e21db7sm2713928ywj.96.2023.06.12.13.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:06:59 -0700 (PDT)
Date:   Mon, 12 Jun 2023 15:06:56 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 10/26] net: stmmac: dwmac-qcom-ethqos: add a newline
 between headers
Message-ID: <20230612200656.ndt5pwhi3gqj42a5@halaney-x13s>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-11-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612092355.87937-11-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:23:39AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Typically we use a newline between global and local headers so add it
> here as well.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index ecb94e5388c7..5b56abacbf6b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -7,6 +7,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/phy.h>
>  #include <linux/property.h>
> +
>  #include "stmmac.h"
>  #include "stmmac_platform.h"
>  
> -- 
> 2.39.2
> 

