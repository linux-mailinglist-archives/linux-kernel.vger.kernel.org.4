Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D516EEB44
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbjDZAIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbjDZAIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:08:48 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9711210E9;
        Tue, 25 Apr 2023 17:08:47 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-51b33c72686so4796947a12.1;
        Tue, 25 Apr 2023 17:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682467727; x=1685059727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9i5U0weApSgOp8j05lUu9QIcnw9fLdi0tpcAkmgkXs=;
        b=HUhCeJdBhL2iGscRY0Vwa+al3UX8v+PwcFQLePyKyYEjtCwNisjrGYxC3jPRKsA1dB
         zJcnfar12P2GykPlHVu1lt6wjJ61TmIigJaLTjibE7qFzubEeslk7OoaGeduFkq5aSrr
         /iqJtblJT6UqGSTdlHk5vApTh7mXcRydS3eEHn77VXjt1DkvFkJmE7mcVqJHtknHFs7l
         KCQD+oIa9eI9BqN+FNBEflFj7RyR84umxmcTPM+GjPntiaJzaYvYiHSDXlmwSDkhEmTS
         pGg7Jxj52qzvtxBKFKxSzYsa62NRcIIY7ceR7F9GKjvuwDJcA0uoRMkoUPG7Ue+wFhem
         4M0Q==
X-Gm-Message-State: AAQBX9ezvi+HAzAHmAc7V9I+hh+r26Fjn7A1EStVAOeLFM2MfW5t/DcU
        gm62nxnhsDbXq7NBfnlw1m3uC0lYmw8=
X-Google-Smtp-Source: AKy350Y0W4Vkr5i4JFFpgZiGbCaiQeEFH2DdBwmJymAsP4/8qMBAvt3jl/BqPZ6yJhAWP/v9oC3H1w==
X-Received: by 2002:a17:90a:4b8f:b0:234:31f3:e00f with SMTP id i15-20020a17090a4b8f00b0023431f3e00fmr19830807pjh.43.1682467726992;
        Tue, 25 Apr 2023 17:08:46 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5099:ad7c:6c1:9570? ([2620:15c:211:201:5099:ad7c:6c1:9570])
        by smtp.gmail.com with ESMTPSA id c24-20020a17090ad91800b0023d0d50edf2sm10241320pjv.42.2023.04.25.17.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 17:08:46 -0700 (PDT)
Message-ID: <12308ca3-f824-596e-078f-bc00fa674aef@acm.org>
Date:   Tue, 25 Apr 2023 17:08:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/5] ufs: mcq: Add support for clean up mcq resources
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
 <5e662692bc0ad5108ce91ae3d1ec2b575c34d4ae.1681764704.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5e662692bc0ad5108ce91ae3d1ec2b575c34d4ae.1681764704.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 14:05, Bao D. Nguyen wrote:
> @@ -3110,7 +3128,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
>   		err = -ETIMEDOUT;
>   		dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
>   			__func__, lrbp->task_tag);
> -		if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0) {
> +		if (ufshcd_clear_cmds(hba, 1UL << lrbp->task_tag) == 0) {
>   			/* successfully cleared the command, retry if needed */
>   			err = -EAGAIN;
>   			/*

Is this change necessary?

> @@ -7379,6 +7397,20 @@ static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
>   			 */
>   			dev_err(hba->dev, "%s: cmd at tag %d not pending in the device.\n",
>   				__func__, tag);
> +			if (is_mcq_enabled(hba)) {
> +				/* MCQ mode */
> +				if (lrbp->cmd) {
> +					/* sleep for max. 200us to stabilize */

What is being stabilized here? Please make this comment more clear.

> +					usleep_range(100, 200);
> +					continue;
> +				}
> +				/* command completed already */
> +				dev_err(hba->dev, "%s: cmd at tag=%d is cleared.\n",
> +					__func__, tag);
> +				goto out;
> +			}

Please do not use lrbp->cmd to check whether or not a command has 
completed. See also my patch "scsi: ufs: Fix handling of lrbp->cmd".

> @@ -7415,7 +7447,7 @@ static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
>   		goto out;
>   	}
>   
> -	err = ufshcd_clear_cmds(hba, 1U << tag);
> +	err = ufshcd_clear_cmds(hba, 1UL << tag);
>   	if (err)
>   		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err %d\n",
>   			__func__, tag, err);

Is this change necessary?

> -	if (!(test_bit(tag, &hba->outstanding_reqs))) {
> +	if (!is_mcq_enabled(hba) && !(test_bit(tag, &hba->outstanding_reqs))) {

Please leave out one pair of superfluous parentheses from the above 
expression.

Thanks,

Bart.
