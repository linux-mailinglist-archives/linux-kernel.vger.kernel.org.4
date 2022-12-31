Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7865A716
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 22:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiLaV3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 16:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaV3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 16:29:00 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4763D8;
        Sat, 31 Dec 2022 13:28:59 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id 20so11937115plo.3;
        Sat, 31 Dec 2022 13:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adjBQcXCLgzOUyvmCAw+CpN46s5Adoe7A7poEBz9+sE=;
        b=uR7/wVdeMS2tLeetPB7/xo+0sbV7VWs+JdZrD8KjkP2KT/AjYmipUjURNsIv/ANTjU
         dBe0mHRCHDl+RBXtIga6DqpL1CFr/2rLyYY3XePaG+FePzs+jjj2c7zx0wbKsBKDjfKU
         MeP1P7zUu2zvaP9uPtt05TgPerdEglFkPF2c93YzS99CAF7jgzD/DFoURcXrqxPS2ueJ
         Ngjvtyr1WQUpwRK8Z7PTAYERRRPsa0l6dQCw1OZclKZPUijyZE2KHF83Y4XHQq2f4ryq
         A/oMX/WL8Nad700zLGkpJiDPL+84DrQgU86IssISyYr4F1v40YkqQxGSO2LOvthfRwz5
         y+Ig==
X-Gm-Message-State: AFqh2krPDdpyX3mx8PhNjAdL3G6r5TUn2BloK5MWXcgdykJKgOiXzDgy
        4M+IbA1c5EibNK4vp2gTlBY90UATqgk=
X-Google-Smtp-Source: AMrXdXtCeSrKhnuxYyEFIv/tHDz2NbBrEOnfT1K153E+dmGEL0qGnvyWjf/x6agZRKB/+fdVqW5P2g==
X-Received: by 2002:a17:903:2447:b0:191:1a7c:ef9f with SMTP id l7-20020a170903244700b001911a7cef9fmr55949758pls.1.1672522138944;
        Sat, 31 Dec 2022 13:28:58 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y4-20020a655b44000000b0047899d0d62csm14641850pgr.52.2022.12.31.13.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 13:28:57 -0800 (PST)
Message-ID: <6dc49f2e-1c81-8392-20b4-f79af2abace0@acm.org>
Date:   Sat, 31 Dec 2022 13:28:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 18/23] scsi: ufs: core: Add reinit_notify() callback
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
 <20221222141001.54849-19-manivannan.sadhasivam@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221222141001.54849-19-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/22 06:09, Manivannan Sadhasivam wrote:
> reinit_notify() callback can be used by the UFS controller drivers to
> perform changes required for UFSHCD reinit that can happen during max
> gear switch.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

