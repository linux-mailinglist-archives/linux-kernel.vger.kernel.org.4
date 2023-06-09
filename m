Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB79729CE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbjFIOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbjFIOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C14730D7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686320961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SeFjQ+AIqSoCw9oUu0kheJJ6w4RLgwEZPguDnMov+Ro=;
        b=Jt9wSEpMLIQg3X78KTApvIPitabofva+3/b9CVg6xSBIBkN83TWajt0unsS50iqxdFFle8
        tOgicfBVeNFO2jtqi8iVWBZZjYN54fhEHzvAT1I4wzBV2E2rg650wnWcfwq0BQp5Ei8lzM
        8NNG53uPemeQhFJpVqdZE+wZIt3Q2e4=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-52BSY-SqOt-JMT6itr_wFA-1; Fri, 09 Jun 2023 10:29:20 -0400
X-MC-Unique: 52BSY-SqOt-JMT6itr_wFA-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-bb2a7308f21so2572137276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686320960; x=1688912960;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeFjQ+AIqSoCw9oUu0kheJJ6w4RLgwEZPguDnMov+Ro=;
        b=dkBVd6Y500j0edBThjkXsbF7+AZNjKTFhH91ftlbvDkHvpw5sqIETagnRay+tRzdz0
         XJN3FQL22leEDogRDjHYTdmFZM5j1i2y2AopHFPEPEt71IKGO127cRZFuZxqsOeJfvHk
         PIN55NNg+lH/b3e+CNtTK3pPQJXd/K9B1wHPwABV10+llurEAWdcJBIoupMO2dSmSaBW
         +Q8Be4JsCoGRenR/mVb0+XeofWwPnuITSf7W+bLmUdMepD0TxTahHHLQT9Hm7W43pLuW
         AlKdkjZHMrY3RKOUie0IHEs4stbjAg2Vv0WGl8uTtwVXEtUeKDUL4Txn61byZri+7FR3
         mWAg==
X-Gm-Message-State: AC+VfDw4XiPmPIQKJoO6nv28t0aSE/nnp2X0t3ly4l78ie5mH5L9Opnp
        uGETxA7sYCTGnzY4O5U/iI2bKbMCo+tG0yRHquQWIIgX2IFPoQkRbusA9ozg0400pzvxwsHnYiH
        io8/XYu2CyoDrUVh8xelH3Ymv
X-Received: by 2002:a25:f50f:0:b0:ba8:66fb:dd84 with SMTP id a15-20020a25f50f000000b00ba866fbdd84mr1101344ybe.20.1686320960005;
        Fri, 09 Jun 2023 07:29:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TEL5O7n3UfPsYTiUfzgwgsZext91z/RVtBWG4mbDyI3+V4ZyAbGaL21xcL2PV/gyhI4oc1Q==
X-Received: by 2002:a25:f50f:0:b0:ba8:66fb:dd84 with SMTP id a15-20020a25f50f000000b00ba866fbdd84mr1101326ybe.20.1686320959702;
        Fri, 09 Jun 2023 07:29:19 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id c5-20020a5b0145000000b00bb144da7d68sm905217ybp.13.2023.06.09.07.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:29:18 -0700 (PDT)
Date:   Fri, 9 Jun 2023 10:29:16 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richardcochran@gmail.com, echanude@redhat.com
Subject: Re: [PATCH] arm64: dts: qcom: sa8540p-ride: Specify ethernet phy OUI
Message-ID: <ZIM3PPXi+ed3CJ2J@brian-x1>
References: <20230608201513.882950-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608201513.882950-1-ahalaney@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
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

On Thu, Jun 08, 2023 at 03:15:13PM -0500, Andrew Halaney wrote:
> With wider usage on more boards, there have been reports of the
> following:
> 
>     [  315.016174] qcom-ethqos 20000.ethernet eth0: no phy at addr -1
>     [  315.016179] qcom-ethqos 20000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
> 
> which has been fairly random and isolated to specific boards.
> Early reports were written off as a hardware issue, but it has been
> prevalent enough on boards that theory seems unlikely.
> 
> In bring up of a newer piece of hardware, similar was seen, but this
> time _consistently_. Moving the reset to the mdio bus level (which isn't
> exactly a lie, it is the only device on the bus so one could model it as
> such) fixed things on that platform. Analysis on sa8540p-ride shows that
> the phy's reset is not being handled during the OUI scan if the reset
> lives in the phy node:
> 
>     # gpio 752 is the reset, and is active low, first mdio reads are the OUI
>     modprobe-420     [006] .....   154.738544: mdio_access: stmmac-0 read  phy:0x08 reg:0x02 val:0x0141
>     modprobe-420     [007] .....   154.738665: mdio_access: stmmac-0 read  phy:0x08 reg:0x03 val:0x0dd4
>     modprobe-420     [004] .....   154.741357: gpio_value: 752 set 1
>     modprobe-420     [004] .....   154.741358: gpio_direction: 752 out (0)
>     modprobe-420     [004] .....   154.741360: gpio_value: 752 set 0
>     modprobe-420     [006] .....   154.762751: gpio_value: 752 set 1
>     modprobe-420     [007] .....   154.846857: gpio_value: 752 set 1
>     modprobe-420     [004] .....   154.937824: mdio_access: stmmac-0 write phy:0x08 reg:0x0d val:0x0003
>     modprobe-420     [004] .....   154.937932: mdio_access: stmmac-0 write phy:0x08 reg:0x0e val:0x0014
> 
> Moving it to the bus level, or specifying the OUI in the phy's
> compatible ensures the reset is handled before any mdio access
> Here is tracing with the OUI approach (which skips scanning the OUI):
> 
>     modprobe-549     [007] .....    63.860295: gpio_value: 752 set 1
>     modprobe-549     [007] .....    63.860297: gpio_direction: 752 out (0)
>     modprobe-549     [007] .....    63.860299: gpio_value: 752 set 0
>     modprobe-549     [004] .....    63.882599: gpio_value: 752 set 1
>     modprobe-549     [005] .....    63.962132: gpio_value: 752 set 1
>     modprobe-549     [006] .....    64.049379: mdio_access: stmmac-0 write phy:0x08 reg:0x0d val:0x0003
>     modprobe-549     [006] .....    64.049490: mdio_access: stmmac-0 write phy:0x08 reg:0x0e val:0x0014
> 
> The OUI approach is taken given the description matches the situation
> perfectly (taken from ethernet-phy.yaml):
> 
>     - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
>       description:
>         If the PHY reports an incorrect ID (or none at all) then the
>         compatible list may contain an entry with the correct PHY ID
>         in the above form.
>         The first group of digits is the 16 bit Phy Identifier 1
>         register, this is the chip vendor OUI bits 3:18. The
>         second group of digits is the Phy Identifier 2 register,
>         this is the chip vendor OUI bits 19:24, followed by 10
>         bits of a vendor specific ID.
> 
> With this in place the sa8540p-ride's phy is probing consistently, so
> it seems the floating reset during mdio access was the issue. In either
> case, it shouldn't be floating so this improves the situation. The below
> link discusses some of the relationship of mdio, its phys, and points to
> this OUI compatible as a way to opt out of the OUI scan pre-reset
> handling which influenced this decision.
> 
> Link: https://lore.kernel.org/all/dca54c57-a3bd-1147-63b2-4631194963f0@gmail.com/
> Fixes: 57827e87be54 ("arm64: dts: qcom: sa8540p-ride: Add ethernet nodes")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

