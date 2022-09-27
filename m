Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D16F5ED09F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiI0W5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiI0W5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:57:47 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615C2EF090
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664319465; x=1695855465;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+XgzzH+/89MenioakUEmHr4D5h4BOnJMF4ck9V+QoSc=;
  b=Cy2k6nAOcjFEL3If60yOF7QkBtwLi3Ia4EoIXprZbxxMFMpWHUqFybIf
   Qya6HWJQhyKxwSobqYyhmffwKUsUQY+Ujv5Yd7Z3zBzgyZ9X7atVQ0qY0
   CDBJs7JvrGbmYmH73YJmvv15w64A1zw1JVaVtlsOPsaKslLiY/ztyYSN7
   AJvpZx0BUBc2CmTvFEC7HWR+5FVBYRJpuX7ZLSSPNdfOHBPMG1OGjjvhU
   OnfWVg2oorpT7zjNXVdXeRAIZUUb6UNJ5tC3kizVXp8qafC92qZRGxEVV
   oaw9XhAg0gzWJLfDIbSaA/56JAH2UReMrqB4eGVR/vrHUyjbcghBpuKbJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,350,1654531200"; 
   d="scan'208";a="324523625"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 06:57:44 +0800
IronPort-SDR: yFCtsEHPLVXin1GLntsBiLB9h6rwe53GJUtQVhJux7fzvpBp/5SZ6ez+L9Mb4t+7SNuOQ5xdA6
 IxU67Bl/b64M+0c8IT0aGCiajyLhtlrT4oW7R3orBLmkRAug4kKklOQxCjabWX8utD2H9YD+6L
 jRcffqrsXFDnptj0EUK/D12i2lHeWngTOpkN3YRUsYcracIoFSPBv6Jcl/05MZlcKu9IpcDeLI
 P2EngBjAmz1KmKDLL1M9v/fQ/BmC6MCY+ybrLG1+jJpvBIfyKdtF4PfSZrZfxIcJ/B+spS1VPk
 bq/NS6s9hwONZtKr2p9i/0SV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 15:12:08 -0700
IronPort-SDR: PS6QL5ALLn9Z7ejthJGyEm3bvHz9BQHvNYPp+1LaR35TiVKhE4mbX0WF3VAOgGguiS5hkKLbsd
 h0zXXxOZroVHjDv4XpUiX9W9D74MtfRyocq0TuTYvIPUnFj4WQLS8Hh9spmw+gsKS8j3VurfdJ
 21OlnjxRBtY4shYs8gX2S/MlYjA6z4eht3UL/n7s2B1JvLmTZxI+kjKu0vtwFzBcTAtTu1Flsc
 arQXX4pisXmQtit1kcCMGALM9Tp10jFSkHBss8hG5606wZpeoYpsOaYFhi7H9D07toc8T/59SC
 LDc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 15:57:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4McZlW3gTTz1Rwtm
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 15:57:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664319462; x=1666911463; bh=+XgzzH+/89MenioakUEmHr4D5h4BOnJMF4c
        k9V+QoSc=; b=lLiJVZLMsF6t0bTUYQV0Fqsh8PLOzaul0tJXNnD2z5W1QRiQZz3
        srsHrqDGJt2zb3VE2nn6IvR/eFBLrXgPbiXgOXo7v8mV7ymkkt/RPJmUsezKBm1Y
        J0rk4sNzmS2bxk22MljzR20A26wwBju1aCr8U7XrdPDX1fOiCEE3gXv6BpurJ9O1
        X+JoyYpsfyj3tIhO625fiQXuhm6S4+omm7dIk3ywANRqkz23qSKP9z13XVDBtdOq
        gqlb5v+AnhA1PmLMMU1VbgW/c6Hkct75YUpb1lvdaP+/rfvC2EkMTNWh4s8G/1c5
        HjYXTZEYonsG93MLypSumQTg3F13fV72a6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tfRnFLC7a-PL for <linux-kernel@vger.kernel.org>;
        Tue, 27 Sep 2022 15:57:42 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4McZlS5Yfvz1RvLy;
        Tue, 27 Sep 2022 15:57:40 -0700 (PDT)
Message-ID: <caa8552b-3bb4-5824-aa99-82386d367479@opensource.wdc.com>
Date:   Wed, 28 Sep 2022 07:57:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 3/8] scsi: pm8001: use sas_find_attached_phy_id()
 instead of open coded
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220927123926.953297-1-yanaijie@huawei.com>
 <20220927123926.953297-4-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220927123926.953297-4-yanaijie@huawei.com>
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

On 9/27/22 21:39, Jason Yan wrote:
> The attached phy id finding is open coded. Now we can replace it with
> sas_find_attached_phy_id(). To keep consistent, the return value of
> pm8001_dev_found_notify() is also changed to -ENODEV after calling
> sas_find_attathed_phy_id() failed.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 8e3f2f9ddaac..042c0843de1a 100644
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
> +		phy_id = sas_find_attached_phy_id(&parent_dev->ex_dev, dev);
> +		if (phy_id == -ENODEV) {
>  			pm8001_dbg(pm8001_ha, FAIL,
>  				   "Error: no attached dev:%016llx at ex:%016llx.\n",
>  				   SAS_ADDR(dev->sas_addr),
>  				   SAS_ADDR(parent_dev->sas_addr));
> -			res = -1;
> +			res = phy_id;

Nit:

res = -ENODEV would be a lot clearer.
Or do:

		if (phy_id < 0) {
			...
			ret = phy_id;
		} ...

No ?

> +		} else {
> +			pm8001_device->attached_phy = phy_id;
>  		}
>  	} else {
>  		if (dev->dev_type == SAS_SATA_DEV) {

-- 
Damien Le Moal
Western Digital Research

