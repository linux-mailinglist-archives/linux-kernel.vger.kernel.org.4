Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E017738A10
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjFUPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjFUPrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:47:16 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5003BC;
        Wed, 21 Jun 2023 08:47:15 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b52bf6e669so47781795ad.2;
        Wed, 21 Jun 2023 08:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362435; x=1689954435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5Mcef6zMkNz9FKaMVVsQpbKPOPdZ24sc4KU/lOwhoA=;
        b=Bi/cXZWeZgWMODnp89bAt8fNFY8oQ4OLLzKrznbVOLQnLvoLjTMSMZS9xlAdJM4Yil
         2tUFAlgT9tERxr196lRy3dXaO3CCKOsw0NgHGmHPKG5074D5ffWD2ODkK49bP8erhHaM
         HsV8auPVLV4sLHXvKLIBT0//rpX9V/mhkT/mJV2cgHPqpTSZvlF6NNRCbgq6eHfnxCDJ
         vsMjmFv5EYeRELE6XJqeZhRuidsuf5AVvjAso70JdY0ru/l3kmuYEfyyNfZsi8WB5enM
         tdF/HHyjP53GuBgezZOnYZhh5VjhVQvaUvUHaKVTdNiNzHqEaSwKEGUpSW6XvV0zDoPj
         yIcw==
X-Gm-Message-State: AC+VfDwx2b3j2wNtVJM71Fn5Hd7yGE3xnDERXs6i4oofqGRVp5AlDA9j
        b5ypiSgrD0yBEz6ky8qkZawK1IlbZco=
X-Google-Smtp-Source: ACHHUZ5TZ+AEE0tR2knWzeb7OcqtZ05gFVcqzh+aTH+zi7o1/qW/EOI3CETf/JsKXR8pyNBDrqhJfw==
X-Received: by 2002:a17:903:2682:b0:1b1:9d14:1537 with SMTP id jf2-20020a170903268200b001b19d141537mr13780419plb.55.1687362435057;
        Wed, 21 Jun 2023 08:47:15 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9bb2:be1e:34e3:7c45? ([2620:15c:211:201:9bb2:be1e:34e3:7c45])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b001b54d064a4bsm3629752plg.259.2023.06.21.08.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 08:47:14 -0700 (PDT)
Message-ID: <93834519-c945-94a7-f1f8-7bf85bf86dd5@acm.org>
Date:   Wed, 21 Jun 2023 08:47:10 -0700
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
> 
> It's reported that blktests can't unload scsi_debug after block/001:
> 
> blktests (master) # ./check block
> block/001 (stress device hotplugging) [failed]
>       +++ /root/blktests/results/nodev/block/001.out.bad 2023-06-19
>        Running block/001
>        Stressing sd
>       +modprobe: FATAL: Module scsi_debug is in use.
> 
> Fix this problem by grabbing request_queue reference directly, so that
> scsi host module can still be unloaded while request_queue will be
> pinged by sg device.

pinged -> pinned

Otherwise this patch looks good to me.

Bart.
