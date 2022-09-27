Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31255EB794
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 04:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiI0CYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 22:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiI0CY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 22:24:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB6AB1AD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664245466; x=1695781466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0iSGZW8cmukJH3UL3PwqWyDwnkfTJaj1NMHHrP/i+As=;
  b=AZqdtA73M3O2zTh7wH52x1Mo4dRsiLPv38uQlorGGM7WQnL/+Uh9Gmre
   DrrG68vggKAIY8USfwPPNSoaKNUrohtHkDJvtiitVOppou5ULy7XtRPaY
   N+BGN8sFmBfPd5lNjOyqbnEEsl2GcIdDmaeN88mDJOHdSiDbW6c9c/3P5
   EBGuVo7cb5HXAf81rWmSAB+ThniWvL7XFh/+kuGoQIGExtYasRrg0VFl+
   Vaj3zeK1Q/uryDOx65n3ksP3LczUBxj502MFdbvH1ZtCvkl4j1ZP0IjTO
   B9I7Ukr2D0vkmKwEasorlD43ZRvOMl1Umpj6eu5jmwIxd3XXdS4ng/Gnm
   g==;
X-IronPort-AV: E=Sophos;i="5.93,347,1654531200"; 
   d="scan'208";a="324440596"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 10:24:22 +0800
IronPort-SDR: yBFZi9utMzcVw7IN0lRzoXsnIwS0pCyvbzgkTU8n6XGlrfYSfrIZvALSazlpxKyZ4LbRuizr3d
 7x+ojiw3OQaEchy8Oxsyxm8XdGRQ4kqrP6wQhEJUC4N0JdxGKUx+3zYX0d5gGBxgLT3Vv2/30y
 tJQshDonVk/njTVtk1YM9iJTxydpOadfPvn7OuuS8CMTRFv7AE+glPK7Rag847m290E8jGGyTY
 pcHNDWMCm9bimMY9pqZ0QVATEt+gLGuMFfBd9JpWqVp/FdTTVLA1ai3OofFHm+xwzu1WRyK/nH
 QPoDN3qWE/DFYBvnUz+IJWB/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 18:38:49 -0700
IronPort-SDR: zIFVyw7a+526MJK125tczeY3OO2qM2NLJhdkPjAf7QuoB6bTG825aJtOp8dSZhbRE5PAhLgGiu
 E1qp1GJHb/TzkLNGZdOFYeXsBX60hEnwUGWAjth7Fxl6We7G/1VsuAF7h6dEJrjIlrsxT1j1kK
 q/PZhwHFXi0bIFdUpioyvMpPhDG/SzZfZFQor5lduWak0ak64lkzQBs411rBGH0V72fMJWhNi4
 rOLZ/9M4ACN4qGAVWaB4oDRGjHwH0jXz7InG+7b8fHVTDXe6E5btPtw7+nironV+0ZFCFrvWcN
 W14=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2022 19:24:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mc3NQ2CzNz1Rwtl
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 19:24:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664245461; x=1666837462; bh=0iSGZW8cmukJH3UL3PwqWyDwnkfTJaj1NMH
        HrP/i+As=; b=EiVEoKOWXSjiVURoS0JrEpq9nzO62yscc8KL1cxsJaZr4dN3C5o
        6/3JvNpIuKtSzw7ivz3mj9efCGnyMRlVnKZDMXmeq/0So0qDOgDMO4VJyl4uMo3q
        MFd20oodm1/8SZDvPnM2unpLlU3fHdx+kRc+20sMDWrhNDpx25QSW06mF3L40MGx
        QMI13MBnhvK2NUEZz+68TUbwt77fqQcAmBNkkwIhvcGa3gyYG/6MppCYOsC/N7P2
        trJ7r978d1EHgdYcd9rohaI+Kk0t/C+7sQ18G1hM1/JuEZer9Y92Xo2BOIoD+rNz
        UQm/LbFRLoDwZ1GTtbPGHedoi1HMu7RjGhQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SFkewBMyEyif for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 19:24:21 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mc3NM6LGQz1RvLy;
        Mon, 26 Sep 2022 19:24:19 -0700 (PDT)
Message-ID: <0939e5df-9e2c-8471-b704-9520225b5759@opensource.wdc.com>
Date:   Tue, 27 Sep 2022 11:24:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 2/8] scsi: libsas: introduce sas_find_attached_phy()
 helper
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, hch@lst.de, bvanassche@acm.org,
        john.garry@huawei.com, jinpu.wang@cloud.ionos.com,
        Jack Wang <jinpu.wang@ionos.com>
References: <20220927022941.4029476-1-yanaijie@huawei.com>
 <20220927022941.4029476-3-yanaijie@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220927022941.4029476-3-yanaijie@huawei.com>
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
> LLDDs are implementing their own attached phy finding code repeatedly.
> Factor it out to libsas.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/libsas/sas_expander.c | 16 ++++++++++++++++
>  include/scsi/libsas.h              |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index fa2209080cc2..df5a64ad902f 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -2107,6 +2107,22 @@ int sas_ex_revalidate_domain(struct domain_device *port_dev)
>  	return res;
>  }
>  
> +int sas_find_attached_phy(struct expander_device *ex_dev,
> +			  struct domain_device *dev)
> +{
> +	struct ex_phy *phy;
> +	int phy_id;
> +
> +	for (phy_id = 0; phy_id < ex_dev->num_phys; phy_id++) {
> +		phy = &ex_dev->ex_phy[phy_id];
> +		if (sas_phy_match_dev_addr(dev, phy))
> +			return phy_id;
> +	}
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(sas_find_attached_phy);
> +
>  void sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
>  		struct sas_rphy *rphy)
>  {
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 2dbead74a2af..75faf2308eae 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -750,6 +750,8 @@ int sas_clear_task_set(struct domain_device *dev, u8 *lun);
>  int sas_lu_reset(struct domain_device *dev, u8 *lun);
>  int sas_query_task(struct sas_task *task, u16 tag);
>  int sas_abort_task(struct sas_task *task, u16 tag);
> +int sas_find_attached_phy(struct expander_device *ex_dev,
> +			  struct domain_device *dev);
>  
>  void sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
>  			   gfp_t gfp_flags);

-- 
Damien Le Moal
Western Digital Research

