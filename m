Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26A611FEC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ2ELt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2ELn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:11:43 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E8F85A88
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:11:43 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p141so6132187iod.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a05XFZRuF/egEfrk+8goUQtIMz5cRuT5WlopnCpocEA=;
        b=kovLSyB8MPVeIrLXWhsv4ebR53tgy1CbZfJhjTODbTdNXDFJYhSS58l3eIrBPQloXb
         X1pjzYRmxulUgTVO9lYnvjrDngx55x8ukqNGRn6r8jA1R2skNKQcbkyQvIXoP2mPTljg
         sS1maOrMjVjwYgXlW9qK6HUrsLu+iIKpJOxKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a05XFZRuF/egEfrk+8goUQtIMz5cRuT5WlopnCpocEA=;
        b=7nXljMCaMIt32kWTiX82OvWSyb7n/eb/Uxs10aHg3dqdh/B5eSAYfRaWWmxScdSJWU
         UObzbYfgaSRLGqMgx5vx/k/8NbNhbs261gNMQTHT1a/C6SppKYYzLeNpsdLQznFXBiTe
         eG02Ht1JojBNN34jyktiMzgC5l8rYE595g6nktLLpxGcWelMmRHHysStZOkbjqYxoZE2
         EPnFy4ehLcKbd4Ql6EISBNUrKzZfNDo2Y4zy+HPotVvOzTmZIt9dpw8UskGQau5fIfvI
         wZ+XUd0d2lN8RJANHPR8V2blR0+zMN2svJhBW88D1CNbQ61ZdN10mJQI0rTSAuoswyYi
         n/cw==
X-Gm-Message-State: ACrzQf2fZ7CIj/HqxcTnmQl+8xAlBel5ab8FVsL750TNtHCleLTEi0Hp
        hr35LOgFm9JVtWfH1p8KG2yj5kU4LV7X20TpCPXuuw==
X-Google-Smtp-Source: AMsMyM4Y55scCBOsz86/H1I8gLjPFFzF+wX16Ll/6KNE81tm9k6eqk5HNMIvLNKpxTO1zj9SQrri/vM5tOasSmUIFeY=
X-Received: by 2002:a6b:4a01:0:b0:6bc:d4ae:321c with SMTP id
 w1-20020a6b4a01000000b006bcd4ae321cmr1385305iob.59.1667016702459; Fri, 28 Oct
 2022 21:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com> <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com> <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
In-Reply-To: <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Sat, 29 Oct 2022 00:11:32 -0400
Message-ID: <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,THIS_AD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 12:02 PM Rajneesh Bhardwaj
<irenic.rajneesh@gmail.com> wrote:
> I'd advise against this promotion based on my experience with S0ix entry failures.

On Thu, Oct 27, 2022 at 11:40 AM Hans de Goede <hdegoede@redhat.com> wrote:
> I'm not a fan of the change you are suggesting here.

Thanks everyone for the feedback. Looks like there is consensus that it's
not advisable to promote the warning. We will move forward with changes to
our monitoring infrastructure instead.
