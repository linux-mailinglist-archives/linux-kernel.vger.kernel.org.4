Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6D7245DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbjFFO0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjFFOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:25:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E8199D;
        Tue,  6 Jun 2023 07:25:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b04949e5baso54248645ad.0;
        Tue, 06 Jun 2023 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686061524; x=1688653524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hmEz2MbCDzEXdAiTp6Aa2zyFmyqIvzUtehqc+a8JQM=;
        b=AgA8yJ2qSN0nKfzypklbbkOnFwubsWwLlNS1zuBDIfsGWUgRPxp4sXVz1ygkD7cM6T
         GcGX5fRp3+VQuDz3BG2Z8y3FcONjfMHDwCuxcO+jSaiOomqg5evWMmSjJcP/pA/N6yWY
         +iF9llU8Pu4KC8a/xjGJ7TsC0+wzeHpbwFjgHz2Rd38ed28bikd2JPt3KQE8LmWPb/7R
         xEY6cFSWXiYrvds/eg/8asRjB1q2dSwh4eupWCLOphNRJHKS5rJknVahnHLHZNQnQctd
         cxOzs0SkFVq7yEbHlsVMXSaYF+rU1vxQGuD04MkqqH1ZNTrERJtcPlLTonlhI/AKNzS/
         c0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061524; x=1688653524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hmEz2MbCDzEXdAiTp6Aa2zyFmyqIvzUtehqc+a8JQM=;
        b=c4Rs0+56tv4YIHuOsjq2+/Az/GjmB+k+xCH3Df8QDpN3qGg4gBeQkGltuSDcdmnzkW
         aou/u+PnjsE1PZXCHx8vAKJd5ywz4pAGjA+q/hS09MqGbUuXZDWEBiDbBSjblkIJly7n
         s7aToYggg4hmFcHP4X5DTJ3l/QcSPqTlV4Smzd5PeMT13b1XA7+xgE9tMmDsxDNKXi6Y
         dESmcsb8jFGXM7HNVMGs8WvoC8YO1Q/p3s+1BTY/quaRT8yf6/R/nb+O9t/fCa+1NT1x
         2ESnfRTZLwpxhKIBsQvI7vLuqwq6Dl61+YjSoKvEcQQG/h0Wy46l4cC34zE/Zcf+UemU
         EBPQ==
X-Gm-Message-State: AC+VfDzAOg+uFSFFMcffzDhHgS8e43cZHvr2oZpcLJT6Wkl/7ALrPZyu
        NSOBOBo4LnGmxN8bCbxRKmG3zvnrnIOct4Vrfyk=
X-Google-Smtp-Source: ACHHUZ7d+2TaEqKX/qlkdetQq2bn1illhFx2x6aBzSwuTkXTmCZiL6B4FG2rL7icmDKgrCjNKyk9TlvUUPAvcq5qcdE=
X-Received: by 2002:a17:902:e5cd:b0:1b2:28ca:d16 with SMTP id
 u13-20020a170902e5cd00b001b228ca0d16mr2457853plf.44.1686061524285; Tue, 06
 Jun 2023 07:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230525125746.553874-1-aleksander.lobakin@intel.com>
 <20230525125746.553874-4-aleksander.lobakin@intel.com> <8828262f1c238ab28be9ec87a7701acd791af926.camel@gmail.com>
 <cb7d3479-63a5-31b4-355d-b12a7e1b2878@intel.com> <CAKgT0Ud204CiJeB-5zcTKdrv7ODrfP09t73CqRhps7g3qhWU5w@mail.gmail.com>
 <d375fef9-43c4-9f2a-41c9-5247fcb3aa1e@intel.com> <CAKgT0Uc4UQ=PpVtjUAP=hjTDrWWkc79PeSwp39T6MSpo1ZyOag@mail.gmail.com>
 <cd88ac7e-fe82-fdc0-3410-0decf57d3c43@intel.com> <CAKgT0UeEz2Gqb62sn0pP3_yBMc-LpR0Twmv5_HTREvHBLpCsNw@mail.gmail.com>
 <5aac6822-6fe5-e182-935e-7aa86f1e820d@intel.com>
In-Reply-To: <5aac6822-6fe5-e182-935e-7aa86f1e820d@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 6 Jun 2023 07:24:47 -0700
Message-ID: <CAKgT0UegFu3LDhwx+ec8q1=c3OFzrKp=mhopzRFr84s4m9Ciug@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 03/12] iavf: optimize Rx
 buffer allocation a bunch
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jun 6, 2023 at 5:49=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Duyck <alexander.duyck@gmail.com>
> Date: Fri, 2 Jun 2023 10:50:02 -0700
>
> Sorry for the silence, had sorta long weekend :p
>
> > On Fri, Jun 2, 2023 at 9:16=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
>

[...]

> > The other thing is you may want to double check CPU(s) you are
> > expected to support as last I knew switch statements were still
> > expensive due to all the old spectre/meltdown workarounds.
> Wait, are switch-cases also affected? I wasn't aware of that. For sure I
> didn't even consider using ops/indirect calls, but switch-cases... I saw
> lots o'times people replacing indirections with switch-cases, what's the
> point otherwise :D
>
> Thanks,
> Olek

I think it all depends on how the compiler implements them. I know
switch cases used to be done as indirections in some cases. It is
possible they did away with that in the compilers some time ago or
came up with a fix to work around them. I just remember back when that
came up people were going through and replacing switch cases with
if/else blocks in the case of performance sensitive workloads. Odds
are there have been workarounds added to address that, but it is just
something to be aware of.

Thanks,

- Alex
