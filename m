Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58655B5819
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiILKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiILKVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:21:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA86711C30
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662978114; x=1694514114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rbitQRJ6jDxMHRoRFNvyOiXLWpjVICziWAEq1TuoVCI=;
  b=QXdxPbDqX3eBB0hM6u1akqAf9PrCn+qOPueonze55Vr/Us3/wbZZQy79
   p7ESzRpdkc5gEMkaJXIk9g3Uz1YIV/72TtZNgfwxwRIddiv0YQ63yv+y+
   d0nbN0cyFr+lHuM8WQxsFr6rOj2LRcDdOPou5KB7tYtq9Ttt8hOiiFtjU
   j/N5z+i4j5hrsOuyi+/w+dvXoS+YXsORiSY8RK2zoAvrD2QbKoCqvDVI4
   f+YenwCGR3Zr5fNG6vzaGJkTVYK6HNMBZEgjUAmFHn0usbsU0qj9JfU5l
   5DFcnTw9u2a/vt6wX3F2Fvc1LyMkibkrw/pxkh7/8zLMXXexWjvEAtu99
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="296566548"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="296566548"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:21:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="684376357"
Received: from mtabaka-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.57.56])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 03:21:50 -0700
Date:   Mon, 12 Sep 2022 12:21:42 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mchehab@kernel.org,
        chris@chris-wilson.co.uk, matthew.auld@intel.com,
        thomas.hellstrom@linux.intel.com, jani.nikula@intel.com,
        nirmoy.das@intel.com, airlied@redhat.com, daniel@ffwll.ch,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, vitor@massaru.org,
        dlatypov@google.com, ndesaulniers@google.com
Subject: Re: [PATCH v10 3/9] compiler_types.h: Add assert_type to catch type
 mis-match while compiling
Message-ID: <Yx8INguMNIU4RIGY@alfio.lan>
References: <20220909105913.752049-1-gwan-gyeong.mun@intel.com>
 <20220909105913.752049-4-gwan-gyeong.mun@intel.com>
 <Yx3A16ZElKOeJr0o@alfio.lan>
 <579b8532-7687-4620-d146-c8ffbbc14097@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <579b8532-7687-4620-d146-c8ffbbc14097@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

Thanks for dropping in,

[...]

> >> + * @t1: data type or variable
> >> + * @t2: data type or variable
> >> + *
> >> + * The first and second arguments can be data types or variables or mixed (the
> >> + * first argument is the data type and the second argument is variable or vice
> >> + * versa). It determines whether the first argument's data type and the second
> >> + * argument's data type are the same while compiling, and it breaks compile if
> >> + * the two types are not the same.
> >> + * See also assert_typable().
> >> + */
> >> +#define assert_type(t1, t2) _Static_assert(__same_type(t1, t2))
> > 
> > In C11 _Static_assert is defined as:
> > 
> >   _Static_assert ( constant-expression , string-literal ) ;
> > 
> > While
> > 
> >   _Static_assert ( constant-expression ) ;
> > 
> > is defined in C17 along with the previous. I think you should add
> > the error message as a 'string-literal'.
> 
> See how static_assert() is defined in linux/build_bug.h, and let's avoid
> using _Static_assert directly. So this should IMO just be

yes, our definition of static_assert() is against the C11
specification, which should define it as:

  #define static_assert _Static_assert

this doesn't make me a big fan of it. But, because it's widely
used, I think it should be used here as well, as you are
suggesting.

> #define assert_same_type(t1, t2) static_assert(__same_type(t1, t2))
> 
> (including the naming of the macro; I don't think "assert_type" is a
> good name). No need to add an explicit string literal, the name of the
> macro and the constant expression itself are plenty to explain what is
> being asserted (with the latter being the reason the string was made
> optional).

The string literal would be "__same_type(t1, t2)", right? I would
still use something more explicit... up to Gwan-gyeong.

Thanks,
Andi
