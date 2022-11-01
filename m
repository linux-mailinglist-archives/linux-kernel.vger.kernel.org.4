Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0166142CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKABi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiKABiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:38:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B4013DD7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:38:54 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e19so7125379ili.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rFcFtrUWDD7wOJNwbyc+wIiDwYpeYSwMkMCUUwIfLCA=;
        b=ZCT1Zygf8gLVKF4L3NOckwmpB+hK95U0elPFNVSr4t2n6eM7vlJiOilioFuHkd4SVx
         fblsF3kARMPIfdP9ZpQFzTtmAlxt4g+xci12R57dLcRUqSWUpz+04aAki2RTvwuuSUuQ
         Fa0pGr9YiUZlbquYjoESaq762VoyFwoiBEckk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFcFtrUWDD7wOJNwbyc+wIiDwYpeYSwMkMCUUwIfLCA=;
        b=xWqSVnd6qFD0uUapArwtERj13RwcBN2DZeL+LVXf9xLUOHuCjR5PxQsHSPLLOVzAMa
         dgCEbHeCwYZG1i/BSHUVD9jqEFbrI2hCXrvsRQUiHVmvr7uuV43WybqYL4oukAomLP2v
         NfEk6I6bT4FR3+JTIZcS0oFMOK8OKhBA2G/XpAUNZTH6i+NOi+KxFq5cnv0rOeVPWK6E
         0444Ejt/tcfMONF56kcAiAa6CBmd48gQ0legjzqdfihu9Ek/5FljkB0Nrq9+rGeLxoCB
         S/APXoqo8BdgxXOMwtLObMEfp2uVYVpdeE8MRq3aziAfk9S40QIb5UX+ARPxG/HDJdrI
         o0Rw==
X-Gm-Message-State: ACrzQf3QjTSfCYAWjf0VrH2Z/HH4UXgB2C9qUV9Fe7kaZDSfxpiQcRgZ
        tUEOEY8TLlQWGuQClSbm07S3wXZ+I6ZWgZLYtVRYyw==
X-Google-Smtp-Source: AMsMyM7YqoFr83RhbdshghyOzE+J9fJTEUa6ewa//JFhpxcGATT30qD2gEQrx7vIdKbLQW5VAG2HCnrYfnA7uIt2RGo=
X-Received: by 2002:a05:6e02:c6b:b0:300:8f53:2c38 with SMTP id
 f11-20020a056e020c6b00b003008f532c38mr8338611ilj.253.1667266733422; Mon, 31
 Oct 2022 18:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com> <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com>
 <CAE2upjS6qRGRcuVYuAB5DMf66A7VcfCKKYEkpsr1My7RnKDFtQ@mail.gmail.com>
 <CAG-rBihDRq1y61tAp56yYCoTOSZXO9OZNzn7gXb_y8XaiO_zqg@mail.gmail.com> <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB610109F448E3FC8CE71FBA76E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Mon, 31 Oct 2022 21:38:42 -0400
Message-ID: <CAG-rBijSASfbfWQNarjGqj2UxQDOSdwM-qj5YA5A9ur=DNJf-g@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
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
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 3:39 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> Just thinking about it a little bit more, it could be a lot nicer to have something like:
>
> /sys/power/suspend_stats/last_hw_deepest_state

While I agree that reporting through a framework is generally better
than getting infrastructure to grep for specific strings, I believe
that a simple sysfs file is probably too simplistic.

1. We need more sophisticated reporting than just last_hw_deepest_state:

- sometimes the system enters the deep state we want, yet after a
while moves back up and gets "stuck" in an intermediate state (below
S0). Or, the system enters the deep state we want, but moves back to
S0 after a time without apparent reason. These platform-dependent
failures are not so easily describable in a generic framework.

- ChromeOS in particular has multiple independent S0ix / S3 / s2idle
failure report sources. We have the kernel warning above; also our
Embedded Controller monitors suspend failure cases which the simple
kernel warning cannot catch, reported through a separate WARN_ONCE().

2. A simple sysfs file will need to be polled by the infrastructure
after every suspend; it would be preferable to have some signal or
callback which the infrastructure could register itself with.

The generic infrastructure to support this sounds like quite a bit of
work, and for what gain? Compared to simply matching a log string and
sending the whole dmesg if there's a match.

Is the light worth the candle?

Sven
