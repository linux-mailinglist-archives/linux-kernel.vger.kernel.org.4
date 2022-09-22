Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABDD5E67B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiIVPzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiIVPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:55:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F917AC253
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:55:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w20so9151381ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=5YOa+gv1sIPcp5S2eMDxZrJPz51jsjFGvspNVL+ych0=;
        b=LEFzWbqksCDh4S4OiJrbR7XAYMyOC2rDNgEzxm4wNn6u+IvIuPSxz7ChVzcXYCA9kN
         JUv48f4jgPup+CHrzZf6w+AfSyBn13B+QQpM2W85KtMMefowgfzF6SEkXu9wDa88gO2B
         nN2k3CYK4Hh5e/4TzZfHnbEaM6zaDEwuByIkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5YOa+gv1sIPcp5S2eMDxZrJPz51jsjFGvspNVL+ych0=;
        b=nqVtpHHu2St8Y9FMauhzm9BmbRmtY5ECEtfPG7g8gI4CI1yzFOq2QP1rFpK0CDvUYB
         dU9nx2EonP6yBBsZ+0ZGY3T2PfObWznJqJjLUrrKqd2fkSICc/Dnp5F4mRPz1or5mmV8
         vZGuYDEzlQAlSLjr//DiWXr2evP1AZ5haINwzxQaFfLqLce08lCJ5CfCFb2E5yMmlfUx
         n3HvMAbziI+qrNtV6XqC0YmH9ALgy7eygNjKj1se6byr+Ljl328dIo7phzct0dZR+k+z
         9os6kj3SD6Atrtebam3Dw9HOmXhrwOVYDE9NEPjDo1h8Fls3fThZ99oJJjN86GTAJVJD
         M4fA==
X-Gm-Message-State: ACrzQf09ySlMUGYF8uV4cLJVCBiqpBPRdHTxeU3Fv2URY6HK0hUwmxaO
        nedpK4QlwbWL8SvF1A0NWaGUeA==
X-Google-Smtp-Source: AMsMyM6pj2YmcAiXg6SonP+gJGRIk20ZQXjacFA/fb+08tqqdtojyBlUHrRZT8F0Z+9OyQ05xLAwxg==
X-Received: by 2002:a17:90b:3ec9:b0:203:246e:4370 with SMTP id rm9-20020a17090b3ec900b00203246e4370mr15665429pjb.221.1663862121161;
        Thu, 22 Sep 2022 08:55:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001754fa42065sm4270774plk.143.2022.09.22.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:55:20 -0700 (PDT)
Date:   Thu, 22 Sep 2022 08:55:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Elder <elder@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        dev@openvswitch.org, x86@kernel.org,
        linux-wireless@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/12] slab: Introduce kmalloc_size_roundup()
Message-ID: <202209220845.2F7A050@keescook>
References: <20220922031013.2150682-1-keescook@chromium.org>
 <673e425d-1692-ef47-052b-0ff2de0d9c1d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <673e425d-1692-ef47-052b-0ff2de0d9c1d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:10:56AM +0200, Christian K�nig wrote:
> Am 22.09.22 um 05:10 schrieb Kees Cook:
> > Hi,
> > 
> > This series fixes up the cases where callers of ksize() use it to
> > opportunistically grow their buffer sizes, which can run afoul of the
> > __alloc_size hinting that CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE
> > use to perform dynamic buffer bounds checking.
> 
> Good cleanup, but one question: What other use cases we have for ksize()
> except the opportunistically growth of buffers?

The remaining cases all seem to be using it as a "do we need to resize
yet?" check, where they don't actually track the allocation size
themselves and want to just depend on the slab cache to answer it. This
is most clearly seen in the igp code:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/igb/igb_main.c?h=v6.0-rc6#n1204

My "solution" there kind of side-steps it, and leaves ksize() as-is:
https://lore.kernel.org/linux-hardening/20220922031013.2150682-8-keescook@chromium.org/

The more correct solution would be to add per-v_idx size tracking,
similar to the other changes I sent:
https://lore.kernel.org/linux-hardening/20220922031013.2150682-11-keescook@chromium.org/

I wonder if perhaps I should just migrate some of this code to using
something like struct membuf.

> Off hand I can't see any.
> 
> So when this patch set is about to clean up this use case it should probably
> also take care to remove ksize() or at least limit it so that it won't be
> used for this use case in the future.

Yeah, my goal would be to eliminate ksize(), and it seems possible if
other cases are satisfied with tracking their allocation sizes directly.

-Kees

-- 
Kees Cook
