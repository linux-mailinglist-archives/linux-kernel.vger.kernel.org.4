Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3962FE48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiKRTtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiKRTtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:49:46 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153289CF71;
        Fri, 18 Nov 2022 11:49:46 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id q21so4615889iod.4;
        Fri, 18 Nov 2022 11:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yu1RSY6PbtmdL2lPaJSdNWr1Vo1kRzD5jonT6FIhP6w=;
        b=aT3Re3hrINWiJcFJFCFxad2LlurC7+ngzo/E0KVWG9KFiaierI9Z9t0vPxXbXMVJCZ
         2tm0ugYjuKBH22QRDnoEit3rOkMEtZOKVsft0Zl9CHBVhj/brjVwQ4H84IK0IVwvzCpz
         KLMXWrvtkHXf7i9WzPeip1GQmx5qdSJ5gZJslriPXijgE3Il1Zvm8DpHJxxpJQWerd8M
         xmJHvwUsqRlVIT1/rY0VzVRmyfhar4uWaAih1j7XWpBTGyu7sX0RnqTDxcYZCUP0XoXE
         OIgAONzy62bU93ye3/tr5c8jg9mQLQcFSvpC7obdE5qBNLLz7VhbHN8FBI7uh0zJViww
         vnTg==
X-Gm-Message-State: ANoB5pnt3+GaUJhVfGKZo/6ERrWCi7XzgJ/eXLRPi8SaIH5xjBGrhuRe
        30fZNTRJ2prXh8bGxeeEfZDcP7SSiHEX0JmjZQ8TfXrY
X-Google-Smtp-Source: AA0mqf56ivZ28N6/V56X0yKg/mBm6iUlLlqA8/FI65eVpgNI06WJoMc/gmauhWTnBRPyIn2HXGfxEIB2qGOLbPER6ck=
X-Received: by 2002:a05:6602:2592:b0:6de:3ac7:5d20 with SMTP id
 p18-20020a056602259200b006de3ac75d20mr4118749ioo.9.1668800985372; Fri, 18 Nov
 2022 11:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20221116025417.2590275-1-srinivas.pandruvada@linux.intel.com>
 <20221116025417.2590275-2-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0jrEDkfZbMzdLHzvGwa3jK61vUBBqzUUM8BaQvLLcZnhg@mail.gmail.com> <ac94b8218de744a1ca9649fc9585292f11b91063.camel@linux.intel.com>
In-Reply-To: <ac94b8218de744a1ca9649fc9585292f11b91063.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Nov 2022 20:49:34 +0100
Message-ID: <CAJZ5v0j=LUkTtcQb3YVN0R3W4p7Cg-+wU8EAW75wz7bSTXhp4Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] thermal: intel: Protect clearing of thermal
 status bits
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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

On Fri, Nov 18, 2022 at 8:40 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2022-11-18 at 18:57 +0100, Rafael J. Wysocki wrote:
> > On Wed, Nov 16, 2022 at 3:54 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > The clearing of the package thermal status is done by Read-Modify-
> > > Write
> > > operation. This may result in clearing of some new status bits
> > > which are
> > > being or about to be processed.
> > >
> > > For example, while clearing of HFI status, after read of thermal
> > > status
> > > register, a new thermal status bit is set by the hardware. But
> > > during
> > > write back, the newly generated status bit will be set to 0 or
> > > cleared.
> > > So, it is not safe to do read-modify-write.
> > >
> > > Since thermal status Read-Write bits can be set to only 0 not 1, it
> > > is
> > > safe to set all other bits to 1 which are not getting cleared.
> > >
> > > Create a common interface for clearing package thermal status bits.
> > > Use
> > > this interface to replace existing code to clear thermal package
> > > status
> > > bits.
> > >
> > > It is safe to call from different CPUs without protection as there
> > > is no
> > > read-modify-write. Also wrmsrl results in just single instruction.
> > > For
> > > example while CPU 0 and CPU 3 are clearing bit 1 and 3
> > > respectively. If
> > > CPU 3 wins the race, it will write 0x4000aa2, then CPU 1 will write
> > > 0x4000aa8. The bits which are not part of clear are set to 1. The
> > > default
> > > mask for bits, which can be written here is 0x4000aaa.
> > >
> > > Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com>
> > > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> >
> > How urgent is this?  Would 6.2 be sufficient?
> >
> Not urgent. 6.2 should be enough.

OK

> > Also, do you want it to go into -stable?
> Yes.

Which series?
