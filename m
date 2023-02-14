Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9473A6955FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjBNBd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjBNBd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:33:28 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69EF4238
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676338406; x=1707874406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6O0cKiof/xhZj67mC+vtf+PEcWgOhr6C3UqDaX253AU=;
  b=ZtElqt8rArRhtvkVf2hNO8h4jmnovSnwR5cyL1Yfx5iUP1cmSbbttyig
   85aXXQEY5UbPEZkKkL36IXi2F3PgF5IPAbNJADOAz6zsgnMQIDnUzPFPK
   /jahUHUmtFXKxYYracjkBtOWXMnB75JZxzhrHz3kN03Os00xHzgHZGflL
   0kr6hrCQWbfJfiXywYovBYqz1b127VqKks6nruxKxDx5CaQBDMZxbpSX4
   9WGVRJ589KF5p/99tZiwbuQQqrlWxKSXU2TVtQ6y5Z5eNDaQQmwcCwC37
   unlsgIWFzSgInD9FraTpMNngWLb4vM4nyFMENp9AFY4S97gyNU30RYK0L
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="223249309"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 09:33:25 +0800
IronPort-SDR: hkl3w7mxzrTxYsU1zqED1wbMTuPf8TKMg/0K38RtBHfKmg8Rq3ICuYkkBhcQRdjTaii2rg4Bfb
 psd9KJGva5Pg+CDdg8w1iP8bsnqD23oaOCjb+z0dbzQc4cCzlnaEIHSu3EcV8146ug2In7okDy
 huRJfpwJlPwLthZLRlS4+wloFSmS0tH++txvyK8HB2wDUETclkoKcyQrxjvwDb+SYL2fnyd6cf
 VK2808Gv4BWfC+BPv+4UNY2DAAgXMWHDrzota5uYIWU35GNHwdzUvvHCeVmEKjVXMkRFuWDGKt
 O6s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 16:50:34 -0800
IronPort-SDR: voyC81FWCS3kc4D+Ne35IZYnPK/yg2nAr3OXhWRLjB86NUa1xBqQrursQEXhNOsFOuIEXSqnVL
 XCPT/y1KfHAT6m7jmRR/7KCm0Y4EeUQzqOBH/dX0ivNEFfEuUXsj5G9WHno42Ta4LTk253FmAA
 98ky74XN8fUJeF75Wp5HXa+1dWfn651H3ET24BnL+Owe1f6MPPcVKPg9CtEJId29mrop+befd/
 haTVwyUYlP3ql7Dn58yotuL8uI8mNUnOgiNJA+cW3eddlPYrWPhLRrVUXDjtO1MF3qtnF8p4ap
 eac=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 17:33:25 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PG3d15909z1RvTr
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:33:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676338405; x=1678930406; bh=6O0cKiof/xhZj67mC+vtf+PEcWgOhr6C3Uq
        DaX253AU=; b=dVGgCOL8MI0ix9REakmGSKKN0VY0iIig3sG6tbi9NK0TuFA50At
        m2b/PGDUCKY1W/uLkoH84nv8oKLGfS0xu8kiL0SkFHSolRX81+xTPDfs78joCd7D
        6zY94TUAL/F3KUudyXjs+Fu1cyKkS+bgYR0pU65MZt2r7JkXGgnCkV7e5E/ur6gG
        fHi7m/DKGzghHRN++8NeuJ8QYIyIZY2/LZmjhzndRoucFLiuWghCW6GxZUFQZ/7g
        hYwJS8l5Yr88v5ODtRjY3NHXZP0aag9Cz23hAvRWjHvqt4ra7WKlvczOe5ghLeZy
        VomkDlMPi0B3nszWtPq8WC5IWKKKHwCoHHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Br5xwAMj3xfX for <linux-kernel@vger.kernel.org>;
        Mon, 13 Feb 2023 17:33:25 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PG3d04hy0z1RvLy;
        Mon, 13 Feb 2023 17:33:24 -0800 (PST)
Message-ID: <b7626a3c-cf6b-45a2-0342-3bafa8090dcf@opensource.wdc.com>
Date:   Tue, 14 Feb 2023 10:33:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ata: libata-core: Disable READ LOG DMA EXT for Samsung
 MZ7LH
To:     Patrick McLean <chutzpah@gentoo.org>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <20230210215151.812839-1-chutzpah@gentoo.org>
 <dce110de-649d-cde8-9401-346675c95263@opensource.wdc.com>
 <20230213121745.2847a9ff@moya.linuxfreak.ca>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230213121745.2847a9ff@moya.linuxfreak.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 05:17, Patrick McLean wrote:
> On Sat, 11 Feb 2023 12:11:48 +0900
> Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
> 
>> On 2/11/23 06:51, Patrick McLean wrote:
>>> Samsung MZ7LH drives are spewing messages like this in to dmesg with AMD
>>> SATA controllers:
>>>
>>> ata1.00: exception Emask 0x0 SAct 0x7e0000 SErr 0x0 action 0x6 frozen
>>> ata1.00: failed command: SEND FPDMA QUEUED
>>> ata1.00: cmd 64/01:88:00:00:00/00:00:00:00:00/a0 tag 17 ncq dma 512 out
>>>          res 40/00:01:01:4f:c2/00:00:00:00:00/00 Emask
>>>          0x4 (timeout)
>>>
>>> Since this was seen previously with SSD 840 EVO drives in
>>> https://bugzilla.kernel.org/show_bug.cgi?id=203475 let's add the same
>>> fix for these drives as the EVOs have, since they likely have very
>>> similar firmwares.
>>>
>>> Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
>>> ---
>>>  drivers/ata/libata-core.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index 2ea572628b1c..c4c89d24f84c 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -4045,6 +4045,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>>  	{ "Samsung SSD 870*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>>>  						ATA_HORKAGE_ZERO_AFTER_TRIM |
>>>  						ATA_HORKAGE_NO_NCQ_ON_ATI },
>>> +	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>>> +						ATA_HORKAGE_ZERO_AFTER_TRIM |
>>> +						ATA_HORKAGE_NO_NCQ_ON_ATI, },
>>>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>>>  						ATA_HORKAGE_ZERO_AFTER_TRIM },
>>>    
>>
>> Looks OK, but ATA_HORKAGE_NO_NCQ_ON_ATI is for PCI vendor ID 1002h. AMD
>> also has vendor ID 1022h. Did you check you adapter vendor ID & tested
>> this patch ?
> 
> We tested this patch, and it resolves the problem for us (we have been
> using it for several months).

OK. Thanks for confirming. Will apply in a little while. Thanks !

> 
>> -- 
>> Damien Le Moal
>> Western Digital Research
>>
> 
> 

-- 
Damien Le Moal
Western Digital Research

