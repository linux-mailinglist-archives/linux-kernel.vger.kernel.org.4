Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9E6BA001
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCNTuL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Mar 2023 15:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCNTuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:50:09 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E1055B6;
        Tue, 14 Mar 2023 12:50:08 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id x13so19372438edd.1;
        Tue, 14 Mar 2023 12:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWbK/M0x77Xrv3ybj/Re+cbFQtzYq8yEvXF3k1BEmvY=;
        b=4RJRfPd5RPNkJJj5YwJTo8rGmEB0qCDxCLTVv+B12w+cqQrnmu2rcdv/qFiJCnhD5K
         M4INv1+0ApxINpoDFm0idTskbCRa//LitkRPT8A54VIHCr0N7P+UGfu5VZOZDf/O0lTW
         TVzDPENCLROXJ6YO7aa49w4kvw7CwD/FQsJ1R/x4HtWr+OUsVm9fD1EWm6mdy0MI8/we
         6/BdAPkKIquo5NQ+/+CyzIeTtEYSofoAcNwjBHISUrOwxJvAw1Jq0qDZ+1Ir3DSvABpm
         IQe+DtYcGCJy5axzZUpuw4Prmiuj53m9C1ykFAhZr3xUfb9BCcDl3OxR1TvsDwh+5/Qe
         HPeA==
X-Gm-Message-State: AO0yUKXDTeEIOstL/d2ay3kUAz5hWBR7JG0HuWh8JQ/OJJCwpyA0q9v2
        0ZzqhnrY5hzIaCNsylF0aqn4rZmDJQff/CvB+GE=
X-Google-Smtp-Source: AK7set/Djlb4zJE6lSC+TyP7Pdyu5bPVjgQ1dFa2g2As+v6CEIyqKFqSzUCxjq+autyjSQRQArE2iqolCK3vDD2exTY=
X-Received: by 2002:a50:874e:0:b0:4fb:2593:846 with SMTP id
 14-20020a50874e000000b004fb25930846mr155813edv.3.1678823406946; Tue, 14 Mar
 2023 12:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230225115144.31212-1-W_Armin@gmx.de> <d2660362-dc25-e75f-394b-1997bd062933@gmx.de>
In-Reply-To: <d2660362-dc25-e75f-394b-1997bd062933@gmx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Mar 2023 20:49:55 +0100
Message-ID: <CAJZ5v0itUSnsxgdvw39e+YZWe4jTHA1fLjw3HZSKHTkp+eLHwQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ACPI: SBS: Fix various issues
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 6:15 PM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 25.02.23 um 12:51 schrieb Armin Wolf:
>
> > On my Acer Travelmate 4002WLMi, the system locks up upon
> > suspend/shutdown. After a lot of research, it turned out
> > that the sbs module was the culprit. The driver would not
> > correctly mask out the value used to select a battery using
> > the "Smart Battery Selector" (subset of the "Smart Battery Manager").
> > This accidentally caused a invalid power source to be selected,
> > which was automatically corrected by the selector. Upon
> > notifing the host about the corrected power source, some batteries
> > would be selected for re-reading, causing a endless loop.
> > This would lead to some workqueues filling up, which caused the
> > lockup upon suspend/shutdown.
> >
> > The first three patches fix a stacktrace on module removal caused
> > by some locking issues. The last patch finally fixes the
> > suspend/shutdown issues.
> >
> > As a side note: This was the first machine on which i installed Linux,
> > to finally fixing this took ~5 years of tinkering.
>
> What is the status of this patchset? Should i use a SRCU notifier chain
> for the query notifiers? I would really like to see this getting fixed,
> as it prevents me from using linux on this machine.

I'm not entirely convinced about the query notifiers idea TBH.
