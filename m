Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0391659C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiL3UdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3UdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:33:23 -0500
Received: from 1.mo552.mail-out.ovh.net (1.mo552.mail-out.ovh.net [178.32.96.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B941BEBA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:33:21 -0800 (PST)
Received: from mxplan6.mail.ovh.net (unknown [10.109.146.51])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 2521C2B0CD;
        Fri, 30 Dec 2022 20:15:56 +0000 (UTC)
Received: from jwilk.net (37.59.142.104) by DAG4EX1.mxp6.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 30 Dec
 2022 21:15:55 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-104R005e5696247-8558-4316-907d-20674b30cbbf,
                    61162F1CAD51C30F4082BD59ECF03BCF2A04D20D) smtp.auth=jwilk@jwilk.net
X-OVh-ClientIp: 5.172.255.8
Date:   Fri, 30 Dec 2022 21:15:54 +0100
From:   Jakub Wilk <jwilk@jwilk.net>
To:     <oss-security@lists.openwall.com>
CC:     <linux-man@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <20221230201554.xborkqi2x5dvnh6h@jwilk.net>
Mail-Followup-To: oss-security@lists.openwall.com,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y6SJDbKBk471KE4k@p183>
 <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca>
 <tog7cb$105a$1@ciao.gmane.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <tog7cb$105a$1@ciao.gmane.io>
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG3EX2.mxp6.local (172.16.2.22) To DAG4EX1.mxp6.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 964eb37d-b66c-4350-8a99-ebd663178077
X-Ovh-Tracer-Id: 5114681804795926493
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrieeigddufeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfhfgggtuggjihesthdtredttddtvdenucfhrhhomheplfgrkhhusgcuhghilhhkuceojhifihhlkhesjhifihhlkhdrnhgvtheqnecuggftrfgrthhtvghrnhepuedttdetlefhffduvdehgfefudejledtkeehudevkeekleefudeuvdegjedufffgnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhifihhlkhesjhifihhlkhdrnhgvtheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepohhsshdqshgvtghurhhithihsehlihhsthhsrdhophgvnhifrghllhdrtghomhdplhhinhhugidqmhgrnhesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedvpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tavis Ormandy <taviso@gmail.com>, 2022-12-28 01:50:
>>>But, really, I just don't see how this can practically be said to be 
>>>parsable...
>>
>>In its current form it never will be.  The solution is to place this 
>>variable-length field last.  Then you can "cut -d ' ' -f 51-" to get 
>>the command+args part (assuming I counted all those fields correctly 
>>...)
>>
>>Of course, this breaks backwards compatability.
>
>I think that cut command doesn't handle newlines,

Indeed.

>There already is 'ps -q $$ -o >comm='

FWIW, "ps ... -o comm=" doesn't just print the raw comm value: it 
replaces non-printable chars with punctuation characters, and it may 
append " <defunct>" if the process is a zombie.

The easiest way to get unmangled comm is to read it from 
/proc/$PID/comm, then strip the trailing newline.

(But I suspect most /proc/*/stat parsers don't care about the comm field 
at all; they just want to skip over it to get their hands on the 
following fields.)

-- 
Jakub Wilk
