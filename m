Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4A6AB1EE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 20:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCETuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 14:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCETuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:50:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF4713532
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 11:50:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cy23so30260465edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 11:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678045834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbruZeRcdIAG55bT23cShTnlfVoJhr8qqbxgS4+29E0=;
        b=KCki8+NNlEGcYR0vBV9DFfHmI67Fi5vp9VdlzjPOHN/4EaHZg20seM1WX60X7bBX1T
         hjxG8XpXuYQ6MxWlQEcejL6CpZLllzBKM0n2kpF+F3MBsECLflYAyP4xoSjfOxsE+Of7
         iwFSHjajd2gB4JqT64VVIQAGGzVgXt7j93/Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678045834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbruZeRcdIAG55bT23cShTnlfVoJhr8qqbxgS4+29E0=;
        b=nIp+rtm5EgDYpiQeDG1IUenrIrRorLy/A3ndmqoKte+18OygC/ARwToOrXkcqWf2S7
         zUtEpjGXpcTqsqV5LOYcIYe6TIFKhT9xK1kwD/QxTBtR1LklftYLxq7BtfDpjrDIYJLz
         3LxJcqrT5SWelDxexEcyhxOUZfBLhBynWGhyQq56CbiRpGt6YQ6zql3Pd7tlvWE9U6fc
         Db5cIWUkHYCarx8SBw/4a+BA0MvPQeFFfav9bh+kEi5VnwK51KUMUOn1CCrgXuLc+ITU
         ZO1XjSPwqssiEUfCKycvlqfrx7brKXzdJAGESh2ZzA5ZUR2UMouL/DbrQUMKLywQWpie
         H0oA==
X-Gm-Message-State: AO0yUKV2KV31ICCgIxYXV25qmhObV6i/S9aM4hfTWV3QfuNGKF9MhFAe
        Jv7YcjC2Hf6+9Dkc1ab/UyKEgFIIbSTttZaGVp6xUg==
X-Google-Smtp-Source: AK7set9u2DkVeL/I8tu5HnZlCX+AAU3pmAwWId/sXnZoO7GVm2fz/oHi8jBb6mdIGrxgpNIV2ALTjA==
X-Received: by 2002:a17:907:1909:b0:8b1:304b:8e2c with SMTP id ll9-20020a170907190900b008b1304b8e2cmr8917730ejc.0.1678045834582;
        Sun, 05 Mar 2023 11:50:34 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id m25-20020a509319000000b004be11e97ca2sm4029054eda.90.2023.03.05.11.50.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 11:50:34 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id u9so30487501edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 11:50:34 -0800 (PST)
X-Received: by 2002:a50:cd94:0:b0:4c2:1a44:642e with SMTP id
 p20-20020a50cd94000000b004c21a44642emr4641203edi.5.1678045833857; Sun, 05 Mar
 2023 11:50:33 -0800 (PST)
MIME-Version: 1.0
References: <167800644191.309766.5757985605946414576.tglx@xen13>
 <CAHk-=whr2KrDkMnQ5pKKxn8nCD718ExKAmPE3TLxkWnjtj6OvA@mail.gmail.com> <87ttyzhtem.ffs@tglx>
In-Reply-To: <87ttyzhtem.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Mar 2023 11:50:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6CNFeiSa5j3BS5z4L+ekLo6-sYZi6YxFVqFVf2viTGw@mail.gmail.com>
Message-ID: <CAHk-=wg6CNFeiSa5j3BS5z4L+ekLo6-sYZi6YxFVqFVf2viTGw@mail.gmail.com>
Subject: Re: [GIT pull] irq/urgent for v6.3-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
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

On Sun, Mar 5, 2023 at 11:47=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> That looks more correct. Let me see what my script zoo managed to get
> wrong this time.

I think your scripts did the equivalent of generating the diffs for
all commits separately, and then feeding that to "diffstat".

That _is_ a kind of real diffstat too.

It's just not the one I get when I pull and compare (since I'll be
using the "end result" diff, not the "commits as separate diffs" one).

                Linus
