Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412695B9FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiIOQpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiIOQpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:45:39 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5624F64E;
        Thu, 15 Sep 2022 09:45:37 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id l10so18887770plb.10;
        Thu, 15 Sep 2022 09:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dGTAfwMFVda3M657H9jeHsvdIZrvS+apidMKmSoUdQU=;
        b=31849xoRPHnEdNuhtjtzHwa4OT8237Tg+K7K9eXwmwvm9Pemimqbt+PNpnRZkJ044t
         jtU6kslLrtlF7mHH+L4PIrXHIztNHcLH13J4qMff8p+6xuJaGtXCf51QyDOb0fbA1Tzi
         bwirRU4Ht4Kzu/kIH2nnfNCKgqNUsxdhJbrVsVtCy7992bZHldIUsNAlIMPAIhN+aZex
         Tp+qPMr4Jr05lB+JxCnkMdVzflwvk6S19TAc/cK8qnrOZpQBDzcvsblVzpE5pfXsz7gq
         oXyp5aWwyh0uQJX3ABuuJCkz5NQaHtb0GXye1FxT8mQi4LZyw88SSv4qil/ytj547PFZ
         znHw==
X-Gm-Message-State: ACrzQf2r8CJkPACt7yJhDe668zIRiAuEDAnr70bRJB8Wkb95aAfejpLk
        bilOGXqQHN/6rG1G5QMOGlQ=
X-Google-Smtp-Source: AMsMyM7EfbikQBm6Q9xOadLhTHcJLIYNE1vIOPqRX/gogHjL3BbhwRBPZV76KrAe3F9Q71EXBNF/KQ==
X-Received: by 2002:a17:90a:5aa2:b0:200:30aa:c773 with SMTP id n31-20020a17090a5aa200b0020030aac773mr11284848pji.182.1663260337245;
        Thu, 15 Sep 2022 09:45:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3e2c:d8db:6573:bb97? ([2620:15c:211:201:3e2c:d8db:6573:bb97])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001709b9d292esm13449354plg.268.2022.09.15.09.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 09:45:36 -0700 (PDT)
Message-ID: <04e4a2f5-03b9-a226-f3ef-9f9fcec1255d@acm.org>
Date:   Thu, 15 Sep 2022 09:45:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: BUG: unable to handle kernel paging request in scsi_device_unbusy
Content-Language: en-US
To:     Rondreis <linhaoguo86@gmail.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAB7eexKijKtCak4xh0JiyuQ0BmpryRLGm+_psrzjV+7KkKzA_g@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAB7eexKijKtCak4xh0JiyuQ0BmpryRLGm+_psrzjV+7KkKzA_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/22 08:56, Rondreis wrote:
> CPU: 0 PID: 12256 Comm: usb-storage Not tainted 6.0.0-rc4+ #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS

Does the above indicate an x86 CPU?

> Call Trace:
>   <TASK>
>   instrument_atomic_write include/linux/instrumented.h:86 [inline]
>   set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
>   sbitmap_deferred_clear_bit include/linux/sbitmap.h:327 [inline]
>   sbitmap_put include/linux/sbitmap.h:336 [inline]
>   scsi_device_unbusy+0x1aa/0x380 drivers/scsi/scsi_lib.c:301

There is some tricky code in the sbitmap implementation. How about 
checking the implementation of that code to see whether any memory 
barriers are missing?

Thanks,

Bart.
