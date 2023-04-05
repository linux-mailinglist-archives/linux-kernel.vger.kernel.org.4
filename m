Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AFC6D83AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjDEQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDEQ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:29:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971D2173E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:29:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so142533283edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680712172; x=1683304172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQpmkrukxD+353BntikJkYNT/bA711Va7HsLI05KtRc=;
        b=dQksIU9PE6HszHKvLD+ogeImYLBH1cY4sRxqbWwybPd61NZnajLYAKGbUHNabcPTDK
         MwGIzKuX7dDXq0rSuiIQDpbDPf8y8FaI5rx9oLh0mqgFnamtlkSNtG4VESjl/dSplTqF
         Rfnx1Srj4uPfep4y8+TuhI/pM3NdEqpL/KHho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712172; x=1683304172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQpmkrukxD+353BntikJkYNT/bA711Va7HsLI05KtRc=;
        b=sOnhBHljqz+ksZPhztopRbturcZG23QRaaZr+3elPDXWWXNIj8kQBX/4SGGHytMrCJ
         IHVTZQQG6JVj1zMJbuQxQBbbbYUEdGqo4BlfGPdnnIRaa4IxZkoCLXEPrFi8PieBaLme
         popfPAFT2XsTuv/n3wA2PjmaGRElb8gY04fLo1hqY8N7Argu3W80IQCKgAxJDz3SG953
         35Dni53/WaDEYiZinwLxqRYCHtmF++RltATKMzG1kbwVVYi/l4XOAy4hfzpiAeuooIRq
         6tu9j9BNHJCvkjnr1nNrW1WNMBfiJk0j797Tw9acCjbXqkXxN+6chItc44u0EeJR6hAn
         2YdQ==
X-Gm-Message-State: AAQBX9ceMkD/xY/6k6ZF7F6ZvmlJPm7z4SeKTEHv4TOtPcFare/6Rvv9
        dq+1iW6qE+e9zUFAN5+cDjpfIKGDsjIeC8hcTCJR7Q==
X-Google-Smtp-Source: AKy350YChMJQ4oxUITzwdx7FKEE7cu1/CB0/BH/BKeCUxBH7oY8ojSgxmJEQwVWE+ClEOv3XbMuz0A==
X-Received: by 2002:a17:906:138a:b0:920:7a99:dcd4 with SMTP id f10-20020a170906138a00b009207a99dcd4mr3602610ejc.62.1680712171902;
        Wed, 05 Apr 2023 09:29:31 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm7564269edj.79.2023.04.05.09.29.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:29:31 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id ew6so142410137edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 09:29:31 -0700 (PDT)
X-Received: by 2002:a17:906:7e05:b0:932:da0d:9375 with SMTP id
 e5-20020a1709067e0500b00932da0d9375mr1892812ejr.4.1680711806400; Wed, 05 Apr
 2023 09:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230405022702.753323-1-mcgrof@kernel.org> <20230405022702.753323-6-mcgrof@kernel.org>
 <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
 <ZC2cC+I1KTyD8UcC@bombadil.infradead.org> <ZC2dtI02ZIbjte2l@bombadil.infradead.org>
In-Reply-To: <ZC2dtI02ZIbjte2l@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Apr 2023 09:23:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGhHk4u2RRZmJinA4Apb47pXXJPW9cOZ_2-yUqOvaC7Q@mail.gmail.com>
Message-ID: <CAHk-=wiGhHk4u2RRZmJinA4Apb47pXXJPW9cOZ_2-yUqOvaC7Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for atomic64_t
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 9:11=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> Oh but I don't get the atomic incs, so we'd need debugfs_create_atomic_lo=
ng_t().

No, you misunderstand what I meant.

Just use "atomic_long_t" in the module code.

But then the debugfs code should do

        debugfs_create_ulong(... &val->counter ..);

to expose said atomic_long values.

No need for new debugfs interfaces.

Because "atomic_long" is just a regular "long" as far as plain
read/set operations are concerned - which is all that the debugfs code
does anyway.

So I think you can do something like

  atomic_long_t total_mod_size;

   ...

  debugfs_create_ulong("total_mod_size",
       0400, mod_debugfs_root,
       &total_mod_size.counter);

but I didn't actually try to compile that kind of version.

(I think "counter" is actually a _signed_ long, so maybe the types don't ma=
tch).

               Linus
