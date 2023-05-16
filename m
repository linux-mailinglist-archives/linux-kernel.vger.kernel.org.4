Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BAC704C16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjEPLON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjEPLNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:13:54 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBAD1997
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:13:03 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-3063394ae41so5045296f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684235525; x=1686827525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEUQpMHb6dJRirsjs02VRZsGdmT007slrG/7m3ecq4A=;
        b=jTh2sQy0h/wnTK3qlXXk0iLSLxxkkq3JJYemyleO0akNJycR3xdqBSpFNtuP78sZPH
         q1z/GaeVqh9f2wSvYHQqSuSK7Bnt7Fu3exPaDiHHDDRttWsjp+vLnZlEPiweSaqgYXGs
         w8cnMdF+arz1/vqXlDr6fqPt/uNxzKSj4h15+wWoA70j/0yrHfTLjW5ETXWnsjsuk/Gx
         dkH36a5oiSpgOQuj1kffDVVXxBdYnIH+/IrQ//0LrMqG6OGLj3rCv13LncGf0/iaSpk6
         tgSXGNexxLB2X+dNoIuTwdn2UNfplnB30pKsU61QfAH4pzhHPPxixiGt4jrRPoGXosGM
         L5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235525; x=1686827525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEUQpMHb6dJRirsjs02VRZsGdmT007slrG/7m3ecq4A=;
        b=Lr3MnutjkKas1zbE97Rlo3mkGeyorgHXLmMSysfUe2/8O2z55U/xx8xAYvMPiMYgLn
         5alxSKc2nBTV3ehkcx4WHCUdBGu3RCr7+QxydM4H3lJo0TI06Ek1QTTk1S/a6M9kQusx
         TGjSO3qfTvMHO5pJHPEx4qUWeLk7FNxRlWzJmYEu2T6kGsMo3h9tIkkisiNZBcJo8kGI
         bTfOvOVku08MZLgT8QsKrATlHJf7rWN5U/4zcjt24EzOujnMnmT8GOvAfpPppfn+yCuO
         BZ4r7DWiyVKMo96WwuaeOqgW/nyv/+NxukWD0D/vo7IqUzOxDdzJT/CdzyMjegdwhXUm
         VZOg==
X-Gm-Message-State: AC+VfDyKIwfRZniDHVU1MKjXptCfwVSspF0627BPdx2GDdwbZs5Yjgk1
        vod83M/UlXHJmTIvcPPsPzDG+VnT0CZL9C8=
X-Google-Smtp-Source: ACHHUZ7bk6OwKBPWjNuvpRxLseI+VezMQERmUNQzW8hSrKxmZjJnVMCvYNXDCOS7pg3d6PBqqkO+3Thap10VUM8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a5d:4ac4:0:b0:307:cea0:ee9a with SMTP id
 y4-20020a5d4ac4000000b00307cea0ee9amr2239352wrs.7.1684235525305; Tue, 16 May
 2023 04:12:05 -0700 (PDT)
Date:   Tue, 16 May 2023 11:12:02 +0000
In-Reply-To: <871qjhe9xh.fsf@metaspace.dk>
Mime-Version: 1.0
References: <871qjhe9xh.fsf@metaspace.dk>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516111202.2455529-1-aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: str: add conversion from `CStr` to `CString`
From:   Alice Ryhl <aliceryhl@google.com>
To:     nmi@metaspace.dk
Cc:     alex.gaynor@gmail.com, alice@ryhl.io, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com, yakoyoku@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hindborg <nmi@metaspace.dk> writes:
> Alice Ryhl <alice@ryhl.io> writes:
>> On 5/8/23 13:41, Gary Guo wrote:
>>> On Wed,  3 May 2023 14:10:16 +0000
>>> Alice Ryhl <aliceryhl@google.com> wrote:
>>>> These methods can be used to copy the data in a temporary c string into
>>>> a separate allocation, so that it can be accessed later even if the
>>>> original is deallocated.
>>>>
>>>> The API in this change mirrors the standard library API for the `&str`
>>>> and `String` types. The `ToOwned` trait is not implemented because it
>>>> assumes that allocations are infallible.
>>> How about add a `TryToOwned` trait to the kernel crate and implement
>>> that trait for `CStr` instead?
>>
>> Eh, I don't think it's worth it. It doesn't give anything new to the CStr api,
>> and I think it's rather unlikely that someone will actually need to be generic
>> over such a trait any time soon.
> 
> It is just as valid as having `From<&str>` and `ToOwned<&str>`. While it
> does not add anything in terms of function, it carries intention. I
> think we should consider adding it at some point.
> 
> BR Andreas

Sure, I think its quite reasonable to add new traits, I just don't think
it should be part of this patch. Adding new traits makes it a
significantly bigger change IMO, and my changes have an actual user down
the road.

Alice
