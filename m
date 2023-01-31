Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E336821DF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAaCFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjAaCFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:05:41 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED3F19F37
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675130741; x=1706666741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AcsiuLuDwWfVsTzWwmYa8LChhoDmQwERu0vhn8YNug0=;
  b=ckfJkv/OI0DvVfpRmt5iLvNZEwpPXxVj69ceCdUXZ5dCOJlk/Gaf5wMg
   JilAid6beAVWi76jHGoj9NFL+wNE4WOG/DT2rZAdg+U9Yxd2C1TUPsb5o
   Mtd17C7YV/I/UewxtoQNwbisw0GofI+V74Gdf/F9E599ZROe7b3Xez/o8
   KH3ByduaAUgNzG3SrEd4/TZyK4qEu8INrPkuk8FzZoYGA6/e01e1z/gjZ
   9C9MPuR7M0T9ApsYVHQxQxEu9MvKKdqGPJBT9DB2eAVXRrAKWIdVrM6qE
   RWJFzIWxPZuDONeiatgRLGc/0e62fb9otPmYoFCcf16V85xWbVO0NYnR0
   w==;
X-IronPort-AV: E=Sophos;i="5.97,259,1669046400"; 
   d="scan'208";a="334094200"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 10:05:39 +0800
IronPort-SDR: lVMd67hLv6LCa4nujS5ApE9DPCYGuVnZjZPQZIGJ1kzY20KwB6+UxrSb9jDe6GxVZ/e6h4vuaB
 l0NV9KoHJ84sOgeBnzOzfgR21xb7zGhqdD7M9nGXt6BU6wh1nTkPjKsQVmCjikyMSQxqVPR9te
 JXyvvdeP2Xrjs1kBThT+FA6/bCAz3Rf0JMqdX/NX1c9PHn/CChpyo7dmOJSlHozxqodRoZjgJ5
 tAYEEqA7s6evG3NkIqO5WGIAbO2dt48Jny62psklWVjLZMZ3NAjcM+dsMfv9Xt3GQn33Bfvvx8
 tZY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 17:17:20 -0800
IronPort-SDR: HKSzjeJDE7pFtNzzFJY0VA+rVWquUEp6L4SN3IKB/vIoioEXw72oT0ZJMIfkhNN2SYyK38cqbi
 DGH9HE63nK6uCVD8OiAGl1PDni3+XoASAPthorWnHYXJDW1gusYyhD/Jg7a1ma7SPsrXtlSNmv
 7DGwJ5Sx0LfMvKTCTFpr3/SeM2fniDbc12Pb992EGf05GH6WnLtUM0S5m8bcCaLE6t/d9sW0pM
 RWrJjmymniLckLtwBjzqYqmNP0e+gtXPKrSkuHRDUhoSjCQp8QNXQQS4b+8Ei9PKlGEECaQEFd
 BZU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2023 18:05:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5T0g0HL0z1RwqL
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:05:39 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675130738; x=1677722739; bh=AcsiuLuDwWfVsTzWwmYa8LChhoDmQwERu0v
        hn8YNug0=; b=If7in8ACFpGd9feMG2WQjqjiESkIbI/SSsPJRd0A/fqdyxaPLLO
        EIxXz42KfGgFXxlNtGWxobMWwIx3Ni5oYuYwu7RN2HtB4O4ljNyxJNwXkB5+tV7k
        NEzMfXo2NsMs+OpIbM7l5jcczl1eRMXYCTqqgCwbN/7lbtUeKYf/3taHuZzV4Xqp
        /yPBdjIVEqp5Ho/eckNcS9LedHOrNigrM1Oh93W9pQyaFlwNP/N83Ss6tzsEgaeY
        +egN+bJGJSuAinpgS1jThyxyYxRs3/6c8tU9+qOytZie+44COimoUgdD3sdTccN8
        QvaKLMoxgwPZZE/5mPNdaNMsfPoC0t9U4fg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bkw1kSN_2tKF for <linux-kernel@vger.kernel.org>;
        Mon, 30 Jan 2023 18:05:38 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5T0d0H6Dz1RvLy;
        Mon, 30 Jan 2023 18:05:36 -0800 (PST)
Message-ID: <e6041145-7336-2534-8449-7b9b6a842466@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 11:05:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] drivers/block: Move PARIDE protocol modules to
 drivers/ata/pata_parport
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d4f7ebd5-d90d-fb96-0fad-bd129ac162dc@opensource.wdc.com>
 <20230130211050.16753-1-linux@zary.sk> <20230130211050.16753-2-linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230130211050.16753-2-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 06:10, Ondrej Zary wrote:
> diff --git a/drivers/Makefile b/drivers/Makefile
> index f1365608bc8c..de8aa561c95c 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -98,7 +98,7 @@ obj-$(CONFIG_DIO)		+= dio/
>  obj-$(CONFIG_SBUS)		+= sbus/
>  obj-$(CONFIG_ZORRO)		+= zorro/
>  obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
> -obj-y		 		+= block/paride/
> +obj-$(CONFIG_PATA_PARPORT)	+= ata/pata_parport/

It would be better to have this in drivers/ata/Makefile, not here, so that doing
something like:

make -j64 M=drivers/ata W=1
or
make -j64 M=drivers/ata C=1

actually also checks the parport protocol modules too.

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 23588738cff0..2f85812e16ef 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_PATA_SAMSUNG_CF)       += pata_samsung_cf.o

 obj-$(CONFIG_PATA_PXA)         += pata_pxa.o

+obj-$(CONFIG_PATA_PARPORT)     += pata_parport/
 obj-$(CONFIG_PATA_PARPORT)     += pata_parport.o

And then we could also have drivers/ata/pata_parport.c moved under
drivers/ata/pata_parport/ to tidy things up.

If you agree, I can fix that up, that is easy to do.

-- 
Damien Le Moal
Western Digital Research

