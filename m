Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD43C727BF4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjFHJy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjFHJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:54:25 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA03269E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:54:24 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bad97da58adso477661276.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686218063; x=1688810063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0ba9DNkSY4/DucgUWvAeaHUG2A2JOR/Yvq1EwvyCGo=;
        b=PvrqaK1/kX1GZWYJfA7CicJo63zMlQ6/mCMec4FvBwqcpI23YdywuXvaYywxpXoVAt
         fh+jOZqYZ/YwptXtLy+cR0dVNTruCXj0dQMldKBD49hQ4ZyxPkxkMkVMp5vJhV4kB58V
         X2nOulJrWA/WpAOmg8EmidVRjaUHdL6w7vd1al+jmlqHcALAlFpXlxIiyuoLVI7oHPjD
         dBK82ifo17E+pFRt4GbQN4CA7jy75ipE922hLl7V2V4Xcg0eNlwSgv673SEwq9YOEKDw
         nI/U9R2Rwj/XvfEKcaBw7f+RlemPwY4n+uCHUpf2LvxIG7PHX9ZfP4RYnhxtz9ClrZMK
         yVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686218063; x=1688810063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0ba9DNkSY4/DucgUWvAeaHUG2A2JOR/Yvq1EwvyCGo=;
        b=eiq1vDcRM4g4LftkeRFiPryrnyHwx9E8Vk5P7Mf0knigXdtUEu9vXP9Yxn/5MmvY7v
         Xqg3FKTkynH9Wy7u6gEg2U6ww4B+rtwZeidS69LzKj23BemJjGRIUTXc/664IpzslFRX
         TPsfx+7akdhBAPuvtf5XZkilJa8XX2Ai9fIveuyKwcQzDRLph/3yiLFLtOfSAelZbp68
         c1y5HZPjaO5AXJ8xX3n+WFiiYfydQU1TRtfMfvRAe9sdU95p/I3cGqk7SaYtiRKVakIs
         5wXWWWm2QfmS/PaPm90VbgXs4x7dsgvOMSUm6yn4grwozfq1bI4PsTPGnGNE0EdvOysq
         7s9Q==
X-Gm-Message-State: AC+VfDwgRYjoqFgcdV6V9unXDkjxEzNMGlZ74oeEdt8H8ssVfCSTeYnj
        qATgf8DonZT7pc63a6dAygGJgxCFlvGk5QdesX5+7g==
X-Google-Smtp-Source: ACHHUZ5a1sWdYHtcKgG2yKf8VeE8kNtZPQc7G/LZ+GLdMKmpWFnaDoLh/zKdSQaBoJ7nTto8hrjlXqozJ7J92leT9lo=
X-Received: by 2002:a81:86c7:0:b0:561:429e:acd2 with SMTP id
 w190-20020a8186c7000000b00561429eacd2mr10650706ywf.35.1686218063254; Thu, 08
 Jun 2023 02:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230607124628.157465-1-ulf.hansson@linaro.org> <ZICXjExmCRwcQ3BA@e120937-lin>
In-Reply-To: <ZICXjExmCRwcQ3BA@e120937-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 11:53:47 +0200
Message-ID: <CAPDyKFoQv1wue122umZo4W3YNTQb4ic8bnJq_nrWZ7bu8dzKUQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] arm_scmi/opp/dvfs: Add generic performance scaling support
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 at 16:43, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Wed, Jun 07, 2023 at 02:46:12PM +0200, Ulf Hansson wrote:
> > The current SCMI performance scaling support is limited to cpufreq. This series
> > extends the support, so it can be used for all kind of devices and not only for
> > CPUs.
> >
> > The changes are spread over a couple of different subsystems, although the
> > changes that affects the other subsystems than the arm_scmi directory are
> > mostly smaller. The series is based upon v6.4-rc5. That said, let's figure out
> > on how to best move forward with this. I am of course happy to help in any way.
> >
> > Note that, so far this is only be tested on the Qemu virt platform with Optee
> > running an SCMI server. If you want some more details about my test setup, I am
> > certainly open to share that with you!
> >
> > Looking forward to get your feedback!
> >
>
> Hi Ulf,
>
> thanks for this first of all.
>
> I'll have a look at this properly in the next weeks, in the meantime
> just a small minor remark after having had a quick look.
>
> You expose a few new perf_ops to fit your needs and in fact PERF was
> still not exposing those data for (apparent) lack of users needing
> those. (and/or historical reason I think)
>
> My concern is that this would lead to a growing number of ops as soon as
> more data will be needed by future users; indeed other protocols do
> expose more data but use a different approach: instead of custom ops
> they let the user access a common static info structure like
>
>
> +       int (*num_domains_get)(const struct scmi_protocol_handle *ph);
> +       const struct scmi_perf_dom_info __must_check *(*info_get)
> +               (const struct scmi_protocol_handle *ph, u32 domain);
>
> and expose the related common info struct in scmi_protocol.h too.
> Another reason to stick to this aproach would be consistency with other
> protos (even though I think PERF is not the only lacking info_get)
>
> Now, since really there was already a hidden user for this perf data
> (that would be me :P ... in terms of an unpublished SCMI test-driver),
> I happen to have a tested patch that just expose those 2 above ops and
> exports scmi_perf_dom_info and related structures to scmi_protocol.h
>
> If you (and Sudeep) agree with this approach of limiting the number of
> exposed ops in favour of sharing upfront some static info data, I can
> quickly cleanup and post this patch for you to pick it up in your next
> iteration.

I think your suggestions make perfect sense to me too.

While I was adding the new ops in scmi_perf_proto_ops, I was merely
trying to get inspiration from the scmi_power_proto_ops, it seems like
those need an update too.

Although, there is no need for you to send a patch for "perf" at this
moment - as this piece of code is easy for me to put together myself.
I will simply replace a few of the patches in the series with a new
one, no problem at all.

>
> (really I'd have more conversion of this kind also for other remaining
>  protos but these are unrelated to your series and I'd post it later)

Yes, that can be handled separately, and I leave that for you to manage.

Kind regards
Uffe
