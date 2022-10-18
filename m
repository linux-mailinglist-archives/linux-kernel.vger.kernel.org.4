Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0578E602B21
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiJRMFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiJRME1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:04:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49D7491DE;
        Tue, 18 Oct 2022 05:03:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 339BA33E49;
        Tue, 18 Oct 2022 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666094631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbRAc8FpKFKeJzh5cRw7qht0aI7mot6X3f5/v8nZvdU=;
        b=pp7RwiJCZ9Y2sJK45odOstTjtj6tVfcML3ZyaLKfA+gELO9Kxi2vaO2YjLDWDA4PXbmVEV
        y7X40TGqQaXrkPAhkNCZ1mg3krNoGzu8wyjs8rJdRcCNndflDzDcijmE0Kr5h9lwebJqCk
        F4T0qYCsRwYZje1OdKo6Bd3JJEOYMQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666094631;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbRAc8FpKFKeJzh5cRw7qht0aI7mot6X3f5/v8nZvdU=;
        b=xmFaMAyq9kZlAlT2R1D/iOcVHGj86vhzkLVd/+qHjJ2KVVxZ5GEmgiK/4EOmGhdYfly5BQ
        0D2PlEY8nmq5kcCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F28DC13480;
        Tue, 18 Oct 2022 12:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z2wbOiaWTmMSZQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 18 Oct 2022 12:03:50 +0000
Message-ID: <7b049690-b3e8-6e45-ffef-967df77a7f48@suse.de>
Date:   Tue, 18 Oct 2022 14:03:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 5/7] scsi: pm8001: Use sas_task_find_rq() for tagging
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, ipylypiv@google.com, changyuanl@google.com
References: <1666091763-11023-1-git-send-email-john.garry@huawei.com>
 <1666091763-11023-6-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1666091763-11023-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 13:16, John Garry wrote:
> The request associated with a scsi command coming from the block layer
> has a unique tag, so use that when possible for getting a CCB.
> 
> Unfortunately we don't support reserved commands in the SCSI midlayer yet,
> so in the interim continue to manage those tags internally (along with
> tags for private commands).
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/scsi/pm8001/pm8001_init.c | 12 ++++--------
>   drivers/scsi/pm8001/pm8001_sas.c  | 13 +++++++++----
>   drivers/scsi/pm8001/pm8001_sas.h  | 11 ++++++++---
>   drivers/scsi/pm8001/pm80xx_hwi.c  | 19 +++----------------
>   4 files changed, 24 insertions(+), 31 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
