Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95BE5BEC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiITSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiITSM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:12:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D16E1570E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:12:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z13so5002064edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UxJ8rW//GvFRzYiqb7FcOc8c4uS74wXg/hmPFHHyeA0=;
        b=YBLruLr5DBNAIlTAxtA3I1Zr5N+6+7ZpxNpjzAFJ4O+39pTvESNS4BZszLmARDv7a5
         yBVGN7GOBBJFowcCyD7FrfIhACWI8EiIQppJMJaZa8wTm+2kZ5jmVsdG6MH3/4c54TWr
         m7zeVAb/yWZMXPuWx03G5DAxMX2EYgjcoyCDTukhy0Qa5kwqgDL6Bs1EsxL8KwaVfp5E
         s0FnaGMDutVEoerMWhaleTosA9v+M8nKr8gzfaK3VKPvPDZgI8xbWfUuYaxuPjcxQK1x
         VD7DmpnW8dcB6cNTAaWvxZZ9t++KhlI8j4gK2jLPxkacqRGupsysmRuI2ou4nZX/u/DX
         +3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UxJ8rW//GvFRzYiqb7FcOc8c4uS74wXg/hmPFHHyeA0=;
        b=iNT5hDyWR9RY0rtn5EEKGxIMi3+FGVejzmjTgMAa9MAj2eYIkt5jN2Xbm9XEYIcI98
         rCYktSvH0bI96yTv0bvPy3oWLV+mbLfYw7oy/uwFklK7TXMXYLjROoqQYnaUiw1YgP0u
         +Z26gr6LBKqsTxewROR3MjZa5sYFoSuAH4OxShFN7x3uEwyjsxflNYm6nafaU6yOIdJH
         ntUtqwdsn5+Quux1K470WBS44PVg9Sy3y4yE9QTPdNq4/2bo/uAVCNi212h1J3Zz3Nu5
         Xa9hVaIZwUY431EYrnnxbcFMBr1HxI9NnqJ0grrZOyKI5/NH8NU7+a/ZvGJI1pVLcC2k
         hB6w==
X-Gm-Message-State: ACrzQf2WuSB0nRZbJ10NGeC3XYb3EzssJUocIjwbGmsC2u3QKyb3HLb3
        qJuCxDYJgdxfArPUFUASVHKfJE39UXxGNfsX8/Wa+mPABkw=
X-Google-Smtp-Source: AMsMyM7PMxdTFGqqTHkNV2MZvsSy/zTh84aME965vBYd0cNVakCzxExWkU8Vx5Y8SwaT9xnkrtg0AOKAgquknl6Z1K8=
X-Received: by 2002:aa7:d3d3:0:b0:44e:baab:54d9 with SMTP id
 o19-20020aa7d3d3000000b0044ebaab54d9mr20817547edr.43.1663697546757; Tue, 20
 Sep 2022 11:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220911095923.3614387-1-pasha.tatashin@soleen.com> <20220912132322.7c486c40c6acf8eec0785c87@linux-foundation.org>
In-Reply-To: <20220912132322.7c486c40c6acf8eec0785c87@linux-foundation.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 20 Sep 2022 14:11:50 -0400
Message-ID: <CA+CK2bDkvgifEXh9voz5oYog-rDNm2GnqTZL=-5HndOFF2CJqg@mail.gmail.com>
Subject: Re: [PATCH 0/3] page table check default to warn instead of panic
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 4:23 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sun, 11 Sep 2022 09:59:20 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> > From: Pasha Tatashin <tatashin@google.com>
> >
> > Page table check when detects errors panics the kernel. Let instead,
> > print a warning, and panic only when specifically requested via kernel
> > parameter:
> >
> >       page_table_check=panic
> >
> > The discussion about using panic vs. warn is here:
> > https://lore.kernel.org/linux-mm/20220902232732.12358-1-rick.p.edgecombe@intel.com
>
> The changelog doesn't actually describe the reason for making this
> change.  Somebody obviously wants pagetable check errors to no longer
> panic the kernel, but why??  (The same can be said of the [2/3]
> changelog).

This came from the discussion listed above. There seems to be a
consensus that we should reduce the number of BUG_ON() in the kernel,
and replace them with WARN_ON_ONCE() when possible to recover. In the
case of page_table_check we can recover, but for some it may be unsafe
because of security implications. Therefore, I would like to keep  an
option of being able to panic only because of page table check errors,
but not keeping it enabled by default.

I will add more info to the commit message.

>
> Also, should we be changing the default?  People who like the panic
> will get a big surprise when they find out that they should have added
> a kernel parameter to get the old behaviour back.  It would be less
> disruptive to default to panic unless page_table_check=warn was added.

I was thinking about this as well. I decided to change the default:
the old users will still get a warning, but going forward we will be
inline with the rest of the kernel: warn on by default, and optionally
panic.

>
> If there's a solid reason for changing the default, it should be
> changelogged.  And if that reason is generally agreed to, perhaps the
> kernel should print a warning at boot if neither page_table_check=panic
> nor page_table_check=warn were provided.  To tell people that the
> default has been changed.

I am not sure that is needed, and when do we remove that extra boot
message? This is a relatively new feature, and existing users would
still get an ugly warning about incorrect page table mappings.

Thank you,
Pasha

>
>
