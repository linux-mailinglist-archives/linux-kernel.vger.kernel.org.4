Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48286FE43C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjEJSx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjEJSxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:53:55 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C319A2;
        Wed, 10 May 2023 11:53:54 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so3575794b3a.3;
        Wed, 10 May 2023 11:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683744834; x=1686336834;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XZnXZk2NqNpZbu4ppDYH+lMIUnLxZBrdrLy3iG8Aa8=;
        b=mBTxO1/kU9efMJdBRh7elV1kxyqMZIH/fZehDAYB/rGAUQxPEyuZH0hSkfeoWpkCAF
         LhQoOO5JpM15T3ZljMBSUtlIb6BOQVbRuTymYNIP7nQnebDE2TM/qKDZHUHiTKCFkLYN
         yL/dsW9ET4qtLdrUfyLYnaeLZ30MWIDnWIZaKJ2XNLoAZ+VuT8e0ed4jeYDYEx1N+6wK
         1JBVb0cxDAAOs6ygKIYg+ZE1Hw2zuleTGN0w7AkXKtvHPKITME4dYGY2x/1EGqwh1W38
         8nRNnnV/LMZGEDd4/g7Np/Xft3seD4OLDJlvCl6gAsePUv+c3F+/02Ph5veN990bm39s
         hGhg==
X-Gm-Message-State: AC+VfDyhSPgzq3ahlKNQASYb9P/dJ4RNpN7D0efY+5+hi34L2e/C1+sS
        z7wDJ89d3P7r+bSysm8TFnpRwbefk3+HGQ==
X-Google-Smtp-Source: ACHHUZ7HVQwdpYNHayRmEK7RfOJmhYOj4rPihYbqAz35h7Lwx5+EkcXZaO2LHdWD25WtT/YAFPJSgQ==
X-Received: by 2002:a05:6a00:2e0e:b0:63d:24c0:1223 with SMTP id fc14-20020a056a002e0e00b0063d24c01223mr27077278pfb.29.1683744833649;
        Wed, 10 May 2023 11:53:53 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:62b7:b46c:dff7:98a0? ([2001:4958:15a0:30:62b7:b46c:dff7:98a0])
        by smtp.gmail.com with ESMTPSA id t7-20020aa79387000000b0063f2a5a59d1sm3828371pfe.190.2023.05.10.11.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 11:53:53 -0700 (PDT)
Message-ID: <3b0a9357-88a6-c435-34d6-c75e9dfe9aaa@acm.org>
Date:   Wed, 10 May 2023 11:53:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH v1] ufs: poll HCS.UCRDY before issuing a UIC command
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com
References: <CGME20230509083312epcas2p375f77d18a9026f7d263750baf9c9a5bb@epcas2p3.samsung.com>
 <1683620674-160173-1-git-send-email-kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1683620674-160173-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 01:24, Kiwoong Kim wrote:
> With auto hibern8 enabled, UIC could be working
> for a while to process a hibern8 operation and HCI
> reports UIC not ready for a short term through HCS.UCRDY.
> And UFS driver can't recognize the operation.
> UFSHCI spec specifies UCRDY like this:
> whether the host controller is ready to process UIC COMMAND
> 
> The 'ready' could be seen as many different meanings. If the meaning
> includes not processing any request from HCI, processing a hibern8
> operation can be 'not ready'. In this situation, the driver needs to
> wait until the operations is completed.
> 
> Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> ---
>   drivers/ufs/core/ufshcd.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 96ce6af..fc79539 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2368,7 +2368,18 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>    */
>   static inline bool ufshcd_ready_for_uic_cmd(struct ufs_hba *hba)
>   {
> -	return ufshcd_readl(hba, REG_CONTROLLER_STATUS) & UIC_COMMAND_READY;
> +	ktime_t timeout = ktime_add_ms(ktime_get(), UIC_CMD_TIMEOUT);
> +	u32 val = 0;
> +
> +	do {
> +		val = ufshcd_readl(hba, REG_CONTROLLER_STATUS) &
> +			UIC_COMMAND_READY;
> +		if (val)
> +			break;
> +		usleep_range(500, 1000);
> +	} while (ktime_before(ktime_get(), timeout));
> +
> +	return val ? true : false;
>   }
>   
>   /**

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
