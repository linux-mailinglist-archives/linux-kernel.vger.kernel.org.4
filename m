Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0456C2EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCUK3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUK25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:28:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0EB1739;
        Tue, 21 Mar 2023 03:28:56 -0700 (PDT)
Message-ID: <4be55ba4-d3fa-dfa9-7b38-13f3ced20ad2@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679394534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtGItoQ8L3NjqyoFnxMVHZxPsc49P77sScHa0pTao9I=;
        b=gqME3xN2HEhoIz3aaQlh3kFuAvjDVcVBgLAgNYo10TG2k/wnfpyXH+s67tgCr/1+vrhIjr
        W0cmex/Xsf3+CzGau/xNylAPKPS987c/27TCG+q4NdaIag2Pq+bo8nkCknlUcHUE6ghA9n
        o88kGFv+R7+gWzUI+ocbo51Szl0tdKBty9aIO3X/xbmZ7NE5UWG7aIaTS5c/Csa1MCRW+Y
        U9l8/MQKSz+BrjpHo8r64WhKB3egg9FcJCo2/daeKm9ta0X+LR7JIA7kDAGQhsDTeIaD+U
        5XNcg1hgyYVXurguBAIMLG4IjRBTLcLGtSrEZAfL/PiARFYfRUMAUfmIdhCevA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679394534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtGItoQ8L3NjqyoFnxMVHZxPsc49P77sScHa0pTao9I=;
        b=RroFRKl+4cd430cT3z7aLKdv6B1W4m5bjck2Eq7gwBxxEDFo3Sa2vBxKi+rvlefRlQjjfE
        E+A752hvIWpjmsAg==
Date:   Tue, 21 Mar 2023 11:28:54 +0100
MIME-Version: 1.0
Content-Language: de-DE-frami
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230315173524.63179-1-bage@linutronix.de>
 <20230315173524.63179-2-bage@linutronix.de>
 <CAK7LNASckF_6QLHkvLEk3b8nE23v4Qy4wmm4FHd5BrDo6U2x2g@mail.gmail.com>
From:   Bastian Germann <bage@linutronix.de>
Subject: Re: [PATCH v3 1/1] kbuild: deb-pkg: Build parallely with current
 dpkg-buildpackage
In-Reply-To: <CAK7LNASckF_6QLHkvLEk3b8nE23v4Qy4wmm4FHd5BrDo6U2x2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.03.23 um 11:18 schrieb Masahiro Yamada:
> "make bindeb-pkg" also runs in 16 threads because
> $(DEB_BUILD_OPTIONS) always contains "parallel=16"
> even if -j<N> option is given at all.
> 
> In other words, this patch will take away user's freedom
> to choose the number of threads.

Okay. To solve this, I would forward make's -j option to the dpkg-buildpackage calls,
which is now called with the defaults.

I think you should see the warning with older dpkg-buildpackage versions without the
patch applied as well because their default is dpkg-buildpackage -j`nproc` and is in
effect currently.
