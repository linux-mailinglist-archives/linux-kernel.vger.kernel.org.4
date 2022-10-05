Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7165F595F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJERuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJERuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:50:14 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F21EE20;
        Wed,  5 Oct 2022 10:50:13 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so11326720ooo.8;
        Wed, 05 Oct 2022 10:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lT6lx5ZDRpxgW+xAGllB8Ira6Ynt7/Xp9qu0pEh/gYc=;
        b=DylDZ6bEfb3HIE11eFU1xtxy57xByujX3fS721pcWxmU1Wxo9hcvuJ01QYy0OU0OCw
         ORQV5MIySWvb6nCE93Scmt7t3A8ipWk+87kmBLMTSMZSaK2hl4hlYQXNtzXP6h+b7G62
         Bxrx9rGXaIvJSbleJqhZBTXo6wlBpln3cs5Lg7PgNGjnjcv4/u36aazLFH2sveDceJX4
         PGAwKhzAAs14yaFmbORrals9mafiWGTvnExMZXLVYKcxWyxUGF5jbkhSC7CDa9pycMyj
         Mo4ueLGtnD8PiyZXc6a9il35fho1qfOxDRECcIcYY6nEWpO0K0yyM/YN+lS6zYbkfg0X
         /ZMg==
X-Gm-Message-State: ACrzQf00lzUZ8TQoLWSN9y8bBFMAbnuWEi0nmnf6gI6tenfndEvccOeI
        S0nXyLRH3PM4+7jQVG+7avi9yRzsVVapsIcafLP2VZnr
X-Google-Smtp-Source: AMsMyM4xN9VF9TvWdOefI/ak40ugxy598G2NtbLoEgPQYArnwPKN2STkdSNU+9QCQmReUfS8td8u2eg3ZGo9BLq44kQ=
X-Received: by 2002:a4a:b4cd:0:b0:476:8f72:5b60 with SMTP id
 g13-20020a4ab4cd000000b004768f725b60mr257862ooo.58.1664992212787; Wed, 05 Oct
 2022 10:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220920222822.2171056-1-namhyung@kernel.org> <20220920222822.2171056-2-namhyung@kernel.org>
 <YysWn/W3+dXlZnYG@kernel.org> <CAM9d7cjtrVsccWUOCAtz1LbHoYxx7uV4SCaBMLdME-pdZjmjfw@mail.gmail.com>
In-Reply-To: <CAM9d7cjtrVsccWUOCAtz1LbHoYxx7uV4SCaBMLdME-pdZjmjfw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Oct 2022 10:50:01 -0700
Message-ID: <CAM9d7ch1GG2xjOpPwMf0q88CWtX2DdSiRXDJX6vevTk_1g+USw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf record: Save DSO build-ID for synthesizing
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Sep 21, 2022 at 10:55 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 6:50 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Sep 20, 2022 at 03:28:22PM -0700, Namhyung Kim escreveu:
> > > When synthesizing MMAP2 with build-id, it'd read the same file repeatedly as
> > > it has no idea if it's done already.  Maintain a dsos to check that and skip
> > > the file access if possible.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > v2 change)
> > >  * Remove perf_event__synthesize_{start,stop} and use machine->dsos  (Adrian)
> >
> > Will wait till I merge perf/urgent into perf/core so that this applies.

I think it's doable now :)

Thanks,
Namhyung
