Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4980C66849F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjALUzY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Jan 2023 15:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbjALUx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:53:28 -0500
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 12:31:17 PST
Received: from ouvsmtp1.octopuce.fr (ouvsmtp1.octopuce.fr [194.36.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7013F46;
        Thu, 12 Jan 2023 12:31:17 -0800 (PST)
Received: from panel.vitry.ouvaton.coop (unknown [194.36.166.20])
        by ouvsmtp1.octopuce.fr (Postfix) with ESMTPS id 863D21DC;
        Thu, 12 Jan 2023 20:55:34 +0100 (CET)
Received: from sm.ouvaton.coop (ouvadm.octopuce.fr [194.36.166.2])
        by panel.vitry.ouvaton.coop (Postfix) with ESMTPSA id 42E285E1B7F;
        Thu, 12 Jan 2023 20:55:34 +0100 (CET)
MIME-Version: 1.0
Date:   Thu, 12 Jan 2023 19:55:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
From:   "Yann Droneaud" <ydroneaud@opteya.com>
Message-ID: <ae35afa5b824dc76c5ded98efcabc117e6dd3d70@opteya.com>
Subject: Re: [RFC PATCH 0/4] random: a simple vDSO mechanism for reseeding
 userspace CSPRNGs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Florian Weimer" <fweimer@redhat.com>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>
In-Reply-To: <CAHmME9oXB8=jUz98tv6k1xS+ELaRmgartoT6go_1axhH1L-HJg@mail.gmail.com>
References: <CAHmME9oXB8=jUz98tv6k1xS+ELaRmgartoT6go_1axhH1L-HJg@mail.gmail.com>
 <cover.1673539719.git.ydroneaud@opteya.com>
X-Originating-IP: 10.0.20.16
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

12 janvier 2023 à 18:07 "Jason A. Donenfeld" <Jason@zx2c4.com> a écrit:
 
> Sorry Yann, but I'm not interested in this approach, and I don't think
> reviewing the details of it are a good allocation of time. I don't
> want to lock the kernel into having specific reseeding semantics that
> are a contract with userspace, which is what this approach does.

This patch adds a mean for the kernel to tell userspace: between the
last time you call us with getrandom(timestamp,, GRND_TIMESTAMP),
something happened that trigger an update to the opaque cookie given
to getrandom(timestamp, GRND_TIMESTAMP). When such update happen,
userspace is advised to discard buffered random data and retry.

The meaning of the timestamp cookie is up to the kernel, and can be
changed anytime. Userspace is not expected to read the content of this
blob. Userspace only acts on the length returned by getrandom(,, GRND_TIMESTAMP):
 -1 : not supported
  0 : cookie not updated, no need to discard buffered data
 >0 : cookie updated, userspace should discard buffered data

For the cookie, I've used a single u64, but two u64 could be a better start,
providing room for implementing improved behavior in future kernel versions.

> Please just let me iterate on my original patchset for a little bit,
> without adding more junk to the already overly large conversation.

I like the simplicity of my so called "junk". It's streamlined, doesn't
require a new syscall, doesn't require a new copy of ChaCha20 code.

I'm sorry it doesn't fit your expectations.

Regards.

-- 
Yann Droneaud
OPTEYA
