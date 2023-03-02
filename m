Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4754D6A8987
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCBTgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCBTg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:36:29 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D624989D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:36:26 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a25so1671437edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677785784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMpeUvEYrqUYBTl3i4/HldERmQW4oJNrULU8+QHVKzQ=;
        b=XRQVtAupTDdw1py9gAtxHyCxujiE+0pjnM8n745X54LJKMphBhmndVtv/ekhluiK/L
         5p1c0I+GC5dAqhg+Z1bA5TymswtAKRtKsxWugrYK+IDUVXOY14yfcAYqtMouJXCLIR0Q
         cY3ZP1LKZ3dr7jrprQd8YqLw6FWk30WlHRX8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677785784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMpeUvEYrqUYBTl3i4/HldERmQW4oJNrULU8+QHVKzQ=;
        b=ueVclatt4umPnANo786naZPnvv2TZIDKVl3+g0Yopc8LEA5PbsVTuwrPKtF/coy3gU
         JQoSaY1i3fCvkcYskFZnGB2N30yYYO1IutX55QNmoyP+P/sywh/aW/NPh8u6fD8glrLg
         DlwWmiEl4yUYICKPr1tCNMa5sou+PmWnxZCLrxfR4u0RjIGIpVYIoM3KzXU2hVaRvS/3
         F0Y2wc6MlBeBjLnIjm4QgNXm7O1+l+qmUXAWDe2jMpIrYvQoxSCnEJ/zZb0OYdZOxf9p
         m9wjjqf6EH+QS7Sp0SViUN5KqAo9pETriB2KjhVF8Yy/s+CpistfY8PWvZEAxEKO14l3
         XZ1w==
X-Gm-Message-State: AO0yUKU24G/7ln+TYCLH+SfEr36pZKP7/EOtHdzU8V9SUeRoOc8DI0Uw
        mAxvGKTl43JBNon4GbvojChxV8XCbdNTKLYouwo=
X-Google-Smtp-Source: AK7set+Z0nAUIihvWqKC/metVcDmdJJHkvaDGPBfyME0HeVsba6cux020p+cx5yCajKK6xTPO1ILLg==
X-Received: by 2002:a17:906:2348:b0:8e5:c06b:90e9 with SMTP id m8-20020a170906234800b008e5c06b90e9mr11462756eja.50.1677785784627;
        Thu, 02 Mar 2023 11:36:24 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm29605ejf.212.2023.03.02.11.36.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 11:36:23 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id da10so1484036edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 11:36:23 -0800 (PST)
X-Received: by 2002:a50:9e26:0:b0:4af:70a5:5609 with SMTP id
 z35-20020a509e26000000b004af70a55609mr1981413ede.1.1677785783066; Thu, 02 Mar
 2023 11:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20230228132118.978145284@linutronix.de> <20230228132910.991359171@linutronix.de>
 <CAHk-=wjeMbHK61Ee+Ug4w8AGHCSDx94GuLs5bPXhHNhA_+RjzA@mail.gmail.com>
 <87pm9slocp.ffs@tglx> <87bklcklnb.ffs@tglx>
In-Reply-To: <87bklcklnb.ffs@tglx>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 2 Mar 2023 11:36:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=CDyS_ebXw745OCXnhwDpVLnahNveQNcZOPrzE5QiQA@mail.gmail.com>
Message-ID: <CAHk-=wi=CDyS_ebXw745OCXnhwDpVLnahNveQNcZOPrzE5QiQA@mail.gmail.com>
Subject: Re: [patch 2/3] atomics: Provide rcuref - scalable reference counting
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Wangyang Guo <wangyang.guo@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 5:05=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> The result of staring more is:
>
> get():
>     6b57:       f0 41 83 45 40 01       lock addl $0x1,0x40(%r13)
>     6b5d:       0f 88 cd 00 00 00       js     6c30                     /=
/ -> slowpath if negative

[ rest removed ]

Yeah, so this looks like I was hoping for.

That PREEMPT=3Dy case of 'put() makes me slightly unhappy, and I'm
wondering if it can be improved with better placement of the
preempt_disable/enable, but apart from maybe some massaging to that I
don't see a good way to avoid it.

And the ugliness is mostly about the preemption side, not about the
refcount itself. I've looked at that "preempt_enable ->
preempt_schedule" code generation before, and I've disliked it before,
and I don't have an answer to it.

> but the actual network code does some sanity checking:

Ok. Not pretty. But at least it's just an xadd on the access itself,
there's just some extra noise around it.

            Linus
