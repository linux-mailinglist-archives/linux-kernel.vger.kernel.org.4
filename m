Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2581F7128FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244064AbjEZOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243953AbjEZOyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:54:22 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881CEA4
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:54:20 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3980c92d8d6so587687b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1685112860; x=1687704860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+56fY/5+2HGaZ2hqcCU8ZKhJQzE36DT9siXObgPb4sI=;
        b=SEtT0oQS+/fYOqtyGxZV+9T8fQAcpAAz8D+5UIIbdwLy/e03Eyw650js8GGTl99QJ7
         S0QPylmP8Wawzc7usyDjLPFQnn5/VjVEAh6PBarGE2G7wYHQKXKws8jQAcS/4IGZXdw+
         6aIly0yimW2hgXTW9xL2SrEzt6xKhitlAIhCfg2pOl3fH2tKoIJhUuaDqvookoNEMUvK
         WidId6TRRPEjDugBLtT5ErJyIKExi96NJb28feeEJrPBGitxjFvnqvACWjXHxndQjx/q
         ojOqiAwdZS8FoyvDjIrwE9g1dmCNZmD/FzGFo+3iIaUmZhwmgUbQc5sM6Z2zyHdGl5lx
         mzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685112860; x=1687704860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+56fY/5+2HGaZ2hqcCU8ZKhJQzE36DT9siXObgPb4sI=;
        b=L55xDg9Sqa1IpS+4QVBDn8B76BoJ7zJVY+0sHeTvtiCTDeVA+EBGxsTHuU9udSIcHY
         fL2HiYBgeWiRKZ+BXaTzzRxvLVB1ffRv5kPdZUXdPJ87NGWClbkxjqcrWGtmyqCOP5/d
         o+iRmsRiV/dp07i2GMhzomq33eF74uPHiGeBTZ/BAmkv3UejpFaoNT7JrD/jIRwuBPx6
         UGt+vwvZLHupcAtRaKNsYrfbouDMVA67vmF+dBuU/hyMlmNipWfHGqjMSxM6xfa3qFpk
         ETJB92u/OOm4xKW/tgCAty8AC1BgxV1du3IMpTM/4ANGrH8RhYuJEo7texq+v/0V2m4X
         oaKQ==
X-Gm-Message-State: AC+VfDwb+pQJFykWIM29AhgoNYi0Tcp0sasIYv908P4e6s+jN68X+iWk
        s1ClEIkxt4jxawVEGPpfGil6Fmtg0kQ9mFEd7o8tTg==
X-Google-Smtp-Source: ACHHUZ7FFbPzPwjbPfj3GZk2NOBKYF3PNOSEy2uYN47Ub556uDf5WyWkrw7cf99AoSP72AUFgwbl7zPejSPPx3uLT2g=
X-Received: by 2002:a05:6808:7c2:b0:398:10ad:e83e with SMTP id
 f2-20020a05680807c200b0039810ade83emr1068039oij.1.1685112859881; Fri, 26 May
 2023 07:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230515025716.316888-1-vineeth@bitbyteword.org>
 <20230515025716.316888-3-vineeth@bitbyteword.org> <20230515100616.33ba5dd9@luca64>
 <CAO7JXPgq8V5yHM6F2+iXf4XJ9cyT30Hn4ot5b2k7srjsaPc3JQ@mail.gmail.com>
 <20230516093729.0771938c@luca64> <CAO7JXPh5uLV4QjAEi6bJXfAGSsZ=XsnCyzrvKS8m35BGbRPYJw@mail.gmail.com>
 <20230519115621.2b3f75e2@luca64> <20230519121804.6c85a3ed@luca64>
 <CAO7JXPhZPvzVRyL87qNT5VnaVOf=0wrRftFB-Rjx-vJc3JUMog@mail.gmail.com>
 <20230520115857.3838a7ea@nowhere> <CAO7JXPgXi8q02HBeBR_RLWmODd9uQBH_UMCYgVQwbf+FX=Qxkg@mail.gmail.com>
 <20230523225831.60d75b38@nowhere> <CAO7JXPihFGX5Dop=ox3YDQ=8aQbzZ-ka_1h3hT1G46vsbxpzNw@mail.gmail.com>
In-Reply-To: <CAO7JXPihFGX5Dop=ox3YDQ=8aQbzZ-ka_1h3hT1G46vsbxpzNw@mail.gmail.com>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Fri, 26 May 2023 10:54:09 -0400
Message-ID: <CAO7JXPhDCzJOvanKG=04wU3Q=C6GRW=+t2Zq6GmuQvfutjE8PA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] sched/deadline: Fix reclaim inaccuracy with SMP
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Tue, May 23, 2023 at 10:11=E2=80=AFPM Vineeth Remanan Pillai
<vineeth@bitbyteword.org> wrote:
>
> Hi Luca,
>
> [...]
>
> Will send it out tomorrow after a bit more testing.
>
Sorry for the delay. I was trying to fix the inaccuracy when normal
and SCHED_FLAG_RECLAIM tasks are present. Its a bit complicated than
I initially thought as Umax_reclaim and Uextra needs to be computed
at the root domain level and this would mean more locking. I have a
patch ready but I think I need to do more testing to understand the
performance implications and it is better to batch it as a separate
series.

So, I am just sending out the GRUB equation fix which is tested well
and I am confident about. Will send out rest of the fixes later as
a separate series.

Thanks,
Vineeth
