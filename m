Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBE8610490
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiJ0Vih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJ0Vif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:38:35 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84AD72EF2;
        Thu, 27 Oct 2022 14:38:34 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id s196so2930891pgs.3;
        Thu, 27 Oct 2022 14:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fu+AE2w/NjkXk0KKy23RtcVXcub0gQ9rE9WPHcfx1Q=;
        b=jBU3PnFHTDSeBgavLo37H6csyVXAcZF4XsSXO9JhiZ3RTVFgRPR3JzfHwUuLDdTlwY
         NbvdHsybDyft6bN7K4jC4WH4G2uPCYV7jcdhS+rg+Q5pIpQRDyvzSU0hmU7kySHg1Mml
         QGzYK3qG1AWnFZnXwTS0KZH4jwe11IRek1w8XNLVqs1YqtSifrv5qepcQdPXFLFIW9c3
         XNntbngsWFnHNvSi79wfcCNKd9ycEemHvz17Q2leJ/NQNxIC3MtH/kkDjAXMZoUY+64Q
         gYWx7chMT8ooPZAlHvVSDjcdwYCxT1crtKkepMA706Ecu9rMtOxHwb8pYV4VT2MxUsWS
         TbRA==
X-Gm-Message-State: ACrzQf2ZRz6m7+AqcXOtYcNx5PPcaGXmTKViDLio6mOxfXyAbzFQnmOD
        R8UU0SJm5vuprjf4qI7OQN7w8s/fLMo=
X-Google-Smtp-Source: AMsMyM4nU0xhIGSaZ7xuFhJD16Ppb/dYzKOYcXSfAYOwmA+buJNGVWyimemJMks3bOFam6I+8Qn5/A==
X-Received: by 2002:a63:6a85:0:b0:43b:d845:f67d with SMTP id f127-20020a636a85000000b0043bd845f67dmr42692485pgc.349.1666906714042;
        Thu, 27 Oct 2022 14:38:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bc2b:ff19:1b02:257b? ([2620:15c:211:201:bc2b:ff19:1b02:257b])
        by smtp.gmail.com with ESMTPSA id q9-20020a63d609000000b004405c6eb962sm1494780pgg.4.2022.10.27.14.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:38:33 -0700 (PDT)
Message-ID: <18ef5dff-141c-7d23-6930-8bd5a9871e3e@acm.org>
Date:   Thu, 27 Oct 2022 14:38:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 08/17] ufs: core: mcq: Allocate memory for mcq mode
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, quic_richardp@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <054ec088877bd4b421f2e9cb2b0fd8c4e058af11.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <054ec088877bd4b421f2e9cb2b0fd8c4e058af11.1666288432.git.quic_asutoshd@quicinc.com>
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
>   int ufshcd_mcq_init(struct ufs_hba *hba)
>   {
> -	int ret;
> +	int ret, i;
> +	struct ufs_hw_queue *hwq;

Although this is not a strict rule, most kernel developers these days 
order declarations from longer to shorter ("reverse Christmas tree").

> +	/* The very first HW queue is to serve device command */

is to serve -> serves
command -> commands

Otherwise this patch looks good to me.

Thanks,

Bart.
