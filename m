Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1245BEF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiITV6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiITV6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:58:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D92261135
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663711089; x=1695247089;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SryP8UGVCrAC/T9URA+bIDzzhnLRUWQZ3Z/jXtawmk0=;
  b=ZxMCXaRb5HTwOeLRobMDU7euubiNoETD1aO6vnFVGXDDJdMkpwsVys0x
   2VFTLAoZVBMRcj7t18HiPvlkeZFFYWwAY298WFkECk18ZA4Iows2nuTba
   +lLtEV5MKsSm4weIQeu0VctaHBvwKk53e55Da9pqQMetEoBv8gj+YlEzr
   fL1+sosGvakoE6nkMO9uJATudVwpQ6G1+UOUPdaPWTtVjZbsnMoNBvbKJ
   SWvjLCnbFG1DjjCVrqTcFPH0Iv3hq2KMB7FmMjqcrM4SR/yUhay4SK5AD
   iWyfrqq3BsA+3mmiV6R4Gn3GJUOJYuLHSLBpw7RqKxxEeWPwiplNy/aIg
   g==;
X-IronPort-AV: E=Sophos;i="5.93,331,1654531200"; 
   d="scan'208";a="211848109"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 05:58:08 +0800
IronPort-SDR: A4jH1sWMnppUYj7nuGDsxg5svgnya/kBXi0WtRVPSAKhjFwSUdLOyTiu5ThXuz41GCcWsXLZvU
 QdFGqmUjaGnW1DoKlSj0ooJF/Kb4Ei58QXZMx6hSWZjZTfj8UyUkVKZurWMN8M2UnlNzY6KgY8
 E05fem/2t6mRx1AmRhkCdJhFkwrmeV8tIqOjM1jEq5kQcs1bHegF5EAmnqFpS1xxnx/jzMp8Hs
 odOJil0QoFh4csdq0kXRJ07fztVXZXwQlEicDpt90bZt1EjK8aOHq9czmN67iRgKH/Xl+R8xan
 aXCzrnGnfATsQcwnigjVNUth
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 14:12:44 -0700
IronPort-SDR: W1r18g7zGpGw3y9Gd/4bTLfN7UDtvO3rZAvfscvc7vw8iVK1gL6mQ2HAnV6euAGba4f6VsCrVT
 drHrCSO4zgk0P0ffyTg8fbFYoFkUDEKZmKXsQfty/hCASRiWQRPTkkU4M0j00vU7UST9lNwVsg
 Ght51OOk45oe4Wdgisi6BquNl8Om+8gtu7MoFGwevDNMIb5WGhR4l4Wd0qAk/0Tg3u7xMEFTIu
 TiCX41O7bOG2Q1G76zPpT8VYI4+UQz12St+CsNKgdPFQSdGl1+DunID0d2pGRzQUIZ90kc+usa
 3rs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 14:58:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXFm05YzZz1Rwrq
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 14:58:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663711088; x=1666303089; bh=SryP8UGVCrAC/T9URA+bIDzzhnLRUWQZ3Z/
        jXtawmk0=; b=R/GsSyg49s/ykMZfJjnIw13a1Uhlbjy8CTjo5ah9My90jxHTWqK
        QLyy9Ah008twYj/EmwuFehxlcAtMpEu+9EvVvY8gaLlT7JB9YKXB+J2Zlw6Gl3C0
        R22hKx5+5p4OsU+bTlGwzjGCj9Gio3LiZtvuxhvKyjVyj+F1vHwFTcDTvBfen3zn
        n+mP0xyd4y4ANg5boS4sbrdnB2210QnXdy8YACZpIb6WE+8y6nxHhZ+mnBix8tdj
        J+ZD3LuqAC/khz79zQm3hA2KsvjK5vrmEb/gaKtB2qiQ6SxvhSfJD9hkSeXXa0T2
        qR/+lii9+8tn0fRb/N4ryB3omGvjozE0LmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9WCPQAHnrFZq for <linux-kernel@vger.kernel.org>;
        Tue, 20 Sep 2022 14:58:08 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXFlw6BmPz1RvLy;
        Tue, 20 Sep 2022 14:58:04 -0700 (PDT)
Message-ID: <c444fad0-7e7f-0940-84ce-a6fdaa99c493@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 06:58:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC 3/6] scsi: core: Add scsi_get_dev()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, hch@lst.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, brking@us.ibm.com
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
 <1663669630-21333-4-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1663669630-21333-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 19:27, John Garry wrote:
> Add a function which allows use to alloc a sdev with configurable
> device parent, and channel:id:lun.
> 
> This is useful for separating adding a scsi device into separate alloc
> and scan steps.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/scsi_scan.c | 25 +++++++++++++++++++++++++
>   include/scsi/scsi_host.h |  3 +++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index 3759b1a77504..fd15ddac01b6 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1988,3 +1988,28 @@ void scsi_forget_host(struct Scsi_Host *shost)
>   	spin_unlock_irqrestore(shost->host_lock, flags);
>   }
>   
> +struct scsi_device *scsi_get_dev(struct device *parent, int channel, uint id, u64 lun)
> +{
> +	struct Scsi_Host *shost = dev_to_shost(parent);
> +	struct scsi_device *sdev = NULL;
> +	struct scsi_target *starget;
> +
> +	mutex_lock(&shost->scan_mutex);
> +	if (!scsi_host_scan_allowed(shost))
> +		goto out;
> +
> +	starget = scsi_alloc_target(parent, 0, id);
> +	if (!starget)
> +		goto out;
> +
> +	sdev = scsi_alloc_sdev(starget, 0, NULL);
> +	if (sdev)
> +		sdev->borken = 0;
> +	else
> +		scsi_target_reap(starget);
> +	put_device(&starget->dev);
> + out:
> +	mutex_unlock(&shost->scan_mutex);
> +	return sdev;
> +}
> +EXPORT_SYMBOL(scsi_get_dev);
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index aa7b7496c93a..5142c7df7647 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -794,7 +794,10 @@ void scsi_host_busy_iter(struct Scsi_Host *,
>   
>   struct class_container;
>   
> +extern struct scsi_device *scsi_get_dev(struct device *parent, int channel, uint id, u64 lun);

You should not need extern here, and long line...

> +
>   /*
> +

white line change.

>    * DIF defines the exchange of protection information between
>    * initiator and SBC block device.
>    *

-- 
Damien Le Moal
Western Digital Research

