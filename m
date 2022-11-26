Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51C639303
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 02:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiKZBKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 20:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKZBK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:10:29 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9302CCAA;
        Fri, 25 Nov 2022 17:10:28 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id md8so799829pjb.4;
        Fri, 25 Nov 2022 17:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEeX4qyWg0IrAHe/fvm5AXFA+iKbUTvD986+eHJxTfA=;
        b=RN9JDfdIuJBguFyi1A9tBs0JXROnRymTPjbW6QtK3uzaFxPzPZfE8BMYO3uGAsES8B
         mPvNlJ2QzVWT+Kgdggc7R51pDDBQcMQEUxRAFOVFrLeV9BHR0f9K2lT7g/pfQOI9QlMv
         Rm+D4EWQ+8OuEnY18ainQ/pPuKkYRakhb7mP+mPC5lvfbGQT4kaIUZ8DF44YC9i+uWHl
         3687p93OqQCNSmDy+PBeePbSE7dWu6UBIfQvZM6fjUSZuQD8dCC4o2xmF3dRDl345Jq1
         5y5wKJkIs1ASTtlrxNQTj4lA/B/NTmeQfRuJ7w5wfvvYOaztx2VTOmefRZQ4y7IpDoWx
         lCdw==
X-Gm-Message-State: ANoB5pnt+uvEXLejnZ17yTLiLIC67QK8XcQOfbgIPNvnr80XKXrRSQRU
        Jw5vPiw4IR5lc0k9bE5RzSQ=
X-Google-Smtp-Source: AA0mqf4YYaQW75PaoYy4IXPZM8MWzzeDuc9H22FTeGdh1VZ7ErM5RanSi3THxi/FOrCJwzcN0IMwjA==
X-Received: by 2002:a17:902:7b84:b0:189:6623:4c47 with SMTP id w4-20020a1709027b8400b0018966234c47mr6292602pll.170.1669425028073;
        Fri, 25 Nov 2022 17:10:28 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id k4-20020a63d844000000b00476e84c3530sm3101627pgj.60.2022.11.25.17.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 17:10:27 -0800 (PST)
Message-ID: <105b9113-8322-aa68-7d21-45f5ba288d34@acm.org>
Date:   Fri, 25 Nov 2022 17:10:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 06/16] ufs: core: mcq: Configure resource regions
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <05400727c8a82b7ef85a576c1fa2d9bd81458e9a.1669176158.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <05400727c8a82b7ef85a576c1fa2d9bd81458e9a.1669176158.git.quic_asutoshd@quicinc.com>
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

On 11/22/22 20:10, Asutosh Das wrote:
> +/* Resources */
> +static const struct ufshcd_res_info ufs_res_info[RES_MAX] = {
> +	{.name = "ufs_mem",},
> +	{.name = "mcq",},
> +	/* Submission Queue DAO */
> +	{.name = "mcq_sqd",},
> +	/* Submission Queue Interrupt Status */
> +	{.name = "mcq_sqis",},
> +	/* Completion Queue DAO */
> +	{.name = "mcq_cqd",},
> +	/* Completion Queue Interrupt Status */
> +	{.name = "mcq_cqis",},
> +	/* MCQ vendor specific */
> +	{.name = "mcq_vs",},
> +};

Which names to associate with nodes in the device tree for UFS MCQ 
resources has not been standardized. Additionally, the UFS driver is 
also used on platforms that do not support the device tree (e.g. Intel 
x86 platforms). So I don't think that the platform_get_resource_byname() 
calls should occur in the UFS driver core. How about moving the code 
that queries device tree nodes into the Qualcomm driver until a second 
user of this code is added? If a second user of this code appears this 
code could e.g. become a kernel module shared by both UFS host 
controller drivers.

Thanks,

Bart.
