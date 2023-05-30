Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F97F715AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjE3KDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjE3KDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:03:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 475C1CD;
        Tue, 30 May 2023 03:03:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FBE9AB6;
        Tue, 30 May 2023 03:04:16 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B75403F67D;
        Tue, 30 May 2023 03:03:28 -0700 (PDT)
Message-ID: <3ed3c9a0-8aed-02ad-b7f0-69200441a994@arm.com>
Date:   Tue, 30 May 2023 12:03:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 05/17] trace: energy_model: Add trace event for EM
 runtime modifications
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-6-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230512095743.3393563-6-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 11:57, Lukasz Luba wrote:
> The Energy Model (EM) supports runtime modifications. Track the changes
> in order to do post-processing analysis. Don't use arrays in the trace
> event, since they are not properly supported by the tools. Instead use
> simple "unroll" with emitting the trace event for each EM array entry
> with proper ID information. The older debugging mechanism which was
> the simple debugfs which dumping the EM content won't be sufficient for
> the modifiable EM purpose. This trace event mechanism would address the
> needs.

Do we really need a full trace_event for this? Can we not follow the
task scheduler rule which says no new trace_events and use a trace_point
here? The footprint in the kernel would be so much smaller.

E.g. pelt_cfs_tp

0 sched.h  694 DECLARE_TRACE(pelt_cfs_tp,
1 core.c   106 EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_cfs_tp);
2 fair.c  3937 trace_pelt_cfs_tp(cfs_rq);

And then this patch should be after the section with the functional changes.

[...]
