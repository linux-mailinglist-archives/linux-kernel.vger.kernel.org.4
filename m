Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD3703847
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbjEORbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbjEORad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:30:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED6510A2B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:27:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aae46e62e9so93227625ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684171666; x=1686763666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HV5hzOslSr/FLxQgkUOdAb0ubgv7oB3Gzqp0pqYMQsc=;
        b=X/eq65FBsDIPDo2Wfb1iwHSoJisHGVKTWyP2n3KTfJga69cQVWysciK1ZDjhlavC7r
         KF0RmdnEOogoZKah/bR6k20VbeKpwafYM9t8+/0zY0xRXIduYg5yKbZ9E6spflp3waIe
         GHVj0DHBIfvPtm7rnej1OBje66kBLGnnF/lbmDHV3A0dDQxPl5+hmVEmPpmEDv9w3OHh
         UdmxdlwCJkaUDXTY0670ar+7CIlGLDPLlRePUFxclSKX/9evlhDEUmIW0nfA20CB5udq
         MKNhHPmvJbbF59DU9avkZkGi6z+FgiUYleHpVpaKex3BexNZMM6HvJcuYogUEAzL7LUs
         da0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684171666; x=1686763666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV5hzOslSr/FLxQgkUOdAb0ubgv7oB3Gzqp0pqYMQsc=;
        b=YrQf+KauxHSO4N9IK8xQ/Q+JSED7vDi+0kradmg0pnC8JmvhBmY1cFftP3gXKwSF/l
         tAb5p1SGSHmcuAgkeop961L0YZs2zCW24N/k8B+jAAloIT7orpKCYfI6KA1+zfv+mwFq
         fyQ4Poo3uqi9gLE+ULpcpHhjMVMrUd+8VHBJQ5wAs2iF6ruOIJpQqrx6Mcbu6cUfIMDE
         3wcC3OBdS9Sr6+bQafxKvwj4loJGopk+1mJKUamBysp9MG5Vvsq2hkkvDSoQrnE/rN86
         f+CGd9E1TK8Cdd1+kzLFB5d76zfO470c40Qrlu+SmQ+M5B34UHcWnUpx5g9dLAFzly21
         acgg==
X-Gm-Message-State: AC+VfDyhDnRKkwy10ADm+V6jE5zkc6jF7G7f8ivp8VfCvHauZ1YHqQ6/
        IaM0VplCWlaFr72hlcNknCU08A==
X-Google-Smtp-Source: ACHHUZ7MrWABVtEdp/AF7fMlIN83m73eYhwUr7xcWs5Y2Ma+gMOWf1rxaW/Y38x6qhqzqMOLcvdB2A==
X-Received: by 2002:a17:902:a516:b0:1ab:1355:1a45 with SMTP id s22-20020a170902a51600b001ab13551a45mr32579411plq.30.1684171665794;
        Mon, 15 May 2023 10:27:45 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d401:af78:6aa0:cf61])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902aa8100b001aafb802efbsm13847316plr.12.2023.05.15.10.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 10:27:45 -0700 (PDT)
Date:   Mon, 15 May 2023 11:27:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] stm32mp15: update remoteproc to support SCMI
 Device tree
Message-ID: <ZGJrj9Vu2H9NZdlH@p14s>
References: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 11:39:22AM +0200, Arnaud Pouliquen wrote:
> Update vs V2[1]:
> ---------------
> - update yaml to remove label in examples
> - fix error management for  devm_reset_control_get_optional(dev, "hold_boot")
> - rebased on commit ac9a78681b92 ("Linux 6.4-rc1")
> 
> [1]https://lore.kernel.org/lkml/20230504094641.870378-1-arnaud.pouliquen@foss.st.com/T/
> 
> 
> Description:
> -----------
> This series updates the stm32_rproc driver and associated DT node to
> support device tree configuration with and without SCMI server. 
> The impact is mainly on the MCU hold boot management.
> 
> Three configurations have to be supported:
> 
> 1) Configuration without OP-TEE SCMI (legacy): Trusted context not activated
> - The MCU reset is controlled through the Linux RCC reset driver.
> - The MCU HOLD BOOT is controlled through The RCC sysconf.
> 
> 2) Configuration with SCMI server: Trusted context activated
> - The MCU reset is controlled through the SCMI reset service.
> - The MCU HOLD BOOT is no more controlled through a SMC call service but
>   through the SCMI reset service.
> 
> 3) Configuration with OP-TEE SMC call (deprecated): Trusted context activated
> - The MCU reset is controlled through the Linux RCC reset driver.
> - The MCU HOLD BOOT is controlled through The SMC call.
> 
> In consequence this series:
> - adds the use of the SCMI reset service to manage the MCU hold boot,
> - determines the configuration to use depending on the presence of the
>   "reset-names" property
>   if ( "reset-names" property contains "hold_boot")
>   then use reset_control services
>   else use regmap access based on "st,syscfg-holdboot" property.
> - set the DT st,syscfg-tz property as deprecated
> 
> Arnaud Pouliquen (4):
>   dt-bindings: remoteproc: st,stm32-rproc: Rework reset declarations
>   remoteproc: stm32: Allow hold boot management by the SCMI reset
>     controller
>   ARM: dts: stm32: Update reset declarations
>   ARM: dts: stm32: fix m4_rproc references to use SCMI
> 
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 44 +++++++++--
>  arch/arm/boot/dts/stm32mp151.dtsi             |  2 +-
>  arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts    |  6 +-
>  arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts    |  6 +-
>  arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts    |  6 +-
>  arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts    |  6 +-
>  drivers/remoteproc/stm32_rproc.c              | 76 ++++++++++++++-----
>  7 files changed, 111 insertions(+), 35 deletions(-)
> 

I have applied patch 1 and 2.  Unless Alexandre wants to proceed differently,
patches 3 and 4 should go through his tree.

Thanks,
Mathieu

> -- 
> 2.25.1
> 
