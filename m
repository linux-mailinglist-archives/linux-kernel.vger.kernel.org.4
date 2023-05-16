Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B5705AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjEPWr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEPWr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:47:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9976619B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:47:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684277274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BtkrSYxnuRq6fiYCIde637D8KY4d2NVOuzHNW7z0qFg=;
        b=YFYIkcto9cPds9qu96Ubj5+T/w+4IEqS9GqLheJM3JbElVLAh7rNwB/NGbGMN0uqwjNMV3
        gmJuyQ5pdbswYubgo332tN7gA8Qf6e4WGIIh0OskJ4P+egADvoNKvWfFwIfPI3JrGxyZOV
        fmUdF5DEBgGHrVV/x/VhpZR65p0eTNElsIe9unk7WFqMC8RyQ09kaV41A/ZJBGaSeS2Z0M
        KA83fx7LJl7ryiDa6h67QclG2E0YY/sdJZZ9c2kRwTN6XhbCpmMEzlJ82FcThDuGva2jnc
        U91IH+Qjc2Ia7VIWBqUUjrXVj9TdPf1R1cXCKLTueYnwWy4sEN3+IvzgGxC6Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684277274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BtkrSYxnuRq6fiYCIde637D8KY4d2NVOuzHNW7z0qFg=;
        b=nsnm3oFCOawHhI4D325r12isohSzO7y7xFjeebthE/ujyb8RB6nsbKoGoDRm/ZyDN73O3t
        Ot00+4+38JbvFVDQ==
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: your mail
In-Reply-To: <20230515192708.sypitem5hzycdois@revolver>
References: <87mt2cxb7y.ffs@tglx> <20230515192708.sypitem5hzycdois@revolver>
Date:   Wed, 17 May 2023 00:47:53 +0200
Message-ID: <875y8r7v1i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15 2023 at 15:27, Liam R. Howlett wrote:
> * Thomas Gleixner <tglx@linutronix.de> [230510 15:01]:
>> The documentation of mt_next() claims that it starts the search at the
>> provided index. That's incorrect as it starts the search after the provided
>> index.
>> 
>> The documentation of mt_find() is slightly confusing. "Handles locking" is
>> not really helpful as it does not explain how the "locking" works.
>
> More locking notes can be found in Documentation/core-api/maple_tree.rst
> which lists mt_find() under the "Takes RCU read lock" list.  I'm okay
> with duplicating the comment of taking the RCU read lock in here.

Without a reference to the actual locking documentation such comments
are not super helpful.

>> Fix similar issues for mt_find_after() and mt_prev().
>> 
>> Remove the completely confusing and pointless "Note: Will not return the
>> zero entry." comment from mt_for_each() and document @__index correctly.
>
> The zero entry concept is an advanced API concept which allows you to
> store something that cannot be seen by the mt_* family of users, so it
> will not be returned and, instead, it will return NULL.  Think of it as
> a reservation for an entry that isn't fully initialized.  Perhaps it
> should read "Will not return the XA_ZERO_ENTRY" ?
>>
>> - *
>> - * Note: Will not return the zero entry.
>
> This function "will not return the zero entry", meaning it will return
> NULL if xa_is_zero(entry).

If I understand correctly, this translates to:

  This iterator skips entries, which have been reserved for future use
  but have not yet been fully initialized.

Right?

>> @@ -6487,9 +6493,14 @@ EXPORT_SYMBOL(mtree_destroy);
>>   * mt_find() - Search from the start up until an entry is found.
>>   * @mt: The maple tree
>>   * @index: Pointer which contains the start location of the search
>> - * @max: The maximum value to check
>> + * @max: The maximum value of the search range
>> + *
>> + * Takes RCU read lock internally to protect the search, which does not
>> + * protect the returned pointer after dropping RCU read lock.
>>   *
>> - * Handles locking.  @index will be incremented to one beyond the range.
>> + * In case that an entry is found @index contains the index of the found
>> + * entry plus one, so it can be used as iterator index to find the next
>> + * entry.
>
> What about:
> "In case that an entry is found @index contains the last index of the
> found entry plus one"

Still confusing to the casual reader like me :)

    "In case that an entry is found @index is updated to point to the next
     possible entry independent whether the found entry is occupying a
     single index or a range if indices."

Hmm?

Thanks,

        tglx
