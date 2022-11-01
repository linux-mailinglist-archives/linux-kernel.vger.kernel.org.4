Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3726A61508B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKARYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiKARY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:24:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBD4178B6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:24:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so38819199ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uI6kpWIoJxkOMk1R26NK02/okOguX+poh3iNl8T8BbY=;
        b=bDSNrrXeg9qyQlzb8dF2Cu9wziw0kx0uUv/+Vn8hkvB26FVea8iZsZzZ7GgAtRdJUS
         n5biy6LDqqrKP92AgGqWGE5CJ1Ib/P1258GOTT+ZVuhH1fNrD5CJuzjn0htgWUzsXFt2
         4IfDCFlBNefKoj7ro9bAZBqX7w1PneCcJc/jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uI6kpWIoJxkOMk1R26NK02/okOguX+poh3iNl8T8BbY=;
        b=gpICs7+Ki2YpyCRoJE/CyzkYIVRFSNmTOcNEsYwilpmUOjXPf8rJj/JgzvCa2H7Kxn
         jrcefaQnGvmDavwRG0sZh3wCqQIETeG1N46fPbMAwE9JZAGHwNGZa4TSouE5DQLHSuOM
         jTCAYQEqxjxSATrRI8hXIcmzirh6HFl6saUjjjBba1/ecKxufdXwKcGpQ0qN0bERDTim
         Z90OLpF4/BKyHsYeyFJHPiyaSnFGhqgC5ifwrPztZ407P6ps4KMcHgqXYrxbN9hjMjLB
         l0C6USSyXpriZ9RHGUMZWc0+wedHxNDVtCGbXplgApZOleNfsttcbS3Go67mhEB5jZii
         iJsA==
X-Gm-Message-State: ACrzQf2Is/xNW526/j0RJnRt2KewbDmreY+sABFNTAzDrL80sptMRQBS
        teq2ucwa49aehokCGxCJAGZka5ooSANPpGmN
X-Google-Smtp-Source: AMsMyM6aJNiYuS8gwbRqlzC/avwgFv/dh3qgX25oQXB8KHEP5Rj/uI41vmxwqN8qXqMAVkzgan19iA==
X-Received: by 2002:a17:907:7211:b0:7ac:e7b0:3bb5 with SMTP id dr17-20020a170907721100b007ace7b03bb5mr19300036ejc.515.1667323464308;
        Tue, 01 Nov 2022 10:24:24 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id g5-20020a50ec05000000b00461cf924029sm4668720edr.42.2022.11.01.10.24.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 10:24:22 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id kt23so38730765ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:24:22 -0700 (PDT)
X-Received: by 2002:a17:907:96a0:b0:7ad:960d:1789 with SMTP id
 hd32-20020a17090796a000b007ad960d1789mr19755941ejc.305.1667323461701; Tue, 01
 Nov 2022 10:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com> <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com>
 <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
 <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com>
 <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CACK8Z6E7=xt118d47FTpmgKHgUBgH48FQzTi5iL90C3MjHb-3Q@mail.gmail.com> <29e7c8f5-0784-6501-e3fb-f2ab33d3f438@amd.com>
In-Reply-To: <29e7c8f5-0784-6501-e3fb-f2ab33d3f438@amd.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Tue, 1 Nov 2022 13:24:10 -0400
X-Gmail-Original-Message-ID: <CAM7w-FUTHEAis-F3bDWSsxzQdT-koD-UO54ee9NzbBpKiQhPzQ@mail.gmail.com>
Message-ID: <CAM7w-FUTHEAis-F3bDWSsxzQdT-koD-UO54ee9NzbBpKiQhPzQ@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 4:55 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> I just spun together an RFC series for this idea and while doing it I
> had the same realization.  So I left the warning messages in place for
> both drivers.
>
> You can take a look at the series here:
>
> https://lore.kernel.org/platform-driver-x86/20221031204320.22464-1-mario.limonciello@amd.com/T/#m6c7db55c98b8a3ce8c48d451fc01c1d9b0df37fb
>

We've had some internal discussions within ChromeOS intel big core,
and we believe this is a worthwhile effort, and we are supportive, as
long as our current S0ix fail detection will not break for the
foreseeable future, i.e. as long as the warning message and register
dump stays in place. Which is the case for your RFC.

+swboyd@chromium.org who expressed interest in doing something similar for ARM.
