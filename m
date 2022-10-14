Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898305FE644
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJNAWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJNAWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:22:41 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840E6422ED
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665706960; x=1697242960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sVhzWB6bJ4Xda1JmI82UJgmAYd2X09c+MflqD/NibXE=;
  b=Xq1YDkleZmdU2R6eKyTfzEK36cjCzSZWXodNm5byJcY1GbD+2lMhwdB8
   sW5n48H4xNsvTQrxXsutSjWbLP6m7JwdzH1CQqiq/gitfBPWTCQeQ5HEd
   WL7PEqGTw3eBSo2bbB9qHusk3rWoAgeT+3yyyuSActhoZzfDuTtPb0klY
   tAqij6pxicTxvdaT4vpv2NztkkPgW9Q5OaY4bIZCwLgXYpSC21NBrHcKA
   joLImoOKRy8kMWGU2LE0zgIT/WnpyjDg1CtTOGh+GPd3X4sWnYvbeJA8X
   G5LItrCIajM42c4c61ch7Ri0JJzbuZQp9RIUwZPDHlsLUTEPiOf5qfs2f
   A==;
X-IronPort-AV: E=Sophos;i="5.95,182,1661788800"; 
   d="scan'208";a="325854415"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2022 08:22:38 +0800
IronPort-SDR: BHF6CW6B5qRe0fU6+/IuhLrjMzi2c/gaWjJ36aVR+76HpNLQo5ktajgkmYpLpW1WD/+77Qe0B2
 Qmj1hCnyZ8MItZZuwIbxMvGXVJTWmB/xhtn7yjC4SZkjB3pLfj8WoouenhsHhf1YMDuTKoq+D6
 zwJSXMPYRHzIwAoQu46asFFM85aFKn1ojqUOe0nDzspUgq/ESGa+TATtBNNS7l63lbD98LJXBk
 EbtUIbOxxUdouwKCno6WjjHLgFqfw7A6Qn5SubIT+e3ZZjdxmmW0Tc7x84bIDkIm3zZnOkrWFv
 r+v2UhTJPS+uhVrbA+hFUjol
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 16:42:15 -0700
IronPort-SDR: 1lYTOeJ6hca3h4yLMB4UUsB6z4npOuJNaXBvSNl4xb/Hl7evR8pRzElaqk3bKxYurwSjyunj2b
 5CqecmUVmgumrr0v5EBDaAThzE/HQk9e15EyKoXTcWxbMPOCH/xH4C5onOfPy9n7JIVSx7lRPX
 cbbn/ZScVe3HOW9Su12rEtQ+lL3PJlOYR+x9dg2DfSGP+2HJa4pUomYpUj7C4rJvOkkxc/hTA8
 n5aWu6szBRSrjvwVkWwhozBjFNZY+Yl7ZgUuNB8jzA2G7azfIEfOUdXucNnpLrOIL2S+ZqUnGD
 nEI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 17:22:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MpRt63qddz1Rwtm
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:22:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665706957; x=1668298958; bh=sVhzWB6bJ4Xda1JmI82UJgmAYd2X09c+Mfl
        qD/NibXE=; b=fmPjxKj7HqP7bSr4u6/wQXre40p8RobYeqHiB4MWenOb/AL5efD
        qUCl9JZA9dKmNbOFRETfkHyP7K7Ve112eVqoGkZWCVGShGbKzKGldwhDdEDxAZvd
        1ezoR5W6/ZRsMzGy6abAcF4MyodwsVnCBhk2UkrweJGNP1NLOGQ0TWmOycFcGW4y
        OLWjcJpXKH7UxxhEtRGaVfbqeTnDTJoX6Fj7qtv46HeSLJ9xmljuLD916kML7tyW
        m0rmu8oJRO/8I9bppMSTDR5jLP9tB/LAYm0B7FADrS85GPKXNvz1PHWGgSwIevDt
        EHT0JeL4/cG3QTEzVlF3k6KPFgASlQDm1Ew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l_BzAKGEbR0s for <linux-kernel@vger.kernel.org>;
        Thu, 13 Oct 2022 17:22:37 -0700 (PDT)
Received: from [10.225.163.119] (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MpRt36XHsz1RvLy;
        Thu, 13 Oct 2022 17:22:35 -0700 (PDT)
Message-ID: <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
Date:   Fri, 14 Oct 2022 09:22:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sergey.Semin@baikalelectronics.ru
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 07:07, Anders Roxell wrote:
[...]
>> 8)
>>> If reverting these patches restores the eSATA port on this board, then you need
>>> to fix the defconfig for that board.
>>
>> OTOH,
>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
>> device failed to boot.
> 
> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...

As mentioned in my previous reply to Naresh, this is a new driver added in
6.1. Your board was working before so this should not be the driver needed
for it.

> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
> controller support")
> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
> successful.

Which is very strange... There is only one hunk in that commit that could
be considered suspicious:

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 9b56490ecbc3..8f5572a9f8f1 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 static const struct of_device_id ahci_of_match[] = {
        { .compatible = "generic-ahci", },
        /* Keep the following compatibles for device tree compatibility */
-       { .compatible = "snps,spear-ahci", },
        { .compatible = "ibm,476gtr-ahci", },
-       { .compatible = "snps,dwc-ahci", },
        { .compatible = "hisilicon,hisi-ahci", },
        { .compatible = "cavium,octeon-7130-ahci", },
        { /* sentinel */ }

Is your board using one of these compatible string ?

Serge ?
Any idea ?

-- 
Damien Le Moal
Western Digital Research

