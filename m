Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73796272C6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 22:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiKMVsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 16:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMVsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 16:48:43 -0500
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CF5DF78;
        Sun, 13 Nov 2022 13:48:42 -0800 (PST)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 3D6BA70E15;
        Sun, 13 Nov 2022 21:48:40 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 28E9C60905;
        Sun, 13 Nov 2022 21:48:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id bPeFWq1A6s5V; Sun, 13 Nov 2022 21:48:39 +0000 (UTC)
Received: from [192.168.5.47] (bras-base-toroon0409w-grc-44-184-147-168-78.dsl.bell.ca [184.147.168.78])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 1A57860112;
        Sun, 13 Nov 2022 21:48:38 +0000 (UTC)
Message-ID: <58472d12-c1e4-59f3-bb37-a98db17ef2ba@interlog.com>
Date:   Sun, 13 Nov 2022 16:48:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: dgilbert@interlog.com
Subject: Re: [RFC PATCH 0/5] scsi:scsi_debug:Add error injection for single
 lun
To:     Wenchao Hao <haowenchao@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221109155950.3536976-1-haowenchao@huawei.com>
Content-Language: en-CA
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20221109155950.3536976-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-09 10:59, Wenchao Hao wrote:
> The original error injection mechanism was based on scsi_host which
> could not inject fault for a single SCSI device.
> 
> This patchset provides the ability to inject errors for a single
> SCSI device. Now we supports inject timeout errors, queuecommand
> errors, and hostbyte, driverbyte, statusbyte, and sense data for
> specific SCSI Command
> 
> The first patch add an sysfs interface to add and inquiry single
> device's error injection info; the second patch defined how to remove
> an injection which has been added. The following 3 patches use the
> injection info and generate the related error type.
> 
> Wenchao Hao (5):
>    scsi:scsi_debug: Add sysfs interface to manager single devices' error inject
>    scsi:scsi_debug: Add interface to remove injection which has been added
>    scsi:scsi_debug: make command timeout if timeout error is injected
>    scsi:scsi_debug: Return failed value for specific command's queuecommand
>    scsi:scsi_debug: fail specific scsi command with result and sense data
> 
>   drivers/scsi/scsi_debug.c | 295 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 295 insertions(+)

Hi,
This patchset seems to assume all scsi_debug devices will be disk (-like) SCSI
devices. That leaves out other device types: tapes, enclosures, WLUNs, etc.

Have you considered putting these device specific additions under:
    /sys/class/scsi_device/<hctl>/device/error_inject/
instead of
    /sys/block/sdb/device/error_inject/

?

Doug Gilbert



