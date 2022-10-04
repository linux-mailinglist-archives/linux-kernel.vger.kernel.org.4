Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A046B5F3C88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 07:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJDFvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 01:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJDFvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 01:51:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524F356C8;
        Mon,  3 Oct 2022 22:51:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 29B961F896;
        Tue,  4 Oct 2022 05:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664862659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJ1y53AfxlVezuUynSJOhUKYRWBv9fsy34UFslZZoKs=;
        b=0KydthnMLPAgj6zEAymJmt511zpUl7nhsCOMcqySOnFc+OdghzdMSkZbQT3QR8mXnf6HsD
        NOZTSy+7x8Ab50cFaP1unf1aOrzUOCPfOwLc+eMGtaRh63G/rKCLj4c8PYYSSRx78yFQPf
        vuH3SdG2YRWyz7yB7eiMJqD6zx9561U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664862659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJ1y53AfxlVezuUynSJOhUKYRWBv9fsy34UFslZZoKs=;
        b=nK6N2PbAhjRR0T0MQ/CJdxShO1UEQNToWBB2C63ctHNl/iiTInZC70kntHNZ6i55tIx302
        QXsb7Xf47HjW7WAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B652613A8F;
        Tue,  4 Oct 2022 05:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sGFCK8LJO2OCDQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 04 Oct 2022 05:50:58 +0000
Message-ID: <1719c2ee-cf05-0885-38a8-7d1176020731@suse.de>
Date:   Tue, 4 Oct 2022 07:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/6] scsi: pm8001: Remove pm8001_tag_init()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, ipylypiv@google.com, changyuanl@google.com,
        hch@lst.de, yanaijie@huawei.com
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
 <1664528184-162714-4-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1664528184-162714-4-git-send-email-john.garry@huawei.com>
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
> From: Igor Pylypiv <ipylypiv@google.com>
> 
> In commit 5a141315ed7c ("scsi: pm80xx: Increase the number of outstanding
> I/O supported to 1024") the pm8001_ha->tags allocation was moved into
> pm8001_init_ccb_tag(). This changed the execution order of allocation.
> pm8001_tag_init() used to be called after the pm8001_ha->tags allocation
> and now it is called before the allocation.
> 
> Before:
> 
> pm8001_pci_probe()
> `--> pm8001_pci_alloc()
>       `--> pm8001_alloc()
>            `--> pm8001_ha->tags = kzalloc(...)
>            `--> pm8001_tag_init(pm8001_ha); // OK: tags are allocated
> 
> After:
> 
> pm8001_pci_probe()
> `--> pm8001_pci_alloc()
> |    `--> pm8001_alloc()
> |         `--> pm8001_tag_init(pm8001_ha); // NOK: tags are not allocated
> |
> `--> pm8001_init_ccb_tag()
>       `-->  pm8001_ha->tags = kzalloc(...) // today it is bitmap_zalloc()
> 
> Since pm8001_ha->tags_num is zero when pm8001_tag_init() is called it does
> nothing. Tags memory is allocated with bitmap_zalloc() so there is no need
> to manually clear each bit with pm8001_tag_free().
> 
> Reviewed-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   drivers/scsi/pm8001/pm8001_init.c | 2 --
>   drivers/scsi/pm8001/pm8001_sas.c  | 7 -------
>   drivers/scsi/pm8001/pm8001_sas.h  | 1 -
>   3 files changed, 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheerx,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

