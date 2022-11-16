Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AA562B1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiKPDBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiKPDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:01:47 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C0712A86
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:01:45 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id s24so20110289ljs.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbJwOo2aYI9tCPUydn6kWQ3LyG6BHpru5i6DVYdJudA=;
        b=R+on548QhW2DknFw9KvnXtq35R8t6uXck8lce5DV9K7xmUvTfHptoZB+Q9tZ/IBHn5
         l77rODpnAH03N6Lu0ANaafhwSQKdqcPPNkyboOtGR6rLhsbI3rC5fzXRVEcH4TVxhlY8
         O7ogXGOdlWNqmFnyBRQCdFUoe0qOgUAzaKfHKGZDN981WvQlL+aNjCw118DrYHPckOON
         OIDQC8oWT/i6Slty07ldKVyWcKuWE31SVgYtlyuCI375q0RYvwo98zMQpnPd9ZvYqW76
         aWFylXZySDrpe+6v9w1Gel3/pYZYrh+48t7qEGOBzfJzg4gh4hcRPR5PDPYxfKhuBr9y
         b3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbJwOo2aYI9tCPUydn6kWQ3LyG6BHpru5i6DVYdJudA=;
        b=L2OLQ0W5Id08L+CdJtDgX8Ngw7WhB4NZuC9t4wFQ2phBQFnFPmynIEWSmfkgBktjzD
         Z+qAL5nrBjSR7xZL1u0xoUW6t9fy0UOy+HL0+RSkNxtoRIitUJGRegClV0FvHls7r+To
         FeiV1aX12aqaN6y+AfHpQm0Fwadzne/NOhe/WfbKaflAhTQbBtAgrWBbSwvJ587LOiPu
         wmE5W2HWrfYqqJBBgD6EVcfFhUJ2pG00yoIdfEngDst700kfFFaQVKf4UIf58oJEEOgF
         jzJ1jV/fJS1LBL64AHz536UxRgb4iU7YolKz48xV9FSumvr5Wi0trSPuA9fs4ap9G0B4
         iwSA==
X-Gm-Message-State: ANoB5pkSznJeVPFRsRO0EWy890iay4Gi08Knlyux73hYOlV7xts+r9Df
        zkatx2/46x7quSBqRCOHHpB4QECpaz7xJbjeNJEhuQ==
X-Google-Smtp-Source: AA0mqf5hKgOzFqoUlQJFzGijZWQaWdbLVsbwyZP+4R2PSwdHdX7xMpQrr/f1KlN3KMgmG2VUAO7apr6ry2vGrVuxYkM=
X-Received: by 2002:a05:651c:12c5:b0:26e:33f:3c3c with SMTP id
 5-20020a05651c12c500b0026e033f3c3cmr7207391lje.52.1668567703500; Tue, 15 Nov
 2022 19:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20221026224449.214839-1-joshdon@google.com> <20221102165922.GA31833@blackbody.suse.cz>
In-Reply-To: <20221102165922.GA31833@blackbody.suse.cz>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 15 Nov 2022 19:01:31 -0800
Message-ID: <CABk29Nvw8XMrc2_9CAUZb=rO_vddGjsfZ1s3mRQyShANDhtZnw@mail.gmail.com>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 9:59 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Also, can a particular cfs_rq be on both cfs_b->throttled_csd_list and
> cfs_b->throttled_cfs_rq lists at any moment?
> I wonder if having a single list_head node in cfs_rq would be feasible
> (and hence enforcing this constraint in data).

After more thought, I realized that we can't reuse the throttled_list
list_head, since that would potentially break the lockless traversal
of a concurrent list_for_each_entry_rcu() (ie. if we removed the
element from the throttled list and then added it to the CSD list).

- Josh
