Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12C2611D70
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJ1Wh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ1Wh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:37:56 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948572475E6;
        Fri, 28 Oct 2022 15:37:55 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id o7so2622088pjj.1;
        Fri, 28 Oct 2022 15:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lG8zamfYpBNuJEJ6N8B81NRx8AkrlU5b5N4pnBOl74A=;
        b=6mPzvGRZPu9/BS2nRcYf35JwMklY6DSrvP03i2pU/QAdYLl6ja4rLrx+v+zf1W+m4c
         6MXPS2msteMTB4xidvGiz3sOegcdfIsI/TfJ+t/35YnRJ7SdI/dEFYJcWi88REVfRHS3
         kOcMKHKbVX7MumYcW4tiJl5ngT+HoOYh8ZuKxQduTI/+yE1xYPhPkPULXShfq4MzFKLS
         vnsY3xW3FGBk3SjoAc5afLM6akx3j7hs3QvOpdCbks1hfYe/vc37AS+744UcjPwC6PHM
         FDkrWpsbAs29U0oM9Fuz0Ttmtwbcy6Kz72j3l+zqeiS5otpPOQpfIgW6G3sS64XwrAPm
         I48A==
X-Gm-Message-State: ACrzQf3w6J2mnjqF+zyt8LqHLBB87LFOarNpaGqdd9a4vIKYeRN3gsLT
        kzmghpMmO3Fd5Nmsn8Fsi1g=
X-Google-Smtp-Source: AMsMyM5/EIfkQ8bhIr+Fgc0GMELe9gnyG6MINjp5bAvQY4GXxo61JvyNXF8SLVTDfE9kybGjloJ3nA==
X-Received: by 2002:a17:902:9b82:b0:183:fffb:1bfe with SMTP id y2-20020a1709029b8200b00183fffb1bfemr1271832plp.173.1666996675010;
        Fri, 28 Oct 2022 15:37:55 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id q6-20020aa79606000000b0056bc5ad4862sm3321945pfg.28.2022.10.28.15.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 15:37:54 -0700 (PDT)
Message-ID: <5e16052f-7cba-48e1-232c-4dd294ebd960@acm.org>
Date:   Fri, 28 Oct 2022 15:37:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] scsi: ufs: core: Refactor ufshcd_hba_enable()
Content-Language: en-US
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20221028073553epcms2p6dc4f8bdbebdc8f96f43fc4197b3edd0c@epcms2p6>
 <20221028073553epcms2p6dc4f8bdbebdc8f96f43fc4197b3edd0c@epcms2p6>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221028073553epcms2p6dc4f8bdbebdc8f96f43fc4197b3edd0c@epcms2p6>
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

On 10/28/22 00:35, Keoseong Park wrote:
> Use "if error return" style in ufshcd_hba_enable().
> No functional change.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
