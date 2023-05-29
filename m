Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19E07143AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjE2FUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjE2FUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A13A6;
        Sun, 28 May 2023 22:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B227D611F0;
        Mon, 29 May 2023 05:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9BEC433EF;
        Mon, 29 May 2023 05:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685337633;
        bh=yVoaOUXbOBC7CemKH4jxuLrA+Cy2P81i7fI7XtLeuiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sk9yj12NbE3zSbxGD88YDiRMuvNeTIz4Fs0F1URoFBTromRWGA7tY567RHMgEpgcu
         G+379bu3UpYFwAsxvgBf/II4WJLhKtneY1jKhWfES3LEyan8RK/q/x7G6YLngxa7nH
         QZ+mphtIwdVQnL19TIHMtxN+w/GUV4vwejQ1X7aP6jSJJh/xcM5jQ8LKYpmzSjICci
         WpryIn2E0eoiW3QU2PAtRjERWiUhc+0VIOmwYJuf91YBaC9AtP9PTID/ffJ5B7wEHU
         UgHcJo3qjPyy5G9+IyNNXMLQR/2lpkZDIrsESZ03MVtXRRflpOohs6ok3Jh4d8+L3h
         ybeZAVRsvVGRw==
Date:   Mon, 29 May 2023 10:50:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] soundwire: qcom: fix unbalanced pm_runtime_put()
Message-ID: <ZHQ2HMflBM6rKMrw@matsya>
References: <20230517163750.997629-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517163750.997629-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-23, 18:37, Krzysztof Kozlowski wrote:
> This reverts commit 57ed510b0547 ("soundwire: qcom: use
> pm_runtime_resume_and_get()") which introduced unbalanced
> pm_runtime_put(), when device did not have runtime PM enabled.
> 
> If pm_runtime_resume_and_get() failed with -EACCES, the driver continued
> execution and finally called pm_runtime_put_autosuspend().  Since
> pm_runtime_resume_and_get() drops the usage counter on every error, this
> lead to double decrement of that counter visible in certain debugfs
> actions on unattached devices (still in reset state):

Applied, thanks

-- 
~Vinod
