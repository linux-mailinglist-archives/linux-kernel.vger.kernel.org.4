Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BEF655351
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiLWRrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiLWRrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:47:20 -0500
X-Greylist: delayed 2301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Dec 2022 09:47:18 PST
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1B1B788
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 09:47:18 -0800 (PST)
X-ASG-Debug-ID: 1671815334-1cf43916c2313940001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id f1OYys6DHxrGcjq4; Fri, 23 Dec 2022 12:08:54 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=2uSPinO9LfjKWSohiabUpBnrYS2Ywe9hn8wsUKvRf8U=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=Bkz25skAKWS2qQL/Iynq
        TFGIpgI5/ATPC3Gtx/D3DJUnzJaw48v3n+A5X6OhMoWST7CCLtQpzR5ZNQ0mZFfaWXROel+cvJ1xX
        Am6fZvt+kSEaGJ74RgwAjCB3PRIn4jWxH8QB9SM79L4xT8kkAEgcV8s0cDyYxElhcDJUYlemLY=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12383131; Fri, 23 Dec 2022 12:08:54 -0500
Message-ID: <d9d58b20-5ce5-ebfd-bcfa-523086b66739@cybernetics.com>
Date:   Fri, 23 Dec 2022 12:08:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCHv2 11/11] dmapool: link blocks across pages
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCHv2 11/11] dmapool: link blocks across pages
To:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@meta.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
References: <20221216201625.2362737-1-kbusch@meta.com>
 <20221216201625.2362737-12-kbusch@meta.com> <Y6XeJ2mzd8p73J93@infradead.org>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <Y6XeJ2mzd8p73J93@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1671815334
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 698
X-Barracuda-BRTS-Status: 1
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/22 11:58, Christoph Hellwig wrote:
> On Fri, Dec 16, 2022 at 12:16:25PM -0800, Keith Busch wrote:
>>  	unsigned int size;
>>  	unsigned int allocation;
>>  	unsigned int boundary;
>> +	size_t nr_blocks;
>> +	size_t nr_active;
>> +	size_t nr_pages;
> Should these be unsigned int like the counters above?

I previously recommended that they should be size_t because they are
counting the number of objects in the entire pool, which can be greater
than 2^32.   See patch 4 "dmapool: cleanup integer types".  However the
kernel test robot has complained that some of the printk format
specifiers need to be changed to match the size_t type.

Tony Battersby
Cybernetics

