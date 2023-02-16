Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C83698D20
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBPGfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBPGfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:35:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D9141B50;
        Wed, 15 Feb 2023 22:35:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4B2861A1B;
        Thu, 16 Feb 2023 06:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50420C433EF;
        Thu, 16 Feb 2023 06:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676529344;
        bh=Y4GfQlxzKwZbc0WydlxWK4dEsOXa7BMquXaZxUfXd5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXq4JXzM6NOSyHEZD/wWTDygA1Lp21jSkGgMc3yKGLtu10FTY1hwRxExaVou4vrnz
         lLTxftZcN4ly8Bya8/VY+zR951hX4698mg3RebcNAGyIigevqSJrDeEEwd01iXeTfl
         8iZuaZihwaLA3VVCAXI6y5UjVfztgl+BPqamx4MY=
Date:   Thu, 16 Feb 2023 07:35:39 +0100
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
Subject: Re: [PATCH v10 13/26] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
Message-ID: <Y+3Ou02LwsfS0TLl@kroah.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212427.3316544-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214212427.3316544-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:24:26PM -0800, Elliot Berman wrote:
> +	case GH_VM_SET_DTB_CONFIG: {
> +		struct gh_vm_dtb_config dtb_config;
> +
> +		if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
> +			return -EFAULT;
> +
> +		dtb_config.size = PAGE_ALIGN(dtb_config.size);
> +		ghvm->dtb_config = dtb_config;

Do you really mean to copy this tiny structure twice (once from
userspace and the second time off of the stack)?  If so, why?

And where are the values of the structure checked for validity?  Can any
64bit value work for size and "gpa"?

thanks,

greg k-h
