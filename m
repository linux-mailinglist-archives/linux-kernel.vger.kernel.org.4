Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063B970A2B7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjESWQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjESWQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:16:12 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A2018F;
        Fri, 19 May 2023 15:16:10 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ae615d5018so22475885ad.1;
        Fri, 19 May 2023 15:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684534570; x=1687126570;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtM0QQIU8DI6fo0EMR+USpkpdkW5a7e0M4zESvox7Pk=;
        b=VlfYDjeYSXtsAVV1ctXqWpvBTdQ+hKbVB477AHvtu1BX1+MXxrlXn5coABgXSipqty
         EEtDzS7M4G4ZED2jSLlFaowg0rdop0J8ndufnArOuFJg40Xs8dd1ne6WntFO+exVXrSI
         fO3MAuF07IEWpMuqFuC0s8V0M2r4KewNDOgBvOjEl8L5hoz0jqd3++yfvQLnBCOsd9MR
         tC+moHzsiMeSbqzu/KdgnjCempSZRfEeHgfslrGnf5+W6UFWDAsavhysPlHd9Zg8RwPc
         7BpWScgWuVkGykUt+dswDX+N8o7m4glqIFaiurlvqgkuwErJa91rxsxI4IBXUre3faOJ
         uztg==
X-Gm-Message-State: AC+VfDzgRLpeTEYsbrg752dBBbiOyi4VwdPfW3MZC5UGoleK9CVs/Huu
        vKGrMlh6hTRqlLmo+CkO9jU=
X-Google-Smtp-Source: ACHHUZ6aAxD485/wVKDZ0bBQlfeObDUeCRkHxLNbStjrAHM+Rv/2TWXWJKQ4OabwG5a3QwDd3nuChg==
X-Received: by 2002:a17:902:7d8d:b0:1ab:19db:f2b with SMTP id a13-20020a1709027d8d00b001ab19db0f2bmr4087054plm.36.1684534570327;
        Fri, 19 May 2023 15:16:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:102a:f960:4ec2:663d? ([2620:15c:211:201:102a:f960:4ec2:663d])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902740200b001ac84f87b1dsm111904pll.155.2023.05.19.15.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 15:16:09 -0700 (PDT)
Message-ID: <a7296997-89a1-2fb6-3bb4-1fc60d50a132@acm.org>
Date:   Fri, 19 May 2023 15:16:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ufs: poll HCS.UCRDY before issuing a UIC command
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, kwangwon.min@samsung.com
References: <CGME20230516034218epcas2p297e9c5a33d370c8c45a40ab58f500ae0@epcas2p2.samsung.com>
 <1684208012-114324-1-git-send-email-kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1684208012-114324-1-git-send-email-kwmad.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 20:33, Kiwoong Kim wrote:
> v1 -> v2: replace usleep_range with udelay
> because it's a sleepable period.
> 
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
> index 9434328..5f6819a 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2365,7 +2365,18 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
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
> +		udelay(500);
> +	} while (ktime_before(ktime_get(), timeout));
> +
> +	return val ? true : false;
>   }

Sleeping during up to 500 ms while holding a spin lock is not acceptable.
Has it been considered to modify the UFS core such that the host_lock is
not held around calls of the above function, e.g. via the (untested) patch
below?

Thanks,

Bart.


diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 9736b2b4120e..394283b04d7c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2416,7 +2416,6 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
  		      bool completion)
  {
  	lockdep_assert_held(&hba->uic_cmd_mutex);
-	lockdep_assert_held(hba->host->host_lock);

  	if (!ufshcd_ready_for_uic_cmd(hba)) {
  		dev_err(hba->dev,
@@ -2452,9 +2451,7 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
  	mutex_lock(&hba->uic_cmd_mutex);
  	ufshcd_add_delay_before_dme_cmd(hba);

-	spin_lock_irqsave(hba->host->host_lock, flags);
  	ret = __ufshcd_send_uic_cmd(hba, uic_cmd, true);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
  	if (!ret)
  		ret = ufshcd_wait_for_uic_cmd(hba, uic_cmd);

@@ -4122,8 +4119,8 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
  		wmb();
  		reenable_intr = true;
  	}
-	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
  	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
  	if (ret) {
  		dev_err(hba->dev,
  			"pwr ctrl cmd 0x%x with mode 0x%x uic error %d\n",

