Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA24767D67A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjAZUei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjAZUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:34:35 -0500
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676BE8A75;
        Thu, 26 Jan 2023 12:34:34 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id g16so1300027ilr.1;
        Thu, 26 Jan 2023 12:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9CbIHhV+ARet+dyr9AydFAWYERzdT9Qwhwp8j9Ig0M=;
        b=bb6r2wVspmhCtcbjKgimk4Aud1E/NR1QMEH3feFYg7hi44lR0mQICAeKArA9dqz1nH
         UK+4CQrOggKWVZ3Ft5qBIS9Wx/PN4phkyO827xNTDv0emrhkeQqy6rBP5BgXv7ZqyVzx
         HXTGlSRgmuoUYK4ussf8LOMFfeWpAfPu+L8z34K+wBypTNoj64eyvhXo60s4Nwy5gvHZ
         gnp18bd6HBftaEdVs53cCQfQ8fBEg7YAHeq6Isu5TlgtjqAZWja+1C69xxpp3MS1SxUI
         Fce+0/5HrN91BRCq12GC1n8tdwzKFuqZXqh/ZsNhdoZDt3J8ubT/6RvTUb7DvWw9kAgB
         MOWQ==
X-Gm-Message-State: AO0yUKV2LdBDxGNlEo1EQrseJUn9HCV+97UsUnLcu2mUqtd3/ZmdRr4j
        WCI3urONield2YB9ZnwTI7gJLOEnB4Yo8vWglRA=
X-Google-Smtp-Source: AK7set+wQrMRe/lrAhLyqRwEYfdqTPCe8+lPbG6MzcJrW7lkO52XWabyd16pKXY4CHjWoS9/vexbJmpYyiV16gNlK5M=
X-Received: by 2002:a92:1a41:0:b0:310:9d4d:80e9 with SMTP id
 z1-20020a921a41000000b003109d4d80e9mr1247755ill.151.1674765273679; Thu, 26
 Jan 2023 12:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20230126194230.3339019-1-namhyung@kernel.org> <ACACAC8D-3390-4D47-B227-5C3182109847@gmail.com>
In-Reply-To: <ACACAC8D-3390-4D47-B227-5C3182109847@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 26 Jan 2023 12:34:22 -0800
Message-ID: <CAM9d7cgzo+LN2dXBkSDd_fyP1XdOu7WjokFARE=L415h0dc-Gg@mail.gmail.com>
Subject: Re: [PATCH] perf script: Add 'cgroup' field for output
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Jan 26, 2023 at 12:06 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On January 26, 2023 4:42:30 PM GMT-03:00, Namhyung Kim <namhyung@kernel.org> wrote:
> >There's no field for the cgroup, let's add one.  To do that, users need to
> >specify --all-cgroup option for perf record to capture the cgroup info.
>
>
> This information about the new field being only available when --all-cgroup is specified should be in the documentation (man page) and probably in the tool itself, refusing it when the needed command line isn't present.

Ok, will update.

Thanks,
Namhyung
