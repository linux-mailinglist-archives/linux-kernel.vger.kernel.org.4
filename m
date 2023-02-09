Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19862690C42
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjBIO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBIO4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:56:18 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754C65BE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:56:17 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u9so3043212plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4Gp3Q22MwnvaJXPkKM1GJ/Tl/PCqCy3cqgkx9gfG6Y=;
        b=zOXq1UwwC+EDJ1QfiH+UOdM+sLNNPgty2xMn4E/1mrGb4wL4NV1pCfhEJYzQoC6wiK
         swk7upAGOO1VnExEwqUMuMrLz8ndRKBTRac72LeJzSe0sFFqCqPipMN42XsjnL4T4lih
         /QlmUTs+WR2XfRvcbQ3uIukv8rdgqoLqfdHQFYkKWsbohYawCo1zhFg6UoA/GRjvFV8s
         RpqBul/0+REXFE9xut2eQ4obAp/l//22M+BUlHupHGeH9VxXTlBn+RTb3AX/gPHhCwkd
         Ql5oKqRhFnERtAnOsRsorr7ydWCIy/AjOiV2WEXD/UpMcMl1Vvzk0VHtz0ClOOsIbrZQ
         n6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4Gp3Q22MwnvaJXPkKM1GJ/Tl/PCqCy3cqgkx9gfG6Y=;
        b=4RsqY++91Cv0l9O5ncYjxcY3soVo1QsphjiVmPgm41v1E2dFvmET1KBzjkp/HQV+gb
         qK4WDm45RCS7Ncs/6younoiQt5Oa5vvvKg/MO0utGHyeYLcomcBWJLgzcWccdZ8bQ6uZ
         /sAIgJEIGZ9+SNzGQnMeCUftfczZuck6Pbb6rLAagquVONCV6LqXytwxK8TLM2/E3KZ2
         ZiijbUqHX911wHF3OwjWTgyWYpp0lYzajfzqln2wkTswUC3uiysiGlOJR4gW0VH2st4U
         6grTRF4XVPhLTe5hM3XPMYmawIVZ7vJyG8mg8PySbxeRT/YaQV1v/TPd7BROiohApdll
         wLpA==
X-Gm-Message-State: AO0yUKX5wxbakgeYDcZ6fwPtXTgjDaGvBr8A18N0B6QMupVcecM0yABJ
        Xnpb5w964BUk+o5FvhD4ewmcgE+nVU/b91P305W5DA==
X-Google-Smtp-Source: AK7set+W88ZhrEcQgq+tAvGlvM7yfbjbvfaALfrOks+QWKsl32L+9dhneGI/1Aux+WTL4q2HP2CtXOr83M7PLBGXJzY=
X-Received: by 2002:a17:90a:684d:b0:22c:789:d60d with SMTP id
 e13-20020a17090a684d00b0022c0789d60dmr1785209pjm.62.1675954576643; Thu, 09
 Feb 2023 06:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20230208111630.20132-1-quic_jinlmao@quicinc.com>
 <CAJ9a7ViBS9K6cKsOi3btw1b5cM9VTSb-q8s6W3WUAgeW3-T2Sg@mail.gmail.com>
 <CAJ9a7ViA5BsbLjRWMsttmpmcPh1yUXK8J79k-pqYybVZkMQHXQ@mail.gmail.com>
 <bb6c9df9-af9b-873e-85bd-a29d00bb39d7@arm.com> <1d9b8ee8-c3f2-99bc-cd4e-8c2dd0f04b2b@quicinc.com>
In-Reply-To: <1d9b8ee8-c3f2-99bc-cd4e-8c2dd0f04b2b@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 9 Feb 2023 14:56:05 +0000
Message-ID: <CAJ9a7Vh08A8b7YLF=pYPudB0CZ0XjEpF=4YHrNNd7xo_JQGYaA@mail.gmail.com>
Subject: Re: [PATCH] coresight: core: Add sysfs node to reset all sources and sinks
To:     Jinlong Mao <quic_jinlmao@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 9 Feb 2023 at 03:02, Jinlong Mao <quic_jinlmao@quicinc.com> wrote:
>
>
> On 2/9/2023 12:36 AM, Suzuki K Poulose wrote:
> > On 08/02/2023 16:20, Mike Leach wrote:
> >> Quick correction - you need to look for enable_source  / enable_sink
> >> files and disable those that are currently '1'
> >>
> >> Mike
> >>
> >> On Wed, 8 Feb 2023 at 16:16, Mike Leach <mike.leach@linaro.org> wrote:
> >>>
> >>> Hi
> >>>
> >>> As this is a sysfs only update - would it not be easier to simply use
> >>> a shell script to iterate through coresight/devices/ looking for
> >>> disable_source / disable_sink files and setting those accordingly?
> >>>
> >>> See tools/perf/tests/shell/test_arm_coresight.sh for an example of a
> >>> script that does similar iteration to test coresight in perf
> >>>
> >
> > +1
> >
> > Suzuki
>
> Hi Mike & Suzuki,
>
> Sometimes user just want to have some quick test from PC with adb commands.
> It is very easy to reset all sources and sinks' status by command below.
> echo 1 > /sys/bus/coresight/reset_source_sink
>

Users of coresight via sysfs will have to know how to use the
coresight infrastructure in order to enable the sources and sinks in
the first place -
e.g
echo 1 > /sys/bus/coresight/devices/tmc_etr0/enable_sink
echo 1 > /sys/bus/coresight/devices/etm0/enable_source

Given that they are aware of which sources and sinks they enabled -
disabling them should be simple.


> Preparing the script for test is not easy for users who are not familiar
> with the coresight framework.
>
If there is a genuine use case were a user has opened so many sources
on the command line that they need a simpler way of closing them than
repeating the enabled commands with an
echo 0 > ...
then any script could be shipped as part of kernel/tools/coresight or
kernel/samples/coresight - they would not have to write it themselves,
and just run it from the command line - for example :-
./kernel/tools/coresight/scripts/sysfs_disable_sources_and_sinks.sh

Realistically users will only try out a couple of devices as the
usefulness of the sysfs interface is really limited to testing or
board bring up.
Any complex use with sysfs - as in the coresight tests I mentioned
earlier is really going to be done by scripting.


Regards

Mike

> Thanks
> Jinlong Mao
>
> >
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
