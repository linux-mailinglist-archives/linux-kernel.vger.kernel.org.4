Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE66B3BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjCJKTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCJKTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:19:45 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4452B69CC1;
        Fri, 10 Mar 2023 02:19:38 -0800 (PST)
Received: from [192.168.1.103] (178.176.75.58) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Fri, 10 Mar
 2023 13:19:29 +0300
Subject: Re: [PATCH 04/32] pata_parport-bpck6: pass around struct pi_adapter *
To:     Ondrej Zary <linux@zary.sk>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, <linux-block@vger.kernel.org>,
        <linux-parport@lists.infradead.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230307224627.28011-1-linux@zary.sk>
 <20230307224627.28011-5-linux@zary.sk>
 <6040658f-990f-8cca-eabb-09e97e09c547@omp.ru>
 <202303092158.50217.linux@zary.sk>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d9e601b1-8689-a438-de2d-481839ec6e97@omp.ru>
Date:   Fri, 10 Mar 2023 13:19:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <202303092158.50217.linux@zary.sk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.75.58]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 03/10/2023 09:59:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 176004 [Mar 10 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 507 507 08d345461d9bcca7095738422a5279ab257bb65a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.58 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.58
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/10/2023 10:02:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/10/2023 7:05:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/23 11:58 PM, Ondrej Zary wrote:
[...]

>>> Remove Interface typedef, pass around struct pi_adapter * down to all
>>> functions instead. Remove PPCSTRUCT define.
>>>
>>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>>    I had some nit tho -- see below...
>>
>> [...]
>>
>>> diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
>>> index fa1f7d4fe3cb..bc128a2c444e 100644
>>> --- a/drivers/ata/pata_parport/bpck6.c
>>> +++ b/drivers/ata/pata_parport/bpck6.c
>> [...]
>>>  static void bpck6_connect(struct pi_adapter *pi)
>>>  {
>>> +	struct ppc_storage *ppc = (void *)(pi->private);
>>
>>    Parens around pi->private are unnecessary here and elsewhere...
>>
>> [...]
>>> diff --git a/drivers/ata/pata_parport/ppc6lnx.c b/drivers/ata/pata_parport/ppc6lnx.c
>>> index 5e5521d3b1dd..f12bb019fc61 100644
>>> --- a/drivers/ata/pata_parport/ppc6lnx.c
>>> +++ b/drivers/ata/pata_parport/ppc6lnx.c
>> [...]
>>> @@ -101,26 +101,27 @@ typedef struct ppc_storage {
>> [...]
>>>  //***************************************************************************
>>>  
>>> -static int ppc6_select(Interface *ppc)
>>> +static int ppc6_select(struct pi_adapter *pi)
>>>  {
>>> +	struct ppc_storage *ppc = (void *)(pi->private);
>>
>>    Parens around pi->private are unnecessary here and elsewhere...
> 
> Yes, missed that. But it's "fixed" in patch 9 by removing this code :)

   Yeah, saw that later... Nevermind then. :-)

MBR, Sergey
