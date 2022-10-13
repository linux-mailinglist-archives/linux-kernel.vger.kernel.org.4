Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6978B5FD5B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJMHsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJMHse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:48:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC8E122BE3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665647313; x=1697183313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TW6SOpQjxf8WZxrXeW9B+zZiJfs42MWqJ6VpceHM6xc=;
  b=WtrsBv6Yqda2L4o2juVd+kM78dx/d/ubbM51Z1qJRGON8uCNEWjfV42P
   C8YEdM4lHNT5tt1+sX+OpXtL1dBwnZlZhSmKVsl5hygOVBsETTWjsUxHT
   UQ7GLdwCHkXeNcDdBPUSOsVrv213urwXBzc2E8XJvSlbThKxqNfoW4BUv
   xsndptcWNJKYrVPY5ykLXhu8dlcWQWdgSw14Gt0Hk+paEbT9r+klEm8mm
   IiRMVxpKLiN9cRqkKAY//twiqG/uVMRqFjj4bBbPHAsqDJkDbb28m6M/7
   UWn0X8inbkEsE9mzB6+2xrymLVvPLXHTWKitpZODtIRfFSKnOgwr1+6OV
   w==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661788800"; 
   d="scan'208";a="218866584"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2022 15:48:33 +0800
IronPort-SDR: fL8o9pz4JoZ+/oeUlviJD8QXgQq51Ef9Tb5kpgxUQ4RhYfSD4Vp7iY1OjYYI7ciCSzBl84+Igf
 I6PWU09CvnQQcFenYyGUHn11wCTsICfu0Q/dcCYN3IWDpEfAK25QlMyNG1cxT6k/aynQ5zewbi
 MeXbNXwdsTWG2pRfElDS5Hd8t7mjqdFzV0WM4WCABRq9xDFsjcKBIN1yfoAoPSpAAkLLIA0VV0
 9mGxDlyM8y+DlLSGHEhktNusX6hbix9TI9fXpFAVwEnJPJ+qGR23Ekb4DRwXBDO+pujDOABB5s
 o544kdZmTIxO3uNNVewOsOqY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 00:08:11 -0700
IronPort-SDR: /MTyb5SK1Devk8VmExcPkmpNNKI/CY+9Ln4ZwwuwD2SDkvFeyTQsGDtIxUpacAhtvCeQztfGzr
 L/xjLHjcnIxIq/53IL7dvQ777qwejFiSrS06U74RO/bHQBMp52oGgHGEopPVCHJz06mbILQf6d
 uileSyrr4XCIBWjom4Ij8pqbkp/I0Y/6TiDjPtxp49cWwuYsT1memJuTlmNl9U1zoleBP8LW1r
 Jis1QVw/Q8F/C/aLSaXm6CgHv+VGa7H/pHzm4+R9fB1DLKi4xnZaSaKCX2/1jFBeZOglU+PI+E
 MBU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 00:48:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mp1q522QDz1RvTr
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:48:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665647312; x=1668239313; bh=TW6SOpQjxf8WZxrXeW9B+zZiJfs42MWqJ6V
        pceHM6xc=; b=O1XznsEJI5uxiWZLiyx9twftJFXWvzo8MQP88H6XIKXwRe47gDd
        4+BWjL7JXL60mkkxmQuIOrwDNdq5+5BVJrMCMPWizFh1RPvq276+WG3eyR0Hwv8X
        1APOUdPtqqyLdHNdzNfh55XmST0Sm+flYBFvVyeJqDlUEBJTv5g+CCZ1emDgd9m2
        cuULYJJXQ6XHan4cusFKyq1kEnxLoF4VNaGBcgvi4hwyZcPo7V2vum0F7VOvfJhq
        t9C7V8XdpbLDNaV/rEIKluZBCsxDk0ty5wlzzyzF0vL1OExxo00cd+dtdCRrO7TU
        5PYKFBoWQ9ivxcsAXKwtftD6ceuDxxCRNsA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fML3buQawjGj for <linux-kernel@vger.kernel.org>;
        Thu, 13 Oct 2022 00:48:32 -0700 (PDT)
Received: from [10.89.85.169] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.85.169])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mp1q36JJGz1RvLy;
        Thu, 13 Oct 2022 00:48:31 -0700 (PDT)
Message-ID: <8f9304d0-5f28-7378-626b-d734fa7a39a0@opensource.wdc.com>
Date:   Thu, 13 Oct 2022 16:48:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: drivers/ata/ahci_st.c:229:34: warning: unused variable
 'st_ahci_match'
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202210121422.MJsXaw1M-lkp@intel.com>
 <4517c95f-1dad-5a8c-5202-073d0a7eff29@opensource.wdc.com>
 <4429d1ec-579e-4b0d-a8d8-06b9a5877a9c@app.fastmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4429d1ec-579e-4b0d-a8d8-06b9a5877a9c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/13 16:33, Arnd Bergmann wrote:
> On Thu, Oct 13, 2022, at 8:13 AM, Damien Le Moal wrote:
>> On 10/12/22 15:37, kernel test robot wrote:
> 
>> I am at a loss with this one... There are plenty of patterns similar to
>> drivers/ata/ahci_st.c doing something like:
>>
>> static const struct of_device_id st_ahci_match[] = {
>>
>>         { .compatible = "st,ahci", },
>>
>>         { /* sentinel */ }
>>
>> };
>>
>> MODULE_DEVICE_TABLE(of, st_ahci_match);
>>
>> For instance, in drivers/pwm/pwm-sti.c, we have:
>>
>>
>> And countless others like this for STI and other arch too.
>>
>> So if CONFIG_MODULE is not enabled, how come we are not submerged with
>> warnings about unused variables ? Is mips arch special in this regard ?
>> Or am I missing something ?
> 
> It has nothing to do with MIPS, the problem is
> 
>                 .of_match_table = of_match_ptr(st_ahci_match),
> 
> The 'of_match_ptr()' sets the pointer to NULL when CONFIG_OF is
> disabled, which avoids a build failure when st_ahci_match[]
> itself is in an #ifdef.
> 
> In this driver, there is no #ifdef around st_ahci_match[], so we
> simply want
> 
>                 .of_match_table = st_ahci_match,
> 
> The thing with the MODULE_DEVICE_TABLE() is that it would
> create another reference if CONFIG_MODULE is enabled, but not
> for a built-in driver, so you only get this type of warning
> for randconfig builds that have the driver built-in and OF
> disabled.
> 
> It's a common mistake, and we should probably remove most
> of the of_match_ptr() references as you rarely have drivers
> that optionally use OF support but benefit from compiling
> that support out on kernels without OF.

Got it. Thanks for the info !

Will patch this and check other ata drivers for the same issue.


-- 
Damien Le Moal
Western Digital Research

