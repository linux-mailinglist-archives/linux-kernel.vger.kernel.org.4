Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75645623592
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiKIVQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiKIVQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:16:21 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41E31237;
        Wed,  9 Nov 2022 13:16:20 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id k7so18274570pll.6;
        Wed, 09 Nov 2022 13:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sv2S8v8aoIMkFk8Z4x5Dwl/WF1J53tF7mO3deU2RxH4=;
        b=fZineH2xMMs5kSWrTdHOhG5xu3sRXY37FHckr786byS8ggjBR4vBAV5HRLT8ue+z8f
         yFAoRyKk+Ag6bU1rb6OzUMbiPnJ5IWv2YBdrZiNU4bInUHqB9RmvwRk6YZXchr+5+a+F
         /u7Y5fb08HXncKVjjdRdomgEdfUI16aLoB9/NZcJ1849gmMkc5NGjTWsR9I+qely7wSI
         qvck/L2e9XTRtcwMOYV3d2QutAKMP+H5hr97jLFxlIof1cTXnlrOMxHYbavhmItNMePG
         LY7f1mcJTp0Dsz67tLynJMQZhbYQUY5RcB+05menRhTjBpaD5uFYtnnimO0oBGpbkXlI
         08Pw==
X-Gm-Message-State: ACrzQf2t5RhueKScV+nnGAvifqdKS3GLq9PKlC4+FlEJtX/fBscLlf7X
        J8C4d1h3iuXkfbVSKcyBpsIqK7dykr0=
X-Google-Smtp-Source: AMsMyM4Z33DzYBqAFNPYNm40x5e/hzUYtWYeSl/cmk8tx/NFjuGTcXEQ3UiY9NkahDb0Nf5ytXqrPA==
X-Received: by 2002:a17:902:ced1:b0:186:b18a:d0d5 with SMTP id d17-20020a170902ced100b00186b18ad0d5mr63284859plg.60.1668028580058;
        Wed, 09 Nov 2022 13:16:20 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:68b6:5dae:a00c:c3b? ([2620:15c:211:201:68b6:5dae:a00c:c3b])
        by smtp.gmail.com with ESMTPSA id i16-20020a632210000000b0043a18cef977sm7781598pgi.13.2022.11.09.13.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 13:16:19 -0800 (PST)
Message-ID: <e92d248b-6041-49bc-a3dd-1e17abf0fb26@acm.org>
Date:   Wed, 9 Nov 2022 13:16:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 05/16] ufs: core: mcq: Add Multi Circular Queue support
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1668022680.git.quic_asutoshd@quicinc.com>
 <5f3cfdaee098ef245e19824b45c092acd8cc48c8.1668022680.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5f3cfdaee098ef245e19824b45c092acd8cc48c8.1668022680.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 11:41, Asutosh Das wrote:
> +static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
> +{
> +	int i;
> +	u32 hba_maxq, rem, tot_queues;
> +	struct Scsi_Host *host = hba->host;
> +
> +	hba_maxq = FIELD_GET(GENMASK(7, 0), hba->mcq_capabilities);
> +
> +	if (!rw_queues)
> +		rw_queues = num_possible_cpus();
> +
> +	tot_queues = UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_queues +
> +			rw_queues;
> +
> +	if (hba_maxq < tot_queues) {
> +		dev_err(hba->dev, "Total queues (%d) exceeds HC capacity (%d)\n",
> +			tot_queues, hba_maxq);
> +		return -EOPNOTSUPP;
> +	}

This function can fail with default kernel module parameters, e.g. 
num_possible_cpus() == 8 and hba_maxq == 4. This is not acceptable. A 
better solution is required, e.g. reducing rw_queues if the user has not 
set this kernel module parameter.

Thanks,

Bart.
