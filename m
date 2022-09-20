Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93305BEB37
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiITQkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiITQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:40:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBC12980E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:40:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bj12so7474038ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JMNdVTN29xxheNQ60C0UdJixTzdS2o/Kn71ZSUiC498=;
        b=O0fQbt4HqeW76QZSC/Cs+vdBiibzuNSAXu1nr7RuuSsmrTy2AMjiQo3cT9tlr/Oyd3
         ToPPH5FZQ40YZ5T/oTqZGvi1FWZELBe65b4byLzhgcbnc/UxHw8t6p1iNUSwOlJRs8oD
         P3hieH4mgO56j5uNyt13K0pknu/i8ckWVrxjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JMNdVTN29xxheNQ60C0UdJixTzdS2o/Kn71ZSUiC498=;
        b=Wdx/FxGq6oP6n4skQSJjMWf5ubL6GMo7i7sGZPjefi8aKxXgAd3Y8jgkJUuOIE2oKo
         g7LWxbu1qfHJ81Eun/W6eyr5r0J3fJGigg17p7wpFDwwHTXYtlB796wHMzUls8JFzdAC
         +ldoUHjmAySBuwtUMBO3W06XaN7HCQQ/cSWtXWWVqm/idbvYPIA7q67cmuy0FgTkY6l4
         HmFLhVLlgfDvk+qsr3bW5rMk9xMLyxbc3DgNZFMTAGaRMmnzF4EAnyA1OaPoB5tTXVD2
         87KAE+NqtuUi+xzPb5UQw393kS1yFGE8O49pQeHNGp+ID1QZdUcAmAM7if3yG4SYhpcE
         Rh3A==
X-Gm-Message-State: ACrzQf1e2lDdiXQwrUSvQFCQQ1yfEZgxw6gz3KdAfLlphR4dRb0auG5E
        blXFw9Rn/C39K6REPlm1uVKOw6CezK/PIg==
X-Google-Smtp-Source: AMsMyM5jOme2ePD05MgbtJg+icdzlsFTwzOqU8tm4QXJw1O0+eloNIporRRvuglqtlnRA4FGJPaN1g==
X-Received: by 2002:a17:907:802:b0:781:8017:b2df with SMTP id wv2-20020a170907080200b007818017b2dfmr6101219ejb.606.1663692003726;
        Tue, 20 Sep 2022 09:40:03 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id ky10-20020a170907778a00b0077826b92d99sm159916ejc.12.2022.09.20.09.40.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 09:40:03 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id s14so3298631wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:40:02 -0700 (PDT)
X-Received: by 2002:adf:a4ce:0:b0:22a:f5e8:6dcc with SMTP id
 h14-20020adfa4ce000000b0022af5e86dccmr9099428wrb.445.1663692002281; Tue, 20
 Sep 2022 09:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220823222526.1524851-1-evgreen@chromium.org> <20220920084648.GA17087@duo.ucw.cz>
In-Reply-To: <20220920084648.GA17087@duo.ucw.cz>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 20 Sep 2022 09:39:25 -0700
X-Gmail-Original-Message-ID: <CAE=gft65bdcoU-oF1=QK2Pg1-kO5gSXk7jxa99fErHK3osytCQ@mail.gmail.com>
Message-ID: <CAE=gft65bdcoU-oF1=QK2Pg1-kO5gSXk7jxa99fErHK3osytCQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Encrypted Hibernation
To:     Pavel Machek <pavel@ucw.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, apronin@chromium.org,
        Daniil Lunev <dlunev@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Paul Moore <paul@paul-moore.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 1:46 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > We are exploring enabling hibernation in some new scenarios. However,
> > our security team has a few requirements, listed below:
> > 1. The hibernate image must be encrypted with protection derived from
> >    both the platform (eg TPM) and user authentication data (eg
> >    password).
> > 2. Hibernation must not be a vector by which a malicious userspace can
> >    escalate to the kernel.
>
> Why is #2 reasonable requirement?
>
> We normally allow userspace with appropriate permissions to update the
> kernel, for example.

I'll take a stab at answering this. I've also CCed one of our security
folks to keep me honest and add any needed additional context.

ChromeOS takes an approach of attempting to limit the blast radius of
any given vulnerability as much as possible. A vulnerable system
service may be running as root, but may also still be fairly
constrained by sandboxing: it may not have access to all processes,
the entire file system, or all capability bits. With Verified Boot
[1], our kernel and rootfs are statically signed by Google (or
yourself if firmware has been reflashed). Even if a full root
compromise occurs, it's difficult for the attacker to persist across a
reboot, since they cannot update the kernel or init flow on disk
without the signing key.

We do our best to lock down other escalation vectors from root to
kernel as well. For instance, features like LoadPin help prevent a
malicious root from simply loading up a payload via insmod.

So in cases like ours, jumping from root execution to kernel execution
represents a real escalation in privilege. Hibernate as it exists
today represents a wide open door for root to become kernel, so we're
forced to disable the Kconfigs for it. This series, along with another
patch to restrict unencrypted resume, would add the guardrails we need
to prevent arbitrary code from moving into the kernel via resume.

-Evan

[1] https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/
