Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CA96CB0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjC0Vh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjC0Vhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:37:54 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23E62D5B;
        Mon, 27 Mar 2023 14:37:50 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso270860pjf.0;
        Mon, 27 Mar 2023 14:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679953070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrhWOpnYqOzbSswTvxc2QdosIlWb0agRKLIOOTrkfmw=;
        b=NTpM3ChtkHyuG4llVTzSaFjxxopKvXXOUTh6CFFOtYdw9xAqR7UaYLaY6QWiDEeC4h
         X1iwVLN1uvaEmCOwiuzstp47zpdLZSKvEn/lUNfVp37db/U2K7KXujjB2OQVJD0hIR9s
         8g3WPkcdiNjuAfzAlsvE63Xrotc48XQsBEWKuRyKqMnMkQM6jnCm05rsZPX45D8ioAAS
         ZSB+s6NTI4tZYGIH79qSCDfJrd5QMNV6UgvGaziKS1k9PC57zvRMG4Agg+WMWmYkKN4Z
         LCokE/hf3bkIa+uOmQx5LL2oKneRg6gRtukbhdv+/Y8FF5Fd94ZIFtKGCLNJToK6Z3V8
         lFuQ==
X-Gm-Message-State: AAQBX9dVVDBzT2nbrM/CJK0UFRvLGbjAN2G4FI5UwcixlDkl6qvP14T0
        id2NJQ55BX0/jApTWcRTPtA=
X-Google-Smtp-Source: AKy350YUGgA7Q9wzXYiKTYTnPFiIvGOAC0Cw9EFoRFAZo56Cz2IQVPBj0e3jbs0LszZPOhiiBaqmkQ==
X-Received: by 2002:a17:90b:38cc:b0:23d:35c9:bf1c with SMTP id nn12-20020a17090b38cc00b0023d35c9bf1cmr14094005pjb.16.1679953070097;
        Mon, 27 Mar 2023 14:37:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:798e:a3a0:ddc2:c946? ([2620:15c:211:201:798e:a3a0:ddc2:c946])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm19609145plo.140.2023.03.27.14.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 14:37:49 -0700 (PDT)
Message-ID: <032dfbdc-bf8d-4ecc-dde3-162162be77ac@acm.org>
Date:   Mon, 27 Mar 2023 14:37:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/5] scsi: blocking IO when host is blocked
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
References: <20230325011734.507453-1-yebin@huaweicloud.com>
 <20230325011734.507453-5-yebin@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230325011734.507453-5-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 18:17, Ye Bin wrote:
> +	if (unlikely(scsi_host_blocked(shost)))
> +		goto out_dec_target_busy;
I this check would be moved earlier then the atomic_inc() and 
atomic_dec() of scsi_target(sdev)->target_busy could be skipped.

Thanks,

Bart.
