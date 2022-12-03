Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC964140A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 04:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiLCDpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 22:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiLCDo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 22:44:57 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A576147
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 19:44:52 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id b189so518813vsc.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 19:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qi0pNA3Q5CNsznnROY2eCNx9atd8tn83Rm2Xt6waJfY=;
        b=C2GhGcqYBjF714vnbg1onPOwrgYHVSpsbk635fMwpnqLm6VP0p/V+npp5R6vbns98e
         4llUvnvOVWjfBETWEzATzIZG/BSUjxGmJzIwXFZNFPvUndPB6c4JCLAa6QGKXPpKPbZP
         R7emqZFmQ+yLFRV/QyK4FBM3YwYVCnnG5SGW6QizjITY9EeNuxc3Upj9df79II2Ysyts
         Rjv/UMDEstas1y05v63jaGYLUeRWJ53wWM5TD4JPVyCeVyvGR5nUOVNzRb3bM9nSzyZa
         rCIMovzMprz1zqwG2s1BNdwhZPfi2s/ARxa1ZB06AN/DeYKvD6q+bTRpzTOutO42se9r
         wAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qi0pNA3Q5CNsznnROY2eCNx9atd8tn83Rm2Xt6waJfY=;
        b=TowG+7qOV82z9k3za8NYBZih2GxaF10zr3YX3PVRc4FV8rTgM0TD0lOl0cU5e28bCu
         9mNCwJ7RdJGhuu37x4xNr915NTBVarX7GBHEAYoxJJ+ZBnEmRFXTdCCIy+w2WVrFjMFu
         mJTfh/Fvm6Ri+W2aitKbOC5YnekbX+MD5jG/QIIK7NRgoHeSYQAJrcm5xDZiFlG15Wz+
         SY6d7Au9bjyY719v56pezau+fJB1zyGs+cseuuSyQTVQH7iAX9RZTSArl506tGwR6v2d
         vlypUKI1p/n3+iQ78h8f3KToSMv4d+MR3fXiIA7Lehi8Mt69ANw5HIBaOI7EmaW/5Dlp
         R3Iw==
X-Gm-Message-State: ANoB5plv5jibAy4Vqu2idlCq8ETzZqYQImMOLdQdY6snBTjTblSg+Gyx
        LNvL3mBEBa+MP0Yo38TlMoXYYQ/3xrD46FOn9R95Eptf8k1nuA==
X-Google-Smtp-Source: AA0mqf6Ldfbvz1RW6/bpQHRsSfWQ+F4Yo3Ooe4xP3p5lc/pHF8DWCiMvXOwhXy88GQj8vzMgh+99v0RB/hp6KIJ7rG8=
X-Received: by 2002:a05:6102:54a5:b0:3b0:7462:a88c with SMTP id
 bk37-20020a05610254a500b003b07462a88cmr26789718vsb.49.1670039091500; Fri, 02
 Dec 2022 19:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20221202141630.41220-1-tcm1030@163.com> <20221202115954.a226f8ef3051266d04caff54@linux-foundation.org>
In-Reply-To: <20221202115954.a226f8ef3051266d04caff54@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 2 Dec 2022 19:44:40 -0800
Message-ID: <CAHS8izMAR7SVanWf90vSCbnUDYZPvZQQ7G7wcqjkgxQjicz=GQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: failed to disable numa balancing
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tzm <tcm1030@163.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 12:00 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  2 Dec 2022 22:16:30 +0800 tzm <tcm1030@163.com> wrote:
>
> > It will be failed to  disable numa balancing policy permanently by passing
> > <numa_balancing=disable> to boot cmdline parameters.
> > The numabalancing_override variable is int and 1 for enable -1 for disable.
> > So, !enumabalancing_override will always be true, which cause this bug.
>
> That's really old code!
>
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2865,7 +2865,7 @@ static void __init check_numabalancing_enable(void)
> >       if (numabalancing_override)
> >               set_numabalancing_state(numabalancing_override == 1);
> >
> > -     if (num_online_nodes() > 1 && !numabalancing_override) {
> > +     if (num_online_nodes() > 1 && (numabalancing_override == 1)) {
> >               pr_info("%s automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl\n",
> >                       numabalancing_default ? "Enabling" : "Disabling");
> >               set_numabalancing_state(numabalancing_default);
>
> Looks right to me.  Mel?
>

Maybe I'm missing something, but it looks wrong to me?

numabalancing_override is default initialized to 0, I think,
indicating that no override exists.
numabalancing_override == 1 indicates it has been overridden to true.
numabalancing_override == -1 indicates that it has been overridden to false.

The above code reads to me:

if (override_exists)
    set_numabalancing_state(override_value)

if (num_online_nodes() > ! && !override_exists)
    set_numabalancing_state(numabalancing_default)

A more clear fix for readability would be an early return between
these 2 if statements I think.

> After eight years, I wonder if we actually need this.
>
