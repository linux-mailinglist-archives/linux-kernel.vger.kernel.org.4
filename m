Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD55FAD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJKHUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKHUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:20:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037333A2F;
        Tue, 11 Oct 2022 00:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DEF9B81201;
        Tue, 11 Oct 2022 07:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C60C433D7;
        Tue, 11 Oct 2022 07:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665472837;
        bh=/8HeXdDL44KxP1+8V4r577mz41Pbncg8nfnzpe0Uy+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWNzE2f7GJx+sDmABCspUuoQSud9KlR8uPRpFPqVr2JkoWMDNvixagqxNIrtW5UEg
         WqEVhe4rprezKarJQ+N65K9SlqMd3+4vxSa1TO+2sN3ghNBbjmQ56Q2F9m8usre6xn
         R4MhKFJ3d7zWSbs7ITCCKyM8njzdaTl4AlTThUTk=
Date:   Tue, 11 Oct 2022 09:21:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
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
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/13] gunyah: Common types and error codes for Gunyah
 hypercalls
Message-ID: <Y0UZcLl20HobX4w3@kroah.com>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-4-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011000840.289033-4-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 05:08:30PM -0700, Elliot Berman wrote:
> Add architecture-independent standard error codes, types, and macros for
> Gunyah hypercalls.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  MAINTAINERS                  |  1 +
>  include/asm-generic/gunyah.h | 74 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 include/asm-generic/gunyah.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef6de7599d98..4fe8cec61551 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8886,6 +8886,7 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>  F:	Documentation/virt/gunyah/
> +F:	include/asm-generic/gunyah.h
>  
>  HABANALABS PCI DRIVER
>  M:	Oded Gabbay <ogabbay@kernel.org>
> diff --git a/include/asm-generic/gunyah.h b/include/asm-generic/gunyah.h
> new file mode 100644
> index 000000000000..64a02dd3b5ad
> --- /dev/null
> +++ b/include/asm-generic/gunyah.h

Why not include/linux/gunyah.h?  Why asm-generic?  This is not an
architecture.

thanks,

greg k-h
