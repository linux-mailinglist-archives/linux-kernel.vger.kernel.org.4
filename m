Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA74675F77
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjATVMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATVMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:12:13 -0500
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A0D891F5;
        Fri, 20 Jan 2023 13:12:12 -0800 (PST)
Received: by mail-pg1-f169.google.com with SMTP id b12so5083000pgj.6;
        Fri, 20 Jan 2023 13:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWERe0yn9/AI89G8p3N0eQK3PGKu0XJFyAh8xZoq6E0=;
        b=X/uyD9rwyPPxhk+abszMBVfjDGHGD0922zuWZC5KHnOrPioANuKpCKFwXUvyH+bZiu
         x3hmjICiVzNT6WQOMdfBEwoAlAvPSAodbaVaYEpKFmEnZ3EPLp1NjDjV/LL7KyYRnoST
         bRXEeN+PLZwn31b7PS2dNa46Z6orWE4JuP0mjQjuuJ9jhBgGQKOXQ3kBTX/g0oM8Oq14
         1u8rWePndlaSEwexJUbrdsqb84XOkbYUPAmNgW5uiC6qyE80xeNTj1dIm8L5v3br0jG3
         MkHix6TbN2PjRkuVVATwLGpMXb0VEXeDhZBGIQfHo04KMnXVQMlK35NSI5ar+F7Ib8+2
         Yz/g==
X-Gm-Message-State: AFqh2koOsdZIe9meBZJjT7R9ElNBDWOCIyFRxtFzEuOMux2kve0ocJxn
        tC9Z49Hf3o6+b/A0tOet09I=
X-Google-Smtp-Source: AMrXdXuYGRlxjz4gBxaOCK8e/yF9OY3LqXaKknGVtettqZjH9a46t2ycs1LButfG05UeGaY+uUfVzQ==
X-Received: by 2002:aa7:946b:0:b0:58b:c873:54e1 with SMTP id t11-20020aa7946b000000b0058bc87354e1mr20707653pfq.24.1674249131802;
        Fri, 20 Jan 2023 13:12:11 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:3a65:5ceb:1d3:9e21? ([2620:15c:211:201:3a65:5ceb:1d3:9e21])
        by smtp.gmail.com with ESMTPSA id h124-20020a628382000000b0058bb2f12080sm14119594pfe.48.2023.01.20.13.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 13:12:10 -0800 (PST)
Message-ID: <9330ae10-de30-89be-cf53-f50db9610532@acm.org>
Date:   Fri, 20 Jan 2023 13:12:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 0/1] scsi: ufs: Add hibernation callbacks
To:     Anjana Hari <quic_ahari@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        konrad.dybcio@linaro.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_narepall@quicinc.com,
        quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com
References: <20230120113321.30433-1-quic_ahari@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230120113321.30433-1-quic_ahari@quicinc.com>
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
>   - Note to Bart: Regrading the comment to pass "restore" as an
>   argument instead of adding a new member to ufs_hba structure, adding
>   new function argument in core file (ufshcd.c) is forcing us to make
>   changes to other vendor files to fix the compilation errors. Hence
>   we have retained our original change. Please let us know your inputs
>   on this. 
Storing state information in a structure member that can be passed as a
function argument makes code harder to read and to maintain than
necessary. Please address my request before this patch goes upstream. I'm
concerned if someone would try to address my request after this patch went
upstream that there would be no motivation from your side to help with
testing the refactoring patch.

I think the patch below shows that it is easy to eliminate the new 'restore'
member variable. Please note that the patch below has not been tested in any
way.

---
  drivers/ufs/core/ufshcd.c | 48 +++++++++++++++++++--------------------
  include/ufs/ufshcd.h      |  3 ---
  2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 19608f3a38f9..b5cfbc1fccc6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9801,34 +9801,11 @@ static int ufshcd_resume(struct ufs_hba *hba)
  	/* enable the host irq as host controller would be active soon */
  	ufshcd_enable_irq(hba);

-	if (hba->restore) {
-		/* Configure UTRL and UTMRL base address registers */
-		ufshcd_writel(hba, lower_32_bits(hba->utrdl_dma_addr),
-			      REG_UTP_TRANSFER_REQ_LIST_BASE_L);
-		ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
-			      REG_UTP_TRANSFER_REQ_LIST_BASE_H);
-		ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
-			      REG_UTP_TASK_REQ_LIST_BASE_L);
-		ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
-			      REG_UTP_TASK_REQ_LIST_BASE_H);
-		/* Make sure that UTRL and UTMRL base address registers
-		 * are updated with the latest queue addresses. Only after
-		 * updating these addresses, we can queue the new commands.
-		 */
-		mb();
-	}
-
-	/* Resuming from hibernate, assume that link was OFF */
-	if (hba->restore)
-		ufshcd_set_link_off(hba);
-
  	goto out;

  disable_vreg:
  	ufshcd_vreg_set_lpm(hba);
  out:
-	if (hba->restore)
-		hba->restore = false;

  	if (ret)
  		ufshcd_update_evt_hist(hba, UFS_EVT_RESUME_ERR, (u32)ret);
@@ -10012,10 +9989,31 @@ int ufshcd_system_restore(struct device *dev)
  {

  	struct ufs_hba *hba = dev_get_drvdata(dev);
+	int ret;

-	hba->restore = true;
-	return ufshcd_system_resume(dev);
+	ret = ufshcd_system_resume(dev);
+	if (ret)
+		return ret;
+
+	/* Configure UTRL and UTMRL base address registers */
+	ufshcd_writel(hba, lower_32_bits(hba->utrdl_dma_addr),
+		      REG_UTP_TRANSFER_REQ_LIST_BASE_L);
+	ufshcd_writel(hba, upper_32_bits(hba->utrdl_dma_addr),
+		      REG_UTP_TRANSFER_REQ_LIST_BASE_H);
+	ufshcd_writel(hba, lower_32_bits(hba->utmrdl_dma_addr),
+		      REG_UTP_TASK_REQ_LIST_BASE_L);
+	ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
+		      REG_UTP_TASK_REQ_LIST_BASE_H);
+	/* Make sure that UTRL and UTMRL base address registers
+	 * are updated with the latest queue addresses. Only after
+	 * updating these addresses, we can queue the new commands.
+	 */
+	mb();

+	/* Resuming from hibernate, assume that link was OFF */
+	ufshcd_set_link_off(hba);
+
+	return 0;
  }
  EXPORT_SYMBOL_GPL(ufshcd_system_restore);

diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 6f50390ca262..1d6dd13e1651 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1071,9 +1071,6 @@ struct ufs_hba {
  	struct ufs_hw_queue *uhq;
  	struct ufs_hw_queue *dev_cmd_queue;
  	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
-
-	/* Distinguish between resume and restore */
-	bool restore;
  };

  /**

