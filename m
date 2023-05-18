Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00777078AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjERD5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjERD5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C530EC;
        Wed, 17 May 2023 20:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECF4064CC2;
        Thu, 18 May 2023 03:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1BCC4339E;
        Thu, 18 May 2023 03:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684382262;
        bh=G6AVMi0hrTTWDhiL/gg16hMUlxCQe8T09+SqoUjJUME=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V2twJTCLyTJw74goxDGDj1YFWMu4s5VQ5ZB8cptlVndVhk7mu2LroRkI3E5Ih7yQW
         IfWDLb2VFXq3KzVPen86qPb0VMq9aLO7vMcgpsuBetCu/FKMvRrZDVKms+zIzSVz+Q
         +eBGmctqOkPKLoCxH5x3L8ppn9sS+imBIH1OgVkC502ZP5+qd0zsx58XftOP0LUQs5
         n7NkIuwqnoufBgaK1WOxVJyNrQ/hMfzI0zt0Bl1ZX1FjCjIazqeRV0LAp513PAjMi7
         OBntH+daVRWuYTWTDcmo5gAC8PRmN7cg3oj3vcgtXH53vecTl5lkbVubHtfcBg+riI
         lXkrXVaSTcawQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-96598a7c5e0so248006066b.3;
        Wed, 17 May 2023 20:57:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDy6XadkY1zA2xgU6D3PcGnUC9GxbgzBoFx/iTqK6KXvnFaXK8mg
        gmMzrNAIIHYhBi1gUfXdSzPt2IcsaEQlx1HN0oE=
X-Google-Smtp-Source: ACHHUZ5vtp6mjND47jiy61XP3fK4msZ3M5xvGQ7gV+x9CgBQOre1DAnS51ZHqla+VrBPOOfvbt0gXi4JCpODyewgJ/Y=
X-Received: by 2002:a17:907:9405:b0:94f:5e17:e80d with SMTP id
 dk5-20020a170907940500b0094f5e17e80dmr40206605ejc.45.1684382260517; Wed, 17
 May 2023 20:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <1683615352-10794-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7waE0gmSU09YKJMHDAnj7BV7ukiLqWs+JzzLrHDG5z8w@mail.gmail.com>
 <20230518030618.GB1068119@leoy-yangtze.lan> <CAAhV-H6L9kNyGU2UrX7jyN_6O_pafSVSamP7DYHkzfMgmCxVXA@mail.gmail.com>
 <20230518032129.GC1068119@leoy-yangtze.lan>
In-Reply-To: <20230518032129.GC1068119@leoy-yangtze.lan>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 18 May 2023 11:57:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6_=qwheWvNozop2+9MexnOZQcva28xaeikCc49_DqABA@mail.gmail.com>
Message-ID: <CAAhV-H6_=qwheWvNozop2+9MexnOZQcva28xaeikCc49_DqABA@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: Add LoongArch case in get_plt_sizes()
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 11:21=E2=80=AFAM Leo Yan <leo.yan@linaro.org> wrote=
:
>
> On Thu, May 18, 2023 at 11:12:26AM +0800, Huacai Chen wrote:
> > On Thu, May 18, 2023 at 11:06=E2=80=AFAM Leo Yan <leo.yan@linaro.org> w=
rote:
> > >
> > > On Thu, May 18, 2023 at 10:11:27AM +0800, Huacai Chen wrote:
> > > > Queued, thanks.
> > >
> > > The patch is fine for me.
> > >
> > > Should not perf patches are to be merged via Arnaldo's tree?
> >
> > I think both are OK, if Arnaldo takes this patch, I will drop it.
>
> A good practice is to firstly inquiry the maintainers.
>
> AFAIK, Arnaldo will test perf patches before sending out pull request;
> if perf patches are scattered out, it might be out of the testing
> radar.
OK, I know, thank you very much.

Huacai
>
> Thanks,
> Leo
