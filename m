Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B830F5EB7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiI0CcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiI0CcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:32:14 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FE3E4DA9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664245932; x=1695781932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uJlTkEEruO+4B+/IkDjfWJ48o9FBDv2KefDND1Ujq5g=;
  b=ZEqebWDCPNFMk/W4GCU/CIXS6ABQHmuqhxLbu4Sqe5yt1iZTN9gWmxNr
   +33LNjt/juIcy2vvSnIujsVyQM4DvQy6bS9XvIJQDLr6onFBULsle2zca
   cBN/KXQRJOv62yAASy3HN4S1nrvz7+GwlgKp14brm+/0D1y3hjeW7krp/
   0cOVHJQFJeY/NFWQG4PcJufGNqY0fsMRdeByJOxnby8+VTAuLWUuZ3Zdx
   rnAqS0pSt05o2tge9DybwFwFqI3doNXxdFZ+yZDXMSE3hLyVLX2TGuiY1
   kUL7va4xMaVK1Y2Ia4+WsJkifxpNqEQ8u2OcuD2U9gRTS2VS4ot1bz8TM
   g==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="210705105"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 10:32:08 +0800
IronPort-SDR: UtbRCdRjQT1C8httVhxNtQeMQ9Z584IlD8WUIhJN1HPYE6i4ZCEV3V0m+euIJ7+0j2D2B5+3li
 XGqDRxadG28DV8n/eKe9CkatK9dxCnz6WXAt/quS6+C6OanZYdiicNiJujCSChMVQztp+OsKoy
 HY/SzfVDAlPOuHQNejhpjt+zFnZT1WNFT3txMjRhNdrTth517DRUoMyvXE+rogqFzRD/ZUzi++
 ZTbjXCu7sv2VZrac8YjNr8yzSOMaS9qdQnjO8Vas3hGJIOOQ9hgHniTcW38xEnGa4Yb+4G0Beq
 wSSDhUpA3XTmJbawxDuT496m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 18:46:33 -0700
IronPort-SDR: PC2h09zRyANGEJE0B0GzAQHUGy48EKe0lVkECi6KdjGQnBzRWcrpj2dIrpCC8kjxxcLV4ejHzS
 6uDBhId6YRloepNZcUv/n/XlX/aCgFtxx05JudnaGtL4ragI8X4OD3M0JFD20iEjw/JhEi4VBs
 VMYfJs/Dy9X4iRAeq3dIRdG/IYMByVspbKHx6kMk8MYB423sg2Ekkw8WgQMKcYKIArWC1ZRDm3
 bo5VjTfErsoABWXJo+ttib/GNfJV1E1nOlnKPVwXgWQPArqm0qmzL12P/lOjtvgr5cr4TeLs5r
 5mk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 19:32:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mc3YM4fjHz1RwvT
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:32:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664245926; x=1666837927; bh=uJlTkEEruO+4B+/IkDjfWJ48o9FBDv2KefD
        ND1Ujq5g=; b=KVCh2SyQwM/mILMTWMFKyXTo4slhR6mNor1qTp/Zmwb9lIl1kJz
        HEsmkivvZ4h3nu9xJSOOIoV+vQ7+EYjL0JRhP47DY592d3HGTPym2ctGv7i4ja5c
        z5J/tRhJp4IAFGIrcGEPeIMKbG6nx6EtT4skz3IpD5tqRcmuiv5bRvISGYay9stZ
        t/pQDnC3DiDkgwOESqjxO3fTpqSlA56+7ROdoVpah0oSunQIng+hXf7PdROIuRjM
        U1S91gTUl+v7sWoFYy5S28quNWYWGjUsfhl8UfuF/Acy62aQjfCaU0cWgvjlUcHr
        Cpb5Wrrc9OjtzKvvvyCJV/1+waLjqYqUBxw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IyDpVQfW-Osh for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 19:32:06 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mc3YK35Vpz1RvLy;
        Mon, 26 Sep 2022 19:32:05 -0700 (PDT)
Message-ID: <654fe6d2-4556-8d15-bacc-b6ee1e927d91@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 11:32:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 8/8] scsi: libsas: use sas_phy_match_port_addr()
 instead of open coded
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com
References: <20220927022941.4029476-1-yanaijie@huawei.com>
 <20220927022941.4029476-9-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220927022941.4029476-9-yanaijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 11:29, Jason Yan wrote:
> The sas address comparation of asd_sas_port and expander phy is open
> coded. Now we can replace it with sas_phy_match_port_addr().

Comparison typo again.

> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

With that fixed,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/libsas/sas_expander.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index f268291b7584..eabc56966f36 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -1005,8 +1005,7 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
>  	}
>  
>  	/* Parent and domain coherency */
> -	if (!dev->parent && (SAS_ADDR(ex_phy->attached_sas_addr) ==
> -			     SAS_ADDR(dev->port->sas_addr))) {
> +	if (!dev->parent && sas_phy_match_port_addr(dev->port, ex_phy)) {
>  		sas_add_parent_port(dev, phy_id);
>  		return 0;
>  	}

-- 
Damien Le Moal
Western Digital Research

