Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37A85EB796
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiI0CZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiI0CZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:25:37 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BC37D7AD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664245533; x=1695781533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lrg6l/pPX8i1bKBhQiAAkehXiG0KnY79HU2FjMsqfDU=;
  b=gVJZLk6l882cN2BFb6LRpckL7d2LNOgdkLUs9EkfXgw8KzwbBmrDlqsv
   x7rg2aSa0AWvR36b7tI9Ldu+fxDvYLAv1xZAwVRfzNz9LTpw6GEIIbAgQ
   MYiwZfQWxjCIMniABdj1GHVKKiOgjzUSTp7FPCrD9Svca2Y1dpm3IAXPK
   c9q0oMj1BOk5VjhBNrXlgVKSm/ifZpoIt4cSIclEb/t5UyamwKy52xvWi
   kl/fsYakVFKkcGbwkNJZbnmzr2DM+0N9jahJemta8ABK9bVnPRKDBjrZI
   YdycG4XTLoROHc1OAF9hFY7W4RtLXWsybhIWTW7OVKrNAPo8yk0YH2jx/
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="316620402"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 10:25:32 +0800
IronPort-SDR: c7eJhCMfRunC9Dcd1eL/WFvGeO1/RqE/drCHTUxiX1FP59pu4XGfV7HpeyAFKOhQtP14ct8NIQ
 1ZW3N4MGrw+GsL3TaLTfARkRi5119ML/bdTVcBYNWVQ1dYXKOTzH+r7NgdOtkqGMF0EuS79VsS
 rJHbydKk5JkOHwL5IUO9nLkhKxJ8x2BzeK5MCLGUVg3rfxtBWdBrkLc8vuvBYzcWilTIQNDkkn
 cE1ptBbDVLrzJUJpuMcDtGrsFQWlSi6ICT0pGT/OJ8FbYP+4F3OMIPgR90DwGxBCwhyqGsl+fs
 Uef/PzBqTJ9oOqGfMP8MJBq0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 18:45:29 -0700
IronPort-SDR: Qxl3lqLn5X4odPJPilezZH8ssVFUwBnIPGNEK9+r38zHcddYoiCcwSgNBZ46U1/FWMbhZWU6L3
 /CKhqZDJB90Svuj2uwXXbgcHdcNSaSAkpKv4CUSzAraxWFbeZzXK6g8uHw4ykN05kQlNTaRCX9
 mc/G7i3kGnNMg2bBgc4EYXjGblHG+cf65RGxps4StDp+bI9baJetDPyUmOhesAu4G8HwRxMDl3
 mN871OnrfOPOganeociRW3WlRKCYhov+PCkg0FJ/fKBRGDrejOVu4vYcDL3EUYYPnHvPsPN6uN
 NCc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 19:25:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mc3Pl5cYbz1Rwtm
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:25:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664245530; x=1666837531; bh=lrg6l/pPX8i1bKBhQiAAkehXiG0KnY79HU2
        FjMsqfDU=; b=RKs4q+443Eu9Of3uIPJt34BXoGmkUOeWAo+mugCS7LKnWeqMpbm
        p8Nv5ugi3SqwVgvAGL9WAWNPaCjtPP0TJ9hSyPxQIRNnTLE3t/K6HG6JrPTfqzA1
        4HUPWpOjD37QuONnukV/EswvaGo1UdKaNewaK1gJ46HTRR2yIxHkToQHFuy/1Gf+
        3J+UmBdHq5OcGqPmklhWKS2jiUyVOKtQt7IVYqDxihfcIRxWj0q04aEC5AsX2CAA
        NtQAY7Zk6fBNav71NAjSS92Fgz1LSGoj5COXKeEKIlFl4rbqsOiS5p3eIUvPSKQB
        IStpWfqQ/AS0Ex0FE3KxcCipeq3qv3eF2JA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OU53RJTj4mrQ for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 19:25:30 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mc3Pj3Jpzz1RvLy;
        Mon, 26 Sep 2022 19:25:29 -0700 (PDT)
Message-ID: <4b38ff03-26b0-1781-b844-328159373f1e@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 11:25:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 3/8] scsi: pm8001: use sas_find_attached_phy() instead
 of open coded
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220927022941.4029476-1-yanaijie@huawei.com>
 <20220927022941.4029476-4-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220927022941.4029476-4-yanaijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 11:29, Jason Yan wrote:
> The attached phy finding is open coded. Now we can replace it with
> sas_find_attached_phy().
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/pm8001/pm8001_sas.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 8e3f2f9ddaac..d15a824bcea6 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -645,22 +645,16 @@ static int pm8001_dev_found_notify(struct domain_device *dev)
>  	pm8001_device->dcompletion = &completion;
>  	if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
>  		int phy_id;
> -		struct ex_phy *phy;
> -		for (phy_id = 0; phy_id < parent_dev->ex_dev.num_phys;
> -		phy_id++) {
> -			phy = &parent_dev->ex_dev.ex_phy[phy_id];
> -			if (SAS_ADDR(phy->attached_sas_addr)
> -				== SAS_ADDR(dev->sas_addr)) {
> -				pm8001_device->attached_phy = phy_id;
> -				break;
> -			}
> -		}
> -		if (phy_id == parent_dev->ex_dev.num_phys) {
> +
> +		phy_id = sas_find_attached_phy(&parent_dev->ex_dev, dev);
> +		if (phy_id == -ENODEV) {
>  			pm8001_dbg(pm8001_ha, FAIL,
>  				   "Error: no attached dev:%016llx at ex:%016llx.\n",
>  				   SAS_ADDR(dev->sas_addr),
>  				   SAS_ADDR(parent_dev->sas_addr));
>  			res = -1;
> +		} else {
> +			pm8001_device->attached_phy = phy_id;
>  		}
>  	} else {
>  		if (dev->dev_type == SAS_SATA_DEV) {

-- 
Damien Le Moal
Western Digital Research

