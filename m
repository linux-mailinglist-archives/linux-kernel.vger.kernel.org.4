Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B86D00B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjC3KKe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 06:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjC3KKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:10:31 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A676A4;
        Thu, 30 Mar 2023 03:10:30 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id h8so74334222ede.8;
        Thu, 30 Mar 2023 03:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680171029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDdNsyWqne+9Tfes3d7A/XkvFVpCBqtgOlpWLUY3XzQ=;
        b=vl9NL5ZBWVYy6JbiXXan2N9yPA6GThbkaeA3cTA+OwUdXONBHhxVMDqu/DqDdluySf
         hFOob5pyvZ8PlwoArs5BoPInDSjRMWWdVGVueHRDqnByhhG3pJyqg5zo1YEXEBdLRF78
         pj8dA5AlWnGVC9ZdmECzxw2IOHiObXnCNEZxQFoHsVbHDOppxaSHgKFlpo8s1Lc0mKX5
         rM8Ky6Xrm0R2oOORTQTuYKW/stjESxWEaqn6VEvsIYlJ1LU0x5Hvbs5avYnWOFknuf7g
         MUl9BRTdFeG40gctNHp0Xs8KjMwpyFvficxSKxbgxn1A/jtSmUhhixqeVMgZ/JVqFSZQ
         +qfA==
X-Gm-Message-State: AAQBX9dHD68IDZ7Q1QlzLIoxsLvYTwMwOA3WqoAust9AHTP6QaqZXgAH
        ID3SV46eGwhiDqcfDKACPvWg2lT3sJPMVIeB7E+jVsXD
X-Google-Smtp-Source: AKy350Y4AcRU/Tt3JhFD3HUel3NqUJEPN/iuQgQP/6Bl3WvR0fmUP0+4R8mGIxxYk11mAyi1toRAAOBQXDL1+LLfczk=
X-Received: by 2002:a17:907:3e8b:b0:931:ce20:db6e with SMTP id
 hs11-20020a1709073e8b00b00931ce20db6emr12652089ejc.2.1680171029187; Thu, 30
 Mar 2023 03:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0iWkJw3KP7sfyDOyYsEkdOxxPhkYiYZMvd78geofGEECQ@mail.gmail.com>
 <20230329133600.908723-1-yajun.deng@linux.dev> <b0e52380c54775073d44bc97f823ec4f@linux.dev>
 <20230330035715.hckcbf4xpsi5cwhz@vireshk-i7>
In-Reply-To: <20230330035715.hckcbf4xpsi5cwhz@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Mar 2023 12:10:18 +0200
Message-ID: <CAJZ5v0inRZgWEYUGaxObn-ZKdN8GUzBVq9xUBgsELWpRUCujuw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix policy->freq_table is NULL in __cpufreq_driver_target()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yajun Deng <yajun.deng@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 5:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-03-23, 01:39, Yajun Deng wrote:
> > March 29, 2023 10:21 PM, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > On Wed, Mar 29, 2023 at 3:36 PM Yajun Deng <yajun.deng@linux.dev> wrote:
> > >
> > >> __resolve_freq() may be return target_freq if policy->freq_table is
> > >> NULL. In this case, it should return -EINVAL before __target_index().
> > >
> > > Even so, __target_index() itself doesn't dereference freq_table
> > > AFAICS, so arguably the driver should be prepared to deal with a NULL
> > > freq_table which comes from it after all.
> > >
> >
> > But there is a statement 'unsigned int newfreq = policy->freq_table[index].frequency;'
> > in __target_index(), if driver doesn't provide freq_table, __target_index()
> > will fault before the driver itself.
>
> Driver must provide a freq table here.

OK, so let's do the check when the driver gets registered.
