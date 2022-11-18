Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6455262EC80
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiKRDwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbiKRDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:52:03 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28A8F3FD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:52:02 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 136so3968907pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpPiECtcuuwxxZW6I2l04Yvk+0H4NlRCXaVbSAhBEDs=;
        b=Y4k+ITVdnWabWfy2tpUEza7/ctINKSkaBCZ3/PX3qAfvyf89lki00V0Xwn2eethcgE
         uklfgJsqroV1nl1rka+esAOWp1TVQZrLJB8wd4WQlZocW/JszizcYUWarJxjffrgQ6R0
         ru/MdhgJmf+22TnqXyIM1tBM2WrHzqbDsi/U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpPiECtcuuwxxZW6I2l04Yvk+0H4NlRCXaVbSAhBEDs=;
        b=kJAmSEk80J51/9iv7Y4I/meRvVL+ULd1NyFVLJiyrCd86lHsVbcrPg6UOMmePp/yVr
         rSRJClHAUMefZr+REbc21uotD5O0ord2+z4eoUFOl8zhQDDjp0cvCKqRVbgNUOroEyST
         2zeLcjkgDE59z8+LRB7oyIPgdI57FsL37lNwFDY6zANs12tXaMZSPbI1/1BWi71zCknw
         aQk1Ya4zoNaGxJ8SnNz/Rvc2oJ0HpdHaXsTHZOk4o2DzvRTeBRbr+Mwd8Jxt3g8ypYDg
         GpJdOBBeGwFYKw9LlHH3I1qWsn2r0CTrvRzVe+G8Te3QNvMZyj7ATPJuL5701Q2gBT1N
         Iizw==
X-Gm-Message-State: ANoB5pkQPhTTPGqkoM/k0TOVyRqM6f9v2BXbhpa73ATlxwpuBTzTGu7r
        JoyDWSJxrL8LXbLiXfGJ1aGvKA==
X-Google-Smtp-Source: AA0mqf5LIOGY++xcoY7JcVjGfKd3ueopnrI6Mq6ww0CuYAUNPQKL6pVl34gT7LPuQraWiXJ/HTNFkA==
X-Received: by 2002:a62:d441:0:b0:53e:6210:96de with SMTP id u1-20020a62d441000000b0053e621096demr5945073pfl.58.1668743522435;
        Thu, 17 Nov 2022 19:52:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r11-20020a63ec4b000000b0043ae1797e2bsm1794260pgj.63.2022.11.17.19.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:52:01 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] slab: Provide full coverage for __alloc_size attribute
Date:   Thu, 17 Nov 2022 19:51:57 -0800
Message-Id: <20221118034713.gonna.754-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; h=from:subject:message-id; bh=PjCBiF2sN+bzrV7VCSddGmjoguZq6Cl6RI+yFLufVf4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdwFfNcru+k/Q+zCg8JWAMeqDxHq8sLjKOG5JeKE3 0h6oVzaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3cBXwAKCRCJcvTf3G3AJj5/D/ 42TO5oeunaOTHbu1yBGFAh47GzImY9MtSgcNOrMok8hnHPtevpfbnlSegxe0HbUP7jbID1ihtqFruR b8XwYzWQxIBMoIc21M5aD70wqlFyfKI0jwWu6i7jVgCOakCY2VPKMOXU7SXtCwcXcvdx+7jyT/axy+ FLnWHtyr+DeWh639lj+oqqG6Bb1O9iVV/ghsBoHdYybtRNVdG67KqyXBHRz0shvKapS2sLhe5jUUrv 0lCjDp4s4oww7gnWYrYYzFlE1s7WBWLMS8QG93zUHMG3jzdWueNlaWbOrylPuYhHimLpG2bANJxQYs 8Odnd1Se+AJd4aXvCfxOxIsfI4pT2yjepl04B8gtXjYD/0I3zO+qXORjitTA1VmYijAWVU+WQ/Qno/ tELZotiNyAwbA0PjhtqMuXZ/VC4PXHZ7uy3rJioJEB8eo60gh3FX1U+vs51KxSHPaxZt+LLnmDz1ts 2PhSrilHbcTMd9nawq8EgdDJ0odurxcwsZFvHXAVaWsW8L8Z0LecdXWGfKI1BH3ndVyBgC7/QoowC5 +Qv6EtEdFp5kz+3miOfrxz/EHw/2rWb0tf1X3T3sUBoUr8TAUFcc34oG+BicxWUXltcl3CAptWVBK/ izeVl073EbSAffqbEN+BuSxGy7gJTPTYNrU7DwWVkCVbUgihdfgC9c+Xrn9g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches work around a deficiency in GCC (>=11) and Clang (<16)
where the __alloc_size attribute does not apply to inlines. :(
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503

This manifests as reduced overflow detection coverage for many allocation
sites under CONFIG_FORTIFY_SOURCE=y, where the allocation size was not
actually being propagated to __builtin_dynamic_object_size(). The problem
was in two halves: the trace wrapper (now fixed in -next), and const-0
special-casing (covered here).

Thanks,

-Kees

v2:
- drop trace wrapper refactoring -- handled differently now (vbabka)
- drop kunit/fortify test patch since it depends on other changes
- rebase
v1: https://lore.kernel.org/all/20221101222520.never.109-kees@kernel.org

Kees Cook (2):
  slab: Clean up SLOB vs kmalloc() definition
  slab: Remove special-casing of const 0 size allocations

 include/linux/slab.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
2.34.1

