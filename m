Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA86A3B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjB0HCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:02:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F471A495;
        Sun, 26 Feb 2023 23:02:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 517DD1F8D4;
        Mon, 27 Feb 2023 07:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677481357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G52KKZ0xD6rFHPvOmRSlgYtu0nGZqp70glW530+JIYs=;
        b=x9iCJosQDW1M6fY5ujwEGUZj9vgW3w765q0lexuHWY+2c9LXUZMj1PAkSQDNbiooE9hTc8
        712ame1Pz253jwtCiz6uSk6Fxisw4as/7jbfPvDdERb1TYHeRENX3ywN7NBSk+TvYdjTes
        RbJbLAjOZjyYOpAznUVlEj0EaERetTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677481357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G52KKZ0xD6rFHPvOmRSlgYtu0nGZqp70glW530+JIYs=;
        b=4BTCqqR23qVEPmvjs7aWOYUerJBxRTfvbR3j/7eYI07qZqDnSYmW4Vks2UdGba8OYg+d0S
        U/tYUvTw1F/ivpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 194AD13912;
        Mon, 27 Feb 2023 07:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5h1nBY1V/GP8DgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 27 Feb 2023 07:02:37 +0000
Message-ID: <0933dabe-2f3d-981d-72ff-43e1f2a2eb69@suse.de>
Date:   Mon, 27 Feb 2023 08:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
Content-Language: en-US
To:     Lee Duncan <leeman.duncan@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220928181350.9948-1-leeman.duncan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 20:13, Lee Duncan wrote:
> From: Lee Duncan <lduncan@suse.com>
> 
> Some storage, such as AIX VDASD (virtual storage) and IBM 2076
> (front end) do not like the recent commit:
> 
> commit c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
> 
> That commit changed getting SCSI VPD pages so that we now read
> just enough of the page to get the actual page size, then read
> the whole page in a second read. The problem is that the above
> mentioned hardware returns zero for the page size, because of
> a firmware error. In such cases, until the firmware is fixed,
> this new black flag says to revert to the original method of
> reading the VPD pages, i.e. try to read as a whole buffer's
> worth on the first try.
> 
> Fixes: c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
> Reported-by: Martin Wilck <mwilck@suse.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Lee Duncan <lduncan@suse.com>
> ---
>   drivers/scsi/scsi.c         | 14 +++++++++++---
>   drivers/scsi/scsi_devinfo.c |  3 ++-
>   drivers/scsi/scsi_scan.c    |  3 +++
>   include/scsi/scsi_device.h  |  2 ++
>   include/scsi/scsi_devinfo.h |  6 +++---
>   5 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index c59eac7a32f2..f2db4b846190 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -321,11 +321,19 @@ static int scsi_vpd_inquiry(struct scsi_device *sdev, unsigned char *buffer,
>   	return get_unaligned_be16(&buffer[2]) + 4;
>   }
>   
> -static int scsi_get_vpd_size(struct scsi_device *sdev, u8 page)
> +static int scsi_get_vpd_size(struct scsi_device *sdev, u8 page, int buf_len)
>   {
>   	unsigned char vpd_header[SCSI_VPD_HEADER_SIZE] __aligned(4);
>   	int result;
>   
> +	/*
> +	 * if this hardware is blacklisted then don't bother asking
> +	 * the page size, since it will repy with zero -- just assume it
> +	 * is the buffer size
> +	 */
> +	if (sdev->no_ask_vpd_sz_first)
> +		return buf_len;
> +
>   	/*
>   	 * Fetch the VPD page header to find out how big the page
>   	 * is. This is done to prevent problems on legacy devices
> @@ -367,7 +375,7 @@ int scsi_get_vpd_page(struct scsi_device *sdev, u8 page, unsigned char *buf,
>   	if (!scsi_device_supports_vpd(sdev))
>   		return -EINVAL;
>   
> -	vpd_len = scsi_get_vpd_size(sdev, page);
> +	vpd_len = scsi_get_vpd_size(sdev, page, buf_len);
>   	if (vpd_len <= 0)
>   		return -EINVAL;
>   
> @@ -402,7 +410,7 @@ static struct scsi_vpd *scsi_get_vpd_buf(struct scsi_device *sdev, u8 page)
>   	struct scsi_vpd *vpd_buf;
>   	int vpd_len, result;
>   
> -	vpd_len = scsi_get_vpd_size(sdev, page);
> +	vpd_len = scsi_get_vpd_size(sdev, page, SCSI_VPD_PG_LEN);
>   	if (vpd_len <= 0)
>   		return NULL;
>   
> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> index c7080454aea9..d2b2e841e570 100644
> --- a/drivers/scsi/scsi_devinfo.c
> +++ b/drivers/scsi/scsi_devinfo.c
> @@ -134,7 +134,7 @@ static struct {
>   	{"3PARdata", "VV", NULL, BLIST_REPORTLUN2},
>   	{"ADAPTEC", "AACRAID", NULL, BLIST_FORCELUN},
>   	{"ADAPTEC", "Adaptec 5400S", NULL, BLIST_FORCELUN},
> -	{"AIX", "VDASD", NULL, BLIST_TRY_VPD_PAGES},
> +	{"AIX", "VDASD", NULL, BLIST_TRY_VPD_PAGES | BLIST_NO_ASK_VPD_SIZE},
>   	{"AFT PRO", "-IX CF", "0.0>", BLIST_FORCELUN},
>   	{"BELKIN", "USB 2 HS-CF", "1.95",  BLIST_FORCELUN | BLIST_INQUIRY_36},
>   	{"BROWNIE", "1200U3P", NULL, BLIST_NOREPORTLUN},
> @@ -188,6 +188,7 @@ static struct {
>   	{"HPE", "OPEN-", "*", BLIST_REPORTLUN2 | BLIST_TRY_VPD_PAGES},
>   	{"IBM", "AuSaV1S2", NULL, BLIST_FORCELUN},
>   	{"IBM", "ProFibre 4000R", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
> +	{"IBM", "2076", NULL, BLIST_NO_ASK_VPD_SIZE},
>   	{"IBM", "2105", NULL, BLIST_RETRY_HWERROR},
>   	{"iomega", "jaz 1GB", "J.86", BLIST_NOTQ | BLIST_NOLUN},
>   	{"IOMEGA", "ZIP", NULL, BLIST_NOTQ | BLIST_NOLUN},
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 5d27f5196de6..b67743e32089 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1056,6 +1056,9 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
>   	else if (*bflags & BLIST_SKIP_VPD_PAGES)
>   		sdev->skip_vpd_pages = 1;
>   
> +	if (*bflags & BLIST_NO_ASK_VPD_SIZE)
> +		sdev->no_ask_vpd_sz_first = 1;
> +
>   	transport_configure_device(&sdev->sdev_gendev);
>   
>   	if (sdev->host->hostt->slave_configure) {
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index 2493bd65351a..5d15784ccefc 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -145,6 +145,7 @@ struct scsi_device {
>   	const char * model;		/* ... after scan; point to static string */
>   	const char * rev;		/* ... "nullnullnullnull" before scan */
>   
> +#define SCSI_VPD_PG_LEN	255	/* default SCSI VPD page size (max) */
>   	struct scsi_vpd __rcu *vpd_pg0;
>   	struct scsi_vpd __rcu *vpd_pg83;
>   	struct scsi_vpd __rcu *vpd_pg80;
> @@ -214,6 +215,7 @@ struct scsi_device {
>   					 * creation time */
>   	unsigned ignore_media_change:1; /* Ignore MEDIA CHANGE on resume */
>   	unsigned silence_suspend:1;	/* Do not print runtime PM related messages */
> +	unsigned no_ask_vpd_sz_first:1;	/* Do not ask for VPD size first */
>   
>   	unsigned int queue_stopped;	/* request queue is quiesced */
>   	bool offline_already;		/* Device offline message logged */
> diff --git a/include/scsi/scsi_devinfo.h b/include/scsi/scsi_devinfo.h
> index 5d14adae21c7..ec12dbaff0e8 100644
> --- a/include/scsi/scsi_devinfo.h
> +++ b/include/scsi/scsi_devinfo.h
> @@ -32,7 +32,8 @@
>   #define BLIST_IGN_MEDIA_CHANGE	((__force blist_flags_t)(1ULL << 11))
>   /* do not do automatic start on add */
>   #define BLIST_NOSTARTONADD	((__force blist_flags_t)(1ULL << 12))
> -#define __BLIST_UNUSED_13	((__force blist_flags_t)(1ULL << 13))
> +/* do not ask for VPD page size first on some broken targets */
> +#define BLIST_NO_ASK_VPD_SIZE	((__force blist_flags_t)(1ULL << 13))
>   #define __BLIST_UNUSED_14	((__force blist_flags_t)(1ULL << 14))
>   #define __BLIST_UNUSED_15	((__force blist_flags_t)(1ULL << 15))
>   #define __BLIST_UNUSED_16	((__force blist_flags_t)(1ULL << 16))
> @@ -74,8 +75,7 @@
>   #define __BLIST_HIGH_UNUSED (~(__BLIST_LAST_USED | \
>   			       (__force blist_flags_t) \
>   			       ((__force __u64)__BLIST_LAST_USED - 1ULL)))
> -#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_13 | \
> -			     __BLIST_UNUSED_14 | \
> +#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_14 | \
>   			     __BLIST_UNUSED_15 | \
>   			     __BLIST_UNUSED_16 | \
>   			     __BLIST_UNUSED_24 | \

To prod people a bit:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

