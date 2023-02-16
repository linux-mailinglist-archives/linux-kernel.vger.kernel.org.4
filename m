Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836FC698D33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBPGiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBPGis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:38:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98985FDA;
        Wed, 15 Feb 2023 22:38:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 639B7B8254D;
        Thu, 16 Feb 2023 06:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEF8C433EF;
        Thu, 16 Feb 2023 06:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676529505;
        bh=kNdtRxIM5pqt8Li3tt+4uiXP2y+kdvnnJ6b3JMf16Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMJYwEtd+tcbfzRi+M9XL5TC9XkZRFA1w1ONhD+G3ZcY2Xe8XuMMGDhmqpSjCGIGN
         doHBY5sN2MOhDjZTv8S3R+4NJfdZH/JJMCG8CxsVhveug5EO3zu4aH03Pt0LT62xpw
         7MjJHmk1oe4wpN8FQmXOwFqXoNU+aJTTqx3Da/ZA=
Date:   Thu, 16 Feb 2023 07:38:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
Message-ID: <Y+3PXRdbVFz/ErxW@kroah.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212417.3315422-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214212417.3315422-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:24:16PM -0800, Elliot Berman wrote:
> 
> When launching a virtual machine, Gunyah userspace allocates memory for
> the guest and informs Gunyah about these memory regions through
> SET_USER_MEMORY_REGION ioctl.

It also frees memory, see below.  Why not document that?

> +	case GH_VM_SET_USER_MEM_REGION: {
> +		struct gh_userspace_memory_region region;
> +
> +		if (copy_from_user(&region, argp, sizeof(region)))
> +			return -EFAULT;
> +
> +		/* All other flag bits are reserved for future use */
> +		if (region.flags & ~(GH_MEM_ALLOW_READ | GH_MEM_ALLOW_WRITE | GH_MEM_ALLOW_EXEC |
> +			GH_MEM_LENT))
> +			return -EINVAL;

Nice, thanks for validating that.


> +
> +

Nit, 2 blank lines are not needed :(


> +		if (region.memory_size)
> +			r = gh_vm_mem_alloc(ghvm, &region);
> +		else
> +			r = gh_vm_mem_free(ghvm, region.label);

So if you set the size to 0 it is freed?  Wouldn't a separate ioctl make
more sense?  Where is this logic documented to userspace?

thanks,

greg k-h
