Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D95F4EFB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 06:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJEECZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 00:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJEECV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 00:02:21 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0D738A15;
        Tue,  4 Oct 2022 21:02:20 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so10079242oop.9;
        Tue, 04 Oct 2022 21:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4Na1g4Yf3ptBeqMqg3ahTZjpb1WV+bqLk+OAmb33/RI=;
        b=RCoMsZgqwdFRC4RVrJW+5m+g48ojGbp+nif+fIy1rNtt9aJ7Vnb4OkgyYF18jPoHh6
         o6D+zUFj9s7wkuUP6Y0wJvEC1573HqpcBpPEPnVU32qh/rYFo5cgeJrZ0Y0/LQ7OlHrA
         P7k+sQMlx7v73QzDwFCoI9cxp94DmHZN8ac9y6pFF3sNqRP38JABiGVn7a+QJPPvSYOk
         iRk/pFTdnevdsvSI1L+ZBRTWRORHozzNo+RUS4Lo5w97X6wCX98/809AW1qaG0OWgwc+
         CDQstMDuSWBBAMuKvyPx9gQ9mlJORPeNzrYZIY2Pceuiv0lbSV6HqiLwZPWQnDFRxLuF
         jVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4Na1g4Yf3ptBeqMqg3ahTZjpb1WV+bqLk+OAmb33/RI=;
        b=E714Mt8KZS7HEoWn4QmCeUL4VDrPa/9rHTAQu+9gsl7RMlljZxRSG5kgnXNkfSNiw3
         t9KVV9U7Ttmk1OXPuBnX2Od4TkJnVps0xW6YQKd4SnTPPl6gg5+8A/4hos7dcNNZKx7P
         dHX7E7p1yzwXryo+QiSVca8BTYkxHKdSGvZylkUhad6TBJ5f0vUZeIEhLjqQtDOSZix9
         MdG8lhHdqSVt1dD/go1j8U3pbZdxb6dqD8zB9ZuAuvlOtCQuJyegorZNjyMpqauXMdVH
         GJ03GFIuJD8sYNoBo0SJyS8Otq2J4MfKST7H0QcLQjU7Is6Kje/E3Z4EOrQnYI00ZBZc
         I0KA==
X-Gm-Message-State: ACrzQf1N4vvZnTTHE84dWXen2e4NMd2QxtUru6Kq7uZQnv23EKxqaU4q
        /yQAAB5joCR/sQuGMjY58UG2KgnfB3FUtLlQdWA=
X-Google-Smtp-Source: AMsMyM5RFvMMV8el79b9Zf5X69Z9wmc0C3+OXWwbIPrvCWAdz1rgMCIG1AQ8BqNMPN1quoS9GpMCwwkTCVQSA6nkcD4=
X-Received: by 2002:a05:6820:1888:b0:476:1d00:9d8f with SMTP id
 bm8-20020a056820188800b004761d009d8fmr10519131oob.98.1664942539962; Tue, 04
 Oct 2022 21:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221004103341.12646-1-jirislaby@kernel.org> <MN0PR12MB610136EC41E0D00F0BA7280FE25A9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB610136EC41E0D00F0BA7280FE25A9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 5 Oct 2022 12:02:08 +0800
Message-ID: <CAJsYDVJsuYvAyFWwoW9=K_9otJR9Y61Wfk_w2e_K7WiyWf3Xjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: resource: do IRQ override on LENOVO IdeaPad
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Fridrich Strba <fstrba@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Oct 5, 2022 at 5:02 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
> [...]
> >
> > White-list this specific model in the override_table.
> >
> > For this to work, the ZEN test needs to be put below the table walk.
>
> Unfortunately this is the second case that popped up very recently.
> Another one is listed here:
> https://bugzilla.kernel.org/show_bug.cgi?id=216552

Now I'm really curious how Windows is able to handle all these vendor crap...

> I don't think we have a good solution to cover the intersection of these bugs.  The
> existing heuristic to look at legacy syntax and the IOAPIC doesn't work properly
> on all the Lenovo and ASUS Ryzen 6000 systems, but it does on these other two.

These legacy IRQ declarations are obsolete, but they aren't really wrong.
Meanwhile the two devices popped up until now both got IRQ declarations which
don't match the actual device configuration.

> We're going to be adding more to this table either way.  I /suspect/ the better solution
> is to revert 37c81d9f1d1b and add to the table all those that are broken.

I think we should have a list of only the wrong IRQ declaration and
apply the fix
just for them, instead of applying the fix to all devices and skip it
for selected
devices the fix breaks.

-- 
Regards,
Chuanhong Guo
