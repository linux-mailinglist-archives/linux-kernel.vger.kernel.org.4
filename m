Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006BB7381FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjFULC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjFULCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:02:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C010FF;
        Wed, 21 Jun 2023 04:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 677CF614D8;
        Wed, 21 Jun 2023 11:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44444C433C0;
        Wed, 21 Jun 2023 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687345368;
        bh=N49s8hoCPzg/d/5Yqx/JLNELPTMhdz+fJaCZkodGWio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gs93SjTKfmM5tRP9D9zbsuHGo9f6Xh4kgyR0a6U1XttmyhFNhs7BavEpTXdRxLVaA
         oD7wG0QOriYFbwHHdnAQC8YDhFlDhY5Q20yEP9aKQkxdhrOtiUAccszGIDq0TDZTlP
         y1SZqSoIae7Tm+BlZMYX0sOdoTGYAVg1soxbYZjN1sa968M9SyIymcHeGOXLa9JoRK
         ldl3lUHnyjgd9Wm+z+tKOZ0W1W4l9xXUgr0edpy3wQWWE2yU6nXJqtyP90yXI+rdck
         Dstw6M3vrqSJirEhKXyx0q35sQ98fhhmJRPwXLz79SLJeneCJYThdsBuNDnfo+7y1q
         H3Ti9T5en087g==
Date:   Wed, 21 Jun 2023 16:32:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] soundwire: qcom: fix storing port config out-of-bounds
Message-ID: <ZJLY1A4es4CQpDxr@matsya>
References: <20230601102525.609627-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601102525.609627-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-23, 12:25, Krzysztof Kozlowski wrote:
> The 'qcom_swrm_ctrl->pconfig' has size of QCOM_SDW_MAX_PORTS (14),
> however we index it starting from 1, not 0, to match real port numbers.
> This can lead to writing port config past 'pconfig' bounds and
> overwriting next member of 'qcom_swrm_ctrl' struct.  Reported also by
> smatch:
> 
>   drivers/soundwire/qcom.c:1269 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14

Applied, thanks

-- 
~Vinod
