Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA128675FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjATV1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjATV1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:27:09 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188866A302;
        Fri, 20 Jan 2023 13:27:09 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id z13so6432974plg.6;
        Fri, 20 Jan 2023 13:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fgA9NtWheAk/cGIu/EZjPSn92v+Slq1npUDliMGR/Q=;
        b=xwI0n7cAKR05fpzkkIkXQZ+JdRMoMgtZzvavisOl8koXIPNVG5t9QRUhZ5UYzAhO59
         586+0TGvdXrR9Yy32DcwPPo2nwPj57Zw3AOkGEPCY824UNp6TGyJRGI2jLXp5XCBJ7Jt
         F7DRHkXpzz2KoVw15l8S2uAtstPVw+ULm29KdAKdVss6O0L64TTvXlKmrXooP0qgjoMp
         Fcq/mELd/IGboh6DOjQTOKHSSdQk9zjMqGy/1V2DqqcqgpsdMFLWpWK8v5lZyBEmWdQN
         3k6113tNWN8Shzp3KQJL+7YyvTtIxcReYgP0e1IoRGij+7dOvBPhJhF3ObCvJlJ6LZj6
         +TwQ==
X-Gm-Message-State: AFqh2koLTH1OJXSAIPdDckOC3PXtF9HCsO7uyuB0zPc0fxguAZVrnkT+
        CidD7qcPgksAhmc6Pz6y3cA=
X-Google-Smtp-Source: AMrXdXv+u1TNi/2Kf+6Kvp2RumJYtKTh2CMd+8xKaWgQpuZg6dLNefrPu/cxXOZIuyEWPQIwrlUe9A==
X-Received: by 2002:a17:902:c409:b0:194:a854:6274 with SMTP id k9-20020a170902c40900b00194a8546274mr20324720plk.60.1674250028328;
        Fri, 20 Jan 2023 13:27:08 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:3a65:5ceb:1d3:9e21? ([2620:15c:211:201:3a65:5ceb:1d3:9e21])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b0019327a6abc2sm7629955plg.44.2023.01.20.13.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 13:27:07 -0800 (PST)
Message-ID: <9800d704-c436-a924-c2bb-ccdf51e86716@acm.org>
Date:   Fri, 20 Jan 2023 13:27:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/1] scsi: ufs: Add hibernation callbacks
Content-Language: en-US
To:     Anjana Hari <quic_ahari@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        konrad.dybcio@linaro.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_narepall@quicinc.com,
        quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com
References: <20230120113321.30433-1-quic_ahari@quicinc.com>
 <20230120113321.30433-2-quic_ahari@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230120113321.30433-2-quic_ahari@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 03:33, Anjana Hari wrote:
> +		/* Make sure that UTRL and UTMRL base address registers
> +		 * are updated with the latest queue addresses. Only after
> +		 * updating these addresses, we can queue the new commands.
> +		 */

Please follow the kernel coding style and start comment blocks with "/*" 
on a line by its own.

> +	/* Resuming from hibernate, assume that link was OFF */
> +	if (hba->restore)
> +		ufshcd_set_link_off(hba);

Why two successive 'if (hba->restore)' statements? Can these two 
if-statements be combined into a single if-statement?

> +int ufshcd_system_freeze(struct device *dev)
> +{
> +
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	/*
> +	 * Run time resume the controller to make sure
> +	 * the PM work queue threads do not try to resume
> +	 * the child (scsi host), which leads to errors as
> +	 * the controller is not yet resumed.
> +	 */
> +	pm_runtime_get_sync(hba->dev);
> +	ret = ufshcd_system_suspend(dev);
> +	pm_runtime_put_sync(hba->dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_system_freeze);

Why does the above function use 'hba->dev' instead of 'dev'?

I do not understand the comment in the above function. My understanding 
is that the power management core serializes hibernation and runtime 
power management. How could runtime resume be in progress when 
ufshcd_system_freeze() is called? Additionally, shouldn't 
ufshcd_system_freeze() skip the UFS controller if it is already runtime 
suspended instead of runtime resuming it? Some time ago I added the 
following code in sd_suspend_system() (commit 9131bff6a9f1 ("scsi: core: 
pm: Only runtime resume if necessary"):

	if (pm_runtime_suspended(dev))
		return 0;

Thanks,

Bart.
