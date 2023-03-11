Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9741A6B6085
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 21:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCKUb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 15:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 15:31:57 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763B46505A;
        Sat, 11 Mar 2023 12:31:55 -0800 (PST)
Received: from [192.168.1.103] (31.173.84.174) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 11 Mar
 2023 23:31:47 +0300
Subject: Re: [PATCH 11/32] parport_pc: add 16-bit and 8-bit fast EPP transfer
 flags
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
CC:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, <linux-block@vger.kernel.org>,
        <linux-parport@lists.infradead.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230307224627.28011-1-linux@zary.sk>
 <20230307224627.28011-12-linux@zary.sk>
 <460ae7d7-a12d-cef3-4343-ac633e15016f@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6933a0fe-012d-d0e4-78e5-e651ab5f80a0@omp.ru>
Date:   Sat, 11 Mar 2023 23:31:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <460ae7d7-a12d-cef3-4343-ac633e15016f@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.84.174]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 03/11/2023 20:21:22
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 176022 [Mar 10 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 507 507 08d345461d9bcca7095738422a5279ab257bb65a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.84.174 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.84.174 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.84.174
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/11/2023 20:23:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/11/2023 6:14:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 11:09 PM, Sergey Shtylyov wrote:

>> PARPORT_EPP_FAST flag currently uses 32-bit I/O port access for data
>> read/write (insl/outsl).
>> Add PARPORT_EPP_FAST_16 and PARPORT_EPP_FAST_8 that use insw/outsw
>> and insb/outsb (and PARPORT_EPP_FAST_32 as alias for PARPORT_EPP_FAST).
>>
>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>> ---
>>  drivers/parport/parport_pc.c | 20 ++++++++++++++++----
>>  include/uapi/linux/parport.h |  3 +++
>>  2 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
>> index 5784dc20fb38..eda4e4e6d4e8 100644
>> --- a/drivers/parport/parport_pc.c
>> +++ b/drivers/parport/parport_pc.c
>> @@ -298,9 +298,15 @@ static size_t parport_pc_epp_read_data(struct parport *port, void *buf,
>>  		}
>>  		return got;
>>  	}
>> -	if ((flags & PARPORT_EPP_FAST) && (length > 1)) {
>> -		if (!(((long)buf | length) & 0x03))
>> +	if ((length > 1) && ((flags & PARPORT_EPP_FAST_32)
>> +			   || flags & PARPORT_EPP_FAST_16
>> +			   || flags & PARPORT_EPP_FAST_8)) {
> 
>    Why not:
> 
>> +		if ((flags & PARPORT_EPP_FAST_32)
>> +		    && !(((long)buf | length) & 0x03))
>>  			insl(EPPDATA(port), buf, (length >> 2));
>> +		else if ((flags & PARPORT_EPP_FAST_16)
>> +			 && !(((long)buf | length) & 0x01))
>> +			insw(EPPDATA(port), buf, length >> 1);
>>  		else
>>  			insb(EPPDATA(port), buf, length);
>

   Oopsie, s/th went wrong while editing... :-/

[...]

MBR, Sergey
