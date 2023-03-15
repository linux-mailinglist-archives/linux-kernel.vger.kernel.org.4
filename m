Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DFA6BA8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCOHQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCOHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:16:08 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E57D2333C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678864567; x=1710400567;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gzn4utLc8E9+krBxKFICMItFLGvLZcLSUim2ZyjAkIc=;
  b=DoTuLg6RxrVA7P9O0400qUtHVnROp/KCQSRiQZrAHpXgccdQiWhwGIwi
   JS1xlVhay1vuLQ5qf/oZftzLS4oIiW9/CNfGgkQJIPNc2d8jI2YlKtVS2
   Ej2cuXPabUpqks4laP54vfJZvkTR49EdZLR3c+iYKpRtFh5wtgQtdaj6N
   UStNiTcRSm9Z3m4ERONbAd4a4sCmJcoLVFu4MYvwEzHAwp4mnYq+XMXi/
   uKK/QAapeADaClHtYgjQ7Bo8zGiLECSUJzCLMra+Z2SNiF8Hob0sm1VT5
   8fv2+HxfK7t43yqiJ8xGuCPjVbnX3wPQHovYi+V6DnYD5VETd1RMMalgt
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="330050561"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 15:16:02 +0800
IronPort-SDR: aokaa89LHaUN5jyVlk/Dgzd3kN4RsoX4i9Z/W/osLVCrOEviWSmpWQuSqBXwwNuJAI/kMd0Q16
 f7w+Ct9FsHBjI0UhBsHEm6rTXOBMBzN24yIgAMXieu8OeVsNHbl6bCvxIGIDhshTm5xLGjRG5C
 WXmS8Sqh/zMyBaWTZvqcvsae8gonxILVIdO/uI0zq7gwzIdpydGNfaCg+2KPeCEXgE8kng5Ckx
 qZA1MbQxrNZzn6D1QQLJT1ajiMJI8Xy/YhH/6D9WxJaFXelp4P54ki9MrQne4TWFL1p5D1O5jD
 uoY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 23:32:29 -0700
IronPort-SDR: 5P/c8ffhk6c9KZiCfNw7R3dWqxkpTJ12MR6G7AGPd1rirC6KDEbi9K+URLfxlN9SlY+Wtki90U
 SXqLME/5NO+B2L1BWB1BY5L6nCrpAp7kejx56Y60Wr+ZGTWJkoV6XL0O6VLDZwy4zS3DFGjDUv
 CYXzz+T7sDItxbxyWwovYOqqzYUmInf18cnI4uMw/qIZCUbYmCJa7EVAUeCH+SI0vfS0F2nclU
 kgk27nXwaZrUvxQaALkbrpZcJR7K7EjHllRN0MZ+JKRdB/ltlEyOHsfBBNXObC+9643g49JiAg
 ymY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 00:16:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc1ry1y3Zz1RtW2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:16:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678864561; x=1681456562; bh=gzn4utLc8E9+krBxKFICMItFLGvLZcLSUim
        2ZyjAkIc=; b=QcmorQfZXKnxA0EP7lHE6ez2ReFY9lPT4JMif04usI6gdah0wx0
        vjPLeQsGOm7rbfUi5HB5svALBY5VWJJkskyIm0D8SDfyog00LnyDo6LIvaBdF+/u
        nw+QcWIBu1sfkqAtZydHxTg80DmhPgDoxAf5m/TzXMgey4VBJ7Ef+m8cogq4hmvB
        w8xwcrKWp7hG4x91n1SD5kzj0evVdg4TfLQwgH8+8e3TkBW4S4IdhrKBCqlg+D1F
        y4g6c7QkY0h9fbJHVs9V53ydftmGFvQMHgvwAY3Al0s00S/nKtFWGhIgui0OwsSB
        adBv0xdYIQ6zHwM7JXVrIPTKFiTLYjOyxEA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 760m16DcZgv2 for <linux-kernel@vger.kernel.org>;
        Wed, 15 Mar 2023 00:16:01 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc1rt5qrVz1RtVm;
        Wed, 15 Mar 2023 00:15:58 -0700 (PDT)
Message-ID: <d9cdb235-4cd6-5ff3-31c2-85e893e25794@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 16:15:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-3-schnelle@linux.ibm.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230314121216.413434-3-schnelle@linux.ibm.com>
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

On 3/14/23 21:11, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/ata/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index b56fba76b43f..e5e67bdc2dff 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -342,6 +342,7 @@ endif # HAS_DMA
>  
>  config ATA_SFF
>  	bool "ATA SFF support (for legacy IDE and PATA)"
> +	depends on HAS_IOPORT
>  	default y
>  	help
>  	  This option adds support for ATA controllers with SFF

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

