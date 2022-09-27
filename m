Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527215EB7AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiI0CaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiI0CaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:30:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E011B61D48
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664245809; x=1695781809;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=96lxJGCdpwYCl6P8l6RqZfZAsJgBQCmCcyStRhiqL/4=;
  b=e7ZVi3WxvJI9H2jTUuq5vHciVJLHZ4hN5M1UX5ctgQOZ41Tp+Lv6xH+H
   IYU4JV8R5dRLdZX9RsBhG9RI4oqHQ/p3Et1eCfnp2hE5aGWCSCODXfDe0
   e33H05OdU7QMP5Y9BAS9eb211mh63kbjQIWNZXcTarcKpXVmtCRmcYyxg
   1sJ/OdRc6MRBIVgZlMuKj+RSAbC/30wbrMRO1WzGgLU9K6WqR6eqa3JZz
   8Wa0kG2ZBKnR6ljT/M4d2O9WlhSrK/efFajOodxB2rzd7XYc/Da+mSmz4
   Mte/dpeKpv+09oneXZjgB0tfAQfSuKNFAdxgXk1tbqD3YyTkuNYs59ld3
   g==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="212759637"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 10:30:07 +0800
IronPort-SDR: GyL2/hGBSJQ/xMXjeZeQagNRyx4NF9yLuvIbuxsPGwo+9YkyurBiqPaW5l5ouh4DYO1GOO2yXq
 s5eIVHNbftPLEdzY4zpPLC7EWYgIMppzEW6s4LZJdFjodyG7CZmPOQuGDQ6jN0zIrV7jUtv67W
 AT5vnmTl1olrQkvEJA4qyUmdr/kaCWRUFEIeps+A5i/YAqFJue1HXr+UMMFo88ztYj3vrHai6+
 XXqKu//eiDWjtRyQf2I8cM+qSBG5n0mywlHJ1+rQoIutMOG92bN/UgJJLzmT3kTbslNvLUUTr8
 IFnXkL+SE/v60OE4In/D0Wh8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 18:50:05 -0700
IronPort-SDR: i4ff2tskMTtRrv5u5ZBQMssIQxcnaZDkm2ySddxiNZmH7LjJQH8Nz4jcI05kOmBmAA2JjBhrjE
 Np61lIXr5Q/yS5Xy4MY1u6le/HM9TcZb95D21avvFl8VGpsN4JWFGFARNvxw1Qj1q+Fu4LmIa6
 LEU4WU8kSeFhkOIgcQdFObIHFWaMl0zLLY1atsD7gXrJDZUsPRTyvnwSmJ2SAe/ngoKeXrSgT6
 jhkHoI6HC34niZOUpKDi6YueSec6StAugG+kC9nkHcVs8btcHTfIBtE49CXwyFjhucZcfw0q64
 D/Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 19:30:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mc3W32fhZz1Rwrq
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:30:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664245806; x=1666837807; bh=96lxJGCdpwYCl6P8l6RqZfZAsJgBQCmCcyS
        tRhiqL/4=; b=NuCGJ4OY4or3+cIZ0sh+htrMgD202kS1LCx6u3HQOmmHT10HsIA
        0NtQQAyKDbV3miL5V1sCDiY2eyEwR0Ne9ipNSOrgIfVzZUmmuKQuq+siA4WjpnCy
        sIC4ZpgNmwp60Z6EG4p3oY+jUlUSaQWPeoVI6FOyGsc53NQL5ZUtB6cB9q5OM2p1
        DV5NQlIwv1G6Vk6f/CD3aC4nnHEpptpEEv8WppVRzTq3JKPNKNVdO32qRfRo6mpo
        Yhs1A12oZUrazpj4iAs/Gul47l45os5IOgKvcKHurLwW1jsul1uXAHN9arET3EQt
        5/Q4RD/ezxQPnD5+7OXXlkHziThMeCTTkcA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N8ivmlQDuOpA for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 19:30:06 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mc3W072ppz1RvLy;
        Mon, 26 Sep 2022 19:30:04 -0700 (PDT)
Message-ID: <585db20d-8530-d605-ebf2-e8d669e693a8@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 11:30:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 6/8] scsi: libsas: use sas_phy_match_dev_addr() instead
 of open coded
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com
References: <20220927022941.4029476-1-yanaijie@huawei.com>
 <20220927022941.4029476-7-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220927022941.4029476-7-yanaijie@huawei.com>
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
> The sas address comparation of domain device and expander phy is open
> coded. Now we can replace it with sas_phy_match_dev_addr().
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/scsi/libsas/sas_expander.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index df5a64ad902f..b2b5103c3e76 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -738,9 +738,7 @@ static void sas_ex_get_linkrate(struct domain_device *parent,
>  		    phy->phy_state == PHY_NOT_PRESENT)
>  			continue;
>  
> -		if (SAS_ADDR(phy->attached_sas_addr) ==
> -		    SAS_ADDR(child->sas_addr)) {
> -
> +		if (sas_phy_match_dev_addr(child, phy)) {
>  			child->min_linkrate = min(parent->min_linkrate,
>  						  phy->linkrate);
>  			child->max_linkrate = max(parent->max_linkrate,
> @@ -1012,8 +1010,7 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
>  		sas_add_parent_port(dev, phy_id);
>  		return 0;
>  	}
> -	if (dev->parent && (SAS_ADDR(ex_phy->attached_sas_addr) ==
> -			    SAS_ADDR(dev->parent->sas_addr))) {
> +	if (dev->parent && sas_phy_match_dev_addr(dev->parent, ex_phy)) {
>  		sas_add_parent_port(dev, phy_id);
>  		if (ex_phy->routing_attr == TABLE_ROUTING)
>  			sas_configure_phy(dev, phy_id, dev->port->sas_addr, 1);
> @@ -1312,7 +1309,7 @@ static int sas_check_parent_topology(struct domain_device *child)
>  		    parent_phy->phy_state == PHY_NOT_PRESENT)
>  			continue;
>  
> -		if (SAS_ADDR(parent_phy->attached_sas_addr) != SAS_ADDR(child->sas_addr))
> +		if (sas_phy_match_dev_addr(child, parent_phy))

This changes the test. This should be:

		if (!sas_phy_match_dev_addr(child, parent_phy))

No ?

>  			continue;
>  
>  		child_phy = &child_ex->ex_phy[parent_phy->attached_phy_id];
> @@ -1522,8 +1519,7 @@ static int sas_configure_parent(struct domain_device *parent,
>  		struct ex_phy *phy = &ex_parent->ex_phy[i];
>  
>  		if ((phy->routing_attr == TABLE_ROUTING) &&
> -		    (SAS_ADDR(phy->attached_sas_addr) ==
> -		     SAS_ADDR(child->sas_addr))) {
> +		    sas_phy_match_dev_addr(child, phy)) {
>  			res = sas_configure_phy(parent, i, sas_addr, include);
>  			if (res)
>  				return res;
> @@ -1858,8 +1854,7 @@ static void sas_unregister_devs_sas_addr(struct domain_device *parent,
>  	if (last) {
>  		list_for_each_entry_safe(child, n,
>  			&ex_dev->children, siblings) {
> -			if (SAS_ADDR(child->sas_addr) ==
> -			    SAS_ADDR(phy->attached_sas_addr)) {
> +			if (sas_phy_match_dev_addr(child, phy)) {
>  				set_bit(SAS_DEV_GONE, &child->state);
>  				if (dev_is_expander(child->dev_type))
>  					sas_unregister_ex_tree(parent->port, child);
> @@ -1941,8 +1936,7 @@ static int sas_discover_new(struct domain_device *dev, int phy_id)
>  	if (res)
>  		return res;
>  	list_for_each_entry(child, &dev->ex_dev.children, siblings) {
> -		if (SAS_ADDR(child->sas_addr) ==
> -		    SAS_ADDR(ex_phy->attached_sas_addr)) {
> +		if (sas_phy_match_dev_addr(child, ex_phy)) {
>  			if (dev_is_expander(child->dev_type))
>  				res = sas_discover_bfs_by_root(child);
>  			break;

-- 
Damien Le Moal
Western Digital Research

