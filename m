Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4046E98DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjDTP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjDTP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:57:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3210B;
        Thu, 20 Apr 2023 08:57:09 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33KFuN5p076111;
        Thu, 20 Apr 2023 10:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682006183;
        bh=eA6xMuLyhPVGtL8UDWOL6E2qJ/1uFYQBafDZUPTdxi0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=zIfgIEYsz22Ou9E/lr6T4FaCmKp0BjdLUO9Kl3YeJhfrig/NnEeG8xeI28m0O6tR2
         PpjCiyCH3/0tT3na8VsdGnNEdP3hiYGFpqGU5fLjGp7sqTN0jVBSO9iE8fHQ9mSxsS
         BRqkaibLEAz0wq7Hx8xhELGViaAj5pYCgfXda0BM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33KFuNtd068948
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Apr 2023 10:56:23 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 20
 Apr 2023 10:56:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 20 Apr 2023 10:56:23 -0500
Received: from [10.250.35.77] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33KFuMvn072033;
        Thu, 20 Apr 2023 10:56:22 -0500
Message-ID: <db9182f5-b070-0504-ccd1-8ff427ae85ee@ti.com>
Date:   Thu, 20 Apr 2023 10:56:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] serial: 8250_exar: Add support for USR298x PCI Modems
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230413214421.6251-1-afd@ti.com>
 <20230413214421.6251-2-afd@ti.com> <ZEEkGzoemaSgKovK@kroah.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <ZEEkGzoemaSgKovK@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 6:38 AM, Greg Kroah-Hartman wrote:
> On Thu, Apr 13, 2023 at 04:44:21PM -0500, Andrew Davis wrote:
>> Possibly the last PCI controller-based (i.e. not a soft/winmodem)
>> dial-up modem one can still buy.
>>
>> Looks to have a stock XR17C154 PCI UART chip for communication, but for
>> some reason when provisioning the PCI IDs they swapped the vendor and
>> subvendor IDs. Otherwise this card would have worked out of the box.
>>
>> Searching online, some folks seem to not have this issue and others do,
>> so it is possible only some batches of cards have this error.
>>
>> Create a new macro to handle the switched IDs and add support here.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/tty/serial/8250/8250_exar.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
> 
> Please redo this without patch 1/2 as that would not make sense to
> backport anywhere, but adding new device ids are allowed in stable
> kernels.  Also, as others pointed out, either convert them all or none
> :)
> 

Fair enough, posting v2 with only the second patch now.

Thanks,
Andrew
