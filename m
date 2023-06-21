Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B939738A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjFUQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjFUQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:06:29 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2895;
        Wed, 21 Jun 2023 09:06:29 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-25edd424306so2129885a91.1;
        Wed, 21 Jun 2023 09:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363589; x=1689955589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANhBuY1BkJQHuvukRlCiWkcwmUgmv7RsjD/BodsFM8Y=;
        b=aaZFt0nsdG8OG5jOJ7Ms305MMoSO9emUcEcFw/fDHSV0Zms4zL0EnoHBmy22I8eHMB
         Sepd9JWQ5/MQeW5+uhRFZDfVi/CYCNmgzsIH1ZJuW/xnY7PKd5XiP8bH0jI+CzfzarnI
         svKlKRd5MLwOOAI8Xoswm1wkl0diKcDPOAvTV+K27AvkPV2FuxyoIdOxweGzZ9u5WSVA
         pSR9vAb9Zb3tPIEfCwz32I+y0lJ1AbsriyX6iZwPt0bL+FYwHanFGbcXAmDt2WwZr4kp
         3NupUN/bESUCGFmaA0qag57ffa2xU347lVWepo0zA73j6Yfqbf/XeggfeI0H/Zb1JCjd
         VFVg==
X-Gm-Message-State: AC+VfDyUPCB01aQ0UJ9EbHhGEBeXhMk4j8CeZ/WHIbS3T3Do2jkF90bu
        lttHHPNR9o7HjenSqTPtxi8=
X-Google-Smtp-Source: ACHHUZ66gQdcOK8mtfBUmJULdBxgu+TcSFVsM+yftcG0qy83CwljhEuG38NLPdTyq/cc1tpfFubXVA==
X-Received: by 2002:a17:90a:db15:b0:260:de07:c663 with SMTP id g21-20020a17090adb1500b00260de07c663mr3061072pjv.27.1687363588637;
        Wed, 21 Jun 2023 09:06:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9bb2:be1e:34e3:7c45? ([2620:15c:211:201:9bb2:be1e:34e3:7c45])
        by smtp.gmail.com with ESMTPSA id g14-20020a17090a290e00b0025e9d16f95bsm3615989pjd.28.2023.06.21.09.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 09:06:27 -0700 (PDT)
Message-ID: <02a90139-a94a-ea1d-cc36-8b4b66a96bba@acm.org>
Date:   Wed, 21 Jun 2023 09:06:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] scsi/sg: don't grab scsi host module reference
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
        chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, yukuai3@huawei.com, axboe@kernel.dk
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 09:01, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In order to prevent request_queue to be freed before cleaning up
> blktrace debugfs entries, commit db59133e9279 ("scsi: sg: fix blktrace
> debugfs entries leakage") use scsi_device_get(), however,
> scsi_device_get() will also grab scsi module reference and scsi module
> can't be removed.

I just noticed that this patch has been posted on the linux-scsi mailing 
list. If you plan to resend this patch, please send it to Jens and Cc 
both linux-block and linux-scsi because this patch fixes a bug in a 
patch that only exists in Jens' tree.

Thanks,

Bart.

