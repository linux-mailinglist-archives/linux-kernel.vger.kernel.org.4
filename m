Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC3D6B2C07
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCIR27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCIR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:28:56 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA4AF6C5D;
        Thu,  9 Mar 2023 09:28:55 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so6154300pjb.5;
        Thu, 09 Mar 2023 09:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678382935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hC+FSZZkCYvYaA4XO9ZGH/kkkiSMtQVDfB8Gu4rcu4Y=;
        b=Z/gF9ub/Xa9Z9185HOcY46Aqlkb9u0iQHVcquP8M3sz3qeCeH6pkZ9DC370ODmqkkM
         oExIQtZmSaAxUxY3414yBsiJIZAqfORQNh2adXZdosu9g0Mi/h6QSenP0EFd8Tex6noI
         yHpvmAZuodvpIb1f5hYbGrxpYNwi38HPr/9wefFcKcDEq2Fg8L3+GphWMPkEUfaVDVPK
         1g0me6bmncpcNEhejMQgtBmQYe7U+ksukmxrlAnw2oV3JKmGTDfjO20cVUMmHiXSk8n4
         4LiuReqTpZOtRazzC6wy1bHZFqRREl/HWmJekAmbZeU9KLBki3GlmYfXBMJ+EsyIexIt
         zPDw==
X-Gm-Message-State: AO0yUKXvVx7m/0HjL0dMFC1/hTVKsl3Lv2LDiLcg6iZUOOPsVk5Tkdux
        2KxQWnl+jBIIod47ET+JCvM=
X-Google-Smtp-Source: AK7set9kIVZhEexhx7ftxyqL45Op9w2m01aZOvbOID9w5ytSdPPbsESJVm04rE6lT6MztDo/Kvr7/A==
X-Received: by 2002:a05:6a20:690e:b0:cb:f76c:ceda with SMTP id q14-20020a056a20690e00b000cbf76ccedamr18063090pzj.22.1678382934893;
        Thu, 09 Mar 2023 09:28:54 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id a14-20020a62e20e000000b005cdc64a287dsm11543452pfi.115.2023.03.09.09.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 09:28:54 -0800 (PST)
Message-ID: <3d858407-481b-a55b-4aa9-513e4a4ca44e@acm.org>
Date:   Thu, 9 Mar 2023 09:28:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] scsi: ufs: core: print trs for pending requests in MCQ
 mode
Content-Language: en-US
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1678338122-88611-1-git-send-email-quic_ziqichen@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1678338122-88611-1-git-send-email-quic_ziqichen@quicinc.com>
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

On 3/8/23 21:01, Ziqi Chen wrote:
> +static void ufshcd_print_trs_all(struct ufs_hba *hba, bool pr_prdt)
> +{
> +	const struct ufshcd_lrb *lrbp;
> +	int tag;
> +
> +	for (tag = 0; tag < hba->nutrs; tag++) {
> +		lrbp = &hba->lrb[tag];
> +
> +		if (lrbp->cmd)
> +			ufshcd_print_tr(hba, tag, pr_prdt);
>   	}
>   }

There is a race in this code: lrbp->cmd may be cleared after it has been 
read and before or while ufshcd_print_tr() is in progress. How about 
preventing that race by blk_mq_tagset_busy_iter() to iterate over 
pending SCSI commands?

Thanks,

Bart.
