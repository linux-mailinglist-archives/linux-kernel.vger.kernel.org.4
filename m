Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BED5EFD99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiI2TGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiI2TFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:05:54 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDBA1438F5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:05:51 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q10so2573650oib.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=d0crPrIiHDvTjv4ASul3Goxd2GrqWv18ntDF0Hrl2co=;
        b=H5ifccgQ3ejZODwR+iA8IAzLi9dYu0f/LWjubXNYIvuq6neuxtgYbJuqppjEF2uYEm
         XFRqX/6m+EvnCT042dj16sp22LNx4emifWUuDPPtKjkWMVmPKJQKgoy3MUns0MnhYiFa
         ZyS1bB5jGNU78LB/vrVxnTpd2ZLgqzBlT8X7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=d0crPrIiHDvTjv4ASul3Goxd2GrqWv18ntDF0Hrl2co=;
        b=c6qjQHs+12f+xzTCly+Mz9+Vqn//iddkFWBkXo3gS7pFGA6DcI9R4p/7lTVn3S49Tv
         ZFCLj1zW4hJnJ4N3g/Yh21SH8/zKY7RS9xUJzur/DgjAf7n8jCFHSklcp9Oi05/q0JN5
         /oFvtMsXhGPkQ+9Ld8pnYTdXraBjtoADWQY5ZM9+ORLwLuXZX1xskT2D5gTJz37YSIIN
         FCOy8tJCAZFws7H0+gfTHIn3mwkG/WkS2rQJojsyehnB/9lpD2AzXF+HHRQ4/XHh1die
         nNk6fWVuPL+VBD08vtAlkcsOc98kzAHXrpCqrYkXjB18WYaQmSaeeQ1KAyfGqLeXOyV0
         S9yw==
X-Gm-Message-State: ACrzQf1tc5MDTj1moEpRxT1iJ8oyMzpJO9cNgahVkx3pRyTpfNryvHWr
        DmEI+WQGI5RyCZ3wXKoOJFOTpXe1NxRd4A==
X-Google-Smtp-Source: AMsMyM4XSDeJJZv/j25jepzBuutpZXsUjvYXDR1FQI8mT+2Delqm1P6PqG/w8FsNlLfT18GdwOc9fQ==
X-Received: by 2002:a05:6808:3012:b0:351:3f4:d060 with SMTP id ay18-20020a056808301200b0035103f4d060mr7842740oib.241.1664478349486;
        Thu, 29 Sep 2022 12:05:49 -0700 (PDT)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com. [209.85.160.54])
        by smtp.gmail.com with ESMTPSA id v32-20020a4a8c63000000b00475d676d2d4sm72260ooj.16.2022.09.29.12.05.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 12:05:48 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-131b7bb5077so2945622fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 12:05:48 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr2868462oab.229.1664478348247; Thu, 29
 Sep 2022 12:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <dacfc18d6667421d97127451eafe4f29@AcuMS.aculab.com>
 <CAHk-=wgS_XpzEL140ovgLwGv6yXvV7Pu9nKJbCuo5pnRfcEbvg@mail.gmail.com>
 <YzXo/DIwq65ypHNH@ZenIV> <YzXrOFpPStEwZH/O@ZenIV>
In-Reply-To: <YzXrOFpPStEwZH/O@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2022 12:05:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLgM06JrS21W4g2VquqCLab+qu_My67cv6xuH7NhgHpw@mail.gmail.com>
Message-ID: <CAHk-=wjLgM06JrS21W4g2VquqCLab+qu_My67cv6xuH7NhgHpw@mail.gmail.com>
Subject: Re: [PATCH 3/4] proc: Point /proc/net at /proc/thread-self/net
 instead of /proc/self/net
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:00 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Which is insane, especially since the entire problem is due to wanting
> that directory to be different for different threads...

Absolutely. This is all due to Apparmor (a) basing things on pathnames
and (b) then getting those pathnames wrong.

Which is why I'm just suggesting we short-circuit the path-name part,
and not make this be a real symlink that actually walks a real path.

The proc <pid> handling uses "readlink" to make it *look* like a
symlink, but then "get_link" to actually look it up (and never walk it
as a path).

Something similar?

                 Linus
