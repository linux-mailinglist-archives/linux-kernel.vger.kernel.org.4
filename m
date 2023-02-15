Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC656983A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBOSoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBOSoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:44:01 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86B740CE;
        Wed, 15 Feb 2023 10:43:25 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so4127586pjd.1;
        Wed, 15 Feb 2023 10:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upzzaOYHVMOiSh2W0MdocuQzyFziZ8qGn/UeRPfAQVI=;
        b=NTG8tH5gBhkkEWrvBykmVJTM2OsGXLhBXGPvwyJy595QeCCd67kwiFhzU2+d24zNzb
         6xSwu1GEVbSUJDzkSWphwRRj3BaP4cYPxUJCoojTY7UBmDZzJQlFFVYnogZOZki56eby
         P5CiSGig2E5BDWDiZziSv5Syw+PcMVrbv77+Tq1DzqFc+YYMArT5DorsOeHlk6kxSkAb
         MW0lfRrHEOWhsFU35eBrcKgMvIcd9VHAAj5+TtLpwsJwQ4zQNXn+4vJMw1IYUfvFJsaz
         E91tmtwFUgsoLOu/dyGHn+vau/C9VwUUGH94ZKTSxGpMOJVT/HQZjDih32oTT4Qs5aIH
         IdeA==
X-Gm-Message-State: AO0yUKUT6seuB6zQpm+ZIhMitFJZtiCX6gAkBuSjGfMQozY6ZjWpq/T6
        3WkxofKL7h9/Qtq/4Sj8SgE=
X-Google-Smtp-Source: AK7set/LXHHDfN4gwzkO5CUp+FYEq1ZaxhCyLTWes+S+B4v5VF40uiT4MDOEx9nsP9jKhoYnApIdUg==
X-Received: by 2002:a17:90b:3eca:b0:234:721e:51e5 with SMTP id rm10-20020a17090b3eca00b00234721e51e5mr840255pjb.10.1676486544333;
        Wed, 15 Feb 2023 10:42:24 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:f2b7:9a62:c95d:fb83? ([2620:15c:211:201:f2b7:9a62:c95d:fb83])
        by smtp.gmail.com with ESMTPSA id ku12-20020a17090b218c00b0022c326ad011sm1792371pjb.46.2023.02.15.10.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 10:42:23 -0800 (PST)
Message-ID: <5b2a364e-0a8d-ffa6-139b-3e3e46a0213d@acm.org>
Date:   Wed, 15 Feb 2023 10:42:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/1] ufs: mcq: fix incorrectly set queue depth
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        avri.altman@wdc.com, mani@kernel.org, beanhuo@micron.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <da085383bec5c08bf34220ec6cc577f7a1b49ba8.1676396928.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <da085383bec5c08bf34220ec6cc577f7a1b49ba8.1676396928.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 09:50, Asutosh Das wrote:
> ufshcd_config_mcq() may change the can_queue value.
> The current code invokes scsi_add_host() before ufshcd_config_mcq().
> So the tags are limited to the old can_queue value.
> 
> Fix this by invoking scsi_add_host() after ufshcd_config_mcq().

Please add a Fixes: tag.

> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 3b3cf78..04e42b2 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8535,6 +8535,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
>   				use_mcq_mode = false;
>   				dev_err(hba->dev, "MCQ mode is disabled, err=%d\n",
>   					 ret);
> +			} else {
> +				ufshcd_config_mcq(hba);
>   			}

Please rework this code such that the success case (ret == 0) is handled 
first. That is the approach followed elsewhere in the Linux kernel.

Otherwise this patch looks good to me.

Thanks,

Bart.

