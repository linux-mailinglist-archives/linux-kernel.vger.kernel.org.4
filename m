Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDD364CBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiLNNxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiLNNxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:53:32 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2291610B70;
        Wed, 14 Dec 2022 05:53:31 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id z17so1251040qki.11;
        Wed, 14 Dec 2022 05:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgCZ6dqvzRcZiRWo8glJcGnEI+Q5rbBDkxsKXvA5utk=;
        b=aOtbjessFpAm9ngJ3OjstPjEdt0HO3xC7boOjIf+SjEYVg//XbGG8i8D/ckOOoekFn
         iA2LwrWJi5DVc8/H+e490iTKUTVzkD4Bo/pjlUl3ucVxisUjjBSSxTJH36SN8GalpGmB
         DWlqUiL6KBByk8TiwouJxlNCG23y1iLQTlDvJJqI+faprwSnwUDpySq/E1UIoWdFTvw2
         qXRDQrGCSGWxYJYzq/ktX952KhNdk1SU7/mrrIT0tkyybX1PntTNrdusY/+GuQWGIKtM
         uCXlIsIm3DO6aIjY8zMlN3ax5bnFiPx488l+b7pzOKLmKsgPou7ZA40e+s/pMYRJh1/n
         u3pw==
X-Gm-Message-State: ANoB5plMP4wUw+i18F05QXsZcvxq1Xn8Z3VvfihxIfGHJtYP9ocJZyJK
        Ox+eQPMFWd2UgF9/yfqe5sq7wyJJWcJH4DUPT3s=
X-Google-Smtp-Source: AA0mqf5PF9slAqaO47lyqJvFLYFFdrhXsLQVr3Ypy5jMVxvsUY9ROH5kYaG7WKOAmPpJUfNYwgD2J/N0erywAX2Txgk=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr82577930qkb.443.1671026010300; Wed, 14
 Dec 2022 05:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20221214020651.1362731-1-srinivas.pandruvada@linux.intel.com> <CAHk-=wi-bq6-d=aoVRDWpLxU-2c2vjkU3OTv37hcK5q781aK+w@mail.gmail.com>
In-Reply-To: <CAHk-=wi-bq6-d=aoVRDWpLxU-2c2vjkU3OTv37hcK5q781aK+w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Dec 2022 14:53:19 +0100
Message-ID: <CAJZ5v0jADnJvgvHa7tVEhqYtSvArVYccJpaq=LWm5=pqfkOh8A@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: Don't set HFI status bit to 1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 4:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Dec 13, 2022 at 6:07 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > When CPU doesn't support HFI (Hardware Feedback Interface), don't include
> > BIT 26 in the mask to prevent clearing. otherwise this results in:
> >     unchecked MSR access error: WRMSR to 0x1b1
> >       (tried to write 0x0000000004000aa8)
> >       at rIP: 0xffffffff8b8559fe (throttle_active_work+0xbe/0x1b0)
> >
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Fixes: 6fe1e64b6026 ("thermal: intel: Prevent accidental clearing of HFI status")
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> You can add my tested-by as well, it seems to fix the issue.
>
> Of course, it could be that I just didn't happen to trigger the
> throttling in my test just now, so that testing is pretty limited, but
> at least from a very quick check it seems good.

I've applied the patch for 6.2-rc1, thanks!
