Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC86CAA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjC0QUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjC0QTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E745530CD;
        Mon, 27 Mar 2023 09:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AF926116F;
        Mon, 27 Mar 2023 16:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C41FC433D2;
        Mon, 27 Mar 2023 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679933944;
        bh=uIC5YyKuH9tQWq/Z0g9ekDH9Njb5iF1tEPWyq+/1ff8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzFo7wFIPom+hwEpRmw1TYBx9V01IZPD0+79PDwQDL64/P9MzSsgEuBZOVpxClv4K
         osWSSlCv2fUr/y6hfciDmaEAqrKHFYxlgWhCXkMy9X/9oUyhO30h/Whv3ZCQJNW6Pn
         ymTWf6wQCab0KcsyOftO9izSdO0NgBOQX4aC70vqApR9Pp/nReWRw0qINzt2qAZruw
         7XN4KY3LzMKlTYguow8iJjvy7OTVQfBfI992iubpf09a5pr9EwCfCcxI+M5ZIzxZGK
         DPiKf+GXL2O7HE8gU0XsqGyn3Xu+I16ygkloICF2tvlFZZtxv0+BG78KDis77QERy5
         T06KxcRmxXXdQ==
Date:   Mon, 27 Mar 2023 17:18:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, manivannan.sadhasivam@linaro.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        catalin.marinas@arm.com, robin.murphy@arm.com
Subject: Re: [PATCH V4 00/11] Fix XPU violation during modem metadata
 authentication
Message-ID: <20230327161857.GA32697@willie-the-truck>
References: <20230117085840.32356-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117085840.32356-1-quic_sibis@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Tue, Jan 17, 2023 at 02:28:29PM +0530, Sibi Sankar wrote:
> The memory region allocated using dma_alloc_attr with no kernel mapping
> attribute set would still be a part of the linear kernel map. Any access
> to this region by the application processor after assigning it to the
> remote Q6 will result in a XPU violation. Fix this by replacing the
> dynamically allocated memory region with a no-map carveout and unmap the
> modem metadata memory region before passing control to the remote Q6.
> The addition of the carveout and memunmap is required only on SoCs that
> mandate memory protection before transferring control to Q6, hence the
> driver falls back to dynamic memory allocation in the absence of the
> modem metadata carveout.

[...]

>   remoteproc: qcom_q6v5_mss: Use a carveout to authenticate modem
>     headers

With this change now merged, am I ok to downgrade the arm64
arch_dma_prep_coherent() back to a clean?

Thanks,

Will
