Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728066B114F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCHSsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCHSsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:48:10 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC8732CDA;
        Wed,  8 Mar 2023 10:48:08 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so2617146pjb.5;
        Wed, 08 Mar 2023 10:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTlBbJFynkKPtsOkjuxxiMzK3mo7Hdi33fadWlp+efc=;
        b=Q09ufSHThgFH64NP5IiLRBlSVt710NIR97v+QKwu/N6InseGNj52xtHJgdg2Knvjb/
         wwwuvhVtcaND1x/tgAWIdh4Z8tM+rs6g1Tz7o3ImnwIpBM2d1pAbswp0i7ZdDep2q3Av
         43GrqBPnZ3JG2AF397c3gakcJREnHmPIE4Bhjrr1vSGBdIueSeWGL3evSHOb9kSfbGmV
         oNs8PW5qRBaNer0a3AX+ahebFBRVi5UtHsB6s93nRvXnEqHACR6IRNqanIHwyL1ilo64
         Z3yUu7rdyEUDGHwTDDn+ll3FPmqoJphE3hN7gWhp+aYUoSahU5WCGNbIeUrck0vAYRVk
         EmqQ==
X-Gm-Message-State: AO0yUKWd2SjHcSVTYRudZcYNCU0nrKXsuovgopJX1RtfUiM63Snsaza1
        ko+882QSCJro+MNVH2CT9ydydUKQ6Eg=
X-Google-Smtp-Source: AK7set9+zgUyljVlKYt7LNNXhgge3r5SP4SXG5hBYbjYo13u7NbpHcsIoINw/r/NquY5b7aOzZCWVA==
X-Received: by 2002:a17:902:ce8a:b0:19c:f698:8564 with SMTP id f10-20020a170902ce8a00b0019cf6988564mr24602290plg.17.1678301287844;
        Wed, 08 Mar 2023 10:48:07 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id kp3-20020a170903280300b00198ef76ce8dsm10137649plb.72.2023.03.08.10.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 10:48:07 -0800 (PST)
Message-ID: <fa4bfc9e-2e75-2e00-2b64-816f4bc26eda@acm.org>
Date:   Wed, 8 Mar 2023 10:48:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v1 2/4] ufs: mcq: Add supporting functions for mcq
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
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
 <b84abc7ea5bddc78ab3c70e9a7b5108a5bc9448f.1678247309.git.quic_nguyenb@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b84abc7ea5bddc78ab3c70e9a7b5108a5bc9448f.1678247309.git.quic_nguyenb@quicinc.com>
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

On 3/7/23 20:01, Bao D. Nguyen wrote:
> +/* Maximum MCQ registers polling time */

registers -> register

> +#define MCQ_POLL_TIMEOUT   500

>   	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
> +	u32 mcq_poll_ms;
>   };

Why has the new member variable 'mcq_poll_ms' been introduced since its 
value is never changed?

Thanks,

Bart.
