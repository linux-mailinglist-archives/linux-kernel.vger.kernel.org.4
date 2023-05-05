Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317646F7E91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjEEISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjEEISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:18:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D51516355;
        Fri,  5 May 2023 01:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AD70611F6;
        Fri,  5 May 2023 08:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D458C433EF;
        Fri,  5 May 2023 08:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683274687;
        bh=ga/+VFX8FBvQCw6s9dDB5iVKT6sGqKd3VaUCEq5zzo8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QlNmEwdYBIPYAbbdbj8TA5rTvitUreojs68cmQSYvFeKpYqdyPEyWD5xuwHWiuxLe
         sgvOsE+nuGTwUnlh3RFqSmbgVbYj4yIhs2ju4MIP4/xNIGlH6GC/TN3uA+4BDbUnbK
         62O9GrJvZ2XFozoUyBB/9VCXlYMq1s25L2TSuGVcLeAi4np2Zn9sX7l01itCnsYzER
         LjpqrfJMxMZY0G5ccph8mklLkdSifw95Ol8JuZDAdSCklr/ppImdCtqIoQntSMmxW3
         VQ92uBoT0jxFeHux3aM0BrtgkloIzxdXyncv/M+lV+2Y7ZSJTXJOMq7TVTU2YvkxFZ
         vu9rw5Sh+jg2Q==
Message-ID: <291f1d97-9195-45ac-8e12-058f5c797277@kernel.org>
Date:   Fri, 5 May 2023 17:17:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ata: libata-scsi: Fix get identity data failed
Content-Language: en-US
To:     Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, john.g.garry@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20230505025712.19438-1-yangxingui@huawei.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230505025712.19438-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/05/05 11:57, Xingui Yang wrote:
> The function ata_get_identity() uses the helper ata_scsi_find_dev() to get
> the ata_device structure of a scsi device. However, when the ata device is
> managed by libsas, ata_scsi_find_dev() returns NULL, turning
> ata_get_identity() into a nop and always returns -ENOMSG.

What do you do to hit the issue ? A while back for me it was the queue depth
setting causing problems. As Garry mentioned, this led to patch 141f3d6256e5
("ata: libata-sata: Fix device queue depth control").

> 
> Fix this by checking whether ATA_FLAG_SAS_HOST is set for ap->flags in
> ata_scsi_find_dev(), as the flag is only used in libsas. If
> ATA_FLAG_SAS_HOST is set, use sas_to_ata_dev() to find associated ATA
> device.
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
> Changes to v1 
> - Let ata_scsi_find_dev() return the correct value and don't keep replacing
> calls to ata_scsi_find_dev().
> 
>  drivers/ata/libata-scsi.c | 12 ++++++++++--
>  drivers/ata/libata.h      |  2 +-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7bb12deab70c..aa580ea341fa 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -26,6 +26,7 @@
>  #include <scsi/scsi_device.h>
>  #include <scsi/scsi_tcq.h>
>  #include <scsi/scsi_transport.h>
> +#include <scsi/libsas.h>
>  #include <linux/libata.h>
>  #include <linux/hdreg.h>
>  #include <linux/uaccess.h>
> @@ -2745,10 +2746,17 @@ static struct ata_device *__ata_scsi_find_dev(struct ata_port *ap,
>   *	Associated ATA device, or %NULL if not found.
>   */
>  struct ata_device *
> -ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev)

Why drop the const ?

> +ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev)
>  {
> -	struct ata_device *dev = __ata_scsi_find_dev(ap, scsidev);
> +	struct ata_device *dev;
> +
> +	if (ap->flags & ATA_FLAG_SAS_HOST) {
> +		struct domain_device *ddev = sdev_to_domain_dev(scsidev);
> +
> +		return sas_to_ata_dev(ddev);

Do you really need the ddev variable ? Also, this really should be a libsas
helper. I beleive this pattern is repeated in several places in libsas, so that
would nicely clean things up.

> +	}
>  
> +	dev = __ata_scsi_find_dev(ap, scsidev);
>  	if (unlikely(!dev || !ata_dev_enabled(dev)))
>  		return NULL;
>  
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 926d0d33cd29..6d66f46da064 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -109,7 +109,7 @@ static inline void ata_acpi_bind_dev(struct ata_device *dev) {}
>  
>  /* libata-scsi.c */
>  extern struct ata_device *ata_scsi_find_dev(struct ata_port *ap,
> -					    const struct scsi_device *scsidev);
> +					    struct scsi_device *scsidev);
>  extern int ata_scsi_add_hosts(struct ata_host *host,
>  			      const struct scsi_host_template *sht);
>  extern void ata_scsi_scan_host(struct ata_port *ap, int sync);

-- 
Damien Le Moal
Western Digital Research

