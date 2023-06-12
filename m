Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728FD72B873
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjFLHLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFLHLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:11:42 -0400
Received: from out187-24.us.a.mail.aliyun.com (out187-24.us.a.mail.aliyun.com [47.90.187.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D033C1710;
        Mon, 12 Jun 2023 00:06:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047194;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TRlXUqR_1686553395;
Received: from 30.177.51.58(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TRlXUqR_1686553395)
          by smtp.aliyun-inc.com;
          Mon, 12 Jun 2023 15:03:16 +0800
Message-ID: <5469fb25-e88a-b703-c0d9-204f0cbcab91@antgroup.com>
Date:   Mon, 12 Jun 2023 15:03:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/3] Rust scatterlist abstractions
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        <rust-for-linux@vger.kernel.org>
References: <20230610104909.3202958-1-changxian.cqs@antgroup.com>
 <2023061017-usable-bountiful-3f59@gregkh>
 <2023061001-immovable-mongoose-7546@gregkh>
 <37513fcd-b371-cc2f-b7f9-e94b045d8c5c@antgroup.com>
 <2023061257-unbeaten-dropkick-a25c@gregkh>
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
In-Reply-To: <2023061257-unbeaten-dropkick-a25c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 1:38 PM, Greg KH wrote:
> On Mon, Jun 12, 2023 at 11:49:51AM +0800, Qingsong Chen wrote:
>> On 6/10/23 11:35 PM, Greg KH wrote:
>>> On Sat, Jun 10, 2023 at 05:33:47PM +0200, Greg KH wrote:
>>>> On Sat, Jun 10, 2023 at 06:49:06PM +0800, Qingsong Chen wrote:
>>>>> Hi All!
>>>>>
>>>>> This is a version of scatterlist abstractions for Rust drivers.
>>>>>
>>>>> Scatterlist is used for efficient management of memory buffers, which is
>>>>> essential for many kernel-level operations such as Direct Memory Access
>>>>> (DMA) transfers and crypto APIs.
>>>>>
>>>>> This patch should be a good start to introduce the crypto APIs for Rust
>>>>> drivers and to develop cipher algorithms in Rust later.
>>>>
>>>> I thought we were getting rid of the scatter list api for the crypto
>>>> drivers, so this shouldn't be needed going forward, right?  Why not just
>>>> use the direct apis instead?
>>>
>>> See https://lore.kernel.org/r/ZH2hgrV6po9dkxi+@gondor.apana.org.au for
>>> the details of that (sorry I forgot the link first time...)
>>
>> Thanks for the information. I agree that turning simple buffers into
>> sg-bufs is not a good idea. If I were implementing a new cipher
>> algorithm, I would definitely follow the `struct cipher_alg`, which
>> takes simple `u8 *` pointer as parameter. However, if we'd like to
>> utilize some existing ciphers, such as aead, we still need scatterlists
>> to construct an `aead_request` for further operations, util changes are
>> made to the underlying interface.
> 
> Why not make the changes to the C code first, and get those changes
> merged, making this patch series not needed at all?
> 

Yes, you're right. I believe Herbert would work on that. And I would
stop this patch series. Thanks.

Qingsong Chen
