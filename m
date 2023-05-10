Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E176FE672
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbjEJVuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjEJVuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:50:18 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D2746A2;
        Wed, 10 May 2023 14:50:18 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-64115e652eeso53554609b3a.0;
        Wed, 10 May 2023 14:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683755417; x=1686347417;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugw5yiiRWKEosECd8DYoddLHj5cw2hGZNdWX0C0svT8=;
        b=Hsgz2aE0+tX+z3B9o+5/GPH7NsLKjV5So8OMGOvOxe8uCbMB4Z4pDMzUmOMsFvX1rE
         HY1YPyJ9F/p52iktxnGnewiAVGwpS6Tjn/8GttXgh/Rn/xM6LgujEq7x7DH69v/s8ptm
         DcveH97ksCI9HIQI+nlV8knOnCi9PgLutEvbT2y2yevAxov/i3ZqOqQ9cd+McxNnKG0H
         eXdHHJSfge34DVckw46p06ypCrhY22r5OMzbQd1+IcxcWZa6QAKOSF5qXua2KK8pDcp1
         GQH25y5Q4EMbkrlX1ufrgNCkfHmaVCwdwqvF5O15L0CzpZUAX1OmJ8y10+4n4tbhBA76
         9bxA==
X-Gm-Message-State: AC+VfDwhRNIe7ApZFGPjojLoB3h1LpH3EXM9h4DcNBDuLXf2SjuO6Wer
        EkEF719jskoSIIxQsNolPwA=
X-Google-Smtp-Source: ACHHUZ615GAKND1ytPyK2/No1AtrqjHqwrLRynk3v/GEup14KBlPJnJGJghuuYohdmZ1DvOUnxzvBw==
X-Received: by 2002:a05:6a00:1894:b0:646:c56c:f0e0 with SMTP id x20-20020a056a00189400b00646c56cf0e0mr10363435pfh.15.1683755417431;
        Wed, 10 May 2023 14:50:17 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:d8b7:fa5f:6808:3db3? ([2001:4958:15a0:30:d8b7:fa5f:6808:3db3])
        by smtp.gmail.com with ESMTPSA id e11-20020a62ee0b000000b00642ea56f06dsm3984120pfi.26.2023.05.10.14.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 14:50:16 -0700 (PDT)
Message-ID: <9022430e-a50b-7744-d8f5-d5953b5460e2@acm.org>
Date:   Wed, 10 May 2023 14:50:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 3/7] ufs: mcq: Add supporting functions for mcq abort
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alice Chao <alice.chao@mediatek.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Eric Biggers <ebiggers@google.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1683688692.git.quic_nguyenb@quicinc.com>
 <d58b5c068bdc03d5fe6d0219bb211370ae681ed2.1683688693.git.quic_nguyenb@quicinc.com>
Content-Language: en-US
In-Reply-To: <d58b5c068bdc03d5fe6d0219bb211370ae681ed2.1683688693.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 22:24, Bao D. Nguyen wrote:
> +/**
> + * ufshcd_mcq_sq_cleanup - Clean up submission queue resources
> + * associated with the pending command.
> + * @hba - per adapter instance.
> + * @task_tag - The command's task tag.
> + * @result - Result of the clean up operation.
> + *
> + * Returns 0 and result on completion. Returns error code if
> + * the operation fails.
> + */
> +int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag, int *result)
> +{
> +	struct ufshcd_lrb *lrbp = &hba->lrb[task_tag];
> +	struct scsi_cmnd *cmd = lrbp->cmd;
> +	struct ufs_hw_queue *hwq;
> +	void __iomem *reg, *opr_sqd_base;
> +	u32 nexus, id, val;
> +	int err;
> +
> +	if (task_tag != hba->nutrs - UFSHCD_NUM_RESERVED) {
> +		if (!cmd)
> +			return FAILED;
> +		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
> +	} else {
> +		hwq = hba->dev_cmd_queue;
> +	}
> +
> +	id = hwq->id;
> +
> +	mutex_lock(&hwq->sq_mutex);
> +
> +	/* stop the SQ fetching before working on it */
> +	err = ufshcd_mcq_sq_stop(hba, hwq);
> +	if (err)
> +		goto unlock;
> +
> +	/* SQCTI = EXT_IID, IID, LUN, Task Tag */
> +	nexus = lrbp->lun << 8 | task_tag;
> +	opr_sqd_base = mcq_opr_base(hba, OPR_SQD, id);
> +	writel(nexus, opr_sqd_base + REG_SQCTI);
> +
> +	/* SQRTCy.ICU = 1 */
> +	writel(SQ_ICU, opr_sqd_base + REG_SQRTC);
> +
> +	/* Poll SQRTSy.CUS = 1. Return result from SQRTSy.RTC */
> +	reg = opr_sqd_base + REG_SQRTS;
> +	err = read_poll_timeout(readl, val, val & SQ_CUS, 20,
> +				MCQ_POLL_US, false, reg);
> +	if (err)
> +		dev_err(hba->dev, "%s: failed. hwq=%d, lun=0x%x, tag=%d\n",
> +			__func__, id, lrbp->lun, task_tag);
> +
> +	*result = FIELD_GET(SQ_ICU_ERR_CODE_MASK, readl(reg));
> +
> +	if (ufshcd_mcq_sq_start(hba, hwq))
> +		err = FAILED;
> +
> +unlock:
> +	mutex_unlock(&hwq->sq_mutex);
> +	return err;
> +}

Please do not use the FAILED / SUCCESS return values in this function. 
These values should only be returned by functions related to SCSI error 
handling. Please do the following:
* Return a negative Unix error code in case of failure.
* Return zero upon success.
* Return the FIELD_GET() result as a positive value.
* Remove the 'int *result' argument.

> +	/* prevent concurrent access to sq hw */
> +	struct mutex sq_mutex;

Hmm ... a submission queue (SQ) exists in host memory so I'm not sure 
the "hw" part of the above comment is correct.

Thanks,

Bart.
