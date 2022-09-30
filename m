Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0DF5F11B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiI3Shn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiI3Shl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:37:41 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157FC1739D3;
        Fri, 30 Sep 2022 11:37:40 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id v186so4968651pfv.11;
        Fri, 30 Sep 2022 11:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=efafKPDXaotfifV7ioMYf9voysdJTvPoHFHiRmXnzh8=;
        b=LZGhsiDt9MC9Hok9KYNy7YetGAACSYQMMHGoZ9dxFUdFlTMnOF4McjiMI+02W46cA7
         pCa0YEMLl08esZpJ22opF4KBoKINv+EgnOvG3R5QXj7axS26odgEaPJShO6OK+WibMeq
         16nNyiyugavkjBsuN6qRtY04t0odotQDrrOHruT5H0mn8Abih/2ZOd0xr1nFFRIFG79r
         Kb5Eon03GFH5bKPzG7Et8r0NsIQJeghLg3p5EFoOq60vUJWjL26uYKm+aKoKKIF1bD66
         nTuxbpVw4JwWaqvtEEKfww4IzGI7Yb2kyg2/1tiyb/v0NV1sS251okjIGgNcy7WT15/i
         qcGA==
X-Gm-Message-State: ACrzQf2l5vxoXI8seZCXmtxEc75GJqrNuZfETzmPGpTbyHaGkAqmnjev
        lCVGsjua4xvEDnjD0Y2n2qI=
X-Google-Smtp-Source: AMsMyM7pHUBp9AyBR4mQyCzjDLxGnbHWvFKk4bh5EdnF2qd0BzZ9SwQ7YzOyXC+UxyR5MekpDcDBOw==
X-Received: by 2002:a63:d30b:0:b0:42b:9ca4:15f4 with SMTP id b11-20020a63d30b000000b0042b9ca415f4mr8631548pgg.146.1664563059451;
        Fri, 30 Sep 2022 11:37:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:56f2:482f:20c2:1d35? ([2620:15c:211:201:56f2:482f:20c2:1d35])
        by smtp.gmail.com with ESMTPSA id p8-20020a635b08000000b0043bed49f31fsm2064027pgb.8.2022.09.30.11.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 11:37:38 -0700 (PDT)
Message-ID: <feb4295c-e31d-1bf0-2176-a844c1c9197e@acm.org>
Date:   Fri, 30 Sep 2022 11:37:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 04/16] ufs: core: mcq: Introduce Multi Circular Queue
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, mani@kernel.org,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, quic_richardp@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        avri.altman@wdc.com, beanhuo@micron.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <e0ae0fccc579fa17b6cfcf3b8bcf963f5ebe67fa.1663894792.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e0ae0fccc579fa17b6cfcf3b8bcf963f5ebe67fa.1663894792.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 18:05, Asutosh Das wrote:
> +static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
> +{
> +	int i, rem;
> +	u32 hbaq_cap, cmp, tot_queues;
> +	struct Scsi_Host *host = hba->host;
> +
> +	hbaq_cap = hba->mcq_capabilities & 0xff;
> +
> +	if (!rw_queues)
> +		rw_queues = num_possible_cpus();
> +
> +	tot_queues = dev_cmd_queue + read_queues + poll_queues + rw_queues;
> +	if (hbaq_cap < tot_queues) {
> +		dev_err(hba->dev, "Total queues (%d) exceeds HC capacity (%d)\n",
> +			tot_queues, hbaq_cap);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	rem = hbaq_cap - dev_cmd_queue;
> +	cmp = rem;
> +	hba->nr_queues[HCTX_TYPE_DEFAULT] = min3(cmp, rw_queues,
> +						 num_possible_cpus());
> +	rem -= hba->nr_queues[HCTX_TYPE_DEFAULT];
> +	cmp = rem;
> +	hba->nr_queues[HCTX_TYPE_POLL] = min(cmp, poll_queues);
> +	rem -= hba->nr_queues[HCTX_TYPE_POLL];
> +	cmp = rem;
> +	hba->nr_queues[HCTX_TYPE_READ] = min(cmp, read_queues);
> +
> +	for (i = 0; i < HCTX_MAX_TYPES; i++)
> +		host->nr_hw_queues += hba->nr_queues[i];
> +
> +	hba->nr_hw_queues = host->nr_hw_queues + dev_cmd_queue;
> +	return 0;
> +}

Please consider removing the variable 'cmp' and instead use min_t() or a 
type cast.

Thanks,

Bart.
