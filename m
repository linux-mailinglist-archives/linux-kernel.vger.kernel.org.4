Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9387E65B308
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjABOBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjABOBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:01:20 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4BA6547;
        Mon,  2 Jan 2023 06:01:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D46B941DF4;
        Mon,  2 Jan 2023 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672668076; bh=8Kw1GfAUqQ8QmT3lnjcfvmkDIJ1W2AProGSJuYR3RcQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ffpA6x+2RCfk2WgOZ8kPqXz8PQ+g/Ovn6QhPSDJltuOjDK5oozX3eyz7hoDPtqQcb
         PuTJ644YLic+aP4xlKlSFktCtlASKbtCLGeimd6rz+pBIe/X04tUj6DOzzq22h4Mu6
         VpNDpJp+to0Jc6O58JmErS9t1pWi9Ru3y0M0XYyi09VCH8Dt1HCi53B0hiG/ks0thX
         hHvy7Td7qTHsLfY0WbLF7MILLu0s7Gon64uFWZEDs1v9BugsG+zE9GETkfjy6qyQoQ
         3CwlEx53MS8N/b0qfB5jRmNcWegZKcV0bdQDkR9tlwyB1Pah5gk4JkXr4ebpmiUYJW
         ddfW9whnyiZ4A==
Message-ID: <6e204026-d102-6d81-f58b-f4340e7d07ac@marcan.st>
Date:   Mon, 2 Jan 2023 23:01:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/4] brcmfmac: Support 89459 pcie
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Aditya Garg <gargaditya08@live.com>
Cc:     Ian Lin <ian.lin@infineon.com>,
        "alep@cypress.com" <alep@cypress.com>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        "brcm80211-dev-list@cypress.com" <brcm80211-dev-list@cypress.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "Double.Lo@infineon.com" <Double.Lo@infineon.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
References: <20220922104140.11889-1-ian.lin@infineon.com>
 <20220922104140.11889-3-ian.lin@infineon.com>
 <3eb9cc12-db75-8042-4106-fa6521c684a7@marcan.st>
 <6D6035D7-894B-44F6-B35A-3EC9C57029B5@live.com>
 <91c8fc96-083d-74b7-3015-e76f1ab59cec@broadcom.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <91c8fc96-083d-74b7-3015-e76f1ab59cec@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 22.58, Arend van Spriel wrote:
> On 1/2/2023 10:45 AM, Aditya Garg wrote:
>> Hi Hector
>>
>>>
>>> Is the CYW89459 just a rebrand of the BCM4355, or just a subset? If it
>>> is a rebrand, it's okay if we call our Apple firmware
>>> brcmfmac89459-pcie* (note that we use per-board firmware names, so it
>>> wouldn't conflict with a generic one). However, if CYW89459 only refers
>>> to specific variants, I think the firmware should be named after the
>>> overall bcm4355 family.
>>>
>>> I'm guessing you intend to ship firmware for this. Would that firmware
>>> work for all 4355 variants, or only the CYW one? If only the CYW one, is
>>> it possible to differentiate between them based on PCI revision ID? Note
>>> that our 4355 has revision ID 12, and Apple specifically calls it 4355C1
>>> (different chip revisions have different firmware builds, which is why I
>>> named our firmware brcmfmac4355c1-pcie). If the CYW variant uses other
>>> revision IDs that do not overlap, maybe we should have different
>>> firmware entries for them with different masks.
>>
>>
>> Can we make a separate table for the OTP Apple chips, something like here :-
>>
>> https://github.com/AdityaGarg8/linux/commit/fc41aac9283d2ba653a8b3191e8c0138c13d8ee1
> 
> I do not understand from this email thread why you would need separate 
> tables. Can you explain?
> 

I think he's proposing we special-case Apple chips into their own
firmware table just to avoid colliding with non-Apple firmware usage,
which is honestly kind of tempting as the safe option if nobody from the
Broadcom/Cypress side is willing to clarify what, exactly, is the
relationship between these chips and what their respective revision
numbers are so we can *correctly* represent them and avoid further
confusion and problems down the line.

You might be able to help with that ;)

- Hector
