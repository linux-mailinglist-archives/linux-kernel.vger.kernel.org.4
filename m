Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DFC623827
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiKJAaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKJAaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:30:08 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A90D11815
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:30:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x2so728337edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 16:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nlqLQiiaOaZsIVqPkpURbCqECGxlhLAGf8/oZgDPEwg=;
        b=TibEJ/dS9oqIAlyw0U4d9Y17tk1l/5W9NiA/VJLZylVbn2FOy3zk5VI/yoCYNAuGoE
         Oc/Um2qfEuVCzsSWM/0hQdPyYt1cE7yzSxpdx7nS7ovvnFNjrDg/SO+IHB7dUcl1WCSg
         iWprIbuqzyqir3yxeR8YrLGkhepBTjIioA0E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlqLQiiaOaZsIVqPkpURbCqECGxlhLAGf8/oZgDPEwg=;
        b=idVudR9UgGi2nEOBqt0mqoNzExZgfuDNfOzS5G2cq+hnTkg/UwlwhfrN6W28+MRfBC
         vtfPBxwMfCOAI3bTsyTGkbG5Y5wmN23pwhZrkWeZUt02pFignp2lO2TuwPG4tYIoc5ws
         T965oiusNvJGvf9FQD0WvDJ3fqlOEqRpiKXNA7GOxd7murG5iXfUTxy/9wyRywkdnM6I
         9gpNCgGH+oszJHcNSO7udTDM10wXEW0Ir+JKETmVviGE4OD6hSgz/blRZquGZmVlt7Xk
         l/9rITv0FW7P2nQ3yObNM19uisuW5OeOEdqFHH0j/fY4Ipr5hGK8gLJr4Y1Gqp2ssdOm
         PX5A==
X-Gm-Message-State: ACrzQf1gYw0dQhJ7uEntEevsy4PXH/tJxYyutU+VipEJBQn7F/ZmCABu
        LvZ8xvel8AJHEKFKBEKGl9IVoES9y5LLEQ==
X-Google-Smtp-Source: AMsMyM6WwbqDpS+fhmlXeL9phAOhVKva1Wt/INql4WX/Xqf3jwpErLSGjX1T5Cp0qoYlEfuGinHMvw==
X-Received: by 2002:a05:6402:6c6:b0:461:c7bd:7da3 with SMTP id n6-20020a05640206c600b00461c7bd7da3mr1339445edy.218.1668040205701;
        Wed, 09 Nov 2022 16:30:05 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906310500b007add28659b0sm6597030ejx.140.2022.11.09.16.30.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 16:30:03 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id z14so134998wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 16:30:03 -0800 (PST)
X-Received: by 2002:adf:e44f:0:b0:236:59a3:c5a8 with SMTP id
 t15-20020adfe44f000000b0023659a3c5a8mr40946801wrm.396.1668040203082; Wed, 09
 Nov 2022 16:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20221103180120.752659-1-evgreen@chromium.org> <20221103105558.v4.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <202211041132.E8CB636@keescook> <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
In-Reply-To: <CAE=gft4+KHVd_cNApo6EcTtxSDQDNB-nPXdus-0K8pQdWF+tiw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 9 Nov 2022 16:29:26 -0800
X-Gmail-Original-Message-ID: <CAE=gft6O6WFbVL4mQ6trS4UkfkvNEFcUT0eN+6QAsXbf6DLdvQ@mail.gmail.com>
Message-ID: <CAE=gft6O6WFbVL4mQ6trS4UkfkvNEFcUT0eN+6QAsXbf6DLdvQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 12:11 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Fri, Nov 4, 2022 at 11:33 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Nov 03, 2022 at 11:01:12AM -0700, Evan Green wrote:
> > > In addition to the private key and public key, the TPM2_Create
> > > command may also return creation data, a creation hash, and a creation
> > > ticket. These fields allow the TPM to attest to the contents of a
> > > specified set of PCRs at the time the trusted key was created. Encrypted
> > > hibernation will use this to ensure that PCRs settable only by the
> > > kernel were set properly at the time of creation, indicating this is an
> > > authentic hibernate key.
> > >
> > > Encode these additional parameters into the ASN.1 created to represent
> > > the key blob. The new fields are made optional so that they don't bloat
> > > key blobs which don't need them, and to ensure interoperability with
> > > old blobs.
> > >
> > > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > There's a lot of open-coded math for the bounds checking. I didn't
> > immediately see any problems, but it'd be nice if there was a way to
> > hook a fuzzer up to this, or at least write some KUnit tests to check
> > boundary conditions explicitly.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Thank you! Yes, agreed about all the bounds checking. I could probably
> pull out the "check for src + 2 > end, then get_unaligned_be16()" into
> a helper function. Let me see if that makes things look better or ends
> up looking the same.

A helper function cleaned this up nicely, so I'll send that in the
next spin but not yet pick up your reviewed tag.
