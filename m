Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB9268BAD1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBFKzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBFKza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:55:30 -0500
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4A07EE0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:55:28 -0800 (PST)
X-ASG-Debug-ID: 1675680924-086e230463018d0001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id Loq46L1VPrZGv2FY (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 06 Feb 2023 18:55:24 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 6 Feb
 2023 18:55:23 +0800
Received: from [10.29.8.47] (10.29.8.47) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 6 Feb
 2023 18:55:22 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <1d808c21-f54d-1506-d95a-0276430aea8d@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.47
Date:   Mon, 6 Feb 2023 18:55:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
To:     Borislav Petkov <bp@alien8.de>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <silviazhao@zhaoxin.com>, <tonywwang@zhaoxin.com>,
        <kevinbrace@gmx.com>, <8vvbbqzo567a@nospam.xutrox.com>
References: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
 <Y95hWVFyw7TM1WSB@zn.tnic> <51ab21ee-403b-f4ce-9a7e-2580ab7e8118@zhaoxin.com>
 <Y+DM8BZUi6a10hXY@zn.tnic>
From:   silviazhaooc <silviazhao-oc@zhaoxin.com>
In-Reply-To: <Y+DM8BZUi6a10hXY@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1675680924
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1455
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4995 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.104401
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thanks for your reply.

As I mentioned before, Nano has several series. We cannot test if all of 
them have the bug. Besides, AFAIK Nano's hardware support for PMC has 
not externally announced. So setting a new X86_BUG_ flag to Nano is 
inappropriate.

I still think exclude PMC support in driver is more appropriate.

Looking forward to your comments.


On 2023/2/6 17:48, Borislav Petkov wrote:
> On Mon, Feb 06, 2023 at 04:26:25PM +0800, silviazhaooc wrote:
>> Due to our company’s email policy, email address with oc suffix is used for
>> sending email without confidentiality statement at the end of the mail body.
>>
>> I will remove –oc from my name later.
> 
> Yes, please. The email address is fine but the name doesn't have to have
> that funky "-oc" thing.
> 
>> But due to some unknown historical reasons, the FMS of Nano and ZXC are only
>> different in stepping.
>>
>> I have considered about using the “Model name string” to distinguish them,
>> but it doesn't seem to be a common way in Linux kernel.
> 
> I don't mind you using steppings to differentiate the two as long as
> this is not going to change all of a sudden and that differentiation is
> unambiguous.
> 
> If not, you will have to use name strings as you don't have any other
> choice.
> 
> Whatever you do, pls define a new X86_BUG_ flag, set it only on Nano and
> then test it in the PMU init code.
> 
> Thx.
> 
