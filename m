Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2C5BAF2D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiIPOWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiIPOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:21:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15EDB2778
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663338101; x=1694874101;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=84pn1zP6OIV/5QpJPF4VioDf7XMSIZsIpSSdc8bqVLo=;
  b=r21TF7stftY3vSWifZTH1Xh1lfCV9iA3jJBQatIb+cWE3HEAaEn0f2F8
   fIw6/LA2BwfIUoB6IUPGznLYevrS23eLux/dWbQlUs/zlV4GiZ56FuH7y
   nqIoGjcum3apIGcgh2Lu2AzNFIjs+t2oXH88YFdnPfLaGksIY0fk5uqA7
   zhAyeFmSWc7BFWh34PHwKt5hZWSitfkZsedkv5r0oTxIttZwsUlqnAkd/
   3f7lXbenRfVtBKGC3SEqklSKFp8r//Q5VX0SnovSVg+Hoglud/naCzRho
   NHHfwwi0yqakEFIW1tsLPNN3q95JhviVj/VuXYuPRjOJk0EH46SKnLxSu
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="209930966"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 22:21:35 +0800
IronPort-SDR: 1Ajwym3uW60c11Xh1lSBaoUtMEM1mJBuOz9HGUZCoMWebkRWoCmuPdPu9d8IG+ggYPhtVF0YNM
 wIKVEa1EnhbX6QapUgmwYIJ7au7sxkznb1xfNiAt4oYaP34WjshM+g0tQg8yUoLohttA4BZ6va
 3UvTr5rNkO79B5Yq/3j9ZiFj4tuVHtV+2XOjaNFASEYqJnTm2+o7IvDBxiUZ3iD2Ncx5jI3YgV
 K2biLLx8i7zVTSruJBVPfgAq7AP3AWZ2VUlz6ojH2heW/IAU5YBPPqtXD5B74xEsMqv37or++C
 S6HNUt17479T9oYhwvz1K7+P
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 06:41:45 -0700
IronPort-SDR: FVPUQKVMDjbidK4HROhfEYPYQUxy2lwC8hENl+pPy6x0wtoK+D9Kkli8+8oqg8pSn9jvUplih7
 G28nu/VdBmi+sQIVPkZMRTLK3LB5kQm5liCIyVdz9EG8P2RtsnZaph9xBL7dEleMBCZsZJGnKS
 /zpWM90aasCAfjNI452KBAOTNMab/zM4ZUGx21auU5eFxbFbTgFI2lXQb8XOD4pv7ePZJbrhao
 c1BPfHltmuamibIp20iuDtLbkUkH5v1oHs1zyXS6Wjdc+/cObXz6HtWAp+yBEBSaI250pPUbfP
 GJE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 07:21:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MTbq25f8sz1RwqL
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:21:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663338094; x=1665930095; bh=84pn1zP6OIV/5QpJPF4VioDf7XMSIZsIpSS
        dc8bqVLo=; b=SBl2kAtab+wRZelgXy74wEUdwx+SPFe9Ko2ETaiGfQ9+Bg4hJK9
        11cxhEpPON0+DY+iQmSLZLgkrPNU6YQN5UIVh33CWfzF5X/xgzjfWfkslhiPgy1T
        qHI7G+ZggRSWyJxM4eEKUYuTSgIsHmaHauTLW7JAV5HjZT4h+ELeaTojGZoV3Mbw
        QUWR9KK5n/GkWiSAq8ZtpXnEE0Ez++LzpRVoO3MNcqNvViZOTIYkIkm9rY4luoNI
        xbF0y6to3XwPlV+mzVOBM+rQD1Wk/ZOk8x+kV8DqV0ujCupbN6bvcs8gXb7pGyxB
        boXqPtFe9Xq7HgcqNl/AJ2TfGGEaDPjU6AQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cXlS-XipHPuJ for <linux-kernel@vger.kernel.org>;
        Fri, 16 Sep 2022 07:21:34 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MTbq03J7tz1RvLy;
        Fri, 16 Sep 2022 07:21:32 -0700 (PDT)
Message-ID: <7b7f36d4-9aa5-fff5-bd82-3658be6496f4@opensource.wdc.com>
Date:   Fri, 16 Sep 2022 15:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v2] ata: libata-core: Check errors in
 sata_print_link_status()
Content-Language: en-US
To:     Li Zhong <floridsleeves@gmail.com>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20220903231039.2278817-1-floridsleeves@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220903231039.2278817-1-floridsleeves@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/04 0:10, Li Zhong wrote:
> sata_scr_read() could return negative error code on failure. Check the
> return value when reading the control register.
> 
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/ata/libata-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 826d41f341e4..ae08c7d35cb0 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3021,7 +3021,8 @@ static void sata_print_link_status(struct ata_link *link)
>  
>  	if (sata_scr_read(link, SCR_STATUS, &sstatus))
>  		return;
> -	sata_scr_read(link, SCR_CONTROL, &scontrol);
> +	if (sata_scr_read(link, SCR_CONTROL, &scontrol))
> +		return;
>  
>  	if (ata_phys_link_online(link)) {
>  		tmp = (sstatus >> 4) & 0xf;

Applied to for-6.1. Thanks.

-- 
Damien Le Moal
Western Digital Research

