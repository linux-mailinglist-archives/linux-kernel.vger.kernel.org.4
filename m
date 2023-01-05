Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C127065F6EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbjAEWhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjAEWhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:37:22 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706F511A1A;
        Thu,  5 Jan 2023 14:37:21 -0800 (PST)
Received: by mail-pl1-f175.google.com with SMTP id p24so18350742plw.11;
        Thu, 05 Jan 2023 14:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCTlzFm5fJtKAO2V8wQaI92SjSB9L9pSd5yrDbFK4ZI=;
        b=Ta62VKCsdH3CYXCmweqLae5Hn912pOhv1wF8ae9jYnLyey+j0CiVBcnI3uBVfoOY6n
         UAAQ4+Uv/EJF5s+jEnQ6IRM2JgfvE3eYX2uik9k473OdOfceN+YKKy3xLHZTFrdjerIj
         Gcionrh2QPOuJmPn6VFPFb16aqvyLbTp/kXEztHsXdkr0vsF+ndWy6pm3K/kfG0Qx7CC
         OuANi/qYP04+mwf2Za/m7qtYUWY1T5WCCgXp4gR9FAbxEK9HKc0I2eDPcB0YUjW5xkkw
         HJRqGJc3AyuU0H9lCkjtvOXjLit2e5z06/bO+vsX2Y125Z7GrgOavvoIZQAfbRxC0527
         AG6A==
X-Gm-Message-State: AFqh2kqeaZljuNOMuvkJDfDP0xyYcRfp4H75kTHhWWcgD345GmK1te6M
        NO8z2uoctLn5XTkoj37xKlw=
X-Google-Smtp-Source: AMrXdXuHU/eFew8BTXJhLBgH4SuzgVSzYb7kCXylY0BzdjufeEvmH9cDwEf+OM38vM/80N78Q7XQZg==
X-Received: by 2002:a17:903:41c6:b0:186:8238:bc9 with SMTP id u6-20020a17090341c600b0018682380bc9mr76005463ple.2.1672958240740;
        Thu, 05 Jan 2023 14:37:20 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:f9eb:49b6:75b:111e? ([2620:15c:211:201:f9eb:49b6:75b:111e])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b001886ff822ffsm26633693plk.186.2023.01.05.14.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 14:37:19 -0800 (PST)
Message-ID: <81a10cd9-7b0b-e982-5d24-5f0438e37b63@acm.org>
Date:   Thu, 5 Jan 2023 14:37:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 7/7] ufs: core: Add advanced RPMB support in ufs_bsg
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com,
        daejun7.park@samsung.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_richardp@quicinc.com, quic_asutoshd@quicinc.com, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221201140437.549272-1-beanhuo@iokpp.de>
 <20221201140437.549272-8-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221201140437.549272-8-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/22 06:04, Bean Huo wrote:
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 5cf81dff60aa..c3dfa8084b5c 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> +int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *req_upiu,
> +				     struct utp_upiu_req *rsp_upiu, struct ufs_ehs *ehs_req,
> +				     struct ufs_ehs *ehs_rsp, int sg_cnt,
> +				     struct scatterlist *sg_list, enum dma_data_direction dir);

Hi Bean,

I think this patch is the first patch that adds a declaration in 
ufshcd.h that uses the enum dma_data_direction data type. That leads to 
the following compiler warning:

In file included from drivers/ufs/host/tc-dwc-g210-pci.c:10:
./include/ufs/ufshcd.h:1282:72: warning: ‘enum dma_data_direction’ 
declared inside parameter list will not be visible outside of this 
definition or declaration
  1282 |                                      struct scatterlist 
*sg_list, enum dma_data_direction dir);
       | 
        ^~~~~~~~~~~~~~~~~~

Can you please post a patch to fix this? Adding the following line is 
probably sufficient:

#include <linux/dma-direction.h>

This has been detected with the following script:
https://github.com/bvanassche/build-scsi-drivers/blob/main/build-scsi-drivers

Thanks,

Bart.
