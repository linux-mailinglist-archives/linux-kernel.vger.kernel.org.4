Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B912678638
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjAWTYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAWTYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:24:40 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB57AD;
        Mon, 23 Jan 2023 11:24:39 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id x36so15797194ede.13;
        Mon, 23 Jan 2023 11:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMyITVm+spjaFdC/IumAxOobxC1X+PgdKWLIddSsFt0=;
        b=OJbDJk3KA7BosEIKc/4POpMnEIpK4WR3My12xD8GI7GDLei/lwXGyMo5FOmAeFVuHQ
         urywQrtom8E8zxgyYOG023dAxf+92dKJqLqC7blximBV3CJEJu5QWFkbfzYOXscE1bfD
         zxsLCXlC2zC5f8PQCiWhFST1YDudGy/L3Npmo2k8Fnb6CPeZbmcAauwjahEYlaMzv+3J
         48RD7PLKohtfRmGYVr+3rNdRxayE0CjGmq9ITK2B3dlBEcZzdIeS3Fm66QuEMFkf77Xg
         sLhsYX79AEZiTXq0gqcbSBD7jxtyv4LlxCfa1MtrhjdAQGd83qTKCZcYTU8+dOYX1wwA
         XnAg==
X-Gm-Message-State: AO0yUKW5ED2HC8OF0ygxHc56Qx0ouel029FyzOEsidTP7PUO1Iek2oG8
        R84DaDjnw/y8BPGtuT8PwbizNBLSWuxpJB4egvg=
X-Google-Smtp-Source: AK7set+pgGjO2z6T4jo0KvY4uPUpTFbOgaSe2C/ypWs655SYgHtZ+FgxoBULQuHLIk/LsJlAw5rpTPUERdpojCGHhjU=
X-Received: by 2002:a50:ec8f:0:b0:49f:6dda:9e1f with SMTP id
 e15-20020a50ec8f000000b0049f6dda9e1fmr78914edr.251.1674501878356; Mon, 23 Jan
 2023 11:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
 <9e24156c-65fc-d38b-317a-9cc8fb2201b9@redhat.com> <Y87PWaFFpHeW5YLv@smile.fi.intel.com>
In-Reply-To: <Y87PWaFFpHeW5YLv@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Jan 2023 20:24:27 +0100
Message-ID: <CAJZ5v0g_WmbCwcqvy_VwZZNDbX48c84vmkqUdGvjX3-w24GCwg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] ACPI: video: Fix refcounting in apple_gmux_backlight_present()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 7:18 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jan 23, 2023 at 06:46:44PM +0100, Hans de Goede wrote:
> > On 1/23/23 18:10, Andy Shevchenko wrote:
> > > acpi_dev_get_first_match_dev() gets ACPI device with the bumped
> > > refcount. The caller must drop it when it's done.
> > >
> > > Fix ACPI device refcounting in apple_gmux_backlight_present().
>
> ...
>
> > Thank you for your work on this, much appreciated and I like
> > the new acpi_get_first_match_physical_node().
> >
> > But I don't think this patch is a good idea. There is a
> > regression related to apple_gmux_backlight_present()
> > with a patch-set fixing it pending.
> >
> > And that patch-set actually removes this function. Adding
> > a fix for this real, but not really important leak now,
> > will just make backporting the actual fix harder.
> >
> > So I would prefer for this patch to not go in and to
> > go for (a to be submitted v2) of the patch-set fixing
> > the regression right away instead.
>
> Maybe I missed something, but I noticed that you actually moved (not killed)
> the code which is currently in this function. If it's the case, I prefer my
> fix to be imported first.

Well, what about making the new code not leak?

That way the separate fix won't be necessary any more, will it?
