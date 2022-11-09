Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3B622E19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiKIOhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiKIOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:36:54 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E49510562;
        Wed,  9 Nov 2022 06:36:50 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id u7so12369070qvn.13;
        Wed, 09 Nov 2022 06:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f0whdKlPSyWQpEW/UnAQbhvhiiMdZQhh1ZOsdVS1cR8=;
        b=f09x7VmU0IQ8+qLiS0UMhfA9r3y2kbJpJrxILrlGWT8DLoNfWQTtCdirgBezcAD/+5
         gKqp0dc3OP8opVPx9GYJezkxzQEHg9AlchuHRx2ghUGm0aKuKwzYYxHwc5uE1ewK4ibg
         m3eGNeakro4/igduPmV0mLHXoWkNy9rtqLoEzNSHjc40VNPQXT6pYR0qnqngjyWZ34Ki
         htK89E/LG/yYNh7LB1HYC4PAXSRgmdr/Oq2uIzpL05O+9irmreyTmOZSUnv4mjDZt0iT
         1g1LEqlMivmacAnoswC15gSQAKFXa1mnW8OfIKevwdfWJ+pwP10iglsZz9YvX80XCdBD
         NfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0whdKlPSyWQpEW/UnAQbhvhiiMdZQhh1ZOsdVS1cR8=;
        b=CufqmmnxKTQkwJf62fTa9/HKEnCpG9A8k74DKfp+zF91fORCamZLYtxqfGBMYPhiF6
         Hl7+JOFrTBaX0x6eL7yIJ9UXc9bbvtAV3Frh6rR7LqONjheXCqjAJFE46vxefL6+ZbHo
         ub4GXxrmzT8x9ePoMS22RdIPU6rM4kecofhQiYAZCbo//uFg1w8vF9ASQvk4DwnYiY4x
         yuRvzrZvJxxVYCmrR4zTgy8o6gjn+bG+crt4Cv016IkIAIcReh/z1EdxsHIg1+Ocg4+b
         FtDsD++UJqMclDnJfijpbvGomr+vXoNRrrtuFZ5yfTeKIV7VTz1vPPIOLNpfw8uVSnp5
         dvzA==
X-Gm-Message-State: ACrzQf33ZTFHKEgltGc8kZKArT52AGCTIJekvYXCw3ka1sjzawtZR7Rn
        byk9bvVb63DOUWInRs41A0HQFmnx32WUzJPfDEA=
X-Google-Smtp-Source: AMsMyM756oDJNaqqxRFFZjRQlKgvE6Pk3WIwfRO74Y3cn5Km3OIoSQJA+4wiw29X9Jv6Rh3pNc79qfu2xBOsfljVNGU=
X-Received: by 2002:ad4:51cf:0:b0:49a:f34e:cfa7 with SMTP id
 p15-20020ad451cf000000b0049af34ecfa7mr1110515qvq.48.1668004609231; Wed, 09
 Nov 2022 06:36:49 -0800 (PST)
MIME-Version: 1.0
References: <TYCP286MB232348AC39E6F4966FA9494BCA3D9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <Y2uu5Q7mLzS0w9VR@kroah.com>
In-Reply-To: <Y2uu5Q7mLzS0w9VR@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Nov 2022 16:36:13 +0200
Message-ID: <CAHp75VdUrjjFqR-AzRs+fB4ruFqhES7k7Qommu7c=E5F8Oa80g@mail.gmail.com>
Subject: Re: [RFC PATCH] acpi: make remove callback of acpi driver void
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dawei Li <set_pte_at@outlook.com>, rafael@kernel.org,
        u.kleine-koenig@pengutronix.de, dvhart@infradead.org,
        andy@infradead.org, lenb@kernel.org, arnd@arndb.de,
        peterhuewe@gmx.de, kys@microsoft.com, kronos.it@gmail.com,
        dmitry.torokhov@gmail.com, bleung@chromium.org,
        sujith.thomas@intel.com, vithampi@vmware.com, lee@kernel.org,
        wim@linux-watchdog.org, jgross@suse.com, davem@davemloft.net,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 3:45 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sun, Nov 06, 2022 at 10:57:53PM +0800, Dawei Li wrote:
> > For bus-based driver, device removal is implemented as:
> > 1 device_remove()->
> > 2   bus->remove()->
> > 3     driver->remove()
> >
> > Driver core needs _no_ inform from callee(bus driver) about the
> > result of remove callback. In that case,
> > commit <fc7a6209d571> ("bus: Make remove callback return void")

Also please read Submitting Patches on how to provide a commit
reference in the message body.

> > forces struct bus_type::remove() be void-returned.
> >
> > Now we have the situation that both 1 & 2 of calling chain are
> > void-returned, so it does _not_ make much sense for 3(driver->remove)
> > to return non-void to its caller.
> >
> > So the basic idea behind this change is making remove() callback of
> > any bus-based driver to be void-returned.
> >
> > This change itself, is for device drivers based on acpi-bus.


-- 
With Best Regards,
Andy Shevchenko
