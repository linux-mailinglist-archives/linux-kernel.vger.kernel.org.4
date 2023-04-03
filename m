Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CCE6D3CBC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDCFSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjDCFSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:18:06 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2289055A7;
        Sun,  2 Apr 2023 22:18:05 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 5F7A075DCB;
        Mon,  3 Apr 2023 05:18:04 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 4D197609E9;
        Mon,  3 Apr 2023 05:18:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id Uzuq-yi2qnTN; Mon,  3 Apr 2023 05:18:04 +0000 (UTC)
Received: from [192.168.48.17] (host-184-164-23-94.dyn.295.ca [184.164.23.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id AD13060529;
        Mon,  3 Apr 2023 05:18:03 +0000 (UTC)
Message-ID: <95019bca-c018-d417-b40f-558dfb51b0e4@interlog.com>
Date:   Mon, 3 Apr 2023 01:18:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 06/11] scsi: scsi_debug: Dynamically allocate
 sdebug_queued_cmd
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
 <20230327074310.1862889-7-john.g.garry@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230327074310.1862889-7-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 03:43, John Garry wrote:
> Eventually we will drop the sdebug_queue struct as it is not really
> required, so start with making the sdebug_queued_cmd dynamically allocated
> for the lifetime of the scsi_cmnd in the driver.
> 
> As an interim measure, make sdebug_queued_cmd.sd_dp a pointer to struct
> sdebug_defer. Also keep a value of the index allocated in
> sdebug_queued_cmd.qc_arr in struct sdebug_queued_cmd.
> 
> To deal with an races in accessing the scsi cmnd allocated struct
> sdebug_queued_cmd, add a spinlock for the scsi command in its priv area.
> Races may be between scheduling a command for completion, aborting a
> command, and the command actually completing and freeing the struct
> sdebug_queued_cmd.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>

Thanks.

