Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51452703F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbjEOVQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245496AbjEOVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:16:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4934A5C1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:16:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684185372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZHhrNE+lQbMd0iIV/PZ3+/ZDJKPK1+e6kKnPQuIdO4=;
        b=mjIcxdOMt117Z/QHUdcxvAHXIzHvqhmCiIOD4xmpVwTwKEFP3bAbA4CeE0Rbf7q97sD5xa
        XT5sPi25X90ACLaZuBUj533X3Gof2ZS+mkXZNl3+nGiDJy5Kxx71nsbfFeOn0UCx2gvHZr
        bowCkjef4fchr61EnWxh1gz2NK8ot5IByR204y7wZY966ZtDpEx7jKYbsjeBUvhMLBL1B/
        26Tr9LWuCQhQG06+xDS+u6Bn1jfRFhMeGO1F3R/QLLegky7enBvgqwzgRUqPCvLUdyozhT
        MrX4wCGrt2CwEEh1vKnNwG+ytq9epy97LtAeaEXtw1fs2LPN4GYU/rRfO+cUHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684185372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZHhrNE+lQbMd0iIV/PZ3+/ZDJKPK1+e6kKnPQuIdO4=;
        b=mIWjKwOGTdaUTvRCsI5Y8rW11BO2lZGkbtLM/DOu1MtM/HOODl+KJnMyb5AEdyu4eunqr4
        QNdFSjbS7c4xzpCg==
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: your mail
In-Reply-To: <20230515192708.sypitem5hzycdois@revolver>
References: <87mt2cxb7y.ffs@tglx> <20230515192708.sypitem5hzycdois@revolver>
Date:   Mon, 15 May 2023 23:16:11 +0200
Message-ID: <87wn198fdw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liam!

On Mon, May 15 2023 at 15:27, Liam R. Howlett wrote:
> * Thomas Gleixner <tglx@linutronix.de> [230510 15:01]:
>>Also the
>> documentation of index talks about a range, while in reality the index
>> is updated on a succesful search to the index of the found entry plus one.
>
> This is a range based tree, so the index is incremented beyond the last
> entry which would return the entry.  That is, if you search for 5 and
> there is an entry at 4-100, the index would be 101 after the search -
> or, one beyond the range.  If you have single entries at a specific
> index, then index would be equal to last and it would be one beyond the
> index you found - but only because index == last in this case.

Thanks for the explanation

>> 
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

That makes actually sense.

>> --- a/include/linux/maple_tree.h
>> +++ b/include/linux/maple_tree.h
>> @@ -659,10 +659,8 @@ void *mt_next(struct maple_tree *mt, uns
>>   * mt_for_each - Iterate over each entry starting at index until max.
>>   * @__tree: The Maple Tree
>>   * @__entry: The current entry
>> - * @__index: The index to update to track the location in the tree
>> + * @__index: The index to start the search from. Subsequently used as iterator.
>>   * @__max: The maximum limit for @index
>> - *
>> - * Note: Will not return the zero entry.
>
> This function "will not return the zero entry", meaning it will return
> NULL if xa_is_zero(entry).

Ack.

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

Something like that, yes.

Let me try again.

Thanks,

        tglx
