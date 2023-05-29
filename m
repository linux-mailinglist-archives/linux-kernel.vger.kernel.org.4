Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E68714C76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjE2OuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE2OuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D87BE;
        Mon, 29 May 2023 07:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFF11625DC;
        Mon, 29 May 2023 14:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB7AC433EF;
        Mon, 29 May 2023 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685371807;
        bh=E0tWy/tllSnb1lYVWIZlelUhkji8r4mVy6G9oBExVwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=viLao7rq8xt8Htq1rCGOx9cEElTBVeXUlVkQb36y7z7xU5fpCC5x/QuQcL+qy2vzQ
         gx1IyBCAgM4v7FYVOaGCjms2PzvXNZMJEB2p/AgfgVYBqwKvza1g7N7DZlmLpnV/YM
         VWUfBG9h5qwVii2+PgiTuXJL5Jc+K68E8GnHxZr4=
Date:   Mon, 29 May 2023 15:50:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v6 6/7] usb: cdns3: Add StarFive JH7110 USB driver
Message-ID: <2023052951-humbly-dentist-cb9c@gregkh>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
 <20230518112750.57924-7-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518112750.57924-7-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 07:27:49PM +0800, Minda Chen wrote:
> Adds Specific Glue layer to support USB peripherals on
> StarFive JH7110 SoC.
> There is a Cadence USB3 core for JH7110 SoCs, the cdns
> core is the child of this USB wrapper module device.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Acked-by: Peter Chen <peter.chen@kernel.org>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> ---
>  MAINTAINERS                        |   6 +
>  drivers/usb/cdns3/Kconfig          |  11 ++
>  drivers/usb/cdns3/Makefile         |   1 +
>  drivers/usb/cdns3/cdns3-starfive.c | 246 +++++++++++++++++++++++++++++
>  4 files changed, 264 insertions(+)
>  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5519f81c8296..06c63f43bb17 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20168,6 +20168,12 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>  F:	drivers/phy/starfive/phy-jh7110-pcie.c
>  F:	drivers/phy/starfive/phy-jh7110-usb.c
>  
> +STARFIVE JH71X0 USB DRIVERS
> +M:	Minda Chen <minda.chen@starfivetech.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
> +F:	drivers/usb/cdns3/cdns3-starfive.c

Does not apply anymore, please rebase and resend.

thanks,

greg k-h
