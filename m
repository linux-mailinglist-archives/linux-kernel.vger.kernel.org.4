Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBF86A648E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCABHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCABHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:07:31 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86902ED76
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:07:30 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d30so47636237eda.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677632849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA/g+K3G8Gm+uzhNLjPprz2bSCPjjGvaQ1drgLyoaRU=;
        b=fdIxUEH4d/wjWWPjRtPs6wIlWomZnPOlNx28xq//Fshqp32lkdwSTb4JgmwaMLuMf3
         hP7y3+Z8QxMW9i/e98/hxeVrq2XyP0mQX04tmQNaR2e+LmhAGpgY8hm7+kXwZFDSoyUO
         q9943JQowyb/DcTe/lafIMcVEKxImy49FhyAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677632849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GA/g+K3G8Gm+uzhNLjPprz2bSCPjjGvaQ1drgLyoaRU=;
        b=3oA2jLZ/eaHqhZcf83lv1wAk+AR50OQTjqfJ9DTHW87p7Gokz1Br+dejApzus9dP9E
         +fvliE1xFFN8lNANQgwwwlH27l/nsC3vLzu4Y1uFkqivIWwYqMXsaBpVRDLjLem9okm9
         8OY7x8+uolgA0cFFSANApApWKgLal++SWWnL1Y02na6V4MKMFw9Oe9+oi0fE7680vCr7
         qnDqtLeuo3lZYe9yY75QNckPKrWA11683we8YCDN1FZv8Oc1mtDJu4P7+gMtnxBuZq6+
         0HnxcYtBg8Q3zlru+AXoKlqC29Mhr7pSs4+aePSwMG5uZRh4fjgG4mPSU/CL6kIa1nSd
         8HPw==
X-Gm-Message-State: AO0yUKVpK60SzNQAjIul2OROTJ+01ztsahMEqK/kN50uR+OFb5Vf4mm4
        LZVOpWgkbJFrRWYRuibEhOKGwuG/difYYOyi5ME=
X-Google-Smtp-Source: AK7set+/Fg1tLHlBHt46wMIUk9ar5VF5mAzQgMeCMnRFxuXDUTxzKr0bBNY4VRDwpFOr9cwunxeCeQ==
X-Received: by 2002:aa7:cc0e:0:b0:4ab:4d3c:7e99 with SMTP id q14-20020aa7cc0e000000b004ab4d3c7e99mr4672243edt.2.1677632848577;
        Tue, 28 Feb 2023 17:07:28 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906854600b008d4df095034sm5166174ejy.195.2023.02.28.17.07.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 17:07:28 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id eg37so47436986edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 17:07:28 -0800 (PST)
X-Received: by 2002:a17:906:c08c:b0:8f1:4cc5:f14c with SMTP id
 f12-20020a170906c08c00b008f14cc5f14cmr2345984ejz.0.1677632847945; Tue, 28 Feb
 2023 17:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20230228132118.978145284@linutronix.de> <20230228132910.991359171@linutronix.de>
 <CAHk-=wjeMbHK61Ee+Ug4w8AGHCSDx94GuLs5bPXhHNhA_+RjzA@mail.gmail.com>
In-Reply-To: <CAHk-=wjeMbHK61Ee+Ug4w8AGHCSDx94GuLs5bPXhHNhA_+RjzA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 28 Feb 2023 17:07:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGA91ca02-J0ebAnCE1wA_=Q35MiFz4ONo3Zw76uFxNQ@mail.gmail.com>
Message-ID: <CAHk-=wiGA91ca02-J0ebAnCE1wA_=Q35MiFz4ONo3Zw76uFxNQ@mail.gmail.com>
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

On Tue, Feb 28, 2023 at 4:42=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> And yes, that may mean that it should have some architecture-specific
> code (with fallback defaults for the generic case).

Another reason for architecture-specific code is that anybody who
doesn't have atomics and just relies on an LL/SC model is actually
better of *not* having any of this complexity.

In fact, the Intel RAO instruction set would likely do that on x86
too. With that alleged future "CMPccXADD", there likely is no longer
any advantage to this model of rcuref.

Now, I don't know when - if ever - said RAO instruction set extension
comes, but I'd hope that the new scalable reference counting would be
ready for it.

             Linus
