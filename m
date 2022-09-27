Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16005EB79F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiI0C20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiI0C2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:28:12 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8DEAD9AA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664245692; x=1695781692;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dtpZvmFtYIdkdXBy+L2NjqNKdBMsA002GGQLmcuex7k=;
  b=G8/vWFfgAexGjzDgkahBU2YPurw7gAVEfFo4KNAaG0o1G8vprCdtWcec
   TGeIz1Hk1xyPXuqb4gPxK/SBy2sdw4Sh+h+cG7O2wgFh01Bd2PdeVsJcT
   hDvYLUmbl4HpMXSUl96O7o0ewa8zl2+4CPDR/eHf54fAxQwse5WdxDilQ
   suX5cmUQjD9FKV2YIO28T/6R5EoYfp+03thh3eIxIhDbAplfCGPt+nb3N
   35wTaD+kqayePU7XcF6nzZ84LWvh27bLuajtmqynBA8D8mPbjTVX3yEau
   loHpWE0EgZpe6dA1Mc9JSNy9KMHv7+F+SrR+w7AjybKAFPyn+Ai7oYX+K
   A==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="210704774"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 10:28:09 +0800
IronPort-SDR: mk4UssP0QejoeM69QQYi7jdAIfQqz81v6Yk3/cEtaA+ME0D/q1WKsj1rfOq5JYIIwLhL0Dz672
 EDufl5uQiNyE1UG7+yQG4kMpjxLhU6MEIm4guhcB2ao6V0l7q8GcWAbh/XaGBDlnWejJO2YTz5
 A1OyPPgSNCbKv0tJWRCfUA1HEGXa6n90PAAbyu14m0ai+sw2oTtsW1kHzqel4TDbLnRijlSx59
 2SYNed4KmA+CrGzKsK4/I0imhkkthtwPG4OAAAsaXbKomSBEa0MkXDWCotaVF8i5TuCxbKWIZ9
 9mV3ROXnTgodMJCU/jEbSybD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 18:42:35 -0700
IronPort-SDR: Vi1Iig0EFnWEbtPaXVmWKsZItEmxzsQe+WAhhvwvN5QccytS5gRN4AE881KQSb+nyR02I9s4cW
 2flzhIHovIGV8oVz5FB8PNa5B2DazcyBK0EjEMd++J6sjoblYdxWpRM2dncCEOOUoo8tpP8ZAC
 OcegIeEByQGn1LURnNPYas1JmF/sp1WLI37VBwP/m+szsvD1nz8uCD6CRzXxj3b66yjPiPbBda
 YDOXqcflALTXE6ZuGvTVz0tKRw2EdQFFgzrGqDKUMgYeySlOhvpx83wAzRMcDt/d9PEquYKHHG
 OYQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 19:28:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mc3Sn03QMz1RwvT
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:28:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664245688; x=1666837689; bh=dtpZvmFtYIdkdXBy+L2NjqNKdBMsA002GGQ
        Lmcuex7k=; b=X8DFloejAxpZb/j/MJILnW0ULQSpx1imZ2DWIwvFLnRss1+3hO3
        1EyzSguoUXVjC2Kg6FHEVJCzFLYOoYjnL8jxC5aV57cek8LTm85DL8t5GkPkoKG5
        05LTnfA7XJNynWun3VpQm6PzlpjsyFWKELTmjgIlsmvaAJNVHtHjZnvXevIBShtM
        piYkmJ7mrJXwSd0l5TFhnobgXEgU1NlUGWBiHcMny4phMQOi1Dr1f6TCqpZlktNl
        iSz57FsIaQ5V9pE0b1vjaV6dihWIVLhnEyt8hDyoDMuTuxEkDv6VMwZ/5oIY2c4J
        IdlOKTPlEQYZ94ifG5AAHH0hI7QPczVf+PQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YbVTfq32janP for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 19:28:08 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mc3Sk4BF5z1RvLy;
        Mon, 26 Sep 2022 19:28:06 -0700 (PDT)
Message-ID: <6654484e-70ce-d34f-ec48-44b0eb2bd0a5@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 11:28:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 5/8] scsi: hisi_sas: use sas_find_attathed_phy()
 instead of open coded
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220927022941.4029476-1-yanaijie@huawei.com>
 <20220927022941.4029476-6-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220927022941.4029476-6-yanaijie@huawei.com>
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
> The attached phy finding is open coded. Now we can replace it with
> sas_find_attached_phy().
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/hisi_sas/hisi_sas_main.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index 33af5b8dede2..995ccb13fb9d 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -792,17 +792,9 @@ static int hisi_sas_dev_found(struct domain_device *device)
>  
>  	if (parent_dev && dev_is_expander(parent_dev->dev_type)) {
>  		int phy_no;
> -		u8 phy_num = parent_dev->ex_dev.num_phys;
> -		struct ex_phy *phy;
>  
> -		for (phy_no = 0; phy_no < phy_num; phy_no++) {
> -			phy = &parent_dev->ex_dev.ex_phy[phy_no];
> -			if (SAS_ADDR(phy->attached_sas_addr) ==
> -				SAS_ADDR(device->sas_addr))
> -				break;
> -		}
> -
> -		if (phy_no == phy_num) {
> +		phy_no = sas_find_attached_phy(&parent_dev->ex_dev, device);
> +		if (phy_no == -ENODEV) {
>  			dev_info(dev, "dev found: no attached "
>  				 "dev:%016llx at ex:%016llx\n",
>  				 SAS_ADDR(device->sas_addr),

-- 
Damien Le Moal
Western Digital Research

