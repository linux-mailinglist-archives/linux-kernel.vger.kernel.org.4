Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD14C66E52B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjAQRqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjAQRp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:45:26 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ADC53F93
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:35:22 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p66so15234765iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=prNnNsy5T4xsGuSVCbHAoEeKQx9E2Oycb0EFwKlDuO8=;
        b=cBXaoSjv+haWHr24w4kmz0KG5HEm76xSSB94stcm2gzSbvIQWrxVUPu/ybPXmVDqw+
         sWSz470KzDgVRCuSsXdGDl8U5o99BT8waqFmlR72/cTKlpgRz6UnLNxqQ7r7Nx4RHePN
         a8Dk5piW3FOS3mk9DurMYeox+YIRIzoIW/vTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prNnNsy5T4xsGuSVCbHAoEeKQx9E2Oycb0EFwKlDuO8=;
        b=xKPbQiDvPsfT0fR84GwUTLHFnBLJU0xYjCDM09nfbjZsIoHYLAmduYQil2LlM3nOak
         ormoEpQ3SWa4OmI3zHH66D3BjKMrVCxAamx6tVCvnByJUKUqpE9Xbb5g1CyYfvEdCWwb
         iGWGE720XC5nlz96UruUtHLsLzpPWv84jhBL30GHRlUW9reHJE4rdlS+OlV1zmZNNIOl
         WmO2ow0jiqP+FglBbOEAWxtPQerDsuxRZoxcsfYvt89mpCPsS9sF11X5XnsenKtoJEyz
         AGQvGqp1g6NpHJdycHgReShOq13JoqcHUVaDCeAHTEJs3VpRVx36iSaRg/JYTnr27vnV
         cVBA==
X-Gm-Message-State: AFqh2koHH+h62kIYNvDYxdTFa48F/p2cGXmLbbfZa7U0BKfD58r5iaJP
        Q2ZOx75s4NQs2IUrxyJiCP+joWcc7ycTjN3k
X-Google-Smtp-Source: AMrXdXsp9GSrctrHvSL+4drkKRKhClbPjEUfJGdajrGOGkmxfv0TFjMDJlJ94SQwMBqJIPU11uVKXw==
X-Received: by 2002:a05:6602:368e:b0:704:6e73:d9af with SMTP id bf14-20020a056602368e00b007046e73d9afmr19065749iob.15.1673976921265;
        Tue, 17 Jan 2023 09:35:21 -0800 (PST)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id d16-20020a6b6810000000b006de73a731dbsm10485401ioc.51.2023.01.17.09.35.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:35:21 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id i70so5999441ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:35:21 -0800 (PST)
X-Received: by 2002:a05:620a:99d:b0:705:efa8:524c with SMTP id
 x29-20020a05620a099d00b00705efa8524cmr178735qkx.594.1673976555002; Tue, 17
 Jan 2023 09:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
 <20230111123736.20025-9-kirill.shutemov@linux.intel.com> <Y8adEg2CYUSVpwtk@hirez.programming.kicks-ass.net>
 <20230117135703.voaumisreld7crfb@box> <Y8a4bmCU9wsenvvF@hirez.programming.kicks-ass.net>
 <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiwiA7FdSww9fTg59r5S7G-DZHtzAcq9u5zBJKYXc1agQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jan 2023 09:28:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4HUBvCvfX3oZLZAZTzPc2vdwsObFqnOsQ-UZrdzm_rQ@mail.gmail.com>
Message-ID: <CAHk-=wj4HUBvCvfX3oZLZAZTzPc2vdwsObFqnOsQ-UZrdzm_rQ@mail.gmail.com>
Subject: Re: [PATCHv14 08/17] x86/mm: Reduce untagged_addr() overhead until
 the first LAM user
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        ndesaulniers@google.com, joao@overdrivepizza.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 9:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The reason clang seems to generate saner code is that clang seems to
> largely ignore the whole "__builtin_expect()", at least not to the
> point where it tries to make the unlikely case be out-of-line.

Side note: that's not something new or unusual. It's been the case
since I started testing clang - we have several code-paths where we
use "unlikely()" to try to get very unlikely cases to be out-of-line,
and clang just mostly ignores it, or treats it as a very weak hint. I
think the only way to get clang to treat it as a *strong* hint is to
use PGO.

And in this case it actually made code generation look better,
probably because this particular use of static_branch_likely() is a
bit confused about which side should be the preferred one.  It's using
the static branch to make the old case not have the masked load, but
then it's saying that the new case is the likely one.

So clang ignoring the likely() hint is probably the right thing here,
and then the wrong thing in some other places.

              Linus
