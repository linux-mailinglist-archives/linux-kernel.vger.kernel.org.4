Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A406608AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjAFVQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjAFVQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:16:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3920926D;
        Fri,  6 Jan 2023 13:16:07 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d17so2455219wrs.2;
        Fri, 06 Jan 2023 13:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OP+YfN5L/CAL5jnc65vOTHTY7IY6KT8aEtFoTjI7ujo=;
        b=gnUAtsSOMFLBBLUcvV5Q0U3dKVfxAtie0fDP4YcsrbWSqEphdsCYQc0QrAwUZqBZJG
         ru9lMiR5yYJlxaIHYNCRq5Wojzd/cy+mkt4Jq4PMjmgFDNEjV9OE8I37N0fbdS0ltg/c
         qxVrUPCrHUeXbcDhUu97Q4XOJIa1Lt/6UvaTYjepQK5HWurzgRyUq9XZTUsaYoNkAQmF
         zw6CZ3movbDjwJ6o0XWo6rqb+DMnJq/waVH30xyzg4VhWd9iJzKFByUKBuIOSZtL+EYu
         k0oBYR93eAarjOop6AQgiTs8R0IrGsXUc6rXfoq3mQy5UTYHXIw9Ssw8VOnf+oVyW75f
         Z/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP+YfN5L/CAL5jnc65vOTHTY7IY6KT8aEtFoTjI7ujo=;
        b=xB2zhQf71vc87vipwwZOHCGYPqvWyng8qUoQ1attTH1NOx+7Ead7IApasM/LqBYk4K
         DkKnsp25cqGMVBM2lXW8FABIw2eJ0BVd0YJNgl1XsAjScWSEW2Qzv53/RpwD1nDSfSvw
         BGfv3g7Cou6HLvVnxMyFXRRniBdxgk38wBCzQ5lbM3+eqMdlIS6Er1I7YlnLW4+tkfh1
         j4ZuenZ/Mwt6Ya2U3Ym55CjvqLNz4zB7nnjt9oD/KGogqS1gUhX2FrFmIwMhUKebCEWJ
         Bel1wU6dyXZrcQoDvtp+a9ggLrKv8zjoleue33zFMREqu1vLd1QDBWZmYANC+swL/rkh
         gyeQ==
X-Gm-Message-State: AFqh2kpPgtU67yOj0iO1G7QqPVfc1yVbT+F3GCwHX+sCkhxfyqFM3SoI
        40eXCxDKIFjI5lXy7CYKvIc=
X-Google-Smtp-Source: AMrXdXsZBmrazdAEnZS+ZMUuv0w9wkfwZTql33wtBDXFGDKMyjaLGHHnKMojyGeEMPgu6WzXPwzwpg==
X-Received: by 2002:a05:6000:70a:b0:263:542c:5918 with SMTP id bs10-20020a056000070a00b00263542c5918mr39982464wrb.38.1673039765448;
        Fri, 06 Jan 2023 13:16:05 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm2206491wrx.21.2023.01.06.13.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 13:16:04 -0800 (PST)
Date:   Fri, 6 Jan 2023 21:16:03 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] docs/mm: start filling out new structure
Message-ID: <Y7iPk+bBNX435TqV@lucifer>
References: <20230101094523.1522109-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230101094523.1522109-1-rppt@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 11:45:21AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Hi,
>
> Last year at LSF/MM Matthew promptly created the new structure for MM
> documentation, but there still was no patches with content.
>
> I've started to work on it a while ago and I wanted to send it out in a
> more complete form, but I've got distracted and didn't have time to work
> on this.
>
> With fast changes around struct page and the threat of Lorenzo's book,
> I've decided to send out what I have till now with a hope that we can
> really make this a collaborative effort with people filling paragraph
> here and there.

:))

Don't worry, I feel as if this documentation and my book only overlap partially,
so there is no reason to consider it a threat!

Being a developer I love bullet points. So I will sum up my thoughts on this
that way:-

- I have to, practically, target a single kernel version (v6.0) if I am to stand
  any chance of getting this done. By the time the book is released (mid 2024
  maybe even later?) it will have slid further from tip kernel so the aims of
  the documentation and the book naturally diverge on this basis alone.

- I have to, again for entirely pragmatic reasons, target a specific
  architecture (x86-64) where architecture-specific discussions are to be had,
  another luxury the core documents cannot afford, so in this respect they must
  go further and be broader than my own.

- The aims of the mm documentation here are, as I gather, to provide a broad
  overview, API guide, and general explainer. Of course the book will somewhat
  overlap with each of these, but I am also taking a deeply self-indulgent (and
  perhaps unwise) approach of going quite a bit deeper and diving into code and
  visualisations and providing something of a 'guided tour' of the kernel in a
  way that just wouldn't make sense or be probably particularly helpful in the
  context of mm docs.

- I feel as if the two are actually symbiotic rather than in competition and I
  really want both to happen and be helpful to people, coming from different
  angles and with different aims as they do. Given your and other maintainers's
  competence and experience both of which dramatically eclipse mine many, many
  times over I am certain these documents will be excellent and will be
  extremely useful, I only hope that the book can at least somewhat compare!

I'd like to contribute too but my time is so limited with the day job and book
that I'd rather keep what time I have for kernel contributions to code/reviews
in order to keep myself 'in the game' so to speak, however I am happy to review
when I have a moment to!

Proximally speaking, I will take a look at the actual patches here and try
(humbly!) to review as best I can!

I should add that I feel quite honoured to be referenced at all here! :)

Cheers, Lorenzo

>
> If somebody does not feel like sending formal patches, just send me the
> "raw" text my way and I'll deal with the rest.
>
> The text is relatively heavily formatted because I believe the target
> audience will prefer html version.
>
> Mike Rapoport (IBM) (2):
>   docs/mm: Page Reclaim: add page label to allow external references
>   docs/mm: Physical Memory: add structure, introduction and nodes
>     description
>
>  Documentation/mm/page_reclaim.rst    |   2 +
>  Documentation/mm/physical_memory.rst | 322 +++++++++++++++++++++++++++
>  2 files changed, 324 insertions(+)
>
> --
> 2.35.1
>
