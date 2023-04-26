Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE46EEB36
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbjDZAEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbjDZAER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:04:17 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ABF8699;
        Tue, 25 Apr 2023 17:04:16 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-24781e23c27so5765050a91.0;
        Tue, 25 Apr 2023 17:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682467456; x=1685059456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/sJthLrl54U2rVtGZJF6Leb82y2ZRoj9yPDjTZn71Y=;
        b=GSRKs0GR2dFvbpjRnywxwxOGPoRjk8f2lQsySNCrY+ciyqSbxWrfT3kI7yliOvlePE
         A9n48HLKNT/TbRzBRb/f0BLbH8wQOATmK6KIC6OjpNzrEPb7lHfXulyghtizdbtREa9U
         8hYUo22XaTD7Gi93kzDQRO5M2e6dYZYv3c9Fd6wyabHQh8BkI8P9A3a8ufdU66KoWYmy
         v4h60F+kEhdJ/NkcfVGaCt61hA45e0I1L1eRrF1VkWVR62DNa4ZCNG5TA9vZCsTDaGn9
         izEzEdWtM7HLFlVs3OM29guBJ/8e0YB8Wv5bP5TW/zvo9c16VmdSiZp0T4Tl24n3ggfC
         wxvg==
X-Gm-Message-State: AAQBX9fUl6nUPjeTiffJ4Dmk6oAn+jLYBaztX1z7i7PdOIZu0HUX+Kag
        rTYCYhoI+ozc4BpmY0/SJfE=
X-Google-Smtp-Source: AKy350aHyentLgQXo+Z2M1ojsWwhUSXYrG2wkE+9Q6xIlmti8kTjceJPc1cLp3s68HIi2zfLqTPFqw==
X-Received: by 2002:a17:90b:30d4:b0:24b:2f97:9208 with SMTP id hi20-20020a17090b30d400b0024b2f979208mr18766468pjb.0.1682467456275;
        Tue, 25 Apr 2023 17:04:16 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5099:ad7c:6c1:9570? ([2620:15c:211:201:5099:ad7c:6c1:9570])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709026b8800b001a04ff0e2eesm8757180plk.58.2023.04.25.17.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 17:04:15 -0700 (PDT)
Message-ID: <19a823d9-d4b0-3c62-38a0-b54dc3937ab3@acm.org>
Date:   Tue, 25 Apr 2023 17:04:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/5] ufs: mcq: Add supporting functions for mcq abort
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        Powen.Kao@mediatek.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Eric Biggers <ebiggers@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1681764704.git.quic_nguyenb@quicinc.com>
 <382670235be85aaa7b7dc407bcf378483ac03562.1681764704.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <382670235be85aaa7b7dc407bcf378483ac03562.1681764704.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 14:05, Bao D. Nguyen wrote:
> +/* Max mcq register polling time in milisecond unit */

A nit: please change "millisecond unit" into "milliseconds".

> +static int ufshcd_mcq_poll_register(void __iomem *reg, u32 mask,
> +				u32 val, unsigned long timeout_ms)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	int err = 0;
> +
> +	/* ignore bits that we don't intend to wait on */
> +	val = val & mask;
> +
> +	while ((readl(reg) & mask) != val) {

& has a higher precedence than != so one pair of parentheses can be left 
out.

> +		udelay(20);
> +		if (time_after(jiffies, timeout)) {

Please use time_is_before_jiffies() instead of time_after(jiffies, ...).

> +			err = -ETIMEDOUT;
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}

Please remove the variable 'err' and return the return value directly.

> +
> +static int ufshcd_mcq_sq_stop(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
> +{
> +	void __iomem *reg;
> +	u32 i = hwq->id;

Please use another variable name than 'i' for a hardware queue ID ('id'?).

> +	u32 i = hwq->id;

Same comment here.

> +/**
> + * ufshcd_mcq_sq_cleanup - Clean up Submission Queue resources

A nit: please use lower case text for "submission queue" and also in the 
comments below ("Clean up" -> "clean up").

> +	spin_lock(&hwq->sq_lock);
> +
> +	/* stop the SQ fetching before working on it */
> +	err = ufshcd_mcq_sq_stop(hba, hwq);
> +	if (err)
> +		goto unlock;

No spin locks around delay loops please. Is there anything that prevents 
to change sq_lock from a spin lock into a mutex?

> +static u64 ufshcd_mcq_get_cmd_desc_addr(struct ufs_hba *hba,
> +					int task_tag)
> +{
> +	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
> +	__le32 hi = lrbp->utr_descriptor_ptr->command_desc_base_addr_hi;
> +	__le32 lo = lrbp->utr_descriptor_ptr->command_desc_base_addr_lo;
> +
> +	return le64_to_cpu((__le64)hi << 32 | lo);
> +}

Please add a new patch at the head of this series that modifies struct 
utp_transfer_req_desc such that command_desc_base_addr_lo and 
command_desc_base_addr_hi are combined into a single __le64 variable.

> +/**
> + * ufshcd_mcq_nullify_cmd - Nullify utrd. Host controller does not fetch
> + * transfer with Command Type = 0xF. post the Completion Queue with OCS=ABORTED.
> + * @hba - per adapter instance.
> + * @hwq - Hardware Queue of the nullified utrd.
> + */
> +static void ufshcd_mcq_nullify_cmd(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
> +{
> +	struct utp_transfer_req_desc *utrd;
> +	u32 dword_0;
> +
> +	utrd = (struct utp_transfer_req_desc *)(hwq->sqe_base_addr +
> +			hwq->id * sizeof(struct utp_transfer_req_desc));

Please double check this function. It has "cmd" in the function name but 
none of the arguments passed to this function allows to uniquely 
identify a command. Is an argument perhaps missing from this function?

Additionally, hwq->sqe_base_addr points to an array of SQE entries. I do 
not understand why hwq->id * sizeof(struct utp_transfer_req_desc) is 
added to that base address. Please clarify.

> +		utrd = (struct utp_transfer_req_desc *)(hwq->sqe_base_addr +
> +				sq_head_slot * sizeof(struct utp_transfer_req_desc));

hwq->sqe_base_addr already has type struct utp_transfer_req_desc * so 
the " * sizeof(struct utp_transfer_req_desc)" part looks wrong to me.

> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 35a3bd9..808387c 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -56,7 +56,6 @@
>   #define NOP_OUT_RETRIES    10
>   /* Timeout after 50 msecs if NOP OUT hangs without response */
>   #define NOP_OUT_TIMEOUT    50 /* msecs */
> -
>   /* Query request retries */
>   #define QUERY_REQ_RETRIES 3
>   /* Query request timeout */

Is the above change really necessary?

> @@ -173,7 +172,6 @@ EXPORT_SYMBOL_GPL(ufshcd_dump_regs);
>   enum {
>   	UFSHCD_MAX_CHANNEL	= 0,
>   	UFSHCD_MAX_ID		= 1,
> -	UFSHCD_NUM_RESERVED	= 1,
>   	UFSHCD_CMD_PER_LUN	= 32 - UFSHCD_NUM_RESERVED,
>   	UFSHCD_CAN_QUEUE	= 32 - UFSHCD_NUM_RESERVED,
>   };

Same question here - is this change really necessary?

Thanks,

Bart.
