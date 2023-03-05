Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF36AB229
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 21:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCEUxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 15:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCEUxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 15:53:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A53D50A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 12:53:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678049610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsnxCpYSUmMI8cQO5Nys4/oa3XU33gGwNfZbpaRDCH8=;
        b=wLMJCUqMQ+6x4VM9+1o/dBRVa9Z+VfBJ9VbajwATHkIqU4NPCZ5TwuT+RrssWSz/b7A6J7
        LU4wX3MCBNOelSpDZT4a4qUMwY8dDw4UOe03Y1iipSp+RDsDyP4bGp/fsB72ggyG8N6GPg
        s3VZpFDFCwOXnwjEmWGdZGIPhT/dUZYNqgiANp/bkPr/YUGbHmg6CJf4zrDC5kfy9Mewby
        NV7n6+G8A83FTXsSXRRlFc6Vhdxsbav+INZslTjPk6tw43/fPoIatoPAWcX6xQ1OnEJkRQ
        N27yURWSwPJZlP1sCvhwlclcNL8POVSd3itEkDoYBI4oELOETgZBMVGPkV9vig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678049610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsnxCpYSUmMI8cQO5Nys4/oa3XU33gGwNfZbpaRDCH8=;
        b=xpAkDszNcxYmHYeoGMcPKBLQlTSwFIl7pH1dMt3D7WGeuljqYZaFho+tsoDOvHP3WxTxXU
        hW+Mz96lweDzRkDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] irq/urgent for v6.3-rc1
In-Reply-To: <CAHk-=wg6CNFeiSa5j3BS5z4L+ekLo6-sYZi6YxFVqFVf2viTGw@mail.gmail.com>
References: <167800644191.309766.5757985605946414576.tglx@xen13>
 <CAHk-=whr2KrDkMnQ5pKKxn8nCD718ExKAmPE3TLxkWnjtj6OvA@mail.gmail.com>
 <87ttyzhtem.ffs@tglx>
 <CAHk-=wg6CNFeiSa5j3BS5z4L+ekLo6-sYZi6YxFVqFVf2viTGw@mail.gmail.com>
Date:   Sun, 05 Mar 2023 21:53:29 +0100
Message-ID: <87o7p6j4xi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05 2023 at 11:50, Linus Torvalds wrote:
> On Sun, Mar 5, 2023 at 11:47=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> That looks more correct. Let me see what my script zoo managed to get
>> wrong this time.
>
> I think your scripts did the equivalent of generating the diffs for
> all commits separately, and then feeding that to "diffstat".

Kinda. It's the case where the merge in the middle of the commits caused
the thing to create something completely nonsensical. There is even a
comment which says:

 # FIXME: Merge into Linus head and diff there

I put that in after you explained it to me quite some years ago that in
that case 'git merge-base irq/urgent linus' does not work.

Obviously that lazy sod who put the comment there did never bother to
fix it for real. :)

Thanks,

        tglx





