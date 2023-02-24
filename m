Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745326A1F86
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBXQW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBXQWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:22:25 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A96267996
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:22:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x10so56035158edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s1ddkJIM272NGkB+LdN/hOmq0DPwywAhS02NibdV81Y=;
        b=bstXxSL+BDGWYBS5i0BfvHRTN5xNltCllunCBSGHMIovfA2Zl4RfJXVwEWe8wBnMcA
         j/8MypiD9cD6M+qyHUfL5CDqO9YEdIBWUdDzQBViMk5d2c96bWbBg7i6UXH/WXncbAj6
         aRxK/kG0bgqQB9xcxRQZsAkPeR0Ta+jmZuR/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1ddkJIM272NGkB+LdN/hOmq0DPwywAhS02NibdV81Y=;
        b=VGqGS+jw+aAhqCEzTcABosMCB6Am3Q5sCHnwgQ7mNlbd/jSRolXJ3beEUHiGO7rd1d
         gPKXXh03VcV0oUvhTe79EPLoBEN+XfMOdKVcX+z1e4ATG0dGdYyf+fwxYbU9WEpU6q1i
         TGbe7Ok3MkB7YnEGATUI1idS4OxBXTJxxsna5bq/j9wiNEuEs1glRHA8C2cDKplMlMm6
         Q9F78Pf2Fbk2VyYGTc8jyDSiDe/Es61r38KjGY77Rm84GLzbQsL+nsEHn1fbI4gr1eAd
         fRafs1NVM9ui3hWZdBQVug2int5cL9AsDyYDsVpufdhJ1nhtV9LMUFdzcs44O/4mxP4Q
         of1w==
X-Gm-Message-State: AO0yUKU/1352v32CTkE/RI7xeb4TeKTi7bcIXscseMdJ+VBFc92tXjRy
        I/3tpdFmoYqfiuyaYoPMnpWo1TojMUPvgOf3zE888Q==
X-Google-Smtp-Source: AK7set+QM9spzx5nXgu783Ibw8Lc9Ig+CZqpceTmxSP51aaY81ab3Z48eHYY6cZ6d3s5yEzc7FewFA==
X-Received: by 2002:aa7:c317:0:b0:4ac:b6b2:1233 with SMTP id l23-20020aa7c317000000b004acb6b21233mr15404880edq.30.1677255741509;
        Fri, 24 Feb 2023 08:22:21 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id fe15-20020a1709072a4f00b008d8f1b238fdsm5945346ejc.149.2023.02.24.08.22.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 08:22:20 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id o12so57267391edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:22:20 -0800 (PST)
X-Received: by 2002:a50:d619:0:b0:4ab:3a49:68b9 with SMTP id
 x25-20020a50d619000000b004ab3a4968b9mr7634213edi.5.1677255740399; Fri, 24 Feb
 2023 08:22:20 -0800 (PST)
MIME-Version: 1.0
References: <2134430.1677240738@warthog.procyon.org.uk> <2009825.1677229488@warthog.procyon.org.uk>
 <CAHk-=whAAOVBrzwb2uMjCmdRrtudGesYj0tuqdUgi8X_gbw1jw@mail.gmail.com>
 <20230220135225.91b0f28344c01d5306c31230@linux-foundation.org>
 <2213409.1677249075@warthog.procyon.org.uk> <2244151.1677251586@warthog.procyon.org.uk>
In-Reply-To: <2244151.1677251586@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2023 08:22:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPPFN0MvHYwtaPAtQkDFHwZrDXxZ+bOWk-qSyGMiLV6g@mail.gmail.com>
Message-ID: <CAHk-=wgPPFN0MvHYwtaPAtQkDFHwZrDXxZ+bOWk-qSyGMiLV6g@mail.gmail.com>
Subject: Re: [RFC][PATCH] cifs: Improve use of filemap_get_folios_tag()
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <stfrench@microsoft.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@cjr.nz>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Xin Hao <xhao@linux.alibaba.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Feb 24, 2023 at 7:13 AM David Howells <dhowells@redhat.com> wrote:
>
> The inefficiency derived from filemap_get_folios_tag() get a batch of
> contiguous folios in Vishal's change to afs that got copied into cifs can
> be reduced by skipping over those folios that have been passed by the start
> position rather than going through the process of locking, checking and
> trying to write them.

This patch just makes me go "Ugh".

There's something wrong with this code for it to need these games.

That  just makes me convinced that your other patch that just gets rid
of the batching entirely is the right one.

Of course, I'd be even happier if Willy is right and the code could
use the generic write_cache_pages() and avoid all of these things
entirely. I'm not clear on why cifs and afs are being so different in
the first place, and some of the differences are just odd (like that
skip count).

               Linus
