Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C974D692D86
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 04:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBKDL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 22:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKDLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 22:11:55 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C9F1DB81
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 19:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676085113; x=1707621113;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jnYrIAyLiLB6n7E5Ks/+GELpUMw3KMHdn1kuZ0eLaJc=;
  b=UZeTMndH9ezICgOOnsf2q0pUzyjOyykiZWr92lQ/9sjkEk9r7fbYhfpV
   ozWC8eT1ETGoxVsHF24K08pp0RdxQRMIz/x+fPoyaSXc3ZVyFKXI4CY5b
   J4hnTyJFZOIJvZr1ZQdkMUCnZlam43gjFOo5Wt/R+ZYpc+AJbC+w0CbYJ
   GmAi5tWL8gigik8/t/xJDm0BqotFtdn4JgMU4FdNnbbXRxJjJvUCIHkEc
   mI8xlHnX6kCJ6tgikqifIX6B3plnV8cqG5ME4zcJf5NuW+F6ZSxfaO35Y
   +zuwRqheotRqZoGjFr0UVOF1R56AG1sBnaOtwpI16dbe1ZtEgHf7y4inc
   g==;
X-IronPort-AV: E=Sophos;i="5.97,287,1669046400"; 
   d="scan'208";a="222843648"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2023 11:11:51 +0800
IronPort-SDR: PIXoAO2x9GI4vV0s5ANg4XqI+8pPAyo7PB5nr/OiGbZXjXI2Lvg7Qzoo4XVkDV8RfwbAwEhLR4
 8N/eW2gOqeMOjvE1/ChGOywPdyannw+S4gqucrMwZIw09B3edr72KM1eIGiJ0uPaNrwk6gAghO
 xwA+m3TL2sG7I6xI8FIWDE5WnDkyAXN4HdEM3bQo5if0gkIXh02UqlBW0dzwRk2mCwcqkD7vQP
 2GjJErsArsZIz3JHIYkc5UGKK+MOM/ED9kTLS/Vw2vfr+xgL71dFvTbb4YxZgUbII/y3lDPPv9
 DOg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2023 18:29:03 -0800
IronPort-SDR: liLyZ7dzlGyHZoFGx4CR4YK7MUJh2T0SenRLKUhoLE75MWps66WnDuyBUyx2f4becOxL8dY5Ef
 Gaq82ow2D8O6Sz4h4zF4l3FNV/CalnhMyZVMIcOnElwn1WPS8NNMPgTcPBUeT6b2zobxU5U6dd
 gc1pS9z+vqNeQQYMVw+m6qSPCcEzISyx3VGdgRoYfOk33TAk235vxqDJW2jiWAph5J76gIjJcq
 w/a7gXpTj27Jq2KmbxrTWR3z+uWRZSRldWhnwSHKEkN0RQeMfPTgOOVCZciCcU4UyDQZgUNY7S
 Stk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2023 19:11:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PDFxy6n8Jz1RwqL
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 19:11:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676085110; x=1678677111; bh=jnYrIAyLiLB6n7E5Ks/+GELpUMw3KMHdn1k
        uZ0eLaJc=; b=tOYgXGFU0/0Gp4yZOiZSFS84Rncdi6+ds7GQOTeh8ar5hTqjGk4
        CrG4/y0W/HYefw19wyyLOsqSsdorPLL8GnZvMeRP4LlPMsXc6cxYO872lesMCg78
        clIiTBrNO2VmBOncHF7Hfhcm+rmt9bVBWd9nbice0y0TQNzy3fP5Bhz1xbkwRkgr
        Dao0NwlIDOhZ+ydVu5WVWocMSrnMIVncmlh8M7FfQ8N54J/1oGsXXTxYqpXDNLbJ
        k6mGS2D5r0y6D/WZflNrd3N0lZxgtO9Tl+CyZHBtJViQElOqQPZtltmP7XSOGl1q
        YEscr6AJexLtOlXrBUKQxp4VGnuaiIHI+Nw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O12bgW3zAeaD for <linux-kernel@vger.kernel.org>;
        Fri, 10 Feb 2023 19:11:50 -0800 (PST)
Received: from [10.225.163.108] (unknown [10.225.163.108])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PDFxx5svxz1RvLy;
        Fri, 10 Feb 2023 19:11:49 -0800 (PST)
Message-ID: <dce110de-649d-cde8-9401-346675c95263@opensource.wdc.com>
Date:   Sat, 11 Feb 2023 12:11:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: libata-core: Disable READ LOG DMA EXT for Samsung
 MZ7LH
To:     Patrick McLean <chutzpah@gentoo.org>, linux-kernel@vger.kernel.org
Cc:     linux-ide@vger.kernel.org
References: <20230210215151.812839-1-chutzpah@gentoo.org>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230210215151.812839-1-chutzpah@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/23 06:51, Patrick McLean wrote:
> Samsung MZ7LH drives are spewing messages like this in to dmesg with AMD
> SATA controllers:
> 
> ata1.00: exception Emask 0x0 SAct 0x7e0000 SErr 0x0 action 0x6 frozen
> ata1.00: failed command: SEND FPDMA QUEUED
> ata1.00: cmd 64/01:88:00:00:00/00:00:00:00:00/a0 tag 17 ncq dma 512 out
>          res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask
>          0x4 (timeout)
> 
> Since this was seen previously with SSD 840 EVO drives in
> https://bugzilla.kernel.org/show_bug.cgi?id=203475 let's add the same
> fix for these drives as the EVOs have, since they likely have very
> similar firmwares.
> 
> Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
> ---
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2ea572628b1c..c4c89d24f84c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4045,6 +4045,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM |
>  						ATA_HORKAGE_NO_NCQ_ON_ATI },
> +	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM |
> +						ATA_HORKAGE_NO_NCQ_ON_ATI, },
>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM },
>  

Looks OK, but ATA_HORKAGE_NO_NCQ_ON_ATI is for PCI vendor ID 1002h. AMD
also has vendor ID 1022h. Did you check you adapter vendor ID & tested
this patch ?

-- 
Damien Le Moal
Western Digital Research

