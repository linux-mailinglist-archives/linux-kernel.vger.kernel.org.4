Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA54B6E2DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 02:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjDOAH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 20:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOAHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 20:07:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA74930F1;
        Fri, 14 Apr 2023 17:07:24 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id j12so13277806oij.3;
        Fri, 14 Apr 2023 17:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681517244; x=1684109244;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YOVBScV/L5mSC+yxrbxs0wZbeTYNUTdbYiVYGdDlaI0=;
        b=eMxMcb8VsSsLAKok0wGQYsG/xwJiaw/pT5CPeAGn9qXXEsAUnJ/XaXkrCd1i2dMQzn
         +B0JNUmPY5tMzixPEa+Pe/WMwDYjmhUah0fauLHgqmaNRJTyVzUW+ItxTTzJ/Ga6n5tE
         JaorDOQXWXf1ZLDCfuMSWRA4J7SZ4UmGK4G6T7Wh0pBFpTBygIIEgMaTHyU7c7C0M120
         YxX9qOZIG8w+PVX+Qzn6nUGKyEkLGAMk+HPoAe4XbzCNMwwwkFIyW38PE3rWKECnHaj2
         OdYCzUgD7Dr0/E91ZiFOChdGGTcSkPz4JrsxEbPn5dppC8xo8l/g/xmuzN8e9yfsjwXi
         uHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681517244; x=1684109244;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOVBScV/L5mSC+yxrbxs0wZbeTYNUTdbYiVYGdDlaI0=;
        b=PF/ojAfuP8kPNWZhqm2BBjdfwjK6NZ21xazAHvQ1uPYTfOPeAuYiD1x7yP4Ler6vFs
         7tb7fbQ/MeGuYyobGCNvqS9Z/pb15M4owcyUcbcIe84W1Qjzh027hbOU9hCblZH+vWzW
         Lv16+lpofRUfC1ZLiUPTdgyxQhViUUXD/CfjYSGusyKV2KxZ7f8YqC3rLt8fTziSqqbN
         vR+h8sSkzhhgsEtVvDuVg14saVdCfnKm5UY6cOyD6eKpd1zVtnHg0hhGc3uWyrtbVxJm
         Z6QzX97Z/WXNx5PjitlZy7qCBRYZ0qs5huq/d3hmyK73k+CEa3h8U3+SWv47vSJyDIi/
         xnhw==
X-Gm-Message-State: AAQBX9eCOsx7K0ZJ2NSXkfbsCCcj019+qMb64W1/PFfVovuOT18YEigh
        h5W3SDhK/Zyfz4iryqRGi9I=
X-Google-Smtp-Source: AKy350ZkB9jnRYIyzuzvlhIwF/V0GJO1JrBy2/M7NK6ZtC9TzMZOk3WXx1r6RvfpR1VGi7WjJsgjzA==
X-Received: by 2002:aca:1c0f:0:b0:389:234:6117 with SMTP id c15-20020aca1c0f000000b0038902346117mr3659084oic.22.1681517244082;
        Fri, 14 Apr 2023 17:07:24 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.238.117])
        by smtp.gmail.com with ESMTPSA id m83-20020acabc56000000b0037d8c938d62sm2202828oif.50.2023.04.14.17.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 17:07:23 -0700 (PDT)
Date:   Fri, 14 Apr 2023 21:07:17 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_00/21=5D_Update_uncore_to?= =?US-ASCII?Q?pics=2C_1x_event_updates=2C_2x_new_archs=2E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fU=h2pu=jgpzGTQ5MbZTZGvFTRYJLw2tqUPYk1vRr7c7w@mail.gmail.com>
References: <20230413132949.3487664-1-irogers@google.com> <ZDgL1Qca7N+Wilm6@kernel.org> <20230414081816.GS4253@hirez.programming.kicks-ass.net> <CAP-5=fU=h2pu=jgpzGTQ5MbZTZGvFTRYJLw2tqUPYk1vRr7c7w@mail.gmail.com>
Message-ID: <2E0A986C-CEB2-43A9-B9EA-B39F1A953C12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On April 14, 2023 8:14:54 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom> =
wrote:
>On Fri, Apr 14, 2023 at 1:20=E2=80=AFAM Peter Zijlstra <peterz@infradead=
=2Eorg> wrote:
>>
>> On Thu, Apr 13, 2023 at 11:04:05AM -0300, Arnaldo Carvalho de Melo wrot=
e:
>> > Em Thu, Apr 13, 2023 at 06:29:28AM -0700, Ian Rogers escreveu:
>> > > Update the uncore PMUs and topic classification as created by:
>> > > https://github=2Ecom/intel/perfmon/pull/70
>> > >
>> > > Event updates stem from:
>> > > https://github=2Ecom/intel/perfmon/pull/68
>> > > impacting alderlake, icelakex and sapphirerapids=2E
>> > >
>> > > Grand Ridge and Sierra Forest events stem from:
>> > > https://github=2Ecom/intel/perfmon/pull/69
>> > >
>> > > Changes generated by with PR70 in place:
>> > > https://github=2Ecom/intel/perfmon/blob/main/scripts/create_perf_js=
on=2Epy
>> > >
>> > > v3=2E Rebase over the update of alderlake and icelakex events=2E
>> > > v2=2E Adds improvements to uncore topics, uncore PMU name fixes and
>> > >     fixes a trigraph issue from ??? being in the json=2E
>> >
>> > b4 isn't liking it:
>>
>> Fwiw, the way I've set up b4 it takes the patches from my local
>> mailstore and it doesn't matter what made it out to lkml=2E Specificall=
y,
>> I pipe the patches from mutt directly into b4=2E
>>
>> I think there's some information in the b4 docs on how to set that up,
>> but let me know if you want more info=2E
>
>Thanks Peter! I'm using gmail for everything and I suspect I won't be
>able to reproduce your setup easily=2E I think the right thing is for me
>to set up a public git repository=2E I got about half-way through the
>kernel=2Eorg documentation before getting distracted=2E I should finish i=
t
>off :-) Perhaps Arnaldo can use the set up though=2E


Yeah, thanks for the info, I use mutt and will try Peter's B4 setup=2E

- Arnaldo=20
>Thanks,
>Ian
