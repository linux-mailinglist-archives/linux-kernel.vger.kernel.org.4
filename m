Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0630C7392B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFUWuy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 18:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFUWuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:50:52 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4AB19AC;
        Wed, 21 Jun 2023 15:50:51 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bacf685150cso6183087276.3;
        Wed, 21 Jun 2023 15:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687387850; x=1689979850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsE/Ooc2RHtLpohHbtgmDcmRrH4GT0O29WSs7/97Xfs=;
        b=LCiQR0PHA10KOKMjllJDfnPPIAC83TKttGm0qq01X6odMBbifqTp0cQPqA5H0HxrWc
         uO82KH54WBoJ7WwswxG/jLfbljW9fMntYk2UOhOrzJw1eaoGMHUj7DOmrbqsBwA65D8O
         mog7nYBFAAplZAGAul88pD3Y03O+rg5ZIis1qUhlnghQc63bMi1sEkg/TGV5xkJCKwIC
         yicqwsscJZyVf9UjoY2PxAZUKlMG/NcVladE3JLEUfczAAnqC4LRgMIBfKbU9MfmVSqi
         +bf/SdBftiOIuJrEUklBLe/FTLrZnITGr2FRuW5nzJMyTJ0EAi+i2HNilLNGYFx/XGkI
         17XA==
X-Gm-Message-State: AC+VfDw63udBnk8No/ejQ2Gp+vKie8oP9oAdmqXUDB/4s64J1abK/tV9
        SKncdFGNVuDjLKDwl/sBinbZ9CqFmPlYqFc7B8E=
X-Google-Smtp-Source: ACHHUZ7v7KOOcJh6FGf9nJQfq9AbeOm/JjShFd1JdRBHoWR7Hkr4nNUMf1LwNayfi2F2QXiJjOCcwGWhsBAZzc8avmA=
X-Received: by 2002:a25:3795:0:b0:bd4:3839:8b55 with SMTP id
 e143-20020a253795000000b00bd438398b55mr13175295yba.64.1687387850424; Wed, 21
 Jun 2023 15:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091603.269-1-ravi.bangoria@amd.com> <CAP-5=fXS726wY1taYEYXDz3YZ4ZwxcL+nhh_yNM7rwamMd8mWg@mail.gmail.com>
 <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
In-Reply-To: <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 15:50:39 -0700
Message-ID: <CAM9d7chNA44HxRYOHLxtBP_7azivrE_MxdKos1gUO3KxnbK_Dw@mail.gmail.com>
Subject: Re: [PATCH] perf/amd: Prevent grouping of IBS events
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Ian Rogers <irogers@google.com>, peterz@infradead.org,
        acme@kernel.org, jolsa@kernel.org, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 8:28 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Ian,
>
> On 20-Jun-23 10:14 PM, Ian Rogers wrote:
> > On Tue, Jun 20, 2023 at 2:16 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>
> >> IBS PMUs can have only one event active at any point in time. Restrict
> >> grouping of multiple IBS events.
> >
> > Thanks Ravi,
> >
> > can you provide an example/test for this? Should this be a weak group issue?
>
> Before:
>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
>   ^C[ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.540 MB perf.data (531 samples) ]
>
> After:
>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
>   Error:
>   AMD IBS may only be available in system-wide/per-cpu mode.
>   Try using -a, or -C and workload affinity
>
> The error message is stale and misleading. I have a patch to fix it.
> I'll post it separately.

I'm just curious if ibs_fetch and ibs_op can be grouped together.

Thanks,
Namhyung
