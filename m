Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0D7266B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjFGRHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFGRHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:07:04 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693371FC2;
        Wed,  7 Jun 2023 10:07:03 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b02497f4cfso39071405ad.3;
        Wed, 07 Jun 2023 10:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686157623; x=1688749623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=505T6N7yolcBjOfAxvT9wkjvITv0vcGHyeXuGtzFDfs=;
        b=Fm7Qs5xAkRb53Yr2g4Lm5o2OLpPM73XgGA63V6m+1KnjXvntTG96EG5M32X1QPYZkF
         Ilk4oWDCrQKOJqpDd0sbg0dUEqgYb+WYTv42teHbIXl+bqy9BJ83BBZQtGDt2t8it0bq
         iOoYGojKc+wiYNQNTfWNowyDpQiVt84kIGyPalxdX2tRtoayDHdTPazIpBbiLb4D3D8C
         eZgitGe2HPMBETj7UzdonKdeybw7bZU/sdStHe0sFZz1Ong+0Q0T2bToDFLmn//T+PW+
         0gvqzHwLHRdOSnIaZGpZw6x9vlpKcwt4Q8OA5pZmM2fErYYSvIKwlo9VNh7COZzKajix
         cvyw==
X-Gm-Message-State: AC+VfDwXsC0P/LdGuB+nFMsTIAg7PoqAUQCL9PQIF0zByKkXQ/DkOASs
        9mx0+F3GS1ZDxhw2NTENSLU=
X-Google-Smtp-Source: ACHHUZ6mZAtaQU022XtjO6NH0ithDH8YOqSyrY2Mmgzn8U7Z2fxNC8LwGJafFGYT3z5tZEfD2rls7A==
X-Received: by 2002:a17:902:f545:b0:1af:fe12:4e18 with SMTP id h5-20020a170902f54500b001affe124e18mr3360049plf.20.1686157622600;
        Wed, 07 Jun 2023 10:07:02 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001afa7040a70sm10659096pls.276.2023.06.07.10.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 10:07:01 -0700 (PDT)
Message-ID: <e9b8b9c5-f400-9152-0f4b-537b05203dd2@acm.org>
Date:   Wed, 7 Jun 2023 10:07:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] scsi: sd: support specify probe type of build-in driver
Content-Language: en-US
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, paulmck@kernel.org,
        bp@suse.de, peterz@infradead.org, will@kernel.org,
        rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
        wyes.karny@amd.com, jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230606051217.2064-1-iecedge@gmail.com>
 <6ad5fba3-926a-7a23-b21b-abffd33708be@acm.org>
 <CAFA-uR_Zn4MdFKs6U6dqPjuVS60yN4RcYU4jJzjknqy7-RWyEQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAFA-uR_Zn4MdFKs6U6dqPjuVS60yN4RcYU4jJzjknqy7-RWyEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 08:55, Jianlin Lv wrote:
> 1. MegaRAID adapters associated with 24 local disks. The disks are named
> sequentially as "sda," "sdb," and so on, up to "sdx."
> 2. STAT controllers associated with the root disk, named "sdy."
> 
> Both the MegaRAID adapters and the SATA controller (PCH) are accessed via
> the PCIe bus. In theory, depending on their PCIe bus ID in ascending order,
> the devices should be initialized in ascending order as well.

Hmm ... I don't think there is anything that prevents the PCIe maintainer
from changing the PCIe probing behavior from synchronous to asynchronous?
In other words, I don't think it is safe to assume that PCIe devices are
always scanned in the same order.

> For cloud deployment, the local volume provisioner detects and creates PVs
> for each local disk (from sda to sdx) on the host, and it cleans up the
> disks when they are released.
> This requires the logical names of the disks to be deterministic.

I see two possible solutions:
- Change the volume provisioner such that it uses disk references that do
   not depend on the probing order, e.g. /dev/disk/by-id/...
- Implement an algorithm in systemd that makes disk names predictable.
   An explanation of how predictable names work for network interfaces is
   available here: https://wiki.debian.org/NetworkInterfaceNames. The
   systemd documentation about predictable network names is available here:
   https://www.freedesktop.org/software/systemd/man/systemd.net-naming-scheme.html

These alternatives have the advantage that disk scanning remains asynchronous.

Thanks,

Bart.

