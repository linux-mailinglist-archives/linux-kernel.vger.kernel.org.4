Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F3F7285A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjFHQpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbjFHQpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:45:12 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001861988;
        Thu,  8 Jun 2023 09:44:46 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1b0201d9a9eso6522305ad.0;
        Thu, 08 Jun 2023 09:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242668; x=1688834668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oN2uOH0xhwYXRY/SUrWmPeIn7QoShRPlGWgaIgQS6r4=;
        b=ddvoep2otUmoMhogBYdCG5Kfe2y4gZpVEqDCsbfB5Q9T8FYEnVWNHhfUTpVhwh4PTc
         z607KGeX5d1ekzjK7uv3TlSE/fXlAzd8r+8J9psoK4JwqPARaG/8bgr1QR3sbkn3zQfD
         1D+wuTZiW3nKDywRoDmIHl72l2xU+Znl3Q62U9ULRSYXdEUlI3OpGMDnpcrbgocU0l9t
         fXA5spECkNI2U6zrH3ZlMBnjRwuNyfoLMSEK7xgtDqLMNpbRo2vBkf0L3PozqtqRx98m
         JpS5b1qeNC2TDJOlec6KHcdU7sMngWwe+Lj5WnRzTQRRzYZj6A53VljIBowA2x5qiZBC
         yS3Q==
X-Gm-Message-State: AC+VfDx+MCIrVIODC+SxhJmz3JU0oaZVqzY2p2hOA6uiLo7Iwga+94gi
        PVKvVDQ1+SiAjLiui/4SzVs=
X-Google-Smtp-Source: ACHHUZ5YgRX5F9XBcpzjZARPQoDBlDS2FlIk8uTpKvyOLhBm9cLOX9pyVA2SlyP8GyTPa/QFqW0iDQ==
X-Received: by 2002:a17:903:64f:b0:1b1:bcea:c8f7 with SMTP id kh15-20020a170903064f00b001b1bceac8f7mr2616299plb.15.1686242667710;
        Thu, 08 Jun 2023 09:44:27 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id jk14-20020a170903330e00b001b050df0a93sm1659550plb.93.2023.06.08.09.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:44:27 -0700 (PDT)
Message-ID: <7c13f4f8-0921-5a15-70bc-248550f1efa4@acm.org>
Date:   Thu, 8 Jun 2023 09:44:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] scsi: ufs: wb: Add explicit flush_threshold sysfs
 attribute
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Daniil Lunev <dlunev@chromium.org>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230608101642.40086-1-luhongfei@vivo.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230608101642.40086-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 03:16, Lu Hongfei wrote:
> +static ssize_t wb_flush_threshold_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", hba->vps->wb_flush_threshold);
> +}

Since wb_flush_threshold is unsigned, please change %d into %u.

> +	if (!ufshcd_is_wb_allowed(hba)) {
> +		dev_warn(dev, "It is not allowed to configure WB buf flush threshold!\n");
> +		return -EOPNOTSUPP;
> +	}

The above check prevents configuring the flush threshold before enabling 
the write booster mechanism. I don't think users will like this. Please 
leave out the above check.

> +	if (kstrtouint(buf, 0, &wb_flush_threshold))
> +		return -EINVAL;
> +
> +	/* The range of values for wb_flush_threshold is (0,10] */
> +	if (wb_flush_threshold <= 0 || wb_flush_threshold > 10) {
> +		dev_err(dev, "The value of wb_flush_threshold is invalid!\n");
> +		return -EINVAL;
> +	}

Please change '10' in the above code into UFS_WB_BUF_REMAIN_PERCENT(100) 
to make the above code easier to read.

Thanks,

Bart.
