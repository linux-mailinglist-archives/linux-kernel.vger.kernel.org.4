Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A626EEB62
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbjDZAVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbjDZAVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:21:48 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD95CC12;
        Tue, 25 Apr 2023 17:21:47 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1a677dffb37so54828175ad.2;
        Tue, 25 Apr 2023 17:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682468506; x=1685060506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFqlWu228df0FTCydNSQGPhP2bvBx2rXqvnLi/w4M1M=;
        b=NZeleoKExR40ohRMQh+SlXO9G06ooVRYuxl4SsAH+S6wHxjQHpCpbGmlxMEKlasVn0
         a0bTj2GbOtEmBbfczPPkkPk4hF3MZMoGka9S+v62Qpq7wtkd+5heYopKD+DpIo3aus2x
         8Tw7g39l4XN9tm3VhKAYlesE9AhkVGfz3znPUIgYs3ZImFMniVnBUHAIdXmyTwEjsuHJ
         uck8gBfsR8MOsz/kNNY+xINuLVgBejBwylvtIxBjIdtcUDGW1ll9OTLgS1e54I2vRUGU
         xJa+utwMDN6AHo8me1IlAOWi5185KsEbiz1aQPMC9/Pxehx4MHNYV2Ugyw4BdY+ICr5K
         wvRw==
X-Gm-Message-State: AAQBX9eFkdhBbkyaPBdWfk3FBYr/Wl9Ack8YdldACrC6ejODXTQJukTD
        mxD0Ry9anp9MLtpo0Ez7yYI=
X-Google-Smtp-Source: AKy350bP7JGxOrcIgjoIVCAIgFna6LZ4/5/GTx9Qjx0rb3tIYblBwQlRfR9R9e1zWxNLbjanY7b7bA==
X-Received: by 2002:a17:903:18d:b0:1a9:6bd4:236a with SMTP id z13-20020a170903018d00b001a96bd4236amr13867817plg.69.1682468506374;
        Tue, 25 Apr 2023 17:21:46 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5099:ad7c:6c1:9570? ([2620:15c:211:201:5099:ad7c:6c1:9570])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902848a00b001a95f632340sm5598686plo.46.2023.04.25.17.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 17:21:45 -0700 (PDT)
Message-ID: <c3297d67-ac6f-e8b5-9167-648302319812@acm.org>
Date:   Tue, 25 Apr 2023 17:21:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 5/5] ufs: core: Add error handling for MCQ mode
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        Powen.Kao@mediatek.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1681764704.git.quic_nguyenb@quicinc.com>
 <5a52b255001e994d0a65be9b1d61fe69f2a12f6c.1681764704.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5a52b255001e994d0a65be9b1d61fe69f2a12f6c.1681764704.git.quic_nguyenb@quicinc.com>
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
> +		/* MCQ mode */
> +		if (is_mcq_enabled(hba))
> +			return ufshcd_clear_cmds(hba, 1UL << lrbp->task_tag);

The above code will trigger an overflow if lrbp->task_tag >= 8 * 
sizeof(unsigned long). That's not acceptable.

>   static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>   {
> +	struct ufshcd_lrb *lrbp;
> +	u32 hwq_num, utag;
> +	int tag;
> +
>   	/* Resetting interrupt aggregation counters first and reading the
>   	 * DOOR_BELL afterward allows us to handle all the completed requests.
>   	 * In order to prevent other interrupts starvation the DB is read once
> @@ -5580,7 +5590,22 @@ static irqreturn_t ufshcd_transfer_req_compl(struct ufs_hba *hba)
>   	 * Ignore the ufshcd_poll() return value and return IRQ_HANDLED since we
>   	 * do not want polling to trigger spurious interrupt complaints.
>   	 */
> -	ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
> +	if (!is_mcq_enabled(hba)) {
> +		ufshcd_poll(hba->host, UFSHCD_POLL_FROM_INTERRUPT_CONTEXT);
> +		goto out;
> +	}
> +
> +	/* MCQ mode */
> +	for (tag = 0; tag < hba->nutrs; tag++) {
> +		lrbp = &hba->lrb[tag];
> +		if (lrbp->cmd) {
> +			utag = blk_mq_unique_tag(scsi_cmd_to_rq(lrbp->cmd));
> +			hwq_num = blk_mq_unique_tag_to_hwq(utag);
> +			ufshcd_poll(hba->host, hwq_num);
> +		}
> +	}

Is my understanding correct that ufshcd_transfer_req_compl() is only 
called from single doorbell code paths and hence that the above change 
is not necessary?


> +	if (is_mcq_enabled(hba)) {
> +		struct ufshcd_lrb *lrbp;
> +		int tag;
> +
> +		for (tag = 0; tag < hba->nutrs; tag++) {
> +			lrbp = &hba->lrb[tag];
> +			if (lrbp->cmd) {
> +				ret = ufshcd_try_to_abort_task(hba, tag);
> +				dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
> +					hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
> +					ret ? "failed" : "succeeded");
> +			}
> +			if (ret) {
> +				needs_reset = true;
> +				goto out;
> +			}
> +		}
> +	} else {
> +		/* Clear pending transfer requests */
> +		for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
> +			ret = ufshcd_try_to_abort_task(hba, tag);
> +			dev_err(hba->dev, "Aborting tag %d / CDB %#02x %s\n", tag,
> +				hba->lrb[tag].cmd ? hba->lrb[tag].cmd->cmnd[0] : -1,
> +				ret ? "failed" : "succeeded");
> +			if (ret) {
> +				needs_reset = true;
> +				goto out;
> +			}
>   		}
>   	}

Please introduce helper functions for the MCQ and SDB code paths such 
that the nesting level of the above code is reduced.

Thanks,

Bart.
