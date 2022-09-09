Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22A85B3F71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIITYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiIITYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:24:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62EA143431
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:24:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d82so2535653pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1YL3JOnJhxMrmebag05eoFsKq7z4k+Mtpi8WQ+HWkBA=;
        b=PFWHM6FNgcGzrNw+awdzUIJDCQyBKEQEKSlevJNyzCOj8tF/Q+hkpQjcpOciNhux9x
         A0OdJumurQVQi1hUylldetn/Dicm6OGl1cwgvO1EgKFkc6h2YtJrmqHz464PBtcjGDSd
         eXfyW4aqpypuN4Ldeon/6uequtYfihPaPzsVa1X9WircOCblJlS7alBk/5SPufUiqWWG
         EE9cRuQcpwjPvVozrW4ItoU1r+I9X/Y931Cq70WNq2wfK1a3Bx0nUxLlNqF5Q6ev919z
         q6vRtgguuTUyeeCPp2Bc4HBx070AZE40+M4agC1mW+twJFYyWDiT4mgb2YCdTMRCYVh+
         plwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1YL3JOnJhxMrmebag05eoFsKq7z4k+Mtpi8WQ+HWkBA=;
        b=sZERwAhTKeixoeLsmX01M8Xq5c9VRpI8hka0ZJsJBIMiIR6OQyagSe3Y2jXRdt7Aw5
         H4k2xWHbCB526HMxfvOArJS7u/xCjSV6jLD/aIq3jfmP9v7K3jF0W6UAtk1rmctJd9oL
         wg2ewnKEm0OYR4NkbZBo4vPO5yAbGlUbePGOLj97N2jcBjUwLkb0d/9XuhIYFeDUGJWj
         MjtI8XZkYfZwwsL3w+lfA2fX/vQjcWgii39MMjmFP1oyF4y7VTv5T3ijJ9L0nMNuE4s8
         Rc/EOO9xaJCsCtQugXrM7poKnlwT0vMxJzn3wd0+ba7AFgN8t7njxp9HgcYAFk9semSM
         mXaQ==
X-Gm-Message-State: ACgBeo1dvGtUVc9PBlPOIboQzrZwf7OBL32+729Sp+MF/QytKpfUOmtj
        VoYYDAGTSo/tNOVZMdk5oY5cFg==
X-Google-Smtp-Source: AA6agR5GxFgslNSJSVhP7jovTdqKbGSdAnXUIpR+aTUm3kfP3svOkUQ9KU1U48DF+jRxLqyIW2628g==
X-Received: by 2002:a63:5526:0:b0:434:c99c:6fdc with SMTP id j38-20020a635526000000b00434c99c6fdcmr13521836pgb.558.1662751441109;
        Fri, 09 Sep 2022 12:24:01 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001768452d4d7sm887925plg.14.2022.09.09.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:23:59 -0700 (PDT)
Date:   Fri, 9 Sep 2022 13:23:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Maria Yu <quic_aiquny@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_clew@quicinc.com
Subject: Re: [PATCH v1] remoteproc: core: do pm relax when not first crash
Message-ID: <20220909192357.GA319190@p14s>
References: <1662712413-38233-1-git-send-email-quic_aiquny@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662712413-38233-1-git-send-email-quic_aiquny@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maria,

On Fri, Sep 09, 2022 at 04:33:33PM +0800, Maria Yu wrote:
> Even if it is not first crash, need to relax the pm
> wakelock otherwise the device will stay awake.
> 

The goal is exactly to keep the device awake... 

> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e5279ed9a8d7..30078043e939 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1956,6 +1956,7 @@ static void rproc_crash_handler_work(struct work_struct *work)
>  	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
>  		/* handle only the first crash detected */
>  		mutex_unlock(&rproc->lock);
> +		pm_relax(rproc->dev.parent);

If we are here it means that rproc_crash_handler_work() has already been called
_and_ that a recovery is in process.  When the first crash handler completes
pm_relax() will be called and the device will go to sleep as expected.

Thanks,
Mathieu

>  		return;
>  	}
>  
> -- 
> 2.7.4
> 
