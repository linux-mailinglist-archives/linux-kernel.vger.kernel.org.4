Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69AF5BCFFF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiISPDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiISPDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:03:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0F533A0D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:03:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so47330434lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=29Q13qvIrzikJw/fUgHdsSOAwHmgeU1WfwREQ1Cge1Y=;
        b=lwxdIbe5BjxF0HFPnwF9Ofpvu0luMg35Ct6ff/AF8HWxyNhmnKGYXO+mANg2sK0aRp
         zDmKcO1OJAa/tYrxnxzBvTsVbyoz/6hGfgwWltTQlppuEsv2vmOuV0C99/+dJ3qo1nuD
         nT6doWb23QqnDbH824dGANTgN7MsuOFdOTvQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=29Q13qvIrzikJw/fUgHdsSOAwHmgeU1WfwREQ1Cge1Y=;
        b=dIcOoey9bbXsmlXm4NqP60TGl1iJTCc8XR3jaJ7966HtcIEkNZ8zXeB7dIJ6qV71q4
         ko9js22rkkThZFNGkFxZChNg9ZK3KEgfsRhb+GClMQ+YAHiycDd2PJTyJnL5vzOkpTfK
         VTgzoBBnHw8hJKGsTAH6aHMvHaHWiJzcMWTYZtUmpIcXcwt9kJa09MYkgQFuLlREyA1/
         AyADTbFiKOUy7oRufdjA7pNzb2C8F7g4594Ilz7Ng2wjaE369ShmtNdintd+hX75kzcT
         I1pWk/IRbOiToXZXnwR4QS/L+S25VwPAz06B6gxG6jVsN/hUhpLk2Cimfvba+sKsk3St
         hQBQ==
X-Gm-Message-State: ACrzQf2PEJVN7mUXLCIozBiozRQTvGuSd1IpXmluEL8Cxbnj9nFR0Iik
        cy6KKlwRPexyQ+H9NJzjgzerGTzPB5qt2Q==
X-Google-Smtp-Source: AMsMyM7PC0ZyTuuiE3oY1YeLNY5S6alvgEY6MCwjUBydhvN4/zAoW2WuGFdZTS/NevVyGqh5TGmpOg==
X-Received: by 2002:a05:6512:2384:b0:497:ad1c:799 with SMTP id c4-20020a056512238400b00497ad1c0799mr6230382lfv.294.1663599805195;
        Mon, 19 Sep 2022 08:03:25 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id s4-20020a056512202400b0049ad315cfc3sm4615078lfs.162.2022.09.19.08.03.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 08:03:23 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q17so20300760lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:03:23 -0700 (PDT)
X-Received: by 2002:a05:651c:17a7:b0:261:c0b1:574b with SMTP id
 bn39-20020a05651c17a700b00261c0b1574bmr5541662ljb.40.1663599802963; Mon, 19
 Sep 2022 08:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220915002235.v2.1.I7c0a79e9b3c52584f5b637fde5f1d6f807605806@changeid>
 <CAHmME9rhunb05DEnc=UfGr8k9_LBi1NW2Hi0OsRbGwcCN2NzjQ@mail.gmail.com>
In-Reply-To: <CAHmME9rhunb05DEnc=UfGr8k9_LBi1NW2Hi0OsRbGwcCN2NzjQ@mail.gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Mon, 19 Sep 2022 11:03:11 -0400
X-Gmail-Original-Message-ID: <CAM7w-FXHWzcN1Y7pwb6+1KA6A2oZRrfpOJdWFVWjRvjbp+DEOg@mail.gmail.com>
Message-ID: <CAM7w-FXHWzcN1Y7pwb6+1KA6A2oZRrfpOJdWFVWjRvjbp+DEOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] random: move add_hwgenerator_randomness()'s wait
 outside function
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        Alex Levin <levinale@google.com>,
        Andrey Pronin <apronin@google.com>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Stephen Boyd <swboyd@google.com>,
        Rajat Jain <rajatja@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 10:51 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The other thing that occurred to me when reading this patch in context
> of the other one is that this sleep you're removing here is not the
> only sleep in the call chain. Each hwrng driver can also sleep, and
> many do, sometimes for a long time, blocking until there's data
> available, which might happen after minutes in some cases. So maybe
> that's something to think about in context of this patchset -- that
> just moving this to a delayed worker might not actually fix the issue
> you're having with sleeps.
>

This is an excellent point. A look at tpm2_calc_ordinal_duration()
reveals that tpm_transmit() may block for 300s at a time. So when
we are using a WQ_FREEZABLE delayed_work, the PM may have to wait
for up to 300s when draining the wq on suspend. That will introduce
a lot of breakage in suspend/resume.

Dominik: in light of this, please proceed with your patch, without
rebasing it onto mine.

+ tpm maintainers Peter Huewe and Jarkko Sakkinen, a quick recap of
the problem:

- on ChromeOS we are seeing intermittent suspend/resume errors+warnings
  related to activity of the core's hwrng_fillfn. this kthread keeps
  runningduring suspend/resume. if this happens to kick off an bus (i2c)
  transaction while the bus driver is in suspend, this triggers
  a "Transfer while suspended" warning from the i2c core, followed by
  an error return:

i2c_designware i2c_designware.1: Transfer while suspended
tpm tpm0: i2c transfer failed (attempt 1/3): -108
[ snip 10s of transfer failed attempts]

- in 2019, Stephen Boyd made an attempt at fixing this by making the
  hwrng_fillfn kthread freezable. But a freezable thread requires
  different API calls for scheduling, waiting, and timeout. This
  generated regressions, so the solution had to be reverted.

https://patchwork.kernel.org/project/linux-crypto/patch/20190805233241.220521-1-swboyd@chromium.org/

- the current patch attempts to halt hwrng_fillfn during suspend by
  converting it to a self-rearming delayed_work. The PM drains all
  work before going into suspend. But, the potential minute-long
  blocking delays in tpm make this solution infeasible.

Peter and Jarkko, can you think of a possible way forward to eliminate
the warnings+errors?

-Sven
