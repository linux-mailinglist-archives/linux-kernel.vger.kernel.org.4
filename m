Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D8D667F89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjALTpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbjALToj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:44:39 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2386E63;
        Thu, 12 Jan 2023 11:38:10 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id u9so47348174ejo.0;
        Thu, 12 Jan 2023 11:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VdqiaMUL5pJHnh0vv31PI0BCnozHCyhdFgddFMC5oY=;
        b=gfgAfo5bxz9lk6VI5sHTkN9LIsuQgo+vOrwWrGvlRyCOsD2SPw7X5sdPQtJhJV6uFR
         a0I4xd6e3EY1K8+xKFqn5hO6oos6n51Sc3VGT57ANi/PekZS4bsclTaig3QxMQa+wTK9
         2He9NtLMjmWKBmV+S4aDgSfLvv7EtQ672tPq8SMqvExRj90IHAjUvLMmbhhWn68BQSux
         rQClUWBMiMoOYnz4iepL97+dOlEWOyCoxk9DkBdVDmVkUGk3JR6c6CYxq2lb548s3wgo
         /NoK7CSEdOqGVNxJc7RMrAA7BmzDrZlKB/gY8XAGkEw2CywEqjjnAlHUqy7mrMgWmvhA
         TyVw==
X-Gm-Message-State: AFqh2ko+7E2pOp6o/+cAovUW0BfkzkV7dIRZR4T9OCQ63zNU5/Pzc82P
        lfJP2TGJstT0ROOWrtJgAzXAT+01CIkvmHG+p+M=
X-Google-Smtp-Source: AMrXdXvKZPHXU+H5/fEX/mbk5PlNsB/sE3EpVAawCLZc/TnIVrXachJXZCNezgeMMeNaEjDeNP0Y9wpWGuHMg6eEhbc=
X-Received: by 2002:a17:906:9484:b0:84d:3c6a:4c55 with SMTP id
 t4-20020a170906948400b0084d3c6a4c55mr2556546ejx.509.1673552289361; Thu, 12
 Jan 2023 11:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20230110211839.19572-1-rick.p.edgecombe@intel.com>
 <CAJZ5v0jnp3jLdD1wN1NjMfxrt+gYZ+im_quHdgsOrWve0XQaWg@mail.gmail.com>
 <cd2a9ccec0d88821fb0c7580f7ae934f2de71ddf.camel@intel.com>
 <CAJZ5v0hffKjor=kzr71esaw7M2BV5vCTEY7pg67-iWXZ98sQBw@mail.gmail.com> <0c7760bf5976cb64c952df5601eae14fd33fbe2e.camel@intel.com>
In-Reply-To: <0c7760bf5976cb64c952df5601eae14fd33fbe2e.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 20:37:58 +0100
Message-ID: <CAJZ5v0hmuWRtMkfsbPkiK5J=S5XvO1U2tzrL+dpPBGwbLJz=5A@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hibernate: Use fixmap for saving unmapped pages
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

On Thu, Jan 12, 2023 at 8:15 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Thu, 2023-01-12 at 15:15 +0100, Rafael J. Wysocki wrote:
> > > >
> > > > I don't think the above is needed.  The code using this function
> > > > cannot be preempted anyway AFAICS.
> > >
> > > The reason I thought it was useful was because this function is now
> > > defined in a header. Someone else might decide to use it. Does it
> > > seem
> > > more useful?
> >
> > Well, it is exposed now, but only in order to allow the __weak
> > function to be overridden.  I don't think it is logically valid to
> > use
> > it anywhere beyond its original call site.
> >
> > To make that clear, I would call it something hibernation-specific,
> > like hibernate_copy_unmapped_page() and I would add a kerneldoc
> > comment to it to describe its intended use.
>
> Ok, I'll change the name, that makes sense.
>
> On the warning, ok, I'll drop it. But to me the code stand out as
> questionable with the PTE change and only the local TLB flush. It's a
> bit of a comment as code on a rare path.
>
> >
> > Furthermore, I'm not sure about the new code layout.
> >
> > Personally, I would prefer hibernate_map_page() and
> > hibernate_unmap_page() to be turned into __weak functions and
> > possibly
> > overridden by the arch code, which would allow the amount of changes
> > to be reduced and do_copy_page() wouldn't need to be moved into the
> > header any more.
>
> Currently hibernate_map_page() maps the page on the direct map and
> doesn't return anything. This new code effectively creates a readable
> alias in the fixmap. So it would have to return an address to use so
> the core hibernate code would know where to copy from. Then it would
> have to pass it back into hibernate_unmap_page() for the arch to decide
> what to do to clean it up. I think it would be more complicated.

AFAICS, you only need hibernate_map_page() to return an address that
will be passed to do_copy_page() (that doesn't need to be touched
otherwise) and hibernate_unmap_page() would just do

clear_fixmap(FIX_HIBERNATE);

so it may as well take the page as the argument.

> There is also already multiple paths in hibernate_map_page() that would
> have to be duplicated in the arch versions.

But only if the arch decides to override the originals.

Now, the only caller of both hibernate_map_page() and
hibernate_unmap_page() is safe_copy_page() in the "else" branch.  Your
current patch replaces that branch completely with an arch version, so
they are not going to be invoked on x86 anyway.

> So I see the idea, but I'm not sure it ends up better. Can we leave this one?

I first need to be convinced that it is indeed better.
