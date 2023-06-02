Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD2C71FC1E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjFBIcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjFBIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:32:30 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F63BA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:32:29 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-96f4d917e06so363337466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685694748; x=1688286748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCvZzCkceHQLAgJOLe2xH1CLoNBzC2CyR2ZyQ8lcY28=;
        b=vMeWSqL3Od3di5QPH5Kan+qcApYKF+tB2LUmi5cBJpdaXtIajcgcY82pUCGxV9/E9O
         l83Mia6kVBsNnWW0gUN41tYRkgJuhByMib9C3r3rLzUkhd5czH8LspvHQEIJt8BGG/El
         3wIjVe+m7HziZNlCGORm1zCQoSBxp846WS1T0sSDEyiwufOhu5+H0aPT4m+bnN48QcOP
         mf6gQgXakNuZxlD66VCC7zYACTumfAIRWf42SNIIh9Em5JxCoFThclfGUAlgRoNsC9Mu
         CDA2S83mEM1Jn6zR7QM6ej0NxRGuMJlhffn7/3+qnABZges3Sxykx7RFJ1JJ3QyNbvdF
         PxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685694748; x=1688286748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCvZzCkceHQLAgJOLe2xH1CLoNBzC2CyR2ZyQ8lcY28=;
        b=BrT1TOU4xWn+Ohq91gqeSrOAD+rfMt2rli5x3/Yx9kukHPeutgJTYBBmBux1zdI+Oc
         1TZhtS83QphNkt8nOgN9q0rMDHWollqI/z+c72R07PXPt3sZ0L+N5Q0q1NYaW77MTm/i
         UIx2Coe/gA9GjvoLcICv0mIjvLi4atLo53G5I5hPnUBsNaftsdJDahQ1n2VyqKn6uO0t
         g+7cE/K3qBtqyCUGyjP9LD05SpMHR5D1Y5aQpgtY8VB1KkSyx67Y6gfZ4mZQ6gYcGThG
         oUVB/Ki7Z0jtkxh8dMF26A0HwQW+bHUsBaqcz/Xq7rC0ADExSItfRXuM+XDVXiR5VrpB
         4Xvw==
X-Gm-Message-State: AC+VfDyEOPOYfOsMRPXaClsHMCxJwAdVfcaKz1ciiGpG9NW9UlLWuwVj
        bV87h/JRh2dA0PWk31Kvl3V8KyoYZXCB9zI=
X-Google-Smtp-Source: ACHHUZ6zF59pjH4cZ+4lTs/BOFGMVHIV1FDOPjf1rZP8tce1rNk0I9uT+7UxQeB08cq3R/FFSW8QgcsRPG1tS/Q=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:2cd5:b0:96f:5028:76e3 with SMTP
 id hg21-20020a1709072cd500b0096f502876e3mr1631473ejc.1.1685694748236; Fri, 02
 Jun 2023 01:32:28 -0700 (PDT)
Date:   Fri,  2 Jun 2023 08:32:25 +0000
In-Reply-To: <20230601183002.237a31fa.gary@garyguo.net>
Mime-Version: 1.0
References: <20230601183002.237a31fa.gary@garyguo.net>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602083226.1034597-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 4/8] rust: workqueue: define built-in queues
From:   Alice Ryhl <aliceryhl@google.com>
To:     gary@garyguo.net
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, walmeida@microsoft.com, wedsonaf@gmail.com,
        yakoyoku@gmail.com
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

Gary Guo <gary@garyguo.net> writes:
> On Thu,  1 Jun 2023 13:49:42 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>> 
>> We provide these methods because it lets us access these queues from
>> Rust without using unsafe code.
>> 
>> These methods return `&'static Queue`. References annotated with the
>> 'static lifetime are used when the referent will stay alive forever.
>> That is ok for these queues because they are global variables and cannot
>> be destroyed.
>> 
>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> 
> This looks fine to me, so:
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>
> 
> Just one question about style: would people prefer:
> 
> 	kernel::workqueue::system().enqueue(...)
> 
> or
> 
> 	use kernel::workqueue::Queue;
> 	Queue::system().enqueue(...)
> 
> ?

I prefer the first version.

Alice
