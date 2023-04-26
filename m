Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2206EEB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjDZAMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238364AbjDZAMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:12:47 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E08699;
        Tue, 25 Apr 2023 17:12:46 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1a677dffb37so54779605ad.2;
        Tue, 25 Apr 2023 17:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682467966; x=1685059966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zA306h9QbtrRdY8f3QEhHfV8lSk2LBCg5jIZCjYsU0=;
        b=HWFiu6ptD4J6UVLN5qMtCacrNzz/8+RiM9YkDapTNre/nQQEnFfWGOBU8uzpdwFI5M
         5aGpFo8p9NXed73/As/FIIv/hfLWM7PxipTPfYj7PpG5k0+v96Vxxs8jwwgZQTsR1bGr
         U8iprJQl3xIGp/Ymg1IuwVEDGjVB8R/1EB2dFqoxlWObNRsO2oGaxmfiSoVzF9OoUxc7
         jWHxo5z05DQCqmo+DQd1jrqiXy7ikQreumjTDtCzc9+LSQeuI3Z81WKdaCQGOL0Q7GHZ
         lSS4HfaivvL0Db4cFeEfBcVM76pDLOs6wJu1Ngifghp6xyoaiFoT5Sblngth30LSvojg
         5hEg==
X-Gm-Message-State: AAQBX9dXkcqLWYU/lYzuEELofrjv2OGUqnxMGiD8VolWGjhRHzIDPs16
        ZKNWwO7CJKoOEPf2Uc0iTv8=
X-Google-Smtp-Source: AKy350axe1uxbKF98wD8SMU+rPJOuRCYssquJZ7bORUPI7pnWiTeGvFS5PBqtNKVob3MgTNClAGhVg==
X-Received: by 2002:a17:902:bd94:b0:1a6:ef75:3c53 with SMTP id q20-20020a170902bd9400b001a6ef753c53mr17971950pls.11.1682467966290;
        Tue, 25 Apr 2023 17:12:46 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5099:ad7c:6c1:9570? ([2620:15c:211:201:5099:ad7c:6c1:9570])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c15100b0019928ce257dsm8760731plj.99.2023.04.25.17.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 17:12:45 -0700 (PDT)
Message-ID: <53f22b81-a738-8f94-8e08-2395133d0249@acm.org>
Date:   Tue, 25 Apr 2023 17:12:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/5] ufs: mcq: Added ufshcd_mcq_abort()
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        Powen.Kao@mediatek.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1681764704.git.quic_nguyenb@quicinc.com>
 <349ea681e56578191da834250cebfbd7859e9216.1681764704.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <349ea681e56578191da834250cebfbd7859e9216.1681764704.git.quic_nguyenb@quicinc.com>
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
> +	if (!lrbp->cmd) {
> +		dev_err(hba->dev,
> +			"%s: skip abort. cmd at tag %d already completed.\n",
> +			__func__, tag);
> +		goto out;
> +	}

Please do not use lrbp->cmd to check whether or not a command has completed.

> +	if (ufshcd_mcq_sqe_search(hba, hwq, tag)) {
> +		/*
> +		 * Failure. The command should not be "stuck" in SQ for
> +		 * a long time which resulted in command being aborted.
> +		 */
> +		dev_err(hba->dev, "%s: cmd found in sq. hwq=%d, tag=%d\n",
> +				__func__, hwq->id, tag);
> +		/* Set the Command Type to 0xF per the spec */
> +		ufshcd_mcq_nullify_cmd(hba, hwq);

The above looks wrong to me. How can ufshcd_mcq_nullify_cmd() identify a 
command if the 'tag' argument is not passed to that function?

> +	/*
> +	 * The command is not in the Submission Queue, and it is not
> +	 * in the Completion Queue either. Query the device to see if
> +	 * the command is being processed in the device.
> +	 */

Please only use capitals if these are required.

> +	if (lrbp->cmd)
> +		ufshcd_release_scsi_cmd(hba, lrbp);

Same comment here - do not use lrbp->cmd to check for completion.

Thanks,

Bart.
