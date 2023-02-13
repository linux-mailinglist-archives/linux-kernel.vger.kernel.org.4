Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935C1694300
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjBMKgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjBMKgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:36:33 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7813217CD2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:36:09 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id d16so4293939ioz.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MB6QgxzH0xV/jeUMQj67Vw4mnLp5zoDu0fxoHPLQUaA=;
        b=IG2IretlOcw+z4pwWWM5lSZI848RIW7S4QEelsNLH0uDw+n6Ns7ANXKOUPM0VMwtT+
         FzgirQFCKjkU2mMLnK/7GAqSNJm+6PH8vnL3FY9QrVag+MDyOxs60zYhNzkxMPhP/n0C
         62w2svDn85cJQraYhO2HLkuCeEiSfhT+yyBe4X9dJlkDLqoxYoHVogY17Svp7/HaQgUo
         uoQZn08BjjI2Hkq6ne85hJbK5MEqRfSOUXPyEK/UdwNS9p3TcsQxe0KML2Uq9a7DXjbM
         s5B0CfTNOG7Pj9x1yup/qcDVQvAlXmjrNSU1/5M7hPKwcTXQTURJ2b7RJzjxvEjpcEe+
         xa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB6QgxzH0xV/jeUMQj67Vw4mnLp5zoDu0fxoHPLQUaA=;
        b=3cMHtjSc4MSbxm0DBTMVda8XL5bwV6r1htwBeOdJKXI2sEuvHDukDRXZH9+bLHKhQp
         QuuibDNO2uSTXhFdEO6Ez5fm03yFfc7vcVf6SImhSsPu2z5VZPDLycUivM4UNPfXXE3T
         PJ8yrmXOxpihqMbCwZP22y+U3bTW2f7jR5plEJE3M08S5E1AIJsxJx61IMOBnNsCE1yH
         Y6CeGfRB3vwQJGOAZ85W1Jthm7WjYuR1daSubVaRP2+ZxJMyd/xGSLmb8VIuDt6CjFhX
         y6NdQ/eU/TK/Zt82gl99VVI5iaVygQ9PwLEOwQ0WQ8QVwzAfxJNv3783ylP4yyZRRkQO
         dSbA==
X-Gm-Message-State: AO0yUKWPfYSALCOcdftub9bpQciNWTpNZ+Nnp2N6XSuPLlFthjfZLrzc
        uwLk+UPrTktVEhJTNS61NHWR4bOACqoWMmdYSu8Xlg==
X-Google-Smtp-Source: AK7set+xYzi0y7mls5yH064yKj0n1VIpNRvrSBS212i/X19YyD1Tom5PcHDLJ4Gey/fWP9Ef0SQi8iqB24Ns7fnVDIA=
X-Received: by 2002:a02:a794:0:b0:3ad:3cae:6378 with SMTP id
 e20-20020a02a794000000b003ad3cae6378mr12237646jaj.16.1676284567286; Mon, 13
 Feb 2023 02:36:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <923c507edb350c3b6ef85860f36be489dfc0ad21.1676063693.git.andreyknvl@google.com>
 <2085e953-ff9d-4d2e-cb35-24383592f2c4@suse.cz>
In-Reply-To: <2085e953-ff9d-4d2e-cb35-24383592f2c4@suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Feb 2023 11:35:28 +0100
Message-ID: <CAG_fn=VHAJ4tyVeEv4ZUcP9eAt7+Teatgfu6APdEDM6J1jqGhQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] lib/stackdepot: rename slab to pool
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:20 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 2/10/23 22:15, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Use "pool" instead of "slab" for naming memory regions stack depot
> > uses to store stack traces. Using "slab" is confusing, as stack depot
> > pools have nothing to do with the slab allocator.
> >
> > Also give better names to pool-related global variables: change
> > "depot_" prefix to "pool_" to point out that these variables are
> > related to stack depot pools.
> >
> > Also rename the slabindex (poolindex) field in handle_parts to pool_index
> > to align its name with the pool_index global variable.
> >
> > No functional changes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Alexander Potapenko <glider@google.com>
