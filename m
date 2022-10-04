Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0025F3C90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 07:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJDFxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 01:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJDFxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 01:53:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860233A3C;
        Mon,  3 Oct 2022 22:53:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3BB31F8F7;
        Tue,  4 Oct 2022 05:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664862819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zn4KgLrbrsg07djtEW13WewA5/R3t4N3KUlWt5rPs84=;
        b=K1m2srGCZ80Yn33A5rS+9RqwtlBf95Hbf0YH/3817NpL6gNd2uwyU8bYJ6ipUWCHMPbUfm
        XUAi1vJGf2zNTNQUpql6mTrQawnn/5MUE3HOZFgTmOgZkef7ua3PDF2tsTcMdlw1i5QwxU
        v+EH501Xt+GvDA4uP/yfTvPhnKkiMrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664862819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zn4KgLrbrsg07djtEW13WewA5/R3t4N3KUlWt5rPs84=;
        b=ThifiipquZ6eRCOnYl0pbP+YWKa+PpJF3+Tg7zonHMSVriqE5Gm4YJj9VN8sP024CT1Byt
        6XAzLhjPZib69pDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6659213A8F;
        Tue,  4 Oct 2022 05:53:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WSZTGGPKO2N6DgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Oct 2022 05:53:39 +0000
Message-ID: <a5d79845-cf8d-32e6-013e-60bbc6b15e86@suse.de>
Date:   Tue, 4 Oct 2022 07:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 5/6] scsi: mvsas: Delete mvs_tag_init()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, ipylypiv@google.com, changyuanl@google.com,
        hch@lst.de, yanaijie@huawei.com
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
 <1664528184-162714-6-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1664528184-162714-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 10:56, John Garry wrote:
> All mvs_tag_init() does is zero the tag bitmap, but this is already done
> with the kzalloc() call to alloc the tags, so delete this unneeded
> function.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/scsi/mvsas/mv_init.c | 2 --
>   drivers/scsi/mvsas/mv_sas.c  | 7 -------
>   drivers/scsi/mvsas/mv_sas.h  | 1 -
>   3 files changed, 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

