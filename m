Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C0737090
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjFTPe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjFTPe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:34:57 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8399412C;
        Tue, 20 Jun 2023 08:34:56 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-77e324816dbso130503939f.2;
        Tue, 20 Jun 2023 08:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275296; x=1689867296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLNtELukUK4y6Bx0FIkvfTL88s3/HWAfOdkvwPNpS3w=;
        b=CDI6fM2KK0SVBb/zsKeGkrJF4IDseVofx1Sz0dzsmTQ9TcC2705vTUxfE8u5csimBO
         pYdnvk5Uu7OeZgwfSYOxtMx1LS/muWknELE5xlxgalnKgsOkv5XKcOYhZadDX8sNRMdx
         2nIyTuRWNtfeaoMQFDpv3oP90ZQxj/coAz8NdBX883DrnjY06RAnC/d/Gw2r/4b0RU4g
         cvUWxJoSmOm2P+wg42gulxWQihcYrK37oG8V3fSq/k2oJfO3oYakHG3cKRyK4Ry8Dv5j
         JZxgMz/Jf2Ql/DJlZp4ZRuZLZvIyGbfzPl2blTn0eLuQTCEQTDktMObYau+sifGnumEX
         Nyaw==
X-Gm-Message-State: AC+VfDy2PV05g1UYlIMeF8iinK9sMfYYbk+TTvNzIvExIBFWzWroxYUg
        oHR4j/pQcObxZO4wt0u0MA==
X-Google-Smtp-Source: ACHHUZ7u1Z4sB8PFcgtXbPu2ZPm2Cr9/W4Oh03MWH7YsunQKvy2SekIG5kL0KrLWXaYUfI0uPMTfCQ==
X-Received: by 2002:a05:6602:20da:b0:77a:d2d3:fbfa with SMTP id 26-20020a05660220da00b0077ad2d3fbfamr10919788ioz.6.1687275295716;
        Tue, 20 Jun 2023 08:34:55 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id eq28-20020a0566384e3c00b0042654b042d5sm699615jab.129.2023.06.20.08.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:34:55 -0700 (PDT)
Received: (nullmailer pid 3637091 invoked by uid 1000);
        Tue, 20 Jun 2023 15:34:53 -0000
Date:   Tue, 20 Jun 2023 09:34:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree-spec@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 1/2] of: reserved_mem: Try to keep range allocations
 contiguous
Message-ID: <168727528754.3636908.14715947831933925098.robh@kernel.org>
References: <20230510-dt-resv-bottom-up-v2-0-aeb2afc8ac25@gerhold.net>
 <20230510-dt-resv-bottom-up-v2-1-aeb2afc8ac25@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-dt-resv-bottom-up-v2-1-aeb2afc8ac25@gerhold.net>
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


On Wed, 14 Jun 2023 21:20:42 +0200, Stephan Gerhold wrote:
> Right now dynamic reserved memory regions are allocated either
> bottom-up or top-down, depending on the memblock setting of the
> architecture. This is fine when the address is arbitrary. However,
> when using "alloc-ranges" the regions are often placed somewhere
> in the middle of (free) RAM, even if the range starts or ends next
> to another (static) reservation.
> 
> Try to detect this situation, and choose explicitly between bottom-up
> or top-down to allocate the memory close to the other reservations:
> 
>   1. If the "alloc-range" starts at the end or inside an existing
>      reservation, use bottom-up.
>   2. If the "alloc-range" ends at the start or inside an existing
>      reservation, use top-down.
>   3. If both or none is the case, keep the current
>      (architecture-specific) behavior.
> 
> There are plenty of edge cases where only a more complex algorithm
> would help, but even this simple approach helps in many cases to keep
> the reserved memory (and therefore also the free memory) contiguous.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/of/of_reserved_mem.c | 55 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 

Applied, thanks!

