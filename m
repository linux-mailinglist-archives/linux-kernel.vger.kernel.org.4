Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE86150DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKARht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiKARhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:37:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054691CB1C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:37:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u24so13567153edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cdUAsiAgmBJ1jbIAcY/gGR+Z/7ih0XBIpAP4mnSXYwg=;
        b=U+3jcriNI6G3mRzAxSj20osZtTDZErBW8Nh3ObL1xuyZVmynG7VTQ6hdaJDZfvYuc4
         BsAvfNmsSOYVQr1aPoTaBNp/Wjsp/mcsuXhQVkBEvgszY1b+jniCkvoAvlnhfUO9/7Ew
         nYABzAW6uipYWW4pCOp3Jvxu/hanu2Vo9v1kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdUAsiAgmBJ1jbIAcY/gGR+Z/7ih0XBIpAP4mnSXYwg=;
        b=ihddnHFpOzKB0xCG7L1HAKUMdBacRFgQGgb7Ad+GXp5rlqA3u2RIhDAQi4Ize6+mW1
         UDcoIE/Ja1jBPoGk558REc5rIvWcDPKha2kqV/LcFtiR5J4lEnnW+ZKZybuiZZAvoiZJ
         d+yUpfH2aaMgR5VPF/ZCIA9S2/D7g1f7sy867whmERP0DY95F12zTRM5sf0iD3rD8QyX
         A0wAW+fPwUaRUOoy5hmS3kO0q+ygoaV2qaztqtIl4CgXN5Zyq9UnLkEkdqsKpGk9t7JQ
         m5rGASK5GBXV54dBEgP8eEsA0x7AbPwnu+RnxzGLUWCGyprkKw5pzAuDnGDcOkro6Jqe
         kuLw==
X-Gm-Message-State: ACrzQf2bfDVoeYRkV0wFjaXMYfeny7mw5a/DdlxrS+dgWpFstJp+t/bz
        nUIW5FB4O2TBdBa5GWaitODWvyh3iHiCWPZ1
X-Google-Smtp-Source: AMsMyM5ebDvYyqKxpcAYm3F4xDirivj+cNvE9O24Ywokb2WFP+TtQBLf0e+ROZpZetJxMjGEcyVBmg==
X-Received: by 2002:a50:eb05:0:b0:457:c6f5:5f65 with SMTP id y5-20020a50eb05000000b00457c6f55f65mr19762375edp.311.1667324259389;
        Tue, 01 Nov 2022 10:37:39 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id f10-20020a50fe0a000000b00443d657d8a4sm4655399edt.61.2022.11.01.10.37.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 10:37:38 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id y69so22795695ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:37:37 -0700 (PDT)
X-Received: by 2002:a05:6402:1947:b0:461:a47d:274 with SMTP id
 f7-20020a056402194700b00461a47d0274mr20093632edz.165.1667324257158; Tue, 01
 Nov 2022 10:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221031204320.22464-1-mario.limonciello@amd.com> <20221031204320.22464-2-mario.limonciello@amd.com>
In-Reply-To: <20221031204320.22464-2-mario.limonciello@amd.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Tue, 1 Nov 2022 13:37:26 -0400
X-Gmail-Original-Message-ID: <CAM7w-FXAGki+k9aP0wV1Qs8dKqpPXgY9ZJR_a83ETrUF6ZRZOw@mail.gmail.com>
Message-ID: <CAM7w-FXAGki+k9aP0wV1Qs8dKqpPXgY9ZJR_a83ETrUF6ZRZOw@mail.gmail.com>
Subject: Re: [RFC 1/3] PM: Add a sysfs file to represent whether hardware
 reached the deepest state
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        rrangel@chromium.org, platform-driver-x86@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

On Mon, Oct 31, 2022 at 4:43 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> +void pm_set_hw_deepest_state(u64 duration)
> +{
> +       suspend_stats.last_hw_deepest_state = duration;

I'm wondering if we could add a userspace notification here. Then
userspace wouldn't have to synchronize with the suspend/resume state
of the system when reading this entry.

What about sysfs_notify() ? Or via udev?

> +}
> +EXPORT_SYMBOL_GPL(pm_set_hw_deepest_state);
