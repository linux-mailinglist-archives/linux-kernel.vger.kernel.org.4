Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979946235D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiKIV2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:28:48 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B27F647B;
        Wed,  9 Nov 2022 13:28:48 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id k15so17899349pfg.2;
        Wed, 09 Nov 2022 13:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LdAQJWTrd4JcStydM8JyAFPJqn01KyaOFQuGdHMw6I=;
        b=cxNNchvItesiBGWnOyJntZLzwXh9jVnFEjyhhemzF4UkqAtGrwJC3N3UYHNJybkORU
         etjValgJK6zfk1y79D3T5l04arqngCQf+JIpKhAMG8A6uDOEoQOFxH13Z7MR5a9RV7TL
         HBACwHAdgZpYMWxVKn/BZ/Oh3cP/5ykFr4Zln7UbZleZwT8NoG4/4F7mMY9AMnL1ndME
         Qh+4vKYGwqWWWzTUuRodg5aANlVOE+ysXmtDuZW9LbyOmtIZOA6+X58+JA3VJMrPVUGN
         IUAftbNPU3RR7MCevMp5MQCLVdrbTT9JpGtHnRStaeH6S4QL/VY8zywGX245j2gl/KAH
         1vFw==
X-Gm-Message-State: ACrzQf0v0tP7hDCy3KR2anYh9rKNMNNM0c/bDK5Q7AYtP0sdoheewlZK
        EJGv7v4opEE4lJB3Zl+957E=
X-Google-Smtp-Source: AMsMyM7g2PdQbZkjCGHGNaX4mYqFciebR+sudQXUYX1ncYUZRYIY31kzYCyf2dbiHsvlJWf4LKCBLA==
X-Received: by 2002:a05:6a00:22d6:b0:56d:39a2:14ae with SMTP id f22-20020a056a0022d600b0056d39a214aemr57482266pfj.80.1668029327769;
        Wed, 09 Nov 2022 13:28:47 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:68b6:5dae:a00c:c3b? ([2620:15c:211:201:68b6:5dae:a00c:c3b])
        by smtp.gmail.com with ESMTPSA id k92-20020a17090a4ce500b00211d5f93029sm1655557pjh.24.2022.11.09.13.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 13:28:46 -0800 (PST)
Message-ID: <d934fe3b-df58-838f-a5cb-f26c05500609@acm.org>
Date:   Wed, 9 Nov 2022 13:28:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 07/16] ufs: core: mcq: Calculate queue depth
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
References: <cover.1668022680.git.quic_asutoshd@quicinc.com>
 <fb85bf2b7dd3126b3168ce4613481365da291db5.1668022680.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fb85bf2b7dd3126b3168ce4613481365da291db5.1668022680.git.quic_asutoshd@quicinc.com>
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
> +	/*  MAC is a 0 based value. */
> +	mac += 1;

Please make ufshcd_mcq_vops_get_hba_mac() return a 1-based value. The 
0-based convention is useful for bit-constrained device registers but is 
confusing when not reading from a hardware register.

> +	/*
> +	 * max. value of bqueuedepth = 256, mac is host dependent.
> +	 * It is mandatory for UFS device to define bQueueDepth if
> +	 * shared queuing architecture is enabled.
> +	 */
> +	return min_t(int, mac, hba->dev_info.bqueuedepth);

According to the UFS specification bQueueDepth is zero if there is one 
queue per logical unit inside the device. Should a warning statement be 
added that reports a complaint if bQueueDepth == 0 since the above code 
does not support bQueueDepth == 0? I'm not sure whether any UFS devices 
exist that use per-LU queuing.

> +static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
> +{
> +	/* Default is 32, but Qualcomm HC supports upto 64 */

I think that "default is 32" should be left out since the code that 
reads the MAC register has been removed.

Additionally, please change "upto" into "up to".

Thanks,

Bart.
