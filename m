Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEB9723852
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjFFHBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjFFHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:01:40 -0400
Received: from out0-211.mail.aliyun.com (out0-211.mail.aliyun.com [140.205.0.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D86E53;
        Tue,  6 Jun 2023 00:01:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.TMWy1uV_1686034891;
Received: from 30.177.52.182(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TMWy1uV_1686034891)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 15:01:32 +0800
Message-ID: <fe4744bb-17db-6f60-4b8c-1453009ef11a@antgroup.com>
Date:   Tue, 06 Jun 2023 15:01:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] rust: kernel: add ScatterList abstraction
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "Asahi Lina" <lina@asahilina.net>, <rust-for-linux@vger.kernel.org>
References: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
 <20230602101819.2134194-2-changxian.cqs@antgroup.com>
 <ZH3+jARBbn2iG1dW@Boquns-Mac-mini.local>
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
In-Reply-To: <ZH3+jARBbn2iG1dW@Boquns-Mac-mini.local>
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

On 6/5/23 11:26 PM, Boqun Feng wrote:
> On Fri, Jun 02, 2023 at 06:18:17PM +0800, Qingsong Chen wrote:
> [...]
>> +impl<'a> ScatterList<'a> {
>> +    /// Construct a new initializer.
>> +    pub fn new(buf: &'a Pin<&mut [u8]>) -> impl PinInit<ScatterList<'a>> {
>> +        // SAFETY: `slot` is valid while the closure is called, the memory
>> +        // buffer is pinned and valid.
>> +        unsafe {
>> +            init::pin_init_from_closure(move |slot: *mut Self| {
>> +                (*slot).set_buf(buf);
>> +                (*slot).mark_end();
> 
> Benno can provide more information, but you cannot dereference or create
> a reference to `*slot`, since `slot` points to an uninitialized object
> (see `try_pin_init` implementations), and referencing uninitialized
> objects is UB (or may cause UB).

I understand that `reading` from uninitialized objects is UB, either
via references or raw pointers. But in this unsafe closure, we just do
the `writing` job to `slot` for initializing. This makes me a little
confused, why is there a difference between reference and raw pointer?
Is there any compiler magic on reference which may cause UB? Still, I
would fix this by `addr_of`. Thanks.
