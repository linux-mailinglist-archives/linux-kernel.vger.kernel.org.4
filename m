Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E22B5FA989
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJKBAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJKBAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:00:22 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C3356001
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:00:17 -0700 (PDT)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 29B0xeJD296140
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 10 Oct 2022 17:59:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 29B0xeJD296140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1665449984;
        bh=jN9W6MCQxKZ7dtCMgey7B5sBRu+MXs6/pqlzU4ZY65Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hPdEbBaRC9i6bfJr2YYORID4OBHx2hy+JXc1qQH3RLE+RGs+zi+fGQBbE9iPFNaCc
         UrCWdN8A0OsuWmpiApggbrfXX0tI2KPIqj9GMvYauOUAp2k8ToJzsucg142o5yuS3j
         vXWt45dVjVlaZoH+7KMO60g7aTDqedrjM4A1siG/C7xXZtB1BB0D0IqidoUky6HCbz
         vual3cOUw+SxzJQh/SgcKc0+aN3sdF4u2VoMHMyeD3HReapf/H83t/UvjzKOW6n16y
         UO4NadsKn+Z4m93SfrcOCbqtNJbNdwYlFugneHZisOJtDSs810OHy80ZZdUqzHpD3O
         /PULKqMVubcQA==
Message-ID: <4714a248-d80e-61fb-15a7-62ab247d2fe7@zytor.com>
Date:   Mon, 10 Oct 2022 17:59:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 0/6] Enable LKGS instruction
Content-Language: en-US
To:     Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, peterz@infradead.org
References: <20221010190159.11920-1-xin3.li@intel.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20221010190159.11920-1-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 12:01, Xin Li wrote:
> LKGS instruction is introduced with Intel FRED (flexible return and event
> delivery) specification https://cdrdv2.intel.com/v1/dl/getContent/678938.
> 
> LKGS is independent of FRED, so we enable it as a standalone CPU feature.
> 
> LKGS behaves like the MOV to GS instruction except that it loads the base
> address into the IA32_KERNEL_GS_BASE MSR instead of the GS segment’s
> descriptor cache, which is exactly what Linux kernel does to load user level
> GS base.  Thus, with LKGS, there is no need to SWAPGS away from the kernel
> GS base.
> 
> Changes since V1:
> * place fixup code into code section "__ex_table" instead of the obsoleted
>    "fixup" section.
> 

Correction: __ex_table is NOT a code section (scared me there for a 
second...). With the new fixup handling code EX_TYPE_ZERO_REG takes care 
of all the work, and there simply is no need for any fixup code at all 
(the exception fixup is fully data-driven.)

So I would say "use EX_TYPE_ZERO_REG instead of fixup code in the 
obsolete .fixup code section."

	-hpa
