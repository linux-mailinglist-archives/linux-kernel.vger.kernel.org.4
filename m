Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD095F0157
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiI2XWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiI2XWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:22:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD9F135044;
        Thu, 29 Sep 2022 16:22:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v4so2712707pgi.10;
        Thu, 29 Sep 2022 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=k9iVNCg81C1n4ax6HQVaWzPvcQNvg+2Jo/FvkuXEunA=;
        b=ZG7Il9MJjhiZYW6rmuir8dLrJp8mtTxzNUqHaNt2KJbdXb0Vqv0ZZwEq4xwit/7/kx
         hxkzj/nOKCWNHp72GCvO/DCoYljFBbXN3J3vBy/4DJrdwk2amR1P1fOSm3hKsWejd76U
         lC6h1j4tQfJ9oM03CSqKfETN+fvlytyBlGiw5vXQ6ZEmrG7BA1ISkOg50x7taHsy3tiQ
         OpCroDSUw+mnxyBOGKwEEuMV4FYnwkyHtdBgcwmHCAyRbwOQH5sYQ4+B23q6EemAOpmE
         K9dq+jajWeU+uERQ0gYfz1lSFNRLdbgAMsRNs8LcTTmOsD+WfjzKuXR9IcbL2t3/6vtV
         AWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=k9iVNCg81C1n4ax6HQVaWzPvcQNvg+2Jo/FvkuXEunA=;
        b=x93sHllHFUETSWlhwgbyAyMgtXsMD7R3WxjlO7/gykduPnW87cp4LsmjT5VyWu3jE3
         8Xkzot2cWPUQEnlfCPde4jA+dgp9UT+606vPmK/IVFZOAVg+PdkihQphHhig32rufSfI
         QWlpCV5vYFwQHhSNwoPWESQiNtr7cJ26UobbL+uvRsjcPMfAptycyazv+RNV7UZ9ChD0
         QiAVkRe4dJBRvRt8OGXY3wul13z1BBOzHGWXRzIlmmLkVxSrh4auE0xHlEcNqr9wNkSE
         GNzPEiOViKgUqWeodM+cAivvHntJ3GjYFsOdwxVRg6+KzpsPQNa+XyrKuLterYE42W7M
         SH+g==
X-Gm-Message-State: ACrzQf35rX2r2clpxyoTVbaGQdCRFsuPNxF7LbckgFoqaVtZkFFTsNim
        tWgmTsA91dANT3gW3T8jYNQ=
X-Google-Smtp-Source: AMsMyM6cJj++MIqaW87//ChnT4eL4aY2b767/mhIM9iIEtDKUNST2lQzIBwjf2ER9kGasWWjIpHLLA==
X-Received: by 2002:a63:5243:0:b0:43c:96a:8528 with SMTP id s3-20020a635243000000b0043c096a8528mr4982707pgl.47.1664493765171;
        Thu, 29 Sep 2022 16:22:45 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:637c:7f23:f348:a9e6])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902d1c300b0017a00216965sm414776plb.218.2022.09.29.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:22:44 -0700 (PDT)
Date:   Thu, 29 Sep 2022 16:22:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to
 acpi_dev_irq_flags
Message-ID: <YzYowYJpRTImmg4m@google.com>
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
 <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
 <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
 <CAJZ5v0gcJRoMSODbTevRdK1zaEZHJcPxvG6XMy9-T_jvwxPFBw@mail.gmail.com>
 <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQZ30CQd-0YnQgYG_OJVWn9_aUjvDAuT_DRGsxQF-q+bjr5BA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:20:12PM -0600, Raul Rangel wrote:
> On Thu, Sep 29, 2022 at 1:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Sep 29, 2022 at 9:27 PM Raul Rangel <rrangel@chromium.org> wrote:
> > >
> > > On Thu, Sep 29, 2022 at 1:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 29, 2022 at 6:19 PM Raul E Rangel <rrangel@chromium.org> wrote:
> > > > >
> > > > > ACPI IRQ/Interrupt resources contain a bit that describes if the
> > > > > interrupt should wake the system. This change exposes that bit via
> > > > > a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
> > > >
> > > > I would call this IORESOURCE_IRQ_WAKE which is (a) simpler and easier
> > > > to read and (b) it sort of matches the "wakeirq" naming convention.
> > >
> > > It was Dmitry who originally suggested the name. I personally like the
> > > CAPABLE in the name. It makes it clear that it's capable of acting as
> > > a wake source, not to be confused with being enabled as a wake source.
> >
> > Well, so be it then.
> >
> > As I said elsewhere, I can apply this patch too if that's useful at this point.
> >
> 
> We just need to make sure the ACPI patches 5-8 land before the i2c
> patches 9-13. The i2c patches 1-4 can land before or after the ACPI
> changes. I'm not sure how things get coordinated across subsystems.

I am fine with all input stuff going through ACPI tree to ease landing.
Or I can pick up everything if Rafael and Jiri/Benjamin agree.

-- 
Dmitry
