Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1445666FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjALKml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjALKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:42:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3ED33D70;
        Thu, 12 Jan 2023 02:36:18 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:36:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673519777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+q9O0QBx7caBqvk7I7LqqANXtU1eZvZLl5BZlayw+Q=;
        b=fRkTEumRk4CzMYZUt8LAh/RJ8slqeouYyZNvTpO1GV2VpwmLt01q480Aq5TZFQsQr/6F39
        5lb1JiQ+ybojkK06e+Vy6YUXqW3Qjls++T+9usTh3TdkJpeYLelEXZV/1PYZtMEVwmpdk2
        GrwB0N7exf6lKrgLYD/lZOTyG+uaVgtWVnBW/T8YSKj2t2kjnhzbbX+oqEQ05BnkOos+FK
        5c7rqYZthb29zRTmXw0Li2xcteUcMnDMU9UUhwFkBPshsm43wo7RK819+YszXYU9iF9TTf
        6bx4S/j8a66hLdcciISidY/sXgF019uGZzjvkhcm/TEJc4XVdyoTE8Luj7jVpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673519777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+q9O0QBx7caBqvk7I7LqqANXtU1eZvZLl5BZlayw+Q=;
        b=9NIVp/yPvUNYUDTJsZlZ0lvXWhGgsOLTh2TTGR1v7URp40uPVOhA5VtsXtLFMU6BNC3wyx
        mQhpAP9/qYBQ4ABQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PM: domains: Add GENPD_FLAG_RT_SAFE for PREEMPT_RT
Message-ID: <Y7/inz5ZoQiR3bP3@linutronix.de>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-2-krzysztof.kozlowski@linaro.org>
 <CAPDyKFrVjenwv0Fe36LBqML-R_w2TjoCwmbnqqOohV_1zH8vJQ@mail.gmail.com>
 <9771639f-5172-8f3b-3ce6-8fd195aa95b3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9771639f-5172-8f3b-3ce6-8fd195aa95b3@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-06 15:52:57 [+0100], Krzysztof Kozlowski wrote:
> > Just so I don't get this wrong, since the cpuidle-psci also calls
> > pm_runtime_* functions so it isn't PREEMPT_RT safe, at least not yet?
> 
> You are correct. Patch 3 here addresses it by... just not doing runtime
> PM. This is a hacky workaround but:
> 1. I don't have any other idea,
> 2. It's not a big problem because RT systems are not supposed to have
> any CPU idle (one of first things during RT system tuning is to disable
> cpuidle).

so you say you use idle=poll instead? 

> Best regards,
> Krzysztof

Sebastian
