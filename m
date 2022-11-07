Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5358D61FF38
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiKGUMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiKGUMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:12:18 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2F126541
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:12:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b2so33176155eja.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=enMdjmIsSbUUYGb+RiHPQULVTIcs0r1uA7QvgYehDfo=;
        b=cK5mzUepaprD41nCiRUmaLmzTIgcnNw5msQaClmACmYhAcO7XK6rJUBvOqZtgby6y8
         52QvjVVQH7ojFFZrM7qfAy0IdolyIX8knrA6IaYyvW21uhXHySccJ3/m2Wleu58EVtDt
         6MIVe9aRiDrWdsThdVgafQbhigdkLUk4g2knQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enMdjmIsSbUUYGb+RiHPQULVTIcs0r1uA7QvgYehDfo=;
        b=prQ4S0i5Iw2r8S2wbfCMAlFfE0yNmPQH4Nl1tnKQFNNaOKOYx/aSM4jdjUb5eC+dcH
         Ov/RpXiFGTawVQjYmaQBCF2g2Ui1fAcTh+onJsOWJLVldjg00MWX49w5uJ59shljtHDD
         K+ev4i+p8RbVes/QXHqinEwmAdQMJMYDXp15RrvYhzTEnoDDGLOsIyOdodw86ToJlf6e
         /nMJGF1BLrsP4CaTbSudW/TL7lc75WIwdkvCG5gSh95mg1niEfFEBwzntklVmug1H7fr
         JldkrJd4prFBfEg0EhoF/+Bpe9prsFb69lYx0P8gVNQJPCMr6f06sdbVUG8maCOkSLYR
         D8zw==
X-Gm-Message-State: ACrzQf3I1ee6195tAyJIOkvqn/G8DozDENd2CyIjmjnjCXfjsgBh84Te
        b3OgSnzut5m8QIutQLHDVJ7GaukLF8T9Wg==
X-Google-Smtp-Source: AMsMyM4Ph345RUwX+gkdz/BFG7fn8Btv92e3rW39RQUNautQE1gOKp5Q+feRlghPD5VkUmjt+Ukamg==
X-Received: by 2002:a17:907:3f19:b0:7a3:2317:4221 with SMTP id hq25-20020a1709073f1900b007a323174221mr48868653ejc.562.1667851936480;
        Mon, 07 Nov 2022 12:12:16 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709066d8300b0074136cac2e7sm3775497ejt.81.2022.11.07.12.12.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:12:15 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id k8so17940720wrh.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:12:15 -0800 (PST)
X-Received: by 2002:a5d:6dc3:0:b0:22a:bcc3:21c6 with SMTP id
 d3-20020a5d6dc3000000b0022abcc321c6mr34070892wrz.450.1667851934711; Mon, 07
 Nov 2022 12:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <202211041132.E8CB636@keescook>
In-Reply-To: <202211041132.E8CB636@keescook>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 7 Nov 2022 12:11:38 -0800
X-Gmail-Original-Message-ID: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
Message-ID: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] security: keys: trusted: Include TPM2 creation data
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 11:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 03, 2022 at 11:01:12AM -0700, Evan Green wrote:
> > In addition to the private key and public key, the TPM2_Create
> > command may also return creation data, a creation hash, and a creation
> > ticket. These fields allow the TPM to attest to the contents of a
> > specified set of PCRs at the time the trusted key was created. Encrypted
> > hibernation will use this to ensure that PCRs settable only by the
> > kernel were set properly at the time of creation, indicating this is an
> > authentic hibernate key.
> >
> > Encode these additional parameters into the ASN.1 created to represent
> > the key blob. The new fields are made optional so that they don't bloat
> > key blobs which don't need them, and to ensure interoperability with
> > old blobs.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> There's a lot of open-coded math for the bounds checking. I didn't
> immediately see any problems, but it'd be nice if there was a way to
> hook a fuzzer up to this, or at least write some KUnit tests to check
> boundary conditions explicitly.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you! Yes, agreed about all the bounds checking. I could probably
pull out the "check for src + 2 > end, then get_unaligned_be16()" into
a helper function. Let me see if that makes things look better or ends
up looking the same.
-Evan
