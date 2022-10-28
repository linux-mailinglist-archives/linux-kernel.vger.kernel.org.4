Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47551611D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJ1WJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJ1WIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:08:42 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7628C24CCA6;
        Fri, 28 Oct 2022 15:08:41 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id y13so5888406pfp.7;
        Fri, 28 Oct 2022 15:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIdR8ig1omdEV7fd5WEXjnAuRKZfGz+B13uwi7OkHMs=;
        b=A0J5WwcCwcwa5eVJumbaM9VjSbYuSB/W4rIFi8Zzadc3fyAHLJAumuRYncR2ZQxdfo
         yupUKeeeCIKwFTMb++Oz0/phSXgO1OalS8vkOrN7uXu/snrnAEDtOGUOaFbi3+TdmpK8
         +e4J5eUgN8/s0ugXmu7XrENsf8PnlCJjlUdKwlFSChaj25QNXf2AoYUxNRaILebjgtBk
         cYO++/5yn13iY2L+EiOcOOl7ffHPzfZCCgQS9KIzd2AbXvfNu5vIXbAyhgucekutfahL
         ZzUjx96yddpPdlcskErQPpWo6Zwg+D6a886gutOslqpchgkHaQuxz3MlUkvt2KxKqc3h
         Kqug==
X-Gm-Message-State: ACrzQf1yhO2qDAGTsRwbyUogW8latBdrhQKFImFT6QDYgIQkP35xr7bq
        6CEuBpvaIlXHL8WQlmZb748=
X-Google-Smtp-Source: AMsMyM7CGn68icfXshr3ltUjfrQSZfJ++ezHubkJVXBc3vBo7Ik5LqcSYDpnvn8qLoa4TtprJP6d1g==
X-Received: by 2002:a05:6a00:1943:b0:563:8173:b46a with SMTP id s3-20020a056a00194300b005638173b46amr1569645pfk.34.1666994920926;
        Fri, 28 Oct 2022 15:08:40 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id bi6-20020a170902bf0600b0017f36638010sm3464312plb.276.2022.10.28.15.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 15:08:40 -0700 (PDT)
Message-ID: <c03ac1f5-e4a4-c26a-c1f5-b4e78cae3472@acm.org>
Date:   Fri, 28 Oct 2022 15:08:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 17/17] ufs: qcom-host: Enable multi circular queue
 capability
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, quic_richardp@quicinc.com,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <4d21c867708a9d37e53293510d81013088d01c39.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4d21c867708a9d37e53293510d81013088d01c39.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 36c40210..b740299 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -853,6 +853,7 @@ static void ufs_qcom_set_caps(struct ufs_hba *hba)
>   	hba->caps |= UFSHCD_CAP_CRYPTO;
>   	hba->caps |= UFSHCD_CAP_AGGR_POWER_COLLAPSE;
>   	hba->caps |= UFSHCD_CAP_RPM_AUTOSUSPEND;
> +	hba->caps |= UFSHCD_CAP_MCQ_EN;

Shouldn't we have a flag that disables MCQ rather than a flag that 
enables MCQ? Otherwise the above line will be duplicated in every single 
host controller driver that supports MCQ.

Thanks,

Bart.

