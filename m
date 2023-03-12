Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB46B6297
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCLA4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCLA4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:56:30 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A029650987
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 16:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678582589; x=1710118589;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pOlTIWs8Pc37VFuKgoNPhQMANn3Yi6ON1BgiCZV6s5U=;
  b=TLGFT15VQ0k4S4H6YeTSFDrwRWGFpjNk4FyHXIVvFg8qQEZuP4EQ+5YE
   0cly2/10prdg0/vloxG39QwK+QZ7ZNN/ieWVruMVvjq5UX9QkpHBhmg/v
   klfxl+wwOMu2hwNq5hP86lBieI0xeFep2DqY5GFJC/u0sSnQhqyLyAINm
   SjrT6l3UXC6IZszq+zaiHkHa0izdmhYsYt1jT1CPg++v50/mhtfcw7Fip
   sNyhc4c14CXdkqlHUqU6tfPSDe7YWCNwm8LqwpBz3sZwiblhgwQF4AT2T
   XFvYiJfV28KusCbYhgAQ4p3CK35k5qpLY5udFXv3+wKcgI1cEdAKsirnW
   w==;
X-IronPort-AV: E=Sophos;i="5.98,253,1673884800"; 
   d="scan'208";a="329776408"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2023 08:56:28 +0800
IronPort-SDR: XBKBzC7dF77Dnz9n1/NGTz489N5czyJLvcz3974x0NUcc95fZZ1ivTI6N9562PfgQIJ6P+hkB6
 2ZT9KvnX40UOzHGbfUe6DjFaz0/sDW1Z5G98aGQMvEyIMR41WvnGukqA4k3cWulN6HEPy/45X4
 /GW8CVZJww5whtEPiSU9Mn7kPZE+72UVFlCvyQzYsPCj+gYkzuTbGrAL2eFa7f+ZMcJAjvct9E
 XE/k30C88o2HJUYwur1JNaEvT0+//1jyfSA78ByBJlV1QsdC/06/sDrEYoPq7ojO7Wa7z4OFwq
 SOM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2023 16:12:59 -0800
IronPort-SDR: dmmZoy7hoQ/Gdvc4AqTLrmE+NTr5kLnFj8Yv5sb9Ov7LYXb8ArF+uZWnFzcb/r1a8QeKns6fdc
 WfcM7TGnFuORCTu4pT/unxJoAgWlfxnEdVs00Hwdm+sZ2/ApJQ43UwpnF5RSB7tdCyA5rcEGYM
 xMOHQnlgu2b+wV43W6NSH7BfyzPEH331IpjqOe1lII4CajNV7S+adUQHOgiPaz5yqYtwseTVSP
 XLfFesOSlLktO9kmRvPBjdJ57LNLmQqAl0y8s+VQzISSgqYQ7m3lk5JrKtLLQ0Gxf+TBXRphT/
 Fw8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2023 16:56:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PZ1ZN4h61z1RvTr
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 16:56:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678582588; x=1681174589; bh=pOlTIWs8Pc37VFuKgoNPhQMANn3Yi6ON1Bg
        iCZV6s5U=; b=tPIzIDDEcGoPcR890IKk0hS564DmRoxa8hJj/qbNEUUTY3evxHy
        t1OkpdPANN1eHQ6QIDBuSJ6JNIpMVpbTa8XRtoWTvhyAj5FbY6satskhX3SOZlsp
        GFSb7+IXDCYcSJbvnhlA43uZTI+3EiL8fXbjXdzHB2nrpEX7R8g0E1WDtawj6MoH
        aCkVdGOp+B4rXI2bYC4ooRvX423f4ZiviwPcBoCskxM4dwcpIacaZZaiGnlmlovt
        cvjQqJMVmdZS6zXkNodN1MQ9IpGCQnPzSgmPkw36+qYVxD2v5PV2+ZRuGWPJ1zb5
        Ql5/6kGXcq1/gsnbl6vifY+09uUBOETRSxQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 42O_prGfWxEQ for <linux-kernel@vger.kernel.org>;
        Sat, 11 Mar 2023 16:56:28 -0800 (PST)
Received: from [10.225.163.78] (unknown [10.225.163.78])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PZ1ZM1CqSz1RvLy;
        Sat, 11 Mar 2023 16:56:26 -0800 (PST)
Message-ID: <8b0eb4d0-ca10-35a5-a74c-fd0f7d11713c@opensource.wdc.com>
Date:   Sun, 12 Mar 2023 09:56:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] pata_parport: fix possible memory leak
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202303112239.21234.linux@zary.sk>
 <20230311214447.7359-1-linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230311214447.7359-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 06:44, Ondrej Zary wrote:
> When ida_alloc() fails, "pi" is not freed although the misleading
> comment says otherwise.
> Move the ida_alloc() call up so we really don't have to free it.

Certainly you meant: "so we really do free it in case of error.", no ?

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202303111822.IHNchbkp-lkp@intel.com/
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---
>  drivers/ata/pata_parport/pata_parport.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> index 6165ee9aa7da..a9eff6003098 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
> @@ -503,18 +503,19 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
>  	if (bus_for_each_dev(&pata_parport_bus_type, NULL, &match, pi_find_dev))
>  		return NULL;
>  
> +	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
> +	if (id < 0)
> +		return NULL;
> +
>  	pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
>  	if (!pi)
> -		return NULL;
> +		goto out_ida_free;
>  
>  	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
>  	pi->dev.parent = &pata_parport_bus;
>  	pi->dev.bus = &pata_parport_bus_type;
>  	pi->dev.driver = &pr->driver;
>  	pi->dev.release = pata_parport_dev_release;
> -	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
> -	if (id < 0)
> -		return NULL; /* pata_parport_dev_release will do kfree(pi) */
>  	pi->dev.id = id;
>  	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
>  	if (device_register(&pi->dev)) {
> @@ -571,7 +572,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
>  out_unreg_dev:
>  	device_unregister(&pi->dev);

Same comment as Sergey: isn't this going to do the ida free ? So shouldn't you
return here ?

>  out_ida_free:
> -	ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
> +	ida_free(&pata_parport_bus_dev_ids, id);
>  	return NULL;
>  }
>  

-- 
Damien Le Moal
Western Digital Research

