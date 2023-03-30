Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D9B6D0629
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjC3NNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjC3NNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:13:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B74AC9760;
        Thu, 30 Mar 2023 06:13:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEA882F4;
        Thu, 30 Mar 2023 06:14:22 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0FE33F663;
        Thu, 30 Mar 2023 06:13:36 -0700 (PDT)
Date:   Thu, 30 Mar 2023 14:13:34 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Maulik Shah <quic_mkshah@quicinc.com>, andersson@kernel.org,
        dianders@chromium.org, swboyd@chromium.org, wingers@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, jwerner@chromium.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com
Subject: Re: [PATCH v2 1/2] cpuidle: psci: Move enabling OSI mode after power
 domains creation
Message-ID: <20230330131334.idb25zf4tdf3zqn3@bogus>
References: <20230330084250.32600-1-quic_mkshah@quicinc.com>
 <20230330084250.32600-2-quic_mkshah@quicinc.com>
 <20230330093431.xn5wwiwqbne5owf7@bogus>
 <CAPDyKFpUmkF=pOwXNrva1k2R+RFBB39-Y4kA0Fve+-3NGbtDag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpUmkF=pOwXNrva1k2R+RFBB39-Y4kA0Fve+-3NGbtDag@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 02:06:19PM +0200, Ulf Hansson wrote:
> On Thu, 30 Mar 2023 at 11:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Mar 30, 2023 at 02:12:49PM +0530, Maulik Shah wrote:
> > > A switch from OSI to PC mode is only possible if all CPUs other than the
> > > calling one are OFF, either through a call to CPU_OFF or not yet booted.
> > >
> >
> > As per the spec, all cores are in one of the following states:
> >  - Running
> >  - OFF, either through a call to CPU_OFF or not yet booted
> >  - Suspended, through a call to CPU_DEFAULT_SUSPEND
> >
> > Better to provide full information.
> >
> > > Currently OSI mode is enabled before power domains are created. In cases
> > > where CPUidle states are not using hierarchical CPU topology the bail out
> > > path tries to switch back to PC mode which gets denied by firmware since
> > > other CPUs are online at this point and creates inconsistent state as
> > > firmware is in OSI mode and Linux in PC mode.
> > >
> >
> > OK what is the issue if the other cores are online ? As long as they are
> > running, it is allowed in the spec, so your statement is incorrect.
> >
> > Is CPUidle enabled before setting the OSI mode. I see only that can cause
> > issue as we don't use CPU_DEFAULT_SUSPEND. If idle is not yet enabled, it
> > shouldn't be a problem.
> 
> Sudeep, you may very well be correct here. Nevertheless, it looks like
> the current public TF-A implementation doesn't work exactly like this,
> as it reports an error in Maulik's case. We should fix it too, I
> think.
> 
> Although, to me it doesn't really matter as I think $subject patch
> makes sense anyway. It's always nice to simplify code when it's
> possible.
>

Agreed, I don't have any objection to the change. The wording the message
worried me and wanted to check if there are any other issues because of this.
As such it doesn't look like there are but the commit message needs to be
updated as it gives a different impression/understanding.

-- 
Regards,
Sudeep
