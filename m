Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA4973F79B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjF0ImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjF0ImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:42:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D2A109
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:42:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb2fae9b286so5444079276.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687855325; x=1690447325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RESTY0nSCfW0d4KcpyLv7Xpk29hSjI3Ckc6/VSjxn4=;
        b=c8XIlf+3aeJrwWjkv8WOhdxbRUqNtzu1r7xryqM84sNDaZTz0rgtwU4fwyvKCSfw+V
         cKwotcy9WmTSkSA1D35NIYW2q7BOtu5c2MlZafkFnYXgxrZCjgbF9WsxmNh34B0ieWP0
         n18tsAHbC/T8dPO8Fb06HV8eCH69k2z2f+HMDJSfW2yzR5ZoKM2M579qULNi9NxPkqBx
         thT8eC5DbFnBcnhsvE8Ha+gDP29RFRwPs2RLoebi29W2qg5Hdi/ZoLZHJx4YOspsEYOE
         jAhmj3bjEW8ADu4jA5WKxCOS0fptUboAd0uNfBw+rJHKHjX/SfxEZ7SlBZtkaws7MISj
         u5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687855325; x=1690447325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RESTY0nSCfW0d4KcpyLv7Xpk29hSjI3Ckc6/VSjxn4=;
        b=J8yQMGPBQIPfwDYo4GVktOvintrGVHkmhBZW21whJ9Og34LJ3uphlKOYHa670kcaXY
         LBJa1wfhPnyu/CnCERMjb3/Ga/bWbQLYXK7HhNrnIvsMPFXcYmFL4Pe0dFRfgEisIFuT
         ik+X1iQg6z/13Pc0XqiRNH2EQYkoLouE227ODAfyd2BC3KUNeNW03kmIaNSADNO3mK6Y
         IWk439gU7OebE4W7ScPwfSUi5ldwMBXioenq6whRMzdnnYXUojaEXgWRb+TFwbAt/Mer
         ypAz6fkpEHhg8NkrDpuv7P8c9/Q7RsbUxqBn3yxxkeGPfGUB8tjvfnzwjMZX4btdWjG6
         ePWg==
X-Gm-Message-State: AC+VfDygTBzakOEn8eUO8zsythP1zdRiGF/KQ5Dj3+9AJu7BPvBH0jcR
        rYwilOl8T/MtekP4JRyBe4d20PF0fvIICrw=
X-Google-Smtp-Source: ACHHUZ5iOX9ZQJ8FlpbvB37RDLgsinU8s6WO100emwe5lWg59GuLkFcVXvVuPSp2u0spSRurCuI1z9UcFOaU4po=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:6988:0:b0:c1d:4fce:460 with SMTP id
 e130-20020a256988000000b00c1d4fce0460mr2519491ybc.4.1687855325036; Tue, 27
 Jun 2023 01:42:05 -0700 (PDT)
Date:   Tue, 27 Jun 2023 08:42:02 +0000
In-Reply-To: <sEZfLlqyui7bU5IsD7mRZq4wIsJqQ5ZZj4qtp6oq-d8rEu4Gx1rp6MXwxTsZt4zEaO7V-5HtmmULgwpVArU4DW-9UcZsjWYg0a5pojvAlVQ=@proton.me>
Mime-Version: 1.0
References: <sEZfLlqyui7bU5IsD7mRZq4wIsJqQ5ZZj4qtp6oq-d8rEu4Gx1rp6MXwxTsZt4zEaO7V-5HtmmULgwpVArU4DW-9UcZsjWYg0a5pojvAlVQ=@proton.me>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627084202.1738047-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 5/8] rust: workqueue: add helper for defining
 work_struct fields
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
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

Benno Lossin <benno.lossin@proton.me> writes:
> On 01.06.23 15:49, Alice Ryhl wrote:
>> +/// # Safety
>> +///
>> +/// The [`OFFSET`] constant must be the offset of a field in Self of type [`Work<T, ID>`]. The methods on
>> +/// this trait must have exactly the behavior that the definitions given below have.
> 
> I think you should just say "implementers are not allowed to implement
> the functions defined by this trait." I see no reason to allow that, since
> all functions are fully determined by the `OFFSET` constant.
 
The macro overrides one of the methods, so that wont work.
(It overrides the method to check that the field has the claimed type.)

I'll apply the rest of your suggestions.

Alice

