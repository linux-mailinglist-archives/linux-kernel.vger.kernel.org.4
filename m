Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169A06794AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjAXKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjAXKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:03:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FB1E5EF;
        Tue, 24 Jan 2023 02:03:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE6EE1F45B;
        Tue, 24 Jan 2023 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674554582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XlyGLp9iAeImFLsnSAcMxEWopq1s7dMOnOrqAcJb5aI=;
        b=iJDUQkn/cNwIAVgveFSobSI3meetZed44h7lnlZflvh4gDI46mQBSDkxqHvrqeHMfYls6f
        9EWA/IotXTRFDUB0S9wT9at9zLO0tXlK3CpdY4EWQJsLzz4JDGUL+eMvI/eysH5fokc2EY
        iLKuAju/gW/5MPS+zYspo9Anb6VcSbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674554582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XlyGLp9iAeImFLsnSAcMxEWopq1s7dMOnOrqAcJb5aI=;
        b=1g2PDkp0PuOb8PuA74YKfnsTkM9oHi5HzEuRXHxv53mKfiTZNvEGV/U2nocVh5EYQDjvUN
        Oyka4gXQ2GVZS6Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8173139FB;
        Tue, 24 Jan 2023 10:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8JCTJ9Wsz2O3ZgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 24 Jan 2023 10:03:01 +0000
Message-ID: <45e64c7c-8a78-d15c-0cc5-9ba465acf691@suse.de>
Date:   Tue, 24 Jan 2023 11:02:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] pata_parport: add driver (PARIDE replacement)
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121225314.32459-1-linux@zary.sk>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230121225314.32459-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 23:53, Ondrej Zary wrote:
> The pata_parport is a libata-based replacement of the old PARIDE
> subsystem - driver for parallel port IDE devices.
> It uses the original paride low-level protocol drivers but does not
> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
> behind parallel port adapters are handled by the ATA layer.
> 
> This will allow paride and its high-level drivers to be removed.
> 
> Unfortunately, libata drivers cannot sleep so pata_parport claims
> parport before activating the ata host and keeps it claimed (and
> protocol connected) until the ata host is removed. This means that
> no devices can be chained (neither other pata_parport devices nor
> a printer).
> 
> paride and pata_parport are mutually exclusive because the compiled
> protocol drivers are incompatible.
> 
> Tested with:
>   - Imation SuperDisk LS-120 and HP C4381A (EPAT)
>   - Freecom Parallel CD (FRPW)
>   - Toshiba Mobile CD-RW 2793008 w/Freecom Parallel Cable rev.903 (FRIQ)
>   - Backpack CD-RW 222011 and CD-RW 19350 (BPCK6)
> 
> The following bugs in low-level protocol drivers were found and will
> be fixed later:
> 
> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
> drivers - they don't handle non-multiple-of-4 block transfers
> correctly. This causes problems with LS-120 drive.
> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
> or 8-bit mode is used first (probably some initialization missing?).
> Once the device is initialized, EPP works until power cycle.
> 
> So after device power on, you have to:
> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
> (autoprobe will initialize correctly as it tries the slowest modes
> first but you'll get the broken EPP-32 mode)
> 
> Note: EPP modes are buggy in FRPW, only modes 0 and 1 work.
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---
> 
> Changes in v2:
>   - keep device connected, remove disconnect timer
> 
>   Documentation/admin-guide/blockdev/paride.rst |  52 ++
>   drivers/Makefile                              |   2 +-
>   drivers/ata/Kconfig                           |  14 +
>   drivers/ata/Makefile                          |   2 +
>   drivers/ata/pata_parport.c                    | 783 ++++++++++++++++++
>   drivers/block/paride/Kconfig                  |  32 +-
>   drivers/block/paride/paride.h                 |  13 +
>   include/linux/pata_parport.h                  | 106 +++
>   8 files changed, 987 insertions(+), 17 deletions(-)
>   create mode 100644 drivers/ata/pata_parport.c
>   create mode 100644 include/linux/pata_parport.h
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

