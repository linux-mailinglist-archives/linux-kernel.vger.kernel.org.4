Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1072AE0F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 20:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjFJSHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFJSHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 14:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2501926B1;
        Sat, 10 Jun 2023 11:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CF660F04;
        Sat, 10 Jun 2023 18:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DDBC433EF;
        Sat, 10 Jun 2023 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686420452;
        bh=/Oi+qoNXc1G119BAPXC4pSYlv8GVhGqklA7F5cmrK84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RYKw+cYbvgdgSGUCy0yaRSQfE2N/QUI0qYuics/RCj7xtEQWHkwIgZuL7uqtrllzQ
         hNz3SJEyOHUEsE2G1MS1r/IGurTNO7mg0jKPxpYcnrVtZ7sgSNn4kUeuDcRfXB4pTa
         YI3770ezMGkFAAOv3BeF9V0O0FL2ShwhWeUuBkMSzkbPKt7vIf14Ffovz271edTWbp
         c+bpvqh9MfIAA/+Yuo8zbRDUalmYM/wdA7GoydFJ2l/jAN3HjTZAwPmTYmIa48flqr
         X3E5p4ZhJjtPZNKRpohgMYo/di5Lb2RYxNdrg5I1d+hOdGD3+wtGcfYA3+mWK3isDA
         K+8eNiUsUUKlw==
Date:   Sat, 10 Jun 2023 19:24:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
Subject: Re: [PATCH v2] dt-bindings: iio: rockchip: Fix 'oneOf' condition
 failed warning
Message-ID: <20230610192405.1a56fb1b@jic23-huawei>
In-Reply-To: <153ea7d7-25d5-8782-a622-ae512134161c@linaro.org>
References: <20230610143601.173307-1-shreeya.patel@collabora.com>
        <c5243179-9baf-59ce-b979-c596dcf6692b@linaro.org>
        <20230610171142.dsezim4gcxr2b65u@mercury.elektranox.org>
        <153ea7d7-25d5-8782-a622-ae512134161c@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2023 19:34:23 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 10/06/2023 19:11, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Sat, Jun 10, 2023 at 06:30:57PM +0200, Krzysztof Kozlowski wrote:  
> >> On 10/06/2023 16:36, Shreeya Patel wrote:  
> >>> rk3588-saradc isn't compatible with the rk3399-saradc variant,
> >>> hence, fix the following dtbs_check warning for 'oneOf' condition
> >>> failure.  
> >>
> >> Are you sure it isn't compatible? According to your driver it is and
> >> this change is not enough.  
> > 
> > The driver changes are still in the iio testing branch and not yet
> > in linux-next. RK3588 ADC is not compatible with previous
> > generations. It's trivial to see in Shreeya's driver patch:
> > 
> > https://lore.kernel.org/all/20230603185340.13838-3-shreeya.patel@collabora.com/  
> 
> I was checking the next. It's fine then.
And I forgot I only pushed out for next to pick it up earlier today.
oops :)

Thanks and applied to the togreg branch of iio.git.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 

