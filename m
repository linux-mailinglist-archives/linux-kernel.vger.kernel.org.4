Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28A641998
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 23:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiLCWuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 17:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLCWuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 17:50:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713851DF1C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 14:50:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A79F60C94
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 22:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FB6C43147
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670107811;
        bh=dx6i/zBU0ZeE6IVzzhxnvcG/T5ZK/6cVLN8A6gKBAIg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hiZpKaTHtcLBdst55X3naUv/ClQHZ2BdUxGzuJRGTVMWhuCLxN913I0WbfEOw28LQ
         ZX+DHCRTnE+lLS5czSOtX5Fgcay9LdjulUN0LK3X8eVMM6Q/b3NjnqmVr5QIkLtK4F
         yCXadkL+rKLUlskBP3MZ9+hqukUAXq4R/A+8SWEYbOQu9HhEI7fEUSIhqqDDobrN7A
         gH2phXjsOpPjjstuMQyDhwsp/nlkSzYnpXYox7KEhSsCnevvB3LjfWD9bb7KkvHROQ
         btMlseOHA8ME9Splkm/iliED3Ymt/1xY59hLKqAON28JDb+8HR2BTJZrTFrlIKFExb
         rjqv4bHAwt6DA==
Received: by mail-ed1-f49.google.com with SMTP id d20so11044179edn.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 14:50:11 -0800 (PST)
X-Gm-Message-State: ANoB5pkub7TzEPYVVBUif9XZyVzyNaC5G+31bzy/eFF5bKswVCOKmvOr
        QgO93yHkvX04D2fWdtTH7SV1cBVdnEBkRe50nUvOig==
X-Google-Smtp-Source: AA0mqf6IMKgvOHkA5/c+9soSeuwZRc+52Mb9yRpznfgn0cMyx+TzFtyUF1PqLc7pfmdr25nJCy6wV1Whkg3Cmb9CDSY=
X-Received: by 2002:a05:6402:3c1:b0:46b:2d74:d970 with SMTP id
 t1-20020a05640203c100b0046b2d74d970mr26185821edw.138.1670107809384; Sat, 03
 Dec 2022 14:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com> <20221203003606.6838-34-rick.p.edgecombe@intel.com>
In-Reply-To: <20221203003606.6838-34-rick.p.edgecombe@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 3 Dec 2022 14:49:34 -0800
X-Gmail-Original-Message-ID: <CALCETrVMY4UadSrn3fTim5iCzPVf+XXnkyq57wjvnhVUNV1V5w@mail.gmail.com>
Message-ID: <CALCETrVMY4UadSrn3fTim5iCzPVf+XXnkyq57wjvnhVUNV1V5w@mail.gmail.com>
Subject: Re: [PATCH v4 33/39] x86: Prevent 32 bit operations for 64 bit shstk tasks
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 4:44 PM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>

> So since 32 bit is not easy to support, and there are likely not many
> users. More cleanly don't support 32 bit signals in a 64 bit address
> space by not allowing 32 bit ABI signal handlers when shadow stack is
> enabled. Do this by clearing any 32 bit ABI signal handlers when shadow
> stack is enabled, and disallow any further 32 bit ABI signal handlers.
> Also, return an error code for the clone operations when in a 32 bit
> syscall.
>

This seems unfortunate.  The result will be a highly incomprehensible
crash.  Maybe instead deny enabling shadow stack in the first place?
Or at least pr_warn_once if anything gets flushed.
