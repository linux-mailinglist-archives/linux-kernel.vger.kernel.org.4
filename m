Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C569C6B2CBC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCISPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCISP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:15:27 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A435F519;
        Thu,  9 Mar 2023 10:15:26 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id kb15so2902731pjb.1;
        Thu, 09 Mar 2023 10:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678385725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1n3W7Mep7n+u6WTkNpOQ23YBe9QKdrpVK921z9QG0TQ=;
        b=zXYeIFavPNXs0NSUY1vaTouA5F2poUYh82kKkaxUnIcAai5sw/s+Jm4lsNOGWMk9dj
         I3H/3ItEw+H56JFnPN2+ifYoPAMsV+BFQdT0cFA+dzKh4t4byQaCRYD9BmNM4xegpFhd
         2yDyca1H+gv6S4sks80zv9ZpRmEyXJP9jAxSIADEIvIlrSgQTFaZZMIpJ6yRHNerqmV0
         q8Uwl9jEvjhq04Mz2HWKaqSFveeAMnoWB8iMh5+5Hhbply1QBLyfyDO3JYNb2IVEX5X8
         wY9ayCqr6xs0wDiNQs4fPhb+1l5OLmfG+YBXVatx4U3pt7KVLPJCZDmyv1f9INYqescZ
         F8xA==
X-Gm-Message-State: AO0yUKXHvuQJYX/SYP9J5+f3OYJbSiq72f4/w/yjkL+BwFuWGfZHDZvt
        6/nlx0Dm4xxhF/35beQZ+f8=
X-Google-Smtp-Source: AK7set9GeDtPXB8h9zEYbgrrWoaLeCxwdQdVIz0UEBRPu3qTrNRUmyZBlWQmaCpnfCkVEMpxXLYVYQ==
X-Received: by 2002:a05:6a20:8407:b0:cd:363d:b27c with SMTP id c7-20020a056a20840700b000cd363db27cmr32359263pzd.16.1678385725521;
        Thu, 09 Mar 2023 10:15:25 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id 1-20020a630301000000b004fb11a7f2d4sm11207080pgd.57.2023.03.09.10.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 10:15:24 -0800 (PST)
Message-ID: <1ca7dbef-5747-29c2-a11c-086cf36d636f@acm.org>
Date:   Thu, 9 Mar 2023 10:15:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v2 1/3] ufs: mcq: Add supporting functions for mcq
 abort
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1678338926.git.quic_nguyenb@quicinc.com>
 <68b786f390dbd93218a482d18c513bc332e82da3.1678338926.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <68b786f390dbd93218a482d18c513bc332e82da3.1678338926.git.quic_nguyenb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 21:28, Bao D. Nguyen wrote:
> +static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
> +		struct ufs_hw_queue *hwq, int task_tag)
> +{
> +	struct utp_transfer_req_desc *utrd;
> +	u32 mask = hwq->max_entries - 1;
> +	bool ret = false;
> +	u64 addr, match;
> +	u32 i;

The variable name "i" is usually used for a loop index. In this case it 
represents a slot in the submission queue. How about renaming "i" into 
"slot"?

> +static inline void ufshcd_mcq_update_sq_head_slot(struct ufs_hw_queue *q)
> +{
> +	u32 val = readl(q->mcq_sq_head);
> +
> +	q->sq_head_slot = val / sizeof(struct utp_transfer_req_desc);
> +}

Please modify this function such that it returns the head slot value 
instead of storing it in a member variable and remove the sq_head_slot 
member variable. Storing the sq_head_slot value in a member variable 
seems wrong to me since the value of that variable will be outdated as 
soon as the submission queue is restarted.

> +static inline bool ufshcd_mcq_is_sq_empty(struct ufs_hw_queue *q)
> +{
> +	return q->sq_head_slot == q->sq_tail_slot;
> +}

Please remove this function and inline this function into its callers.

Thanks,

Bart.
