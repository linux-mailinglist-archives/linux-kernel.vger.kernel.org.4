Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA2A66478E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbjAJRk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjAJRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:40:19 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5438950F68;
        Tue, 10 Jan 2023 09:40:17 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id ss4so23360950ejb.11;
        Tue, 10 Jan 2023 09:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+QsUiSxK3PLQXBjHmmKYMGPtd8ek6iATd0MJHA3O+w=;
        b=L5VZ0uWZosvaS4VIW4JEoSYgva5ei5PNNjSlbKWiz2O2NiRvCj4J8lJbWR5c5e3IGl
         Jo6tlCAI/m2bxTszvWZWSADiMj9anGwh9ODgxaOhTGHXXWGfYnwwlzFvxbmlBSrHBbGE
         v/MnNd5SlZnhUImg2Vcgep8VykYQzVbF3t+CkR0/tv8ApR+oyiESzaLgej9ZXk15mBq5
         QnW3bn2AwcpcC+3vDYBBDXWJIqpZB8RHh9Jqb1K8jslN7IkeXk0J+v3HSLpG4mbhiq1W
         lX07WKf71nbX69ESb1dLJ/0eEWnkvG3d67GQMZro3wDsOCGTSdkhGVk0lXMl0RhNkmij
         9nOw==
X-Gm-Message-State: AFqh2kqlz5vtvIYYNn70NS4/+jO0v5eJuM58Ob8mA6XnMCO+juQ0f5As
        8zBqa/rurCJviB3v/7F5g6Ktb3GekA1KRBhK0Uo=
X-Google-Smtp-Source: AMrXdXtqBaV/vMqS7oyXPfqzceQpEq4DKugP8ej8FBQsfaZhqFW5vaiELvY6lEgz3Sv6YxYml+sqjI7k8TOXhqelCeU=
X-Received: by 2002:a17:907:6d2a:b0:7c0:efba:b39c with SMTP id
 sa42-20020a1709076d2a00b007c0efbab39cmr7548518ejc.209.1673372416425; Tue, 10
 Jan 2023 09:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20221205002804.21225-1-rick.p.edgecombe@intel.com>
 <CAJZ5v0iZ8QdCMca1F+z2NJ8+a-jUkGMSNp2KRovCB-aMjHF7qg@mail.gmail.com>
 <c4c95945df72fda7b7d6f333a4aea7e19d7e684c.camel@intel.com>
 <CAJZ5v0j6qd930BKWWf-e+_Vod0Wv16LZChCOa0yf0_uLC=UMyw@mail.gmail.com> <8f73fdf9d1c9b94cbe1587bf8f5271ca65f17caa.camel@intel.com>
In-Reply-To: <8f73fdf9d1c9b94cbe1587bf8f5271ca65f17caa.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 18:40:05 +0100
Message-ID: <CAJZ5v0i6cxGD+V6G+q-Y_Lp-ov51_zmkZr8ZGpCtqWV-e=BsLg@mail.gmail.com>
Subject: Re: [PATCH] x86/hibernate: Use fixmap for saving unmapped pages
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Brown, Len" <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 6:37 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2023-01-03 at 18:55 +0100, Rafael J. Wysocki wrote:
> > > > OK, so I don't feel like it is 6.2 material at this point.
> > > >
> > > > Please resend it when 6.2-rc1 is out so it gets some more
> > > > significant
> > > > linux-next coverage before going into the mainline.
> > > >
> > > > Thanks!
> > >
> > > Hi,
> > >
> > > This still applies fine on both tip and Linus' tree. Is it a good
> > > time?
> >
> > Sure.
> >
> > Thanks!
>
> I didn't see this picked up anywhere. Not sure if I'm missing it, or
> this exchange was just ambiguous. I thought you could just apply this
> send of it. Do you need anything from me?

Technically I could, but it takes less time if I get a fresh copy of it.
