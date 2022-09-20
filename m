Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE455BDDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiITHDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiITHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:03:09 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47554A805
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:03:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p5so1812864ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ji9CecbK4eOTJliyu3DFMHnKMxpMZqmyVNQT4faFfM8=;
        b=MjnWGd45Flb/C8Q0Z+ZpN1yXm6bN2TKxAIG5ptySSgbI6a+7nvVcLuEc3Fz4F48b9D
         wgJ/k39tblDdYjT2QLEwZn60kKuK1mXd50AVUCAn4Na20+hWiceGDIQtDozDiVLIITfH
         ai4yQlixC29eDXGdsbjhW0fPA9VjIkKbVo1o+zpL80NDl9/cy3kwU+Dd7wgd+67fMMMv
         rB638NbLSU3GzlRXx7CKXjMOicc/qelcJHRfl+BXLhe4dTNBCovaa70ECHFIA/EFLlm3
         aG0hS5/VZRz8vqoJ/6t3pCHESuoc/wJ9qHq9ovkk2N/qrIgJHfKW4E7ekKuVytIdPwjV
         XjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ji9CecbK4eOTJliyu3DFMHnKMxpMZqmyVNQT4faFfM8=;
        b=zpHKktrqg0D6aR6FlRbeM0rtVRTvVycYTZAi641ODJIwpocwQpZ1crWIgm63ZaGIPG
         D0zYFqx4VnGbtdAx5/EiCjVpsL5E+GwwW/mzkzM3rTo/AmlAilvxTxC9OKQU575WVvEu
         yU0uW1pRmQOC9AQVNXvSemICy/amIPhrRn1EtSM4iRByf358eYk8gbMkhGYKTMZgPBos
         5N5Hhh2TuFp7gXy0TehD0/02Fv/Y3GmFa3JuM33AzsQy8ZjV5oNCQuouIX7c7KeUH6dg
         S3nRrTY6pVVoVhE5qTS5nvBrBYcCCfhHibN6UouYQ+i/hxEmXaYaBCxL8E/BafyyRK4k
         flpg==
X-Gm-Message-State: ACrzQf1B0qajHxoOcpW7D34X144a5aNYOtEiAuvm/kalFOFUFGNtktwa
        HBETyPPi2lHN1WJVhwP/aiW+nZdlbpODzbT3ENsM6sGMUrOkRQ==
X-Google-Smtp-Source: AMsMyM6+rvJpak+hb6dOKEJuJwENjM+R5IZ92Xmtuah5owZ7XvbUOK/GWP7g/RgJcejXI5ql9Wmjbka0xWlCUDaz8q0=
X-Received: by 2002:a05:651c:160b:b0:26c:252a:91a5 with SMTP id
 f11-20020a05651c160b00b0026c252a91a5mr6162872ljq.266.1663657387127; Tue, 20
 Sep 2022 00:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org> <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <YyioChBV2ecBw/vg@slm.duckdns.org>
In-Reply-To: <YyioChBV2ecBw/vg@slm.duckdns.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 20 Sep 2022 09:02:54 +0200
Message-ID: <CAKfTPtBCgJwwvEbKYTQZaczE+z+akoJy5607tFF897CK7w+WUg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
To:     Tejun Heo <tj@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sept 2022 at 19:34, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Sep 19, 2022 at 01:55:15PM +0200, Dietmar Eggemann wrote:
> > s/valentin.schneider@arm.com//
> >
> > On 16/09/2022 10:03, Vincent Guittot wrote:
> > > Task can set its latency priority, which is then used to decide to preempt
> > > the current running entity of the cfs, but sched group entities still have
> > > the default latency offset.
> > >
> > > Add a latency field in task group to set the latency offset of the
> > > sched_eneities of the group, which will be used against other entities in
> >
> > s/sched_eneities/sched_entity
> >
> > > the parent cfs when deciding which entity to schedule first.
> >
> > So latency for cgroups does not follow any (existing) Resource
> > Distribution Model/Scheme (Documentation/admin-guide/cgroup-v2.rst)?
> > Latency values are only used to compare sched entities at the same level.
>
> I think it'd still result in a hierarchical behavior as scheduling is done
> recursively top-down. Right, vincent?

Correct

>
> It doesn't fit any of the resource distribution model. But it's rather
> difficult to map latencies to existing concepts of resources and we have a
> precedence in the cpu controller (.idle) which behaves similarly, so as long
> as the behavior is hierarchical, I think it's okay.
>
> Thanks.
>
> --
> tejun
