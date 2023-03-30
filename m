Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E16D0546
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjC3Muk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjC3Mui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:50:38 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F1D119
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:50:38 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id p2so13185575qtw.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680180637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbGjEXx+jyqCAwxZH7W6PHPukJFVfIQLQ8YKOTn0Tbw=;
        b=bRUkS30ulCJDPDGe4XhYBwj0mLzABtubCJxyhnb+dQFkqOU34oh40GYRYHdf1WkKil
         SKljGeAtcE4NtVyQti4nAQbAeefchPbi48bccJ5q6EQITFVTgyQULkQq6EDj+t/um02P
         O7rVhEdGqL7qGCBY4u1c1T2cINcATHg5+yxHrot8xr7BoaSVkJZjbPbRhugXRPalYulG
         KnOy0G8m/+iUEtQz9/UrJfg89O0G+reeTy9ncxdzRAw0nsYbWyzeQu56AR/ytcSLVdPJ
         BGBB0sAH6ZigWctJvNn+yDDkU8AWY7my6MOvE4EeTdvJA9ksP04n/7QXtzd4l/BASIkl
         CxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680180637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbGjEXx+jyqCAwxZH7W6PHPukJFVfIQLQ8YKOTn0Tbw=;
        b=IIMQKuTzkdcadZKUVN8nG5s3VHByIaMO2Q3rBThHsVkBKrKsMZA4fuv/63/bfZbatr
         nShri5UsdcRyX9k02l7uUvGo3bMmi41pzFME31UJknu9qH8t2RNVKxbpNavYpIbbWJQq
         FGxQKeryvGU3+BItecVQ/2w4qfQJNJhkXASN2z/CkZYjReTK3hXv0jJqi2dwA43cXJoU
         +y66EE7+wN2aCp8+movuFAc9VGx8PuiHNm/ZJ7beSaW1Ok/jW5yCrFAVnL9ZRuD3t5ol
         z8ttdAWaDsdzbE4U8YvAdA7NLKge/s4y0ZeaOsY7aPoIlsH60JkQD70jDlgFmF4ojWWt
         tC0Q==
X-Gm-Message-State: AO0yUKVmAxlJp0TSY6WY6ebwo9LJI6kz5AiXDXEp3wQH18GPn6S4soCc
        xyOepROjUGS0bjSv/CmhTBaS+QkNZU1SQ86kRep3bQ==
X-Google-Smtp-Source: AK7set/rJKymPzlrL/TwZWrcM+haO4NBQANZ3HFP/AxejEnln1518UPt5dm2PTi/IdVKY+m2AU9UkiZUYpDRQzCCTlc=
X-Received: by 2002:ac8:7c48:0:b0:3e2:dd92:6d27 with SMTP id
 o8-20020ac87c48000000b003e2dd926d27mr8913844qtv.9.1680180637086; Thu, 30 Mar
 2023 05:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230308131452.383914-1-peternewman@google.com>
 <20230308131452.383914-3-peternewman@google.com> <f103ec28-01b4-d4ca-f6e9-d557ea4efb81@intel.com>
In-Reply-To: <f103ec28-01b4-d4ca-f6e9-d557ea4efb81@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 30 Mar 2023 14:50:26 +0200
Message-ID: <CALPaoChkEkH_oKfUXut6WtXZiK6K8gM1eLk+2NWXkhJsAHtzCw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] x86/resctrl: Parameterize rdt_move_group_tasks()
 task matching
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, Babu.Moger@amd.com, bp@alien8.de,
        dave.hansen@linux.intel.com, eranian@google.com,
        gupasani@google.com, hpa@zytor.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, skodak@google.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On Thu, Mar 23, 2023 at 7:02=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 3/8/2023 5:14 AM, Peter Newman wrote:
> > +/*
> > + * If @from is NULL, then all tasks in the systems are moved unconditi=
onally
> > + * (used for teardown).
>
> Could this description be expanded to describe what the matching does? Ju=
st jumping
> in with the above sentence is quite cryptic.
>
> > + */
> > +static bool rmdir_match(struct task_struct *t, struct rdtgroup *from)
>
> Could the function's name please reflect what the function does as oppose=
d to
> what the current users are doing at the time they call it? Perhaps
> something like "task_in_any_group()" (thinking ahead about a possible
> "task_in_mon_group()" for the next patch, please feel free to change).
> Also note that the "from" is another naming that reflects the usage as
> opposed to what the function does. It could just be "rdtgrp".

I read over the behavior of this function more carefully to try to come
up with a more descriptive name and realized that for MON groups it
behaves identically to the new one I created for rename().

The original rdt_move_group_tasks() was actually fine all along so I'm
just going to drop this patch.

-Peter
