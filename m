Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0EF712A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbjEZQQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjEZQQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:16:03 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E7ED8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:16:01 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6af6f5fc42aso1039431a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1685117761; x=1687709761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDlTDGbuKA41l4lwuGymi6rlTXSveie0ey6DiI9icGU=;
        b=Euf4o/Ygy5/YJmgSUbCtF0/jd8I0XGXo124m4zSjqOcCspN+5euc9GO9amwQ8qbRRS
         KTj1qRcNdtrAt/qeRlywDd3rnPFwtUZvDNb3x+srvwIFThIeJlCKlnZjzir9tjhIIlgf
         Rx6dM8+nmjie2qXwVg03inZ5RXO4KVQSiK0QgPdtd+YYVEF/1MIAey999UPFNUvTPaew
         0ne+Y/jdf59V/UQeTU1n4j9DOhPrT9ZHjOUalbwj4EO2DEJn7+Lqie1H01c79WyyLHqT
         griEAuUytczKujqalE+3++1zozEHsZ8ztxkSnKmj3Yn9RmpzyoKcQxKBLSSqqK4hs4tC
         ywog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685117761; x=1687709761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDlTDGbuKA41l4lwuGymi6rlTXSveie0ey6DiI9icGU=;
        b=fi5iFF0kIdRjnAdvopFe+mhjLbNFTrtebrkAeArXUjYG2v5+qvJuHmk8jFCOeMc4dt
         rVjmrdyFMLCtdFo6MpAfTJuGt9r7AYQCP5DP3Ns+/son1/hqd6lNTOZeHgUOw+UNGPZO
         q4pjV19+HpEzgiRFV44FMSwp1m166m4fTP4WNz413XqkEXKtlEchFrKpOz4OyrJ8NFNe
         jRDjmU5VWp4Utg97TfmWwEy2xABv8LwMCINH3o5FRBBSH8h/25/WV25uLBw7LPiUNOi7
         jG7wNGnrYqCoD4HWgPg/zght3fPiduAkeSJiYkLv72hHT1m36iJpmic9Cjl7CZMhNcjs
         9/xQ==
X-Gm-Message-State: AC+VfDwrmO9AAuSOsbhZdMEOCah3x/2csD08obB9IhvTYk4lEFExvNcg
        WI1EkYMpdAkRcHBS8JF1csiDScPHZTUcoww2MYSEuQ==
X-Google-Smtp-Source: ACHHUZ4h1so23xGA2B3TC0WeilISx3hYkfkFiojRcVtTpd4y89tXJ9rmMtaDQ2e0iM3blS1V6Cdu7cPRH4w+bvXB/ZA=
X-Received: by 2002:a9d:6ad3:0:b0:6af:7818:add2 with SMTP id
 m19-20020a9d6ad3000000b006af7818add2mr1056477otq.37.1685117760931; Fri, 26
 May 2023 09:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230526145519.2282062-1-vineeth@bitbyteword.org>
 <20230526172959.5440b9dd@nowhere> <CAO7JXPgLFgXANqXY7L-YLbijxJCOgUKmd8nUQizb62JorOXGhA@mail.gmail.com>
 <CAO7JXPit6snFM2oW-uSs-mtbmKr9wpbX2exqAUF0iAiaAO6hOg@mail.gmail.com>
In-Reply-To: <CAO7JXPit6snFM2oW-uSs-mtbmKr9wpbX2exqAUF0iAiaAO6hOg@mail.gmail.com>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Fri, 26 May 2023 12:15:50 -0400
Message-ID: <CAO7JXPgf9ffVQ3n9iD8-1abuDSAZHWAZmz56BmM68uJZ7uy+Uw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/deadline: Fix bandwidth reclaim equation in GRUB
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 11:58=E2=80=AFAM Vineeth Remanan Pillai
<vineeth@bitbyteword.org> wrote:
>
> > > ...But I think this is wrong (should be "Umax - ...", not "1 - ...").
> > > I think patch 2/2 has the same issue.
> > >
> > Oops sorry, I missed this. Will send the fixed patch as a
> > reply to the original v4.
> >
> On looking again, I think the description is correct. That line
> mentions the actual m-GRUB equation from the paper. And then the
> comment explains why we use Umax(because of limiting the bandwidth
> to RT capacity).
>
Ahh my bad again :-(, I was looking at the commit message. I see the
issue in the code comment now.

I have just sent the fix as a reply to the initial patch. I shall send a
v5 if needed. Please let me know.

Thanks,
Vineeth
