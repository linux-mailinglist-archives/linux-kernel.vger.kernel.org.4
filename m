Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414D26CD0FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjC2D7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjC2D7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:59:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288A30ED
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:59:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso14850776pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680062345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dul1KlrBtA46iTc3gyaCXFPUr7WrWHqPcvzFasASeEY=;
        b=aNcYNzD2Yv+TTWuv1e5vkYodJIsIihMIylShdg4J4xTW1CXqXRhMx1IQVZydyLL2jb
         g+LjctlkLrUEAZmPquc7SVJeYISB7PQI3DJ0eNGbexUptVX6D47lsVL3KrxsoZornnlQ
         aJ6ImRvoXhQIh6I6MDiatUfjatku1kTe63Jt+D9ksvloTno6vr0lPscxH/KfD0WxbNHq
         0ozbWx1hTXDvHfFwZPa+I0IPh4ZkgzzsEzsrfOqF/Pzo7nFfVHYA998tpThhMuSUChXC
         6opnMuDVAYqOfbVGZqegT1exobUSYYY/+qtyabpFSvdREeIDBSgXy5cPciqz6TEcTUL3
         YBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680062345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dul1KlrBtA46iTc3gyaCXFPUr7WrWHqPcvzFasASeEY=;
        b=hugv7e3bVP/dnWXeHX0yYsAXItKdtXLvpC3TVw78rIkFO333iv45NSiAXvrYq3uSYE
         qNfDJ0wv3mfoNy/ISpMoKoXwjry3Wnt72QKpjFFdc8ZKx9oKti50FODpfMjLK9bubCox
         kRdT8/CRbxncNw0pAv7sY0N7MpaxEhvtMf8miIilGOyIofTQgZWhsIhrZ4+GB/g88DmX
         0wKIfkZGhKHCLBtfR/R348J7IxeuO0LD5SyhL2FBcKa1lr9LMPwpC3X3fTZp5QC+0TgG
         IUNeWGRYhfGRxxaI/W3/JHw3GyMzAq4mNPMp4KUBo7cU1E7psy69WdDbZ01mFjEbC4oJ
         1Z8Q==
X-Gm-Message-State: AO0yUKXM2VkfzxTOTkQYQrSoxuomizGrNpO7Vd2uCrt97l+m+1EVDjxT
        q2joR0twng5X0eKn6VC1n+N7mw==
X-Google-Smtp-Source: AK7set/Lbxss6dIB0PWdWHkTbJl6aZ51bZjCdILJWU+FOnO4dX+3ErUoUd/XkpipicnvrQWi+J6Phg==
X-Received: by 2002:a05:6a20:891d:b0:d5:2a56:15b1 with SMTP id i29-20020a056a20891d00b000d52a5615b1mr15514520pzg.5.1680062345705;
        Tue, 28 Mar 2023 20:59:05 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o4-20020a655204000000b005133f658f1asm6509789pgp.94.2023.03.28.20.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 20:59:05 -0700 (PDT)
Date:   Wed, 29 Mar 2023 11:58:59 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Resolve MPM register space situation
Message-ID: <20230329035859.GD3554086@dragon>
References: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:02:51PM +0200, Konrad Dybcio wrote:
> The MPM (and some other things, irrelevant to this patchset) resides
> (as far as the ARM cores are concerned, anyway) in a MMIO-mapped region
> that's a portion of the RPM (low-power management core)'s RAM, known
> as the RPM Message RAM. Representing this relation in the Device Tree
> creates some challenges, as one would either have to treat a memory
> region as a bus, map nodes in a way such that their reg-s would be
> overlapping, or supply the nodes with a slice of that region.
> 
> This series implements the third option, by adding a qcom,rpm-msg-ram
> property, which has been used for some drivers poking into this region
> before. Bindings ABI compatibility is preserved through keeping the
> "normal" (a.k.a read the reg property and map that region) way of
> passing the register space.
> 
> Example representation with this patchset:
> 
> / {
> 	[...]
> 
> 	mpm: interrupt-controller {
> 		compatible = "qcom,mpm";
> 		qcom,rpm-msg-ram = <&apss_mpm>;
> 		[...]
> 	};
> 
> 	[...]
> 
> 	soc: soc@0 {
> 		[...]
> 
> 		rpm_msg_ram: sram@45f0000 {
> 			compatible = "qcom,rpm-msg-ram", "mmio-sram";
> 			reg = <0 0x045f0000 0 0x7000>;
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			ranges = <0 0x0 0x045f0000 0x7000>;
> 
> 			apss_mpm: sram@1b8 {
> 				reg = <0x1b8 0x48>;

Per "vMPM register map" in the driver, the slice size should be 0x44
instead of 0x48.  Is there one register missing from the driver
comment?

PS. It seems the "n" formula in the driver comment should be corrected
as below.

  n = DIV_ROUND_UP(pin_cnt, 32) - 1

Shawn

> 			};
> 		};
> 	};
> };
