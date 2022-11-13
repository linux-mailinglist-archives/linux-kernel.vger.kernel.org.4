Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633F2626D00
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 01:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiKMAef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 19:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiKMAed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 19:34:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CF610B47
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 16:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=XE1oCfqJOfs2FHdZ2Qk9hMOwWip4dAstO4FN/Ti2yFQ=; b=WOatxRCnU82L+5XSl25dh6pJYy
        LwtkUGp5ZEiyUOGKJVNSveR2j0+OtTz4lNFc8IQIWSDHNrioh3q35KKlSs3KRTQ/jl76YDlvag5CA
        9iLOOTNa1HAssljutvzb5M3KMwMlcB7YEJcl21/lwa1Lt1s0N0LiA5EF6UNxS/I0FNDerzN0gscDP
        QvXe20i5bhFWdBoAegTXLkjyJaPrdLC496pPPN0cyvJ90dz15R96rbzKnM6ELHlwef2kXaa2f759n
        3zvskks87fTcjMezfERzQePRdE0w3EaM5oOq98BEEO4zXFf8ej/2qF9XiYZxJ0pXY90fL35D4LrDz
        swPOEoMw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ou0x2-008YkT-LR; Sun, 13 Nov 2022 00:34:20 +0000
Message-ID: <1df133ef-d5e9-f323-7c67-fc9ffed04274@infradead.org>
Date:   Sat, 12 Nov 2022 16:34:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: include: linux: slab: kmalloc_trace undefined when compiling
 drivers
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <Y2/Luovqgz8O+Kqa@rhino>
 <f83aca33-3a5f-97ac-625e-aa7c72bf60ba@infradead.org> <Y3AXVRAoZA5YEho+@rhino>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y3AXVRAoZA5YEho+@rhino>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/22 13:59, Ian Cowan wrote:
> On Sat, Nov 12, 2022 at 09:21:34AM -0800, Randy Dunlap wrote:
>> Hi--
>>
>> On 11/12/22 08:37, Ian Cowan wrote:
>>> When compiling drivers (speficially drivers/pci/hotplug), I am receiving
>>> the following modpost error for both `kmalloc_trace` and
>>> `kmalloc_node_trace` on the staging/staging-next branch:
>>>

Ian, what do you mean by "on the staging/staging-next branch"?

What kernel version are you trying to build?

The .config that you sent is for v6.1.0-rc1.

>>> ERROR: modpost: "kmalloc_trace" [drivers/pci/hotplug/acpiphp_ibm.ko] undefined!
>>>
>>> This only occurs when I have 'CONFIG_TRACING=y' in my config, and I
>>> have traced it down to the slab header where the kmalloc_trace is
>>> defined. It appears that when CONFIG_TRACING is set, the kmalloc_trace
>>> and kmalloc_node_trace do not get defined by the compiler. I do not have
>>> enough context in this area of the code base to propose a fix or to even
>>> know if maybe it's a local compiling issue for myself. It looks like
>>> there are a few recent commits from August that did some refactoring in this header,
>>> and when compiling prior to that refactoring I am able to compile the
>>> specified drivers without error.
>>>
>>> I will mention that I am using Red Hat gcc version 12.2.1 and make version
>>> 4.3 and am on Fedora.
>> Please post a full failing kernel .config file for this.
>> Thanks.
>>
>> -- 
>> ~Randy
>>
> Below is my .config file. This is pretty much a default Fedora .config
> (copied from my system) with possibly a few additions to make sure the
> modules I needed to compile did compile. I was compiling using the
> command: `make M=drivers/pci/hotplug`.

Sorry, I cannot reproduce the problem.
Hopefully someone else has some ideas.

-- 
~Randy
