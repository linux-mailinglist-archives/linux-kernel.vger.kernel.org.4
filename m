Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5F7220AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjFEIMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFEIMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:12:39 -0400
Received: from out0-220.mail.aliyun.com (out0-220.mail.aliyun.com [140.205.0.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBAA1;
        Mon,  5 Jun 2023 01:12:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047194;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.TLYS.ZU_1685952751;
Received: from 30.177.18.239(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TLYS.ZU_1685952751)
          by smtp.aliyun-inc.com;
          Mon, 05 Jun 2023 16:12:32 +0800
Message-ID: <9c3af5ce-b692-bfe2-4fef-06281d0813eb@antgroup.com>
Date:   Mon, 05 Jun 2023 16:12:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] rust: kernel: add ScatterList abstraction
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "Asahi Lina" <lina@asahilina.net>, <rust-for-linux@vger.kernel.org>
References: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
 <20230602101819.2134194-2-changxian.cqs@antgroup.com>
 <5cbf5dcc-50e2-f6f6-262b-96ac1a8ebc52@gmail.com>
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
In-Reply-To: <5cbf5dcc-50e2-f6f6-262b-96ac1a8ebc52@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/23 3:54 AM, Martin Rodriguez Reboredo wrote:
> On 6/2/23 07:18, Qingsong Chen wrote:
>> +/// # Invirants
>> +///
>> +/// All instances should be valid, either created by the `new` constructor
>> +/// (see [`pin_init`]), or transmuted from raw pointers (which could be used
>> +/// to reference a valid entry of `sg_table`).
>> +///
>> +/// # Examples
>> +///
>> +/// The following is some use cases of [`ScatterList`].
>> +///
>> +/// ```rust
>> +/// use core::pin::pin;
>> +/// # use kernel::error::Result;
>> +/// # use kernel::scatterlist::ScatterList;
>> +///
>> +/// // Prepare memory buffers.
>> +/// let buf0: Pin<&mut [u8]> = pin!([0u8; 512]);
>> +/// let buf1: Pin<&mut [u8]> = pin!([1u8; 512]);
>> +///
>> +/// // Allocates an instance on stack.
>> +/// kernel::stack_pin_init!(let foo = ScatterList::new(&buf0));
>> +/// let mut foo: Pin<&mut ScatterList<'_>> = foo;
>> +/// assert_eq!(foo.length(), 512);
>> +///
>> +/// // Alloccate an instance by Box::pin_init.
>> +/// let bar: Pin<Box<ScatterList<'_>>> = Box::pin_init(ScatterList::new(&buf1))?;
>> +/// assert_eq!(bar.length(), 512);
> 
> This comment has some typos, but luckily there's the `typos` tool [1]
> out there to help us.
> 

I just tried the `typos` tool, but it didn't report any errors. Though, 
I would try other spell checker, with more caution. Thanks.

>> +    /// Obtain a pinned reference to an immutable scatterlist from a raw pointer.
>> +    pub fn as_ref(ptr: *mut bindings::scatterlist) -> Option<Pin<&'a Self>> {
>> +        // SAFETY: `sgl` is non-null and valid.
>> +        NonNull::new(ptr).map(|sgl| Pin::new(unsafe { &*(sgl.as_ptr() as *const ScatterList<'_>) }))
>> +    }
>> +
>> +    /// Obtain a pinned reference to a mutable scatterlist from a raw pointer.
>> +    pub fn as_mut(ptr: *mut bindings::scatterlist) -> Option<Pin<&'a mut Self>> {
>> +        // SAFETY: `sgl` is non-null and valid.
>> +        NonNull::new(ptr)
>> +            .map(|sgl| Pin::new(unsafe { &mut *(sgl.as_ptr() as *mut ScatterList<'_>) }))
>> +    }
> 
> Please mark both of these as `unsafe` as you can still pass an invalid
> pointer to them. Also, if there's no other user of those methods other
> than this module then I'd suggest to make them private.
> 

Those methods are only used by `SgTable` and the iterators by design. 
And it would be better if they were private and marked as unsafe. Thanks.
