Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5742D62224A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiKICy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiKICyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:54:23 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1C26563;
        Tue,  8 Nov 2022 18:54:21 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id k22so15485913pfd.3;
        Tue, 08 Nov 2022 18:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyorhJCTSS6+0hPMlFzpEuVOTIRf/zjd/ug2ks95Ljg=;
        b=VH2QJB4mWw1oJX4ZZX5RCSix1QLp65AequtuiRgCqcmHhhpf2s5dtZdv81bvHLu4ag
         NbEeMLCXB9wvcavGrhfRTNhjJS2QEuCtcQATO63oqNOeObM+e6dYjWLfF1t9gKBxlt3Q
         AxdwN2GzxljwZIyA1FsNSAQxx9TVzdTP4l5ypCsmq8gcyFyqpcqA6lSkZ9QJvCoJlTqR
         CeNtybsHzh0ZCeO+f/uMQBhTcxeoWzmAaITzZqxsF0Lk6QuXvPoI632nUAf5j/Qe4yLr
         /UZHs6EEvSaUb35a/6hu/hXdnYBr/KA+xrW/NCyU2W25jfsWy1IVw/RZ/IGnhhWcNpQ8
         Fd+A==
X-Gm-Message-State: ACrzQf2DW8hJhtGDmWcyP9OGXL7LcapwNDcCwxhiOsW4mYNx4C7dQz92
        c1d9JkFRjyMbr2EYtCmjBBc=
X-Google-Smtp-Source: AMsMyM4prXtxl5s44uI/6xJLoeTZiIab88g/7ZFG+phWqVdgqrZxR8gRhNLQ5JxArDib8u7lOPzCUg==
X-Received: by 2002:a63:d60e:0:b0:46f:8979:30ba with SMTP id q14-20020a63d60e000000b0046f897930bamr47702265pgg.332.1667962460883;
        Tue, 08 Nov 2022 18:54:20 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id ij26-20020a170902ab5a00b0017f6c9622b9sm7627594plb.183.2022.11.08.18.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 18:54:20 -0800 (PST)
Message-ID: <65f5d26b-b0af-f9c6-e77c-e82ac969e9f9@grimberg.me>
Date:   Wed, 9 Nov 2022 04:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Gerd Bayer <gbayer@linux.ibm.com>
Cc:     Jens Axboe <axboe@fb.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
 <20221108074846.GA22674@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108074846.GA22674@lst.de>
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


> Below is the minimal fix.  I'll see if I sort out the mess that is
> probe/reset failure vs ->remove a bit better, though.
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f94b05c585cbc..577bacdcfee08 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5160,6 +5160,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>   
>   void nvme_stop_queues(struct nvme_ctrl *ctrl)
>   {
> +	if (!ctrl->tagset)
> +		return;
>   	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>   		blk_mq_quiesce_tagset(ctrl->tagset);
>   	else
> @@ -5169,6 +5171,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_queues);
>   
>   void nvme_start_queues(struct nvme_ctrl *ctrl)
>   {
> +	if (!ctrl->tagset)
> +		return;
>   	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>   		blk_mq_unquiesce_tagset(ctrl->tagset);
>   }

Can we do that in the pci driver and not here?
