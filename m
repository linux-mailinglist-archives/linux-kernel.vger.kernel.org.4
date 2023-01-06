Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97AC6606E9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjAFTH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjAFTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:07:54 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849D5F74
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:07:53 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id jr11so2826386qtb.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 11:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xXu0UrxATTjQV5tOMZWsigK936HnNawUgyg/NFmPfog=;
        b=WcF+YXOaqvpE/ecoEANu1yF1O+Aukjs7Um8ujF3uWejFh8Ota9tqhXwPE/nYYpPO9x
         YAFPfTmjZPQBY1g17l1dVR0vtyz6t//giJBIlDkMhndMs1nkqUyzyOlsm/w6aKY/UF/E
         ZWEm2doRox7auXvyEHevuIoxPtagRQmAOYrvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXu0UrxATTjQV5tOMZWsigK936HnNawUgyg/NFmPfog=;
        b=TSgu2kHYvMLlceZZi1poUHs4cUEVa2MnhXCK4CyO5xkWG3nlQiQ89yvvwOLnqILuoN
         r+ckKijNz4uhyZ+jaHQtupPo63u0Oub/IttyeJc/qGwlwGdYY0GNBR5uJo2XrF7FQlww
         oLEb62a5VDFN9P8n6a1McxSj0BxUxBN9CYTw8YpXHIw4++wClTeNHOu9OX2ztxErRFh6
         0Ou6b4G2Z9U4wWzBO2FgYwkThArQVAW5nJW0oU+8cgdMs4qG6SEDjXxPsfuZwHlFru/x
         SwQHnGUD9BB1qf27fGe67fZIdNU83RD83uKTcP2WV9lRxuCNbnMNYPfS9JctNGf33PtU
         w+Iw==
X-Gm-Message-State: AFqh2kp/vSJln8ws6XI2fNvIui2R425KTcOYca+qlI/aeJ7Z5rG5ydEY
        6N8hKgsrJFDqfqY4Z2QcEccFDHRv1NUMrIc7
X-Google-Smtp-Source: AMrXdXvXvfxpVeuIQc4nsYQxhYQ/B9ahuvMNR7sHFovX9GP+GbRxkPiIEf8vE8yrlr+tC/O7VGakHA==
X-Received: by 2002:a05:622a:488b:b0:3a9:9cbb:7cdf with SMTP id fc11-20020a05622a488b00b003a99cbb7cdfmr87812039qtb.40.1673032072206;
        Fri, 06 Jan 2023 11:07:52 -0800 (PST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id j18-20020ac84412000000b003a7ee9613a6sm884989qtn.25.2023.01.06.11.07.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 11:07:51 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id z12so2849046qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 11:07:51 -0800 (PST)
X-Received: by 2002:a05:622a:428c:b0:3a6:8b84:47ce with SMTP id
 cr12-20020a05622a428c00b003a68b8447cemr1560637qtb.678.1673031606753; Fri, 06
 Jan 2023 11:00:06 -0800 (PST)
MIME-Version: 1.0
References: <Y7dPV5BK6jk1KvX+@zx2c4.com> <20230106030156.3258307-1-Jason@zx2c4.com>
In-Reply-To: <20230106030156.3258307-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jan 2023 10:59:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjin0Rn6j+EvYV9pzrbA0G2xnHKdp_EAB6XnansQ8kpUA@mail.gmail.com>
Message-ID: <CAHk-=wjin0Rn6j+EvYV9pzrbA0G2xnHKdp_EAB6XnansQ8kpUA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Allow system suspend to continue when TPM suspend fails
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Altmanninger <aclopte@gmail.com>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        tbroch@chromium.org, semenzato@chromium.org,
        dbasehore@chromium.org, Kees Cook <keescook@chromium.org>
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

On Thu, Jan 5, 2023 at 7:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> In lieu of actually fixing the underlying bug, just allow system suspend
> to continue, so that laptops still go to sleep fine. Later, this can be
> reverted when the real bug is fixed.

So the patch looks fine to me, but since there's still the ChromeOS
discussion pending I'll wait for that to finish.

Perhaps re-send or at least remind me if/when it does?

Also, a query about the printout:

> +       if (rc)
> +               pr_err("Unable to suspend tpm-%d (error %d), but continuing system suspend\n",
> +                      chip->dev_num, rc);

so I suspect that 99% of the time the dev_num isn't actually all that
useful, but what *might* be useful is which tpm driver it is.

Just comparing the error dmesg output you had:

  ..
  tpm tpm0: Error (28) sending savestate before suspend
  tpm_tis 00:08: PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x80 returns 28
  ..

that "tpm tpm0" output is kind of useless compared to the "tpm_tis 00:08" one.

So I think "dev_err(dev, ...)" would be more useful here.

Finally - and maybe I'm just being difficult here, I will note here
again that TPM2 devices don't have this issue, because the TPM2 path
for suspend doesn't do any of this at all.

It just does

        tpm_transmit_cmd(..);

with a TPM2_CC_SHUTDOWN TPM_SU_STATE command, and doesn't even check
the return value. In fact, the tpm2 code *used* to have this comment:

        /* In places where shutdown command is sent there's no much we can do
         * except print the error code on a system failure.
         */
        if (rc < 0 && rc != -EPIPE)
                dev_warn(&chip->dev, "transmit returned %d while
stopping the TPM",
                         rc);

but it was summarily removed when doing some re-organization around
buffer handling.

So just by looking at what tpm2 does, I'm not 100% convinced that tpm1
should do this dance at all.

But having a dev_err() is probably a good idea at least as a transitional thing.

                  Linus
