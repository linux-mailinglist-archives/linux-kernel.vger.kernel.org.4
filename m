Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743255F0B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiI3MGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiI3MGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:06:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6B8137445;
        Fri, 30 Sep 2022 05:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B59562312;
        Fri, 30 Sep 2022 12:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1F7C43470;
        Fri, 30 Sep 2022 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664539592;
        bh=S0mIJgFJM3dB0uXkyvoEXDo0PcaqtEvOtb8hBS/fxbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=heTjtm23rTZZUFi4PzjAN4DjWv/LUcSl0Yx3aXcuL+YSVPcRR7i/k72s5IUjC2MNV
         d8et357QAxsU5Hjn26cXoms6XPU26b/l8qxlrge1FBciyMHeZjHG4UHRzW7QRoJ11S
         M2T881APkkOAXWsSjLR2wNJwRhJSbmTolvBZQPWc=
Date:   Fri, 30 Sep 2022 14:06:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/14] gunyah: sysfs: Add node to describe supported
 features
Message-ID: <YzbbxuInZwILaflH@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-11-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928195633.2348848-11-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:56:29PM -0700, Elliot Berman wrote:
> Add a sysfs node to list the features that the Gunyah hypervisor and
> Linux supports. For now, Linux support cspace (capability IDs) and
> message queues, so only report those..
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  Documentation/ABI/testing/sysfs-hypervisor-gunyah | 15 +++++++++++++++
>  drivers/virt/gunyah/sysfs.c                       | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-hypervisor-gunyah b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
> index 7d74e74e9edd..6d0cde30355a 100644
> --- a/Documentation/ABI/testing/sysfs-hypervisor-gunyah
> +++ b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
> @@ -1,3 +1,18 @@
> +What:		/sys/hypervisor/gunyah/features
> +Date:		October 2022
> +KernelVersion:	6.1
> +Contact:	linux-arm-msm@vger.kernel.org
> +Description:	If running under Gunyah:
> +		Space separated list of features supported by Linux and Gunyah:
> +		"cspace": Gunyah devices
> +		"doorbell": Sending/receiving virtual interrupts via Gunyah doorbells
> +		"message-queue": Sending/receiving messages via Gunyah message queues
> +		"vic": Interrupt lending
> +		"vpm": Virtual platform management
> +		"vcpu": Virtual CPU management
> +		"memextent": Memory lending/management
> +		"trace": Gunyah hypervisor tracing

Please no.  Why do you really need this type of list?  What hypervisor
will NOT have them all present already?  Who will use this file and what
will it be used for?

sysfs files should just be 1 value and not need to be parsed.  Yes, we
have lists of features at times, but really, you need a very very good
reason why this is the only way this information can be exposed and who
is going to use it in order to be able to have this accepted.

thanks,

greg k-h
