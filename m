Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9162639306
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 02:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKZBOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 20:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKZBOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:14:06 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438092CDF0;
        Fri, 25 Nov 2022 17:14:06 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id q12so1360303pfn.10;
        Fri, 25 Nov 2022 17:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7ErcfLJhFJdRfBJj830X4NhZcNP4qOk8E34HtsCRQI=;
        b=hCYTDOsx2C46Z25Br+h1Zo+eDIXnHWDDXjoNg6yD1SLWtyAnIiVCI65jZX+3/S9rNJ
         MsyFc1GkiPuOSFzu3CenmK+QIetaqLspNI0AmVDjPg5J48aM0F+gRD7IU3bpTXSsKPkc
         zqNCMKwLtItaRkjLn79Jhd49/vTP5S4Jp1uBJo5GSluY8k8Q1QydcbaHD4w37zdPWrqA
         S78QbLVm1ui7LgIPHKskJMhlmiHkZsEq2PVTwSslD7uDJWnGZ92XZylx7K3S8zDhtCVt
         EKPcMbkTdTkkQaNl/a4O8ShGIZB9JwPsMl/H936rkXSX8yDj+NoFf6ej5pAgdpCoMbKW
         Up5A==
X-Gm-Message-State: ANoB5pk64BeVrm/OHotJ8AXeScnzuGNnGuTKWJGLUmaWw6tqKkvmsPjW
        b4xhM6YelaHILuUkGEJgBEc=
X-Google-Smtp-Source: AA0mqf4YXw7lVfe7T9ZGMmfzN3axd0i4UT4h+X2tme/cHj6ib8f6X28gLp/Lb0TyfZwG0hZfc/R/CQ==
X-Received: by 2002:a63:f041:0:b0:477:f449:36ba with SMTP id s1-20020a63f041000000b00477f44936bamr2047545pgj.125.1669425245308;
        Fri, 25 Nov 2022 17:14:05 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b00186a2dd3ffdsm4088504plg.15.2022.11.25.17.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 17:14:04 -0800 (PST)
Message-ID: <e760d891-36d9-8253-326d-ad5c3645714f@acm.org>
Date:   Fri, 25 Nov 2022 17:14:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 07/16] ufs: core: mcq: Calculate queue depth
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <ae139f730dcec6462f9218856bf974eda4a29e1d.1669176158.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ae139f730dcec6462f9218856bf974eda4a29e1d.1669176158.git.quic_asutoshd@quicinc.com>
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
> +int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)
> +{
> +	int mac;
> +
> +	/* Mandatory to implement get_hba_mac() */
> +	mac = ufshcd_mcq_vops_get_hba_mac(hba);
> +	if (mac < 0) {
> +		dev_err(hba->dev, "Failed to get mac, err=%d\n", mac);
> +		return mac;
> +	}
> +
> +	WARN_ON(!hba->dev_info.bqueuedepth);
> +	/*
> +	 * max. value of bqueuedepth = 256, mac is host dependent.
> +	 * It is mandatory for UFS device to define bQueueDepth if
> +	 * shared queuing architecture is enabled.
> +	 */
> +	return min_t(int, mac, hba->dev_info.bqueuedepth);
> +}

Isn't WARN_ON_ONCE() recommended over WARN_ON()?

Otherwise this patch looks good to me.

Thanks,

Bart.
