Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0709D6B84A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCMWQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCMWQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:16:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020378B079
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:16:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so10921070ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678745789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzuY5XzSCC9BatT9usUBHz1ejcIp3clfPSLT8vnz+po=;
        b=TIH/X0Eu+85xfxdVcnFxDvOLme7eyfQuQc/yq9rftgg9f/j28873G3/Srfm+DkTpXD
         7lHGtF6G9gQvlj4mIW8BDHQma0fCc6EOV1XyTMRNiaJlWrAEAPVLNBYDlhDj+D8bIYaK
         +RCWzG4n5s1mqkWxAgTk1LsYFGXqM8bd5X3Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678745789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzuY5XzSCC9BatT9usUBHz1ejcIp3clfPSLT8vnz+po=;
        b=BYwXsfNtJgMjfdDcuUdbKvBA+CvrlxHFxG0oqDKqK2NJo+2v3UBSY7CL3qJSGSNhzL
         e4QHuYjZw57WfYgKmut7nAY8bHkevUulWjG29RBY4uoRompUNinFV1rt/MgwwpCMc1Tb
         UK9wmjG4JKRkZaXTjPgc5Eo/Ij/KGAqnlJ6365o0sib8dz22Nxc4dP5KpTsvCE+Xypnd
         0sq0NL8j9KO9RfdOfAKnsEV7HMl6MDf+ERi6h7bto/QfQpKguWiINApmr5+o6T6Y0prc
         rQFeHVqXuR/IKAf0xF4hLGujx4Q3fGPRc/wBMEV8nMGPQ1w+c7aZRBgn+5yQPgGrfALS
         vkLg==
X-Gm-Message-State: AO0yUKWHXg3+7SNXoXyDGWy4214TROc0EWUa0fIl35HK4n8pGb2TLlOa
        WatU1hQVgE/mf4evnsIsrILW+NFk1bFd3P04aYhz0w==
X-Google-Smtp-Source: AK7set+BIjl4yx7HDDa5owy5vqsTjsfYE+8x3y3iw2x5WW+DtFb9ooKx3mfFJ02hsYsQqUQunS6UWQ==
X-Received: by 2002:a17:906:c2cb:b0:923:6958:edf7 with SMTP id ch11-20020a170906c2cb00b009236958edf7mr102855ejb.23.1678745789075;
        Mon, 13 Mar 2023 15:16:29 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id yz6-20020a170906dc4600b00882f9130eafsm298405ejb.26.2023.03.13.15.16.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 15:16:28 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id r11so3064523edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:16:28 -0700 (PDT)
X-Received: by 2002:a17:906:6d49:b0:88d:64e7:a2be with SMTP id
 a9-20020a1709066d4900b0088d64e7a2bemr38955ejt.15.1678745788062; Mon, 13 Mar
 2023 15:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net> <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
 <fce02d50-65a7-4aa7-8949-6a82321da292@roeck-us.net>
In-Reply-To: <fce02d50-65a7-4aa7-8949-6a82321da292@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Mar 2023 15:16:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVCTJTQPwoLrscmOa+n9X8+bc5ieCD+7PXw35Ke7i6ng@mail.gmail.com>
Message-ID: <CAHk-=wgVCTJTQPwoLrscmOa+n9X8+bc5ieCD+7PXw35Ke7i6ng@mail.gmail.com>
Subject: Re: Linux 6.3-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 1:30=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> It gets weird. Bisect log below. Reverting the identified patch does
> indeed seem to fix the problem, only I have no clue why this might
> be the case. The patch looks completely innocent to me. Yet, I can
> reliably reproduce the problem with v6.3-rc2, but at least so far I
> have not been able to reproduce it with commit f3dd0c53370 reverted
> (and I am trying on five different servers in parallel).

Yeah, that commit looks very innocuous. I'm surprised it would even
change any code generation, but it's very possible that it ends up
affecting some code layout or something almost by mistake.

I'd be inclined to think that the problem is very timing-sensitive,
and has probably been there for a while, and some random moon phase
just made it happen now.

               Linus
