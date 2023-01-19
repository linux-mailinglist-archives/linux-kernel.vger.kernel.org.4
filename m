Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5A674C73
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjATFeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjATFeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:34:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D794D7DFBC;
        Thu, 19 Jan 2023 21:29:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05155B82129;
        Thu, 19 Jan 2023 07:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E05C433EF;
        Thu, 19 Jan 2023 07:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674115183;
        bh=pKKL2++V2LWrneLPbZFMOa/GzAMecbfqoMLCr5AN248=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DeFFmDzj5d95mRvTYw7/wTDKRGk/n1kX/4BQt30Q4tGIODlIINATXyb3nhL6sDXsR
         W+trEXi0E8mT+tPqZoVyzrzrnFi83AIiZeHkZ4ZQhapyScl5s5db7H0fjiRJkGn+12
         VCWHakJi3Whk0y+QitH/mRJilBqTAlh0SvOnoEGFZP9AzeIS7fJq0oVZnNbJ8OaDP5
         70XEzgok5JWFclMip7D+2Tx7WZJvtalU/8Os0ktmF2KDb8KoM3kXJ+++Ku0k+JCGp+
         ttt34R3WBqi78ooZOZsRlMNNb3i10wJbdDd0lhoAZGvp2lvAncN+nfBAd0x+RdXuYZ
         jYku2HfpvoBlw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pIPqE-0005We-P1; Thu, 19 Jan 2023 09:00:10 +0100
Date:   Thu, 19 Jan 2023 09:00:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Define CMA region for CRD
 and X13s
Message-ID: <Y8j4ikRGiHC5m+y/@hovoldconsulting.com>
References: <20230117184630.2775905-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117184630.2775905-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:46:30AM -0800, Bjorn Andersson wrote:
> While booting the CRD, a series of CMA allocation errors can be seen in
> the kernel log:
> 
>   cma: cma_alloc: reserved: alloc failed, req-size: 128 pages, ret: -12
> 
> Growing the CMA region and querying /proc/meminfo indicates that a newly
> booted system (currently) uses 64MB CMA.

The NVMe driver buffers alone always take up 64 MB and in total roughly
92 MB is used on the CRD after boot here. Perhaps you're missing some
driver in you config (e.g. modem or wifi?).

On the X13s I even have 105 MB allocated after boot.

That's why I increased the CMA region to 128 MB in my out-of-tree
config, which is also what you are doing here but in the devicetree.

> Define a memory region sufficiently large for the current use cases, to
> avoid forcing users to add this themselves, through command line
> parameters etc.
> 
> While fixing the CRD define the same region for the X13s.
> 
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Updated commit message

> +
> +	reserved-memory {
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x8000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
>  };

Johan
