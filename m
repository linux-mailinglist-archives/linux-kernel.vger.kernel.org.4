Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2CC62354E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKIVBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiKIVA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:00:57 -0500
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5CD317DA;
        Wed,  9 Nov 2022 12:59:53 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id 78so17219813pgb.13;
        Wed, 09 Nov 2022 12:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHNdxjB2vbkPuh8ywKXBoD9bI2A/2MU0vQL/ydHZo+4=;
        b=PlNGhFg8DG8XBuJikCLyzpRTrTkLGNaeU3NJ4up2LhTqNrs1kWjSa+MBsyu3XK1zoj
         nbA7DA5vSxCm/0QwMNW/EWGOVkxzMIrBMSsx6rxJYjV5gZh429URQBDbUw5q8Tm1rWUV
         EcKK51Yk/Vr4fXvvaSQnu4HdT7YvKW1FaHM5yTiv9y2XFfVMdWqNu32psgwMldKB3DRj
         fb2BwAXOz38YtsOi9Pvfp8EIeOckWhWLh8g/f5j52ZNptR+GhyLY9OMyHWBpxrryVc5j
         f6qF547BspSFddTUMNraXi9MG9aVID3sxFJHj/zYxYOhjBjEMiGd/k2lz/X4MRpfbHhs
         +36g==
X-Gm-Message-State: ACrzQf1Twyapji/mVhBwxoj0vgw68o7uIQYSLRTwm5pksWjX3BDvR2Ba
        xiuPv4mYBlu5ItUkk1wgdls=
X-Google-Smtp-Source: AMsMyM62kMPNoyJDZgwdKKsxEk4j1aMpr65AK0xZCww1ROwtLXDwkgW6kIMV+m6QN1ONTXR2WuG7bA==
X-Received: by 2002:aa7:988b:0:b0:56e:6d41:b167 with SMTP id r11-20020aa7988b000000b0056e6d41b167mr33632016pfl.70.1668027593139;
        Wed, 09 Nov 2022 12:59:53 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:68b6:5dae:a00c:c3b? ([2620:15c:211:201:68b6:5dae:a00c:c3b])
        by smtp.gmail.com with ESMTPSA id q8-20020a635048000000b00460a5c6304dsm7769722pgl.67.2022.11.09.12.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 12:59:52 -0800 (PST)
Message-ID: <c1acceb1-8824-1d2a-8096-76ad5f17312d@acm.org>
Date:   Wed, 9 Nov 2022 12:59:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 03/16] ufs: core: Introduce Multi-circular queue
 capability
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1668022680.git.quic_asutoshd@quicinc.com>
 <aa223196f80538f061cac6245fd690d34f12f4b2.1668022680.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aa223196f80538f061cac6245fd690d34f12f4b2.1668022680.git.quic_asutoshd@quicinc.com>
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

On 11/9/22 11:41, Asutosh Das wrote:
> +/* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
> +static bool mcq_mode = true;

Please rename both the variable and the kernel module parameter 
"mcq_mode" into "use_mcq_mode".

> +module_param_cb(mcq_mode, &mcq_mode_ops, &mcq_mode, 0644);
> +MODULE_PARM_DESC(mcq_mode, "Disable MCQ mode for UFSHCI 4.0 controllers");

The description of this parameter is confusing since it suggests that 
setting this parameter to 1 disables MCQ mode.

Thanks,

Bart.
