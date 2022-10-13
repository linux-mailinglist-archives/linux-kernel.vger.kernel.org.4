Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF275FD3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 05:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJMDyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 23:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMDyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 23:54:47 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A714F140CC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665633285; x=1697169285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bGW7TFvymg2sARnBD1Vdb1YQ+YDQm45TRkn/b/R2j6I=;
  b=fkLOvBzeNNWzXUiFGVdM5qD/EWPBv5+lrsdrrCR2i8F8eugvkwoh/5+P
   3pgskCuurVNdsMQ+MHmdmcyiyryxqpKW9xjzPPfKTKSthSz9T/Gp3TNtS
   swlWlAJ1ftonYO5e9K/5HhjzFM5Hg6Vny/e52L5imYUmXKYMeikAB4AmV
   zK7CM4IaI+fJapcgLmW3fcM4QpOW3JoKxHs+Qdg4hXis66/zNqwYUmQ4n
   F/FDsydhnrpjbPN4CRrq+1U171Rz9xOgTokBiH/OcbtOdwc5DJTrSy/a3
   QMm1sUAMu8go5CgSQcj+7kdVW3ee7RywLPHU8qpUfhZN3y6jHPiV3U04U
   w==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661788800"; 
   d="scan'208";a="214061890"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2022 11:54:44 +0800
IronPort-SDR: /AxWeWjioJtLWYEg/JClRN5bcbK+TyQKsZmhFpjW4xNN+m0oKQsW2tFKoAsRpN1VgBQ7r4Y0vQ
 O3n9697JbFUU4LoxSOuFlda+rwYJiirsCA0wWU/H0zUvv0GTfEkic4GhiksTjPLfxs6/oxNmNV
 K4SFxpW4OjnDMz1EcLGOFRdOnNp2lyBFaXh85317c4h8DfiPS3KT3dLT0nmq6d3EeaIjnch+wO
 IqDyayJxp1ctU9RLjwlaLyB5Du22mz+nJSpBP2o/opm8kWZdH3l/YlNxhOTwyvR8K1srhrVC17
 rbs9hgCHHI58HKvxLkcxzs6+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 20:08:44 -0700
IronPort-SDR: LPrBp4ldaEXVzuTPhMamZRrjT9LkR3co1ce933kOrbnwvxac/lbln4JnGnYTyF+gpzcX/fS2cU
 Lk+rVA11VW7rWnqVS/aLwxsgQqLamY4YVlfH0L6IBFoS3Cu527Bk6bxC7Zt9DP2Q8BVqe3OChe
 jOjyH5vx4EZRi8fBHtggM1fiKHiLoQ6DE6KY3Dar+/URXrNIyJkSMYki7EvWx1TjcX9S8vnUQj
 QKvtzCECXHeEMeb+c+yLxFQUMfn8YJQLoMQreXnBbgFShUhaQVpwT/OmqOqZ0ZKk9Ck4So0xSP
 l+s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2022 20:54:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MnwdH64RRz1Rwrq
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:54:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665633283; x=1668225284; bh=bGW7TFvymg2sARnBD1Vdb1YQ+YDQm45TRkn
        /b/R2j6I=; b=JAwzwSjgv4pDEzuiFW9aw2f/J4tekZSFz0G5B+klHX0GKbXhxyh
        7M6kLafUSBxAnittZfANuWsgxVAjrd1EbH5kLQx1sA/eEJtb4CmomXc9izhQTgRc
        Cg/YA4T2c9k8gxgCWIF6jEuxt+0bHjbFn4YiJMElADB6cqK9igcOWqqd34pqob/V
        NDSWFmzOZf7Tqa0NaKDcKoUwyqxgw8hLAwqUCvXlNrEdt6eoSvEa5cHxd98Us2ho
        JsmBChTvZLd/IRWC/qsflKhUfOcwt57KpLsoauZ5Rxyv7tJlXpqowjW7mVC2WNZo
        efDxh4AZ8gRqxiURcrenDp8urmvmN29q56g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id orq1dlbZoOI4 for <linux-kernel@vger.kernel.org>;
        Wed, 12 Oct 2022 20:54:43 -0700 (PDT)
Received: from [10.89.85.169] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.169])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MnwdG2q13z1RvLy;
        Wed, 12 Oct 2022 20:54:42 -0700 (PDT)
Message-ID: <0e67aa4d-f66e-f392-5950-31b1c90c287b@opensource.wdc.com>
Date:   Thu, 13 Oct 2022 12:54:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 4.19] scsi: sd: Fix 'sdkp' in sd_first_printk
Content-Language: en-US
To:     Li kunyu <kunyu@nfschina.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221013023438.3263-1-kunyu@nfschina.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221013023438.3263-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/13 11:34, Li kunyu wrote:
> In the sd_first_printk macro, replace the sdkp parameter with the
> defined sdsk parameter to resolve the compilation error.

Which compilation errors ? None that I can see.
Do you mean "to avoid potential compilation errors" ?

> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  drivers/scsi/sd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
> index a7d4f50b67d4..e5bdf0a10071 100644
> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -133,7 +133,7 @@ static inline struct scsi_disk *scsi_disk(struct gendisk *disk)
>  
>  #define sd_first_printk(prefix, sdsk, fmt, a...)			\
>  	do {								\
> -		if ((sdkp)->first_scan)					\
> +		if ((sdsk)->first_scan)					\

Instead of changing this one, I would prefer changing sdsk to sdkp in the macro
parameter list. "sdkp" is used everywhere in sd.c. "sdsk" is not used anywhere
so it would be unclear.

>  			sd_printk(prefix, sdsk, fmt, ##a);		\
>  	} while (0)
>  

-- 
Damien Le Moal
Western Digital Research

