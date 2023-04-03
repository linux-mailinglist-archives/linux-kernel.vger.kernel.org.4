Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC436D3CDB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjDCFZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjDCFZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:25:04 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24EA1FF9;
        Sun,  2 Apr 2023 22:24:33 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 4E88576385;
        Mon,  3 Apr 2023 05:23:56 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 31D3E609E9;
        Mon,  3 Apr 2023 05:23:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id JMNfbkNIKPRl; Mon,  3 Apr 2023 05:23:55 +0000 (UTC)
Received: from [192.168.48.17] (host-184-164-23-94.dyn.295.ca [184.164.23.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 4F3C860529;
        Mon,  3 Apr 2023 05:23:55 +0000 (UTC)
Message-ID: <f2ece258-c14f-69d2-f302-956bff2c921d@interlog.com>
Date:   Mon, 3 Apr 2023 01:23:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 10/11] scsi: scsi_debug: Only allow sdebug_max_queue be
 modified when no shosts
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
 <20230327074310.1862889-11-john.g.garry@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230327074310.1862889-11-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 03:43, John Garry wrote:
> The shost->can_queue value is initially used to set per-HW queue context
> tag depth in the block layer. This ensures that the shost is not sent too
> many commands which it can deal with. However lowering sdebug_max_queue
> separately means that we can easily overload the shost, as in the following
> example:
> 
> $ cat /sys/bus/pseudo/drivers/scsi_debug/max_queue
> 192
> $ cat /sys/class/scsi_host/host0/can_queue
> 192
> $ echo 100 > /sys/bus/pseudo/drivers/scsi_debug/max_queue
> $ cat /sys/class/scsi_host/host0/can_queue
> 192
> $ fio --filename=/dev/sda --direct=1 --rw=read --bs=4k --iodepth=256
> --runtime=1200 --numjobs=10 --time_based --group_reporting
> --name=iops-test-job --eta-newline=1 --readonly    --ioengine=io_uring
> --hipri --exitall_on_error
> iops-test-job: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=256
> ...
> fio-3.28
> Starting 10 processes
> [  111.269885] scsi_io_completion_action: 400 callbacks suppressed
> [  111.269885] blk_print_req_error: 400 callbacks suppressed
> [  111.269889] I/O error, dev sda, sector 440 op 0x0:(READ) flags 0x1200000 phys_seg 1 prio class 2
> [  111.269892] sd 0:0:0:0: [sda] tag#132 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
> [  111.269897] sd 0:0:0:0: [sda] tag#132 CDB: Read(10) 28 00 00 00 01 68 00 00 08 00
> [  111.277058] I/O error, dev sda, sector 360 op 0x0:(READ) flags 0x1200000 phys_seg 1 prio class 2
> 
> [...]
> 
> Ensure that this cannot happen by allowing sdebug_max_queue be modified
> only when we have no shosts. As such, any shost->can_queue value will
> match sdebug_max_queue, and sdebug_max_queue cannot be modified separately.
> 
> Since retired_max_queue is no longer set, remove support.
> 
> Continue to apply the restriction that sdebug_host_max_queue cannot be
> modified when sdebug_host_max_queue is set. Adding support for that would
> mean extra code, and no one has complained about this restriction
> previously.
> 
> A command like the following may be used to remove a shost:
> echo -1 > /sys/bus/pseudo/drivers/scsi_debug/add_host
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>

Thanks.

