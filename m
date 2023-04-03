Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836EA6D3CDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDCF1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDCF1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:27:35 -0400
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463D95FCF;
        Sun,  2 Apr 2023 22:27:11 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id D1C3BE1AC4;
        Mon,  3 Apr 2023 05:26:36 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id C1669609E9;
        Mon,  3 Apr 2023 05:26:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id leviovBKle6R; Mon,  3 Apr 2023 05:26:36 +0000 (UTC)
Received: from [192.168.48.17] (host-184-164-23-94.dyn.295.ca [184.164.23.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id E6C0F60529;
        Mon,  3 Apr 2023 05:26:35 +0000 (UTC)
Message-ID: <6c1e4b16-3f4a-6de5-d479-eaed806e4c41@interlog.com>
Date:   Mon, 3 Apr 2023 01:26:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 11/11] scsi: scsi_debug: Drop sdebug_queue
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
 <20230327074310.1862889-12-john.g.garry@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230327074310.1862889-12-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 03:43, John Garry wrote:
> It's easy to get scsi_debug to error on throughput testing when we have
> multiple shosts:
> 
> $ lsscsi
> [7:0:0:0]       disk    Linux   scsi_debug      0191
> [0:0:0:0]       disk    Linux   scsi_debug      0191
> 
> $ fio --filename=/dev/sda --filename=/dev/sdb --direct=1 --rw=read --bs=4k
> --iodepth=256 --runtime=60 --numjobs=40 --time_based --name=jpg
> --eta-newline=1 --readonly --ioengine=io_uring --hipri --exitall_on_error
> jpg: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=256
> ...
> fio-3.28
> Starting 40 processes
> [   27.521809] hrtimer: interrupt took 33067 ns
> [   27.904660] sd 7:0:0:0: [sdb] tag#171 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
> [   27.904660] sd 0:0:0:0: [sda] tag#58 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
> fio: io_u error [   27.904667] sd 0:0:0:0: [sda] tag#58 CDB: Read(10) 28 00 00 00 27 00 00 01 18 00
> on file /dev/sda[   27.904670] sd 0:0:0:0: [sda] tag#62 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
> 
> The issue is related to how the driver manages submit queues and tags. A
> single array of submit queues - sdebug_q_arr - with its own set of tags is
> shared among all shosts. As such, for occasions when we have more than one
> shost it is possible to overload the submit queues and run out of tags.
> 
> The struct sdebug_queue is to manage tags and hold the associated
> queued command entry pointer (for that tag).
> 
> Since the tagset iters are now used for functions like
> sdebug_blk_mq_poll(), there is no need to manage these queues. Indeed,
> blk-mq already provides what we need for managing tags and queues.
> 
> Drop sdebug_queue and all its usage in the driver.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>

Thanks.

