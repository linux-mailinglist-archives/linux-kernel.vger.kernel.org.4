Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7B68D19B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjBGImh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjBGImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:42:36 -0500
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EE41165C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:42:33 -0800 (PST)
X-ASG-Debug-ID: 1675759350-1eb14e7e420af50001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id lk2joHE7hInOTlC7 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 07 Feb 2023 16:42:30 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 7 Feb
 2023 16:42:30 +0800
Received: from [10.29.8.47] (10.29.8.47) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 7 Feb
 2023 16:42:28 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <950c6d27-bc91-01e0-ba26-d09ad4bf7934@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.47
Date:   Tue, 7 Feb 2023 16:42:26 +0800
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
 <Y+DM8BZUi6a10hXY@zn.tnic> <1d808c21-f54d-1506-d95a-0276430aea8d@zhaoxin.com>
 <Y+Dgx7EeRufHdx17@zn.tnic>
From:   silviazhaooc <silviazhao-oc@zhaoxin.com>
In-Reply-To: <Y+Dgx7EeRufHdx17@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1675759350
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1785
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4071 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.104443
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/2/6 19:13, Borislav Petkov wrote:
> Hi Silvia,
> 
> On Mon, Feb 06, 2023 at 06:55:21PM +0800, silviazhaooc wrote:
>> Thanks for your reply.
> 
> You're welcome.
> 
> First of all, please do not top-post when replying on a public mailing
> list but put your reply under the text you're replying to. Like the rest
> of us do.
> 
Sorry, I'm a newbie in Linux. Thanks for your reminding.

>> As I mentioned before, Nano has several series. We cannot test if all of
>> them have the bug.
> 
> If you cannot test if all of them have the bug, then testing the
> stepping as you do is wrong too.
> 
> You need an unambiguous way to differentiate between ZXC and Nano CPUs.
> 
> If steppings >= 0xe belong solely to ZXC, then state that in a comment
> above it so that you can exclude Nano.
> 
> If Nano starts using those steppings later, though, then that check will
> become wrong too.
> 
> So I need a statement: "this is how you detect a ZXC CPU unambiguously"
> and then use that method when enabling PMU support on it and *only* on
> it.
> 
> Makes more sense?
> 
Yes, that makes sense.

I have carefully checked our product manual for Nano and ZXC FMS.

For ZXC, there are 2 kinds of FMS：

1. Family=6, Model=0x19, Stepping=0-3

2. Family=6, Model=F, Stepping=E-F

For Nano, there is only one kind of FMS:

Family=6, Model=F, Stepping=[0-A]/[C-D]

So model = 0xf, steppings >= 0xe or model = 0x19 belong solely to ZXC.
Nano is an old CPU series which has been stopped production several 
years ago. It will not use the steppings which belong to ZXC.This is an 
unambiguous way to differentiate between ZXC and Nano CPUs.

Do I need to add the statements in the source code and re-commit the patch?

Thx.

> Thx.
> 
