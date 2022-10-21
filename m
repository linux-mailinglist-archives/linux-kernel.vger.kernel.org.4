Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB62607462
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJUJpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiJUJou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC6B1D335
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666345488; x=1697881488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CgwdjJKPZPX+hKe4JRhoUMLH+DE6WQ8e4O5Rsh5JLF8=;
  b=qFJa177VNMSzzVKoZlroX5pxsXLuVHh0mhlF/8a4irI/wxEHvKLq/9ab
   jRLouJ5aLJQ2IBha71X2DFXwN5aJTPnESKi3bKnPq7icIzngwLiIdiSUP
   gZNwgIz7Vf59Yoa84Qn+hHCY0BD7tTgqitpq0Omh9PVhtYcjHr9Abi2V7
   s2c4Gxr5r022M1g+Hzs66D9MhmQ29gtT50972v47nNyE8E74FkcOGRnRo
   MxTbHfC0+0p6/TcaTLm/14GJbdC+FHVnFE5YFMhGnCNp+5XFk2mXq0R9O
   rIdEjFTe86hzxtCzPayitdD0anh6mpVs4z7BpyxAR++sq1ndG9z2N0nfq
   w==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="214423015"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 17:44:45 +0800
IronPort-SDR: j5CpfQ/c+Odbsbh7FdCXH98esJIk1/aTwTVx9T3WEpiBH2Y3d+QYI8acfsR7VILzp2TZ+RPHkA
 FbAUtF3DHCNVy/IxmbtfaZPvGAkIUcprNixUltl3PRji6Uj/YRNxCNbM2TtpRoW0M+FRsJQmWB
 9XXnGt39YepnaFUo9qfIbRO8f01qCvHWxo83EL063IRrSWkNEbphqf4MopBWdg9E+GCDofWuAy
 pylybia+G1VdsYebdFXLvs6yJC61+TSeLiG0t8myD2QxuufUynaRpLyI2fCi9meoVVYWnwNrZ1
 rz+J5jp3EKrhxGu35pcLlC6u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 01:58:32 -0700
IronPort-SDR: SaO/QqUVbQYce2+h9caYVI4z66f/9iPos9pT+daXgXn8yLJWFNcoVmBaXctCHkyruKqbKXpHGS
 jc/VvdfEd5sy5BdmTfYqYZYGAOBH8z9jL3YuHUHXLygfjttcNKpFa79r70gCB0/Fhq/qpKd4l9
 0Rq1+nmLryAlMpQY3i3Se+xfgn0v0gBXPRoTf/Ygq7psQhev3J27umpHDe1/Q4zaKEVjcR/vpJ
 UcnEniNtjkbHw3snErW0fCrcQCXeDjw+XaJdOjEdCtFcOQJ0uL+0M+3z41Cpksp/Ri0PdZEQs/
 AOk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 02:44:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mv01S2QSnz1Rwt8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:44:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666345483; x=1668937484; bh=CgwdjJKPZPX+hKe4JRhoUMLH+DE6WQ8e4O5
        Rsh5JLF8=; b=tXuDtvmKYPjGFcT2CMA37c8E6tjf6AYAIDO61AGUJGEPvrYYFCK
        +ORp1LW+Pqn1WRuzcU9M2jyuOjL2fnf9bpiJ+DaAl9E83lOzxha1h7CH0r6ewwaV
        2s2wO/5aoa/nxr2Zjl0wlf5bWoSxX4Xwczivzmb+LDvtO60tKqEsDKrX6Y54biVL
        jUG1SmPBgqS5l+AUxul7kaMiRL2MzE0BcjMFg8EyQUVZHBuRdi/izLUiXgc35yIK
        Vrx2I7S30D2OFHum7nSUDFXe3l/SSURdeByPkGnO4FA+XJ4Gd3ZO2LQ2QM2yJOu7
        WOHDUor8Haj3lnIL5GD58TMd9F1FBUG6RlA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iqCo_maxc-LO for <linux-kernel@vger.kernel.org>;
        Fri, 21 Oct 2022 02:44:43 -0700 (PDT)
Received: from [10.225.163.126] (unknown [10.225.163.126])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mv01P5zHNz1RvLy;
        Fri, 21 Oct 2022 02:44:41 -0700 (PDT)
Message-ID: <e62600da-4a1c-f797-8fdb-2938ca58f25e@opensource.wdc.com>
Date:   Fri, 21 Oct 2022 18:44:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH linux-next] null_blk: use sysfs_emit() to instead of
 scnprintf()
Content-Language: en-US
To:     yexingchen116@gmail.com, axboe@kernel.dk
Cc:     kch@nvidia.com, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, vincent.fu@samsung.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
References: <20221021085446.414696-1-ye.xingchen@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221021085446.414696-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 17:54, yexingchen116@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/null_blk/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 1f154f92f4c2..5317ef2ba227 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -255,18 +255,18 @@ static inline struct nullb_device *to_nullb_device(struct config_item *item)
>  
>  static inline ssize_t nullb_device_uint_attr_show(unsigned int val, char *page)
>  {
> -	return snprintf(page, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(page, "%u\n", val);
>  }
>  
>  static inline ssize_t nullb_device_ulong_attr_show(unsigned long val,
>  	char *page)
>  {
> -	return snprintf(page, PAGE_SIZE, "%lu\n", val);
> +	return sysfs_emit(page, "%lu\n", val);
>  }
>  
>  static inline ssize_t nullb_device_bool_attr_show(bool val, char *page)
>  {
> -	return snprintf(page, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(page, "%u\n", val);
>  }
>  
>  static ssize_t nullb_device_uint_attr_store(unsigned int *val,

-- 
Damien Le Moal
Western Digital Research

