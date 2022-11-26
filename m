Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06F563931B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 02:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiKZB2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 20:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiKZB2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:28:17 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1731BE83;
        Fri, 25 Nov 2022 17:28:16 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id w23so5313191ply.12;
        Fri, 25 Nov 2022 17:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irS6qchuAX89kfaEICcGZqVuhwCEtkw4+cBnMIMsRE4=;
        b=A5vcvHFTkkwG4te5hFcS6RhuPn+kj3aMiRvdIgUQaDOYM48zSPRaP90q4nx+CrhbuW
         El7+PsRcldzYu4+lrr4zKTqC5YQEsLQ2gK67eu30x2fHviWOgqwJ60vE8TXn2iyvi/Jv
         9Zef0HACdgoDshcuWytWSpNmR4/5u0JgbopE/CxDKpAzKxd1XPN2xNE8cZ1H4JAffE7h
         QecjiJ6IpJDYLcM8dfjfa5EOJUAFbnROxFq1HEtp4xEH2cgl1EwdYMDePv2sXb/wORA7
         cjcnu39D3Yh0FjiHSedxYDZ+j5UJJoWpz6VoxqIuJ8fj6UQ/GFRCCHlzO59XF4b0tQ2U
         6ZQw==
X-Gm-Message-State: ANoB5pmmQ+PsO9n/CPWSSzyIX7/vY+EpBC+YQBqv4vF9naoFvN/FlNXk
        vKDpu44BMOUhZdx1hgovAKE=
X-Google-Smtp-Source: AA0mqf5ZcHUqzra0Frk+ivAyRuwDAeJLBG89m+qnYjmVpULqxHOoH9i82562HZZ3OCSFSLzNExPHhg==
X-Received: by 2002:a17:902:760f:b0:186:8d46:c3 with SMTP id k15-20020a170902760f00b001868d4600c3mr21402757pll.49.1669426095656;
        Fri, 25 Nov 2022 17:28:15 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b0016c0c82e85csm4052347pln.75.2022.11.25.17.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 17:28:15 -0800 (PST)
Message-ID: <ef519087-c302-3547-1419-2dcddfb4c646@acm.org>
Date:   Fri, 25 Nov 2022 17:28:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 09/16] ufs: core: mcq: Configure operation and runtime
 interface
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <52b1525a4d680999687a1f0721ea60fd4cec9eb8.1669176158.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <52b1525a4d680999687a1f0721ea60fd4cec9eb8.1669176158.git.quic_asutoshd@quicinc.com>
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
> +static void ufshcd_config_mcq(struct ufs_hba *hba)
> +{
> +	ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
> +	ufshcd_mcq_make_queues_operational(hba);
> +	ufshcd_mcq_config_mac(hba, hba->nutrs);
> +
> +	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
> +	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
> +	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
> +		 hba->nr_hw_queues, hba->nr_queues[HCTX_TYPE_DEFAULT],
> +		 hba->nr_queues[HCTX_TYPE_READ], hba->nr_queues[HCTX_TYPE_POLL],
> +		 hba->nutrs);
> +}

Please do not reserve a slot for device commands in MCQ mode but instead 
queue device management commands on the device management command queue 
in MCQ mode. Please also add WARN_ON_ONCE() statements in the code that 
uses hba->reserved_slot to make sure that that variable is not used in 
MCQ mode.

Thanks,

Bart.
