Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3366D6A9D81
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCCRWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjCCRWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:22:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6F51CAE8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:22:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s11so13126941edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677864125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP7vTNKcPM1bVXDUg5anR387ZbgL2nhOAlAGlClVsjk=;
        b=KmF3NDGZSwRMe7+f5y/y0k5l0SjiOKYiBKLgWjsV8/77Uh9jMFfjhBTnukLpembo8m
         CNx7ncqmHewiP6g3BUFcFn6Rc/LW60ePAeRU0Lb09xaBOVldkAN1Wxr24nlfJiUrE2J7
         zlF/UQ8axdqiaHUMzaxmiCFnj8HH1tyKeJ86U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677864125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP7vTNKcPM1bVXDUg5anR387ZbgL2nhOAlAGlClVsjk=;
        b=jXhi3koWpOKt0zI+QcUGrQ4SDEouaOpnbrVUMkKM72X8AWJ0xMBpYB68NwteXpX5z/
         5T0zqRd1QOcEqQ3CTnxD7ePnF4/jZdcW4yUPgAwB9AXDKvxt25ZA87g5qd0t/AoR4i5Z
         weMMwFgo7HsopyUnYhzZnCFTdrvbPCegV2TauIHpBNkB39NE1ub0LaS6HFAe57bFwdbn
         WbTfOaj8f7y86Aq1Xu6/QtXFh5+LKdhhz3IyiP6/+2Jbiy2nQAc/7mUhWuEYHHnUhuHs
         tt+2azve5Ha72JGJdZDYO0wt981LxNL0GsJB+1jO0g5TJpzVtQhsJ+ldxV97kRMWpfp1
         wvRA==
X-Gm-Message-State: AO0yUKV9/sMT/n2bi1q5Tah36+zh0d7TcReRWc6Asl/EhFOL+TnL0N88
        VS51iyzstjXFkXy4rQgy2+Ll2tqP86oQdkxEdlvwWg==
X-Google-Smtp-Source: AK7set+EPwf03nJiaOQpOw/7c6KZpOPvw3zZTDEXT7AYnww2TEDwqEmVHNUjtiavfLaukZmObEoWLw==
X-Received: by 2002:a17:906:8d86:b0:8b1:22af:b39f with SMTP id ry6-20020a1709068d8600b008b122afb39fmr2578850ejc.13.1677864124868;
        Fri, 03 Mar 2023 09:22:04 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id j22-20020a1709066dd600b008e6bd130b14sm1165611ejt.64.2023.03.03.09.22.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:22:04 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id d30so13220475eda.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:22:04 -0800 (PST)
X-Received: by 2002:a50:9fa8:0:b0:4ae:e5f1:7c50 with SMTP id
 c37-20020a509fa8000000b004aee5f17c50mr1557108edf.5.1677864123991; Fri, 03 Mar
 2023 09:22:03 -0800 (PST)
MIME-Version: 1.0
References: <2023030300024180930d7a@mail.local>
In-Reply-To: <2023030300024180930d7a@mail.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Mar 2023 09:21:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjCw+NLkLcjbh9e=Pk1mV1A65m5nTTj-g7FB=Hasa3HLw@mail.gmail.com>
Message-ID: <CAHk-=wjCw+NLkLcjbh9e=Pk1mV1A65m5nTTj-g7FB=Hasa3HLw@mail.gmail.com>
Subject: Re: [GIT PULL] RTC for 6.3
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Mar 2, 2023 at 4:02=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> I had to merge rtc-6.2-fixes that you already have to apply the last two
> patches.

Please people... Explain hat in the *merge* message too.

Now we have yet another merge with absolutely zero explanation for it.

Repeat after me: merges are commits too, and need an explanation.
Sometimes they need *more* explanation than regular commits, because
they are subtler than regular commits.

If you cannot be bothered to explain  your merge, then DO NOT DO IT.

             Linus "repeating myself" Torvalds
