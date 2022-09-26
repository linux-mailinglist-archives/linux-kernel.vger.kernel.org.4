Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAAD5EB1E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiIZUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiIZUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:15:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF78EA1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:15:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so13588658pjk.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5e0NMcxrM37hHf1SPYvwWiwpMePVnoGZG2QjiMvl9Vw=;
        b=U1taE2UKrJzmtLwN4Wrm15HUhdqUUQ4dmrV4U0Z4aBkmwLULhcCiHFhED/cifT5QVd
         8G3733MWfeO8lhHI+FRhM/mulJElcP5dA6YADB58qF8ezcFV+vTLBinyC6qfkOTbHh7A
         GRQb/uc+waJoHSokInnmbjMzFr6ccVRHXNGBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5e0NMcxrM37hHf1SPYvwWiwpMePVnoGZG2QjiMvl9Vw=;
        b=fALMe5L2JyK+nF30MXu/Rf2KIdYVIIryI81Nqrue2+qHSRZFCiYVSw61KTjXudeO+K
         hbnB5g3nxX9n14Abgzs51wtd9qhyCYos41+D7TD7SegRnehsK18an5w9RwcagEpSRXzc
         JiHD/kWFMX50eF2GcLOmgLiC+J0rOzEPyOORoa7Uz0G3c6MatLTy3fD8GR34aWITvYf4
         wjGbz2whDMdlpnZV5mdK1irzFeTVlgY6oNtmFjiKh5jc2Nl4IMmLV00i/uz00l4Tt1A2
         w78cYou+TwZzugRjQg7JZvOtwHXX7T4q0Wr6Lc0GT1gI+cjOvYAahy7OMyrhncUR/AHI
         gcHg==
X-Gm-Message-State: ACrzQf2Y1R3RMUcIlCJe8jSKgNLnNRBb7ZAeitUlpCpAd7mZm7vr2V1i
        YoLXmSSCsj0zTsbe7teMFP9vVw==
X-Google-Smtp-Source: AMsMyM5aR3waEBGAC3kimDDDLLkXW+zo/61DYBSMbrRf9WE6ZMLLVXBhGikTzl6Ftq8lE1ueccxWMA==
X-Received: by 2002:a17:902:8214:b0:178:95c9:bd5d with SMTP id x20-20020a170902821400b0017895c9bd5dmr24334550pln.106.1664223304468;
        Mon, 26 Sep 2022 13:15:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 9-20020a621409000000b0053e6eae9668sm12648188pfu.2.2022.09.26.13.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:15:03 -0700 (PDT)
Date:   Mon, 26 Sep 2022 13:15:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v6 2/4] mm/slub: only zero the requested size of buffer
 for kzalloc
Message-ID: <202209261305.CF6ED6EEC@keescook>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-3-feng.tang@intel.com>
 <CA+fCnZfSv98uvxop7YN_L-F=WNVkb5rcwa6Nmf5yN-59p8Sr4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZfSv98uvxop7YN_L-F=WNVkb5rcwa6Nmf5yN-59p8Sr4Q@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 09:11:24PM +0200, Andrey Konovalov wrote:
> On Tue, Sep 13, 2022 at 8:54 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> 
> Hi Feng,
> 
> > kzalloc/kmalloc will round up the request size to a fixed size
> > (mostly power of 2), so the allocated memory could be more than
> > requested. Currently kzalloc family APIs will zero all the
> > allocated memory.
> >
> > To detect out-of-bound usage of the extra allocated memory, only
> > zero the requested part, so that sanity check could be added to
> > the extra space later.
> 
> I still don't like the idea of only zeroing the requested memory and
> not the whole object. Considering potential info-leak vulnerabilities.

I really really do not like reducing the zeroing size. We're trying to
be proactive against _flaws_, which means that when there's a memory
over-read (or uninitialized use), suddenly the scope of the exposure (or
control) is wider/looser.

Imagine the (unfortunately very common) case of use-after-free attacks,
which leverage type confusion: some object is located in kmalloc-128
because it's 126 bytes. That slot gets freed and reallocated to, say, a
97 byte object going through kzalloc() or zero-on-init. With this patch
the bytes above the 97 don't get zeroed, and the stale data from the
prior 126 byte object say there happily to be used again later through
a dangling pointer, or whatever. Without the proposed patch, the entire
128 bytes is wiped, which makes stale data re-use more difficult.

> > Performance wise, smaller zeroing length also brings shorter
> > execution time, as shown from test data on various server/desktop
> > platforms.

For these cases, I think a much better solution is to provide those
sensitive allocations their own dedicated kmem_cache.

> >
> > For kzalloc users who will call ksize() later and utilize this
> > extra space, please be aware that the space is not zeroed any
> > more.
> 
> CC Kees

Thanks! Well, the good news is that ksize() side-effects is hopefully
going to vanish soon, but my objections about stale memory remain.

-Kees

-- 
Kees Cook
