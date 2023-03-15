Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951A06BA486
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCOBXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCOBXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:23:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055ACEFAF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678843426; x=1710379426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X8UKkBh1V1RorkgsXH+xOkeiIn0TdvaVPn4IWxodiyw=;
  b=pr3O9YvgceoSM9UUvYxrGr7MkuNYWWv7+sBWdwjGhILx0m4varfxlvA+
   6XUlS49Pz8VSddVW9S4YGnOM+Tg1pwbgFHpdhqUwFfY8qkgQpf3dX74f2
   nLnZGb/4bFON3nI7AT9wzu+PG9K+0olLK/VkZrJPBIllp+iYhIl/Uu03T
   K7+0Xvd9n4hvY1v/1sChm43evMUFBC3jugbSpOICgrWW7+pCyM17r2CBk
   /JC6rT8z60fca20sqnHZ/xWohbSN5W2TcYNEAtwTx249Eoy/2oBe6AGuA
   pc1d4a1rHGg+y7Sva4Bd9g07lOK9GDEHXBh9jqMEr+RerZtNztozJUx9+
   w==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="225433067"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 09:23:43 +0800
IronPort-SDR: 9LK/OnKFXhDxpSWjwqkooV7sFxNzq+2qoQZhYrGUodtnbJA6R+P0PJmiNEmk3kIKwL4U8tnr3W
 t2WXAAODoq6qv9FR0SA/j0q5e8RP/Bef8+7CBMafbTPLkB4/vKJpwsN7Ll5uaxrDGKtGvwIVLj
 6FdcRKhmA/hoTSi8BaBQ026RyiFN1a8IbQGs86wXoEuEoH5kd1TeY0WFJWpEVFiTTlRHFnYeT4
 fJf7+gRC7Z5KdsZYOxbLvi0rkN02YEJ2n4H1wIxzdmaVTSl1rf0Q/pwMaH+IdTpz+92lQRBzN9
 qYs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 17:34:30 -0700
IronPort-SDR: 6MYjDq52A/XP5aJczbvRMXwlOISf1ALWvUqv+wVPQWd8jq1Lm9ubc8uLa6pR6331Lg5FCITMn+
 n/+ZhdLXwCIFjhO8T2p5bBG1ch4fXfvufWw/1BsE2MekatobLQDojqQuNHW1yKVekRDW7EL/f5
 rz8RlH6BoR/I/lB4Koo99e1VfegbD2xn7uLgIJBB/VM8/Zm+KvUp76xUW5lRH/0EXu9sEs1ovO
 DL6Z9UzgMcJIqr/0qb8hszPyn7SqE0siYUPySoYkTsZkt/2SDnI+gCO74yAYxRp1f91N9NjMc8
 8v8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 18:23:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pbt2R3Rnnz1RtW0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:23:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678843422; x=1681435423; bh=X8UKkBh1V1RorkgsXH+xOkeiIn0TdvaVPn4
        IWxodiyw=; b=bP6jbEKa2LNYrQ3e2NilGHdksmnc/IQsbBc+wU7S6SEmh0bR14o
        jUoM4OkcwGn6CJSOfiLj7omJ37O3WflH2smKKwby8OecIU9bS+scfEFuatS+5YSo
        btf1DwxXuMgoYlEkDcHu0bG4P8Myae0M+2qX9XcONMEwigtdRRYJj1Mk+dxKzft3
        NzEEK6GZ9eThmQNJAZ2qwKqE3RQnIgdi5bzritBbeL8k7Z4uaqvRBgs7nC//ELG0
        +8keKTfSIAlsvvLmQgqzjSIX4oG9R5B1zvxJyEKE/5iGt1mdm+pQO+2SoDl12O3M
        j5krO7MQQgFns5Rd6rXn7bEuC5UGnEofB2g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RRFeq1G4ebEb for <linux-kernel@vger.kernel.org>;
        Tue, 14 Mar 2023 18:23:42 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pbt2M4kD6z1RtVm;
        Tue, 14 Mar 2023 18:23:39 -0700 (PDT)
Message-ID: <7453aba3-9f2a-4723-3039-a85652883b48@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 10:23:38 +0900
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

I do not see HAS_IOPORT=y defined anywhere in 6.3-rc. Is that in linux-next ?
There is a HAS_IOPORT_MAP, but I guess it is different.

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

-- 
Damien Le Moal
Western Digital Research

