Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61A60C012
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJYAtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJYAsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:48:52 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68E71F2E1;
        Mon, 24 Oct 2022 16:25:08 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id 4so3841049pli.0;
        Mon, 24 Oct 2022 16:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvEdoDBAi89KOYt6Jf806Yz9Scu5Xe0JJtdfGkzFZ18=;
        b=K+lKGg4hXOYDBcj3GIhtn+jN0JMJinuGmbQhFGFcYop37kHNZWSMW2vjVmQdmrOLUz
         XbyouAeukUl10t/GMit1HKR0zOrjnE4OCK9O28RWkadO2y65lY1pfK2d0LFymQiBAIkC
         HNIslbeIctxpko8MS1/n7+KQC4CICtG2FaeNSfq71Rd8R7ShdqOzp8d1+cj6jqBVZ5j5
         boCDsHfIbOz7v+e11mq3kNH/T+yrkK6HqV27EMDNI8eCoGED7MHY7/o4HHrahrWTIbc6
         jnoiMWeG+DUrqWfJHnTYT+ODANcInzBh0xwzNo7Hgjc/4D3uY3hjGBsUSnkltsKoxLQH
         JyqQ==
X-Gm-Message-State: ACrzQf20xmIGb2xYQ/wllxO7ES3uWlNXB1NTLnmO+r8vvRMkdQTM+zgn
        ITDR+LkfqNdM+WdBmni5jjM=
X-Google-Smtp-Source: AMsMyM6k8RRmh9tpgHffYmEJrio10Hdw0jl/gJFQklDBZlGYm+ag5YsiUA2iJ6R6oc0pTnOvH5FTXw==
X-Received: by 2002:a17:903:2284:b0:185:3948:be7c with SMTP id b4-20020a170903228400b001853948be7cmr36519102plh.51.1666653908072;
        Mon, 24 Oct 2022 16:25:08 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902e95000b001767f6f04efsm222352pll.242.2022.10.24.16.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 16:25:07 -0700 (PDT)
Message-ID: <1915c52f-0c76-0f90-97e9-0c27c36a9e1a@acm.org>
Date:   Mon, 24 Oct 2022 16:25:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Cleanup ufshcd_slave_alloc()
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221022213650.626766-1-beanhuo@iokpp.de>
 <20221022213650.626766-3-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221022213650.626766-3-beanhuo@iokpp.de>
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

On 10/22/22 14:36, Bean Huo wrote:
> +	u8 lun_qdepth = hba->nutrs;

How about changing this into hba->nutrs - 1 since one tag is reserved 
('reserved_slot')?

Thanks,

Bart.
