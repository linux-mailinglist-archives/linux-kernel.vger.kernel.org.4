Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541F15E7F96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiIWQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIWQTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:19:53 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7011476BF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:18:45 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id c6so224619qvn.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=HpWngawDtbJXOlnZyhoHmwvzKh7G6mMVPg9a8nqJCWI=;
        b=L656aGrukal/u9X3OyN1now2/9VmmEFOFuoWMC5AQ23HVhoR4yJI23PimXKPDEoyaL
         Y5Qd+/U4D2Ec4UlRBFBaGkJ9/fFc5pyQGnvH2NM6+LjdpA5OopoRTOybsY18FlAhQPo5
         s0M1t4ZfO72Scfr6nP3Hx8/VYtKV0jmRDsEMNuH+Wuv9o4FoXYrRJLoqtg97q2DCcy9m
         5+g8C6y2yS7GTniDbAMSPVzMrC4jqzLeiiBzYDkQCK+h6Xtdwuyh5ZrcoV5yhF2+Nnbk
         WqJ/0h60tE+a4KPpX57fuZh4U+k63Agph45hJN1YY+/Hpm2mA9DrkTghtw1InIqw9IWp
         8xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HpWngawDtbJXOlnZyhoHmwvzKh7G6mMVPg9a8nqJCWI=;
        b=29bAWoAJdnShfKvGqsE05HrGQetS4I7QM9TR/L80IzBQaQ56TlXPF6wTiwxI1SfbWA
         ytpI0U281diy2AvrbVrdBGg+TtyPs6ThGr0qctrq3Ww5FIKpPBlf1p59GwWsoaqzYmuD
         XumnaYyitLWoN05bPNR1/z3kh2b9a3sWZ6INL7L29Dywp4IqnC7n8J+IUj0wdIvF06BH
         jg8me+QU7zB0jcLJT0vYFblX7TrEXd14JH/GkGC6zH2LBS5lqJ6BUm8HoL9357TWbTC6
         WSJ+idR9Ao1H4bLeLbrIYV0kVVSl7/4JABXhoERbBdwetCehnQvVR3LzwISF+rW/Wc5n
         qDJA==
X-Gm-Message-State: ACrzQf0Cnv9RBJ+xGRtCbxqgIBGyVX92BmDmcGFvWQazr3g2EsORKg2k
        t1/Q8/Gh+rs/PEPnP7q0mWkkRiiT5kc=
X-Google-Smtp-Source: AMsMyM5oj2Dh1hjjG9TYVEnllS4UfwTP4JxCd7WnQkA1uUOlF8VlKhY6PGCZ08dVIXbWKiK/oVSVVg==
X-Received: by 2002:a0c:ec46:0:b0:4a7:509:386e with SMTP id n6-20020a0cec46000000b004a70509386emr7459208qvq.61.1663949923782;
        Fri, 23 Sep 2022 09:18:43 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2170:e39b:cf3e:8e0a])
        by smtp.gmail.com with ESMTPSA id o17-20020a05622a045100b003447c4f5aa5sm6206834qtx.24.2022.09.23.09.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 09:18:43 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:18:42 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 0/5] lib/find: add find_nth_bit()
Message-ID: <Yy3cYtJCRiFvFV2e@yury-laptop>
References: <20220918030716.1252285-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918030716.1252285-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Sat, Sep 17, 2022 at 08:07:10PM -0700, Yury Norov wrote:
> Kernel lacks for a function that searches for Nth bit in a bitmap.
> Usually people do it like this:
>   for_each_set_bit(bit, mask, size)
>           if (n-- == 0)
>                   return bit;
> 
> Which is not so elegant and very slow.
> 
> This series adds fast routines for this task, and applies them where
> appropriate.
> 
> v1: https://lore.kernel.org/lkml/20220706182300.70862-4-yury.norov@gmail.com/T/
> v2: https://lore.kernel.org/lkml/CAAH8bW_RYG_Tbpip=BkSFAymDm2y3jJBqTi0PJWA=H-a-L_3tg@mail.gmail.com/T/
> v3:
>  - add bitmap_weight_and() and use it in cpumask_local_spread();
>  - rework find_nth_bit() family: similarly to [1], introduce
>    FIND_NTH_BIT(), and optimize the function to return earlier when
>    it's known that the rest of bitmap can't meet the requirement.
>  - patch "lib/nodemask: inline next_node_in() and node_random()" has
>    been merged, so drop it from this series.
> 
> On top of:
> [1] https://lore.kernel.org/lkml/20220915020730.852234-1-yury.norov@gmail.com/T/
> 
> Yury Norov (6):
>   lib/bitmap: don't call __bitmap_weight() in kernel code
>   lib/bitmap: add bitmap_weight_and()
>   lib: add find_nth(,and,andnot)_bit()
>   lib/bitmap: add tests for find_nth_bit()
>   lib/bitmap: remove bitmap_ord_to_pos
>   cpumask: add cpumask_nth_{,and,andnot}
> 
>  fs/ntfs3/bitmap.c        |  4 +-
>  include/linux/bitmap.h   | 13 +++++-
>  include/linux/bitops.h   | 19 +++++++++
>  include/linux/cpumask.h  | 55 +++++++++++++++++++++++++
>  include/linux/find.h     | 86 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/nodemask.h |  3 +-
>  lib/bitmap.c             | 68 ++++++++++++-------------------
>  lib/cpumask.c            | 28 ++++++-------
>  lib/find_bit.c           | 44 ++++++++++++++++++++
>  lib/find_bit_benchmark.c | 18 +++++++++
>  lib/test_bitmap.c        | 47 +++++++++++++++++++++-
>  11 files changed, 320 insertions(+), 65 deletions(-)
> 
> -- 
> 2.34.1
