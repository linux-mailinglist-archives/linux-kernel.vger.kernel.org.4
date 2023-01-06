Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B682066078C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjAFUEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjAFUEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:04:52 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F435928
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:04:51 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id e129so1273188iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 12:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MzDYy7xH3h8odSKsfYc3qRpLkXTC2bMipKsVQCeG9FI=;
        b=LppGhafXep900ETRX0WoS44tL4OJE5U/oiAMFVHG9hQ0mds8BDedt6H6Bw1FrzaM4t
         N4iN+eaxJ90iKHNasykQ02gS0Ik5BRQ9Gn/Ch5b5p8hIX+WAipztit/AA7bm7flrp2hU
         dq28Syy8Q+Mdab8MPFuej1FbyZ91btaR7d6dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzDYy7xH3h8odSKsfYc3qRpLkXTC2bMipKsVQCeG9FI=;
        b=i468k3CQJmN6V7LDh9wS6tPK2oKaJtfaIl4p55DAN5i0PW56S5BLYg8lLQJF0k5X0d
         AQo97N/llvwevGFfU1xcQ5+nPwVl2hKpBww42rQnDCRpSAsdbWzrn1jDFQgSrqXmirE6
         n5+Bz8pCGTf5hSNHgV608DsTaqpDiCIHptIdQaxGczTXMAPYrqbyrdWZHEOwqoSquRWh
         EMCwmb6rTPeCqhARVT5Vi/9UiU5UppWABNfrvRsq0A+WMzwWGKNZL9Iv+HnelE6s627C
         Kjmj0RrEbedb1OdmYDCvjfxEkiATrbJ/5R67mls2CxcTV2g4GBWycqpihZHFMFnGVsMS
         8HfA==
X-Gm-Message-State: AFqh2kpDwt4Z6/y6vh0OfI1aB6DKpaPXtStgdxFKWqFUFktQrA1YAL+H
        QiBVewDSCKbhwR02S7BG3fUX6fp5UoYFRg2OwmoKEQ==
X-Google-Smtp-Source: AMrXdXt+OvGRW73oMucqsNbQBvW95NaKoS/i4Q0oSWPahJsIrZlzWwcHZyn2Uwc7cUnXowlDV8MNakYCs0MmrINVMWY=
X-Received: by 2002:a02:665f:0:b0:376:1ab0:7bd5 with SMTP id
 l31-20020a02665f000000b003761ab07bd5mr5197244jaf.8.1673035489129; Fri, 06 Jan
 2023 12:04:49 -0800 (PST)
MIME-Version: 1.0
References: <Y7dPV5BK6jk1KvX+@zx2c4.com> <20230106030156.3258307-1-Jason@zx2c4.com>
 <CAHk-=wjin0Rn6j+EvYV9pzrbA0G2xnHKdp_EAB6XnansQ8kpUA@mail.gmail.com>
In-Reply-To: <CAHk-=wjin0Rn6j+EvYV9pzrbA0G2xnHKdp_EAB6XnansQ8kpUA@mail.gmail.com>
From:   Luigi Semenzato <semenzato@chromium.org>
Date:   Fri, 6 Jan 2023 12:04:37 -0800
Message-ID: <CAA25o9Sbkg=qD+DH-aqXY9H5R_oBtePcnqagwAGCgoUk8D-Vyg@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Allow system suspend to continue when TPM suspend fails
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
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
        tbroch@chromium.org, dbasehore@chromium.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think it's fine to go ahead with your change, for multiple reasons.

1. I doubt that any of the ChromeOS devices using TPM 1.2 are still
being updated.
2. If the SAVESTATE command fails, it is probably better to continue
the transition to S3, and fail at resume, than to block the suspend.
The suspend is often triggered by closing the lid, so users would not
see what's going on and might put their running laptop in a backpack,
where it could overheat.
3. I don't recall bugs due to failures of TPM suspend, and I didn't
find any such bug in our database.  Many (most?) ChromeOS devices left
the TPM powered on in S3, so didn't use the suspend/resume path.

Thank you for asking!


On Fri, Jan 6, 2023 at 11:00 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jan 5, 2023 at 7:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > In lieu of actually fixing the underlying bug, just allow system suspend
> > to continue, so that laptops still go to sleep fine. Later, this can be
> > reverted when the real bug is fixed.
>
> So the patch looks fine to me, but since there's still the ChromeOS
> discussion pending I'll wait for that to finish.
>
> Perhaps re-send or at least remind me if/when it does?
>
> Also, a query about the printout:
>
> > +       if (rc)
> > +               pr_err("Unable to suspend tpm-%d (error %d), but continuing system suspend\n",
> > +                      chip->dev_num, rc);
>
> so I suspect that 99% of the time the dev_num isn't actually all that
> useful, but what *might* be useful is which tpm driver it is.
>
> Just comparing the error dmesg output you had:
>
>   ..
>   tpm tpm0: Error (28) sending savestate before suspend
>   tpm_tis 00:08: PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x80 returns 28
>   ..
>
> that "tpm tpm0" output is kind of useless compared to the "tpm_tis 00:08" one.
>
> So I think "dev_err(dev, ...)" would be more useful here.
>
> Finally - and maybe I'm just being difficult here, I will note here
> again that TPM2 devices don't have this issue, because the TPM2 path
> for suspend doesn't do any of this at all.
>
> It just does
>
>         tpm_transmit_cmd(..);
>
> with a TPM2_CC_SHUTDOWN TPM_SU_STATE command, and doesn't even check
> the return value. In fact, the tpm2 code *used* to have this comment:
>
>         /* In places where shutdown command is sent there's no much we can do
>          * except print the error code on a system failure.
>          */
>         if (rc < 0 && rc != -EPIPE)
>                 dev_warn(&chip->dev, "transmit returned %d while
> stopping the TPM",
>                          rc);
>
> but it was summarily removed when doing some re-organization around
> buffer handling.
>
> So just by looking at what tpm2 does, I'm not 100% convinced that tpm1
> should do this dance at all.
>
> But having a dev_err() is probably a good idea at least as a transitional thing.
>
>                   Linus
