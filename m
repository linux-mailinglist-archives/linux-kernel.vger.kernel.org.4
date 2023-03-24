Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D0A6C820F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCXQCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXQCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:02:03 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D6519C4C;
        Fri, 24 Mar 2023 09:02:02 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id kq3so2178076plb.13;
        Fri, 24 Mar 2023 09:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679673722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQeDTswkf5n66eJVZ3PJ439rYq/MSFC/te2Yd7ITppg=;
        b=3uIFI7OazQrVqTYZp7kS+AcfQ05NuvK+DptlKMoSAb5d1jtSSiFjloM3MjWs2ftqBm
         OL2LJSJWKL11AgkdXgipPqrhgIVOqwg7qX1dmNKrF3dve4zKj6mCPPBdpi5WXAFHcp0l
         m8vy39qXmSX68Ed4YHsjZlzgKPFztcqDCQ38KnXMxTLkVLFpMg4OpBAXytEKDCGBU+0R
         XiribBI6U0RL473QhDac4Di4gcjyg6cLogp6X2+MLfygbQfvfYKgQbR+RqagjKCaLQv1
         324KL+iCUBC43nuGj5arPrtf0AoTqayuhwEQm9+kAWCWeDyO7pBJOP6hSq3J0dodYsXi
         V5aA==
X-Gm-Message-State: AO0yUKXDHZbfFISuILK5EoHCWBfWlbxnXGKXXo9G2sxKgTyOFxQZlFi/
        cllrEN3q0w1M/z7m2Y/BehQ=
X-Google-Smtp-Source: AK7set8+oF2VqQfXa1R/1dsnOqyLOVngF/N0nrkA6UdHQI51ywjXPbPatvD3t9wajutj7VAmZFGQzg==
X-Received: by 2002:a05:6a20:cc59:b0:db:9a60:a52d with SMTP id hq25-20020a056a20cc5900b000db9a60a52dmr2663193pzb.41.1679673722000;
        Fri, 24 Mar 2023 09:02:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2421:e16e:b98f:7e76? ([2620:15c:211:201:2421:e16e:b98f:7e76])
        by smtp.gmail.com with ESMTPSA id i22-20020aa78b56000000b005aa60d8545esm14043267pfd.61.2023.03.24.09.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 09:02:00 -0700 (PDT)
Message-ID: <0a152b0a-4fa9-c727-6e41-910e1eb71e2c@acm.org>
Date:   Fri, 24 Mar 2023 09:01:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/5]scsi:scsi_debug: Add error injection for single device
Content-Language: en-US
To:     "haowenchao (C)" <haowenchao2@huawei.com>,
        John Garry <john.g.garry@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com, louhongxiang@huawei.com
References: <20230323115601.178494-1-haowenchao2@huawei.com>
 <b5f8240e-f46a-b83b-ed16-66c2d8c5571f@oracle.com>
 <c9d213e2-5ab4-0db2-f87a-247519debbbb@huawei.com>
 <750a4b24-6122-6faa-fed4-25e3167ea376@oracle.com>
 <0a6fc4bd-82a1-3200-3061-4634531b5a63@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0a6fc4bd-82a1-3200-3061-4634531b5a63@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 20:42, haowenchao (C) wrote:
> If sysfs is not recommended, what about proc?

procfs is for process information and should not be used for any other 
purpose.

Thanks,

Bart.

