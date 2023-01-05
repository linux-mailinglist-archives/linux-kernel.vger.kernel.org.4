Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCE65F97D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjAFCTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAFCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:19:20 -0500
Received: from omta35.uswest2.a.cloudfilter.net (omta35.uswest2.a.cloudfilter.net [35.89.44.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7411363181
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:19:19 -0800 (PST)
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
        by cmsmtp with ESMTP
        id DZpWp5b9WE9lPDcKEp4ea6; Fri, 06 Jan 2023 02:19:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id DcKDpsr7yvWZODcKDpGuMq; Fri, 06 Jan 2023 02:19:17 +0000
X-Authority-Analysis: v=2.4 cv=do/Itns4 c=1 sm=1 tr=0 ts=63b78525
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=RvmDmJFTN0MA:10
 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8 a=qnK4T_n2zri7Hv_-8ooA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ubigo0rFpxz+YO1pYfYHRyoyOxP8HRuormf/DAHkGT8=; b=GVtyvDDUg6g9jkbBm1QasH/D18
        i7eXkYLcu7fFmi6x5NIbx+Qb43VSxrAlz7idcajozc96I4aqoVzAo07XBntb07TcWrYgY03IQpSzt
        YUsFpyHJGJk7cuij2zADS+IouHY29MI5NrKCSq6ZOKiKop2WAtg8BWvQkLbP1TAvZkwpP3f+fvs1V
        3/tAElOHnWApql6RWG54jiShQwO91OzljlWub17zb3o9Jkj2nXL8mE+VASkx4zZwzBCy+4Z9GGox1
        P006I/34FaqyNx+KUG9Vo/EmBD7LQXwWblrsD6AkfxkvsYStdJSpKMcxnF5w7lRH0qm5FYHmjSh9X
        EXm2FtDg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:43898 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pDZRB-002yOM-6y;
        Thu, 05 Jan 2023 17:14:17 -0600
Message-ID: <ec387c6d-acc7-6696-ba17-bb8792090136@embeddedor.com>
Date:   Thu, 5 Jan 2023 17:14:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] memremap: Replace 0-length array with flexible array
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230105220151.never.343-kees@kernel.org> <Y7dLrdOETjg/+XKq@work>
 <202301051441.C1D7291921@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202301051441.C1D7291921@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1pDZRB-002yOM-6y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:43898
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOPfjiie66Up4DjaD7btZ6tNr6f3mYX8NwQEl/f+ejB/X2f5PdKbqAmUEaQKA2sJX8qNFTWYNPhT1K6cbpnjnWEiWJRTBeS2KjR+D0Z5F7JOLZe4kqzz
 0mLJyeBhKFQjtdAQT5dI37D+/Yhv2Mrv6NqvPX/7nHTvImOEdZnul9P53LGZGbaaKSSgIUxvWbJ7o9my+/jJvCRMiYl4OEscAeiNRv9EPggPHRoiQ8x8lvIR
 KROd0l286qWF5xERDU3cdEYo7ENAoLA8/foojMLN23I=
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/23 16:41, Kees Cook wrote:
> On Thu, Jan 05, 2023 at 04:14:05PM -0600, Gustavo A. R. Silva wrote:
>> I think this is the same patch:
>>
>> https://lore.kernel.org/linux-hardening/YxKO%2FjY1x0xTpl4r@work/
>>
>> It's actually in linux-next.
> 
> Hm, it's been in -next since September? Is this in a tree of yours that
> didn't get pulled for v6.2?

No. I didn't send it. It's just one of the two patches I have in my -next
tree. They didn't look like high priority at the time.

--
Gustavo
