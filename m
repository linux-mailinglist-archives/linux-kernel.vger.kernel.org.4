Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AEE682B67
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjAaL1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAaL1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:27:02 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4524849951
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675164421; x=1706700421;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g+eI0l2eZSsfEyTQaBq+eFb9OwRPKDkyyazrIopi1gU=;
  b=FbgLHZIw+thbPO+BiG00RzpkRMfCAEX09kPXarXirjX2rQxTytSVOldv
   7N99sJgIWPZgYNC0vSgP6PtTwbpNT5nyMi+m0q1XUg9khiE/VaO5f75ZZ
   L/UlJ9yvqw+VrQFPW0RxY57ZHZx97sUxNOYMw9cPn4rcMBrBkCYTFEJLb
   lz+Nxc/R3ZDcjqQXzC98TX5nQlLXgCPlbmGXE5yHaNykS0vxLpKcFpRdQ
   G3cKBVBxsDMAvfoY+Pec8pQNMNyVxELy8TV1Mw19eJEyhAw146HYDiESD
   lYfYrXNkIvNJ7+uphpbuDseKVB6E9WCH1WaGe1QmoADXFhOzubdEdOI1Q
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,261,1669046400"; 
   d="scan'208";a="326459261"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2023 19:26:58 +0800
IronPort-SDR: xwpLLCtyP8DU4lS8fzsW6TK5HB5YbqPz7BX25zZUlOsM7dveNKCfRwEubWDYNCCN5RpEsvwzvK
 YWiK6wGpS35YbfwhTS9WjYlguahRnsM+bh3pTjOSRHn31qBehsQBxLzqu5gaZHRGurUH14HM1O
 iQnx73oXNEOHksyztEak8HR3sGCJNwu7gYOJc+OPzucOxeCpEkD/O3i1uKoUdOss6sZ+wdgB9f
 VpNL7C2D46WtRLyL6l3iRfHIca/GSWOC9ZQ3cQKBHDSPBXuIn6MAlJ5I8DG2hkxZ93CIQD0/eY
 ZMQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 02:38:39 -0800
IronPort-SDR: ySvtv73CPo95aSqsx+kfdzoNBdiQrdG8yW30V6a/O67s+FY326fFbgzTVnmSsY+PcrKz1gMgNY
 hrXj6LL8288JpZloXOZZc00/OaDlTSlrbVM0Rl/F1/b9ppc7+plRmCZx6x/IOe7uo6/LFjskiL
 DRiehE1CbUVAbf5Q1Hpq9v0Zhj6NNSO50ep23POX8wL+xvClksKntzi29fbZK24fm4JT77yUQ2
 egxqTDaJakmc5xt8UnlcWiM1mL9kDzzDJfLnI/Et2xxS2maQC4+d8WheJ5DYEKVqaTMBCVPqvn
 waE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2023 03:26:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P5jSL3J2kz1Rwt8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:26:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1675164417; x=1677756418; bh=g+eI0l2eZSsfEyTQaBq+eFb9OwRPKDkyyaz
        rIopi1gU=; b=agLOWiw5u4qVxhUwQ5rYn8trhbdD/klVmt4G0Jk+jEJ6sdDRT9i
        j6yxjJsjNiiRLHBzcP+dYhyJX0x8+M/FR2wQitpO9mTxeCWPQSXYqWBVb7wDU2RV
        U2rmhaGbuLzCwvGcKN0f63OXe5ClkgpmHfdhLKiQ8YfcCPODW39/6HExa1Tv8GDh
        8KdGTsq5Q7DiDz+c9gJTNBUOwpbmolwQSlJEUDNNSLUAcvrgbeTVbyk7aBfoqmEi
        DijpE2BP6e+1r2qgmqVpNYWCWvaMcVJP5ruZCGA/iSAe4Vq+8i7gUO8b3ZxH7SSL
        lxcwyb9KPyEt5G/GWeH4aWgr0HMcmXIBoUw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aOMx77UcEG7A for <linux-kernel@vger.kernel.org>;
        Tue, 31 Jan 2023 03:26:57 -0800 (PST)
Received: from [10.225.163.70] (unknown [10.225.163.70])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P5jSJ5Zryz1RvLy;
        Tue, 31 Jan 2023 03:26:56 -0800 (PST)
Message-ID: <d8d117bf-4ab1-3473-85e2-00f1b1a85cba@opensource.wdc.com>
Date:   Tue, 31 Jan 2023 20:26:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] libata: clean up some inconsistent indenting
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230131085431.30549-1-jiapeng.chong@linux.alibaba.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230131085431.30549-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 17:54, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/ata/pata_serverworks.c:443 serverworks_init_one() warn: inconsistent indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3905
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/ata/pata_serverworks.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
> index c0bc4af0d196..c6bd9e95d4e8 100644
> --- a/drivers/ata/pata_serverworks.c
> +++ b/drivers/ata/pata_serverworks.c
> @@ -434,10 +434,9 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
>  		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
>  		 (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
>  
> -		 /* If the returned btr is the newer revision then
> -		    select the right info block */
> -		 if (rc == 3)
> -		 	ppi[0] = &info[3];
> +		/* If the returned btr is the newer revision then select the right info block */

Very long line. Please make that a proper multi-line comment.
And the patch title should be:

ata: pata_serverworks: clean up indentation

> +		if (rc == 3)
> +			ppi[0] = &info[3];
>  
>  		/* Is this the 3rd channel CSB6 IDE ? */
>  		if (pdev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)

-- 
Damien Le Moal
Western Digital Research

