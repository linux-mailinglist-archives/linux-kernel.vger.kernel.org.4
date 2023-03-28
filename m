Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F786CCE25
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjC1XjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC1XjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:39:08 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CE81FDB;
        Tue, 28 Mar 2023 16:39:07 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 9E766764DB;
        Tue, 28 Mar 2023 23:39:06 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 8CACF60BE9;
        Tue, 28 Mar 2023 23:39:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id B8jxcH6ZGlUY; Tue, 28 Mar 2023 23:39:06 +0000 (UTC)
Received: from [192.168.48.17] (host-184-164-23-94.dyn.295.ca [184.164.23.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id ED92960BE8;
        Tue, 28 Mar 2023 23:39:05 +0000 (UTC)
Message-ID: <2651d29d-3aa8-065c-4c94-102bd20932b4@interlog.com>
Date:   Tue, 28 Mar 2023 19:39:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v3 02/11] scsi: scsi_debug: Don't iter all shosts in
 clear_luns_changed_on_target()
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org
References: <20230327074310.1862889-1-john.g.garry@oracle.com>
 <20230327074310.1862889-3-john.g.garry@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230327074310.1862889-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 03:43, John Garry wrote:
> In clear_luns_changed_on_target(), we iter all devices for all shosts to
> conditionally clear the SDEBUG_UA_LUNS_CHANGED flag in the per-device
> uas_bm.
> 
> One condition to see whether we clear the flag is to test whether the host
> for the device under consideration is the same as the matching device's
> (devip) host. This check will only ever pass for devices for the same
> shost, so only iter the devices for the matching device shost.
> 
> We can now drop the spinlock'ing of the sdebug_host_list_lock in the same
> function. This will allow us to use a mutex instead of the spinlock for
> the global shost lock, as clear_luns_changed_on_target() could be called
> in non-blocking context, in scsi_debug_queuecommand() -> make_ua() ->
> clear_luns_changed_on_target() (which is why required a spinlock).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com

Thanks.

> ---
>   drivers/scsi/scsi_debug.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 782515abca2c..eba6eca81e84 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -1063,18 +1063,15 @@ static void all_config_cdb_len(void)
>   
>   static void clear_luns_changed_on_target(struct sdebug_dev_info *devip)
>   {
> -	struct sdebug_host_info *sdhp;
> +	struct sdebug_host_info *sdhp = devip->sdbg_host;
>   	struct sdebug_dev_info *dp;
>   
> -	spin_lock(&sdebug_host_list_lock);
> -	list_for_each_entry(sdhp, &sdebug_host_list, host_list) {
> -		list_for_each_entry(dp, &sdhp->dev_info_list, dev_list) {
> -			if ((devip->sdbg_host == dp->sdbg_host) &&
> -			    (devip->target == dp->target))
> -				clear_bit(SDEBUG_UA_LUNS_CHANGED, dp->uas_bm);
> +	list_for_each_entry(dp, &sdhp->dev_info_list, dev_list) {
> +		if ((devip->sdbg_host == dp->sdbg_host) &&
> +		    (devip->target == dp->target)) {
> +			clear_bit(SDEBUG_UA_LUNS_CHANGED, dp->uas_bm);
>   		}
>   	}
> -	spin_unlock(&sdebug_host_list_lock);
>   }
>   
>   static int make_ua(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)

