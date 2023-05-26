Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB6C712DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjEZTrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjEZTrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:47:46 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D630CBD
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:47:45 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bacf7060678so1969159276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1685130465; x=1687722465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUz3cYZJzxYpChJac/7E7ylhZT6Nv4qatri6Adv31ts=;
        b=nGEyT5uymfWQJUBAXIcnKOztcnh+nuA/ennn48fCHOEnED4St0CC/dOuSXWfnFHnau
         OYFzPg0TT6M2J/Lpui/uacLJNLWJIdkWkyIR6c+CkLnelBPOKHQgBEhG/z4CURSHN+k3
         eTNza7OJnInTM0DnCb0qGmgAHt4uQkBo3phHmfjrOlEDfrrUE0mH9ZOg6XyLZJaKTMpw
         cvKT1v4O5DATyNtP0YOuj6kvKb6Y98tIATVyFD+CCCrgtAhk/FqzjiZ2y6kBbsoKTwNy
         gJMEDUNYLsfNsX1i7r18sb2HVYDbcUUFcbsfRDFZK63jcxMkrOIAG/mG1IhCK+WYkyWL
         6wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685130465; x=1687722465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUz3cYZJzxYpChJac/7E7ylhZT6Nv4qatri6Adv31ts=;
        b=k6EKjf2WU2AQ0jyusSfT7w4PVhFm5vnOSS6Hu3EeFg5cRBovt7RvTa4r8Z3uFh3Yqy
         yK2RM2gXIGI2+HXMz6BFSznPRTG3/8kIJ9XqehcXFtbZWdF+QGSLv28OqZRtsRMD2OQu
         V0k4iZIGWUHPoCps/vxy8lMiiMMocbzRHlCTy0XNmM2VoodvQni7qsrvhPPu8dcaIMFq
         ArrxvCQwkCRv0t9jgwjhjOpGFIDEXDDGxlyIuwP8IVr/3bkMipfMxXIoW6X00aOlyt0l
         Pd5no4bdPfCTU3qFvtgIbOvQJYMNyJuq46yXM3zG43iqcmJ8alWU3zNitZlq/ft0Z4pa
         45EA==
X-Gm-Message-State: AC+VfDxjchiUNQ2GPZi/N7gjsvZBwbsjevde2aXebATKgAwZNaa0OYvV
        h6Y1qMBC0DTixx46OobUeEvGppeU+ItAkO2d4WoQEA==
X-Google-Smtp-Source: ACHHUZ4JH7SDDIfaBbEyxaE595kxzNqDoryzPH4uuMbFwu5yeZoTstauDgITfnvovwUAv+R6UqOtD4URMnbpHNYU4ak=
X-Received: by 2002:a25:5cb:0:b0:b9e:c516:6e32 with SMTP id
 194-20020a2505cb000000b00b9ec5166e32mr114111ybf.24.1685130465099; Fri, 26 May
 2023 12:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684887977.git.peilin.ye@bytedance.com> <429357af094297abbc45f47b8e606f11206df049.1684887977.git.peilin.ye@bytedance.com>
 <faaeb0b0-8538-9dfa-4c1e-8a225e3534f4@mojatatu.com> <CAM0EoM=3iYmmLjnifx_FDcJfRbN31tRnCE0ZvqQs5xSBPzaqXQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=3iYmmLjnifx_FDcJfRbN31tRnCE0ZvqQs5xSBPzaqXQ@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Fri, 26 May 2023 15:47:33 -0400
Message-ID: <CAM0EoM=FS2arxv0__aQXF1a7ViJnM0hST=TL9dcnJpkf-ipjvA@mail.gmail.com>
Subject: Re: [PATCH v5 net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
To:     Pedro Tammela <pctammela@mojatatu.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 8:20=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, May 24, 2023 at 11:39=E2=80=AFAM Pedro Tammela <pctammela@mojatat=
u.com> wrote:
> >
> > On 23/05/2023 22:20, Peilin Ye wrote:
> > > From: Peilin Ye <peilin.ye@bytedance.com>

> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

I apologize i am going to take this back, lets please hold the series for n=
ow.

In pursuit for the effect on events, Pedro and I spent a few _hours_
chasing this - and regardless of the events, there are still
challenges with the concurrency issue. The current reproducer
unfortunately cant cause damage after patch 2, so really patch 6 was
not being tested. We hacked the repro to hit codepath patch 6 fixes.
We are not sure what the root cause is - but it certainly due to the
series. Peilin, Pedro will post the new repro.

cheers,
jamal
