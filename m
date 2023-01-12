Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AAC6670C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjALLXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjALLWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:22:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7025BA29;
        Thu, 12 Jan 2023 03:13:23 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:13:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673522001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYwZRT7mnDnD+1Ys7Sftal0USfXOpImO6PMVvnFoRF8=;
        b=SuNYQC29NyY+TDI6nwnfT7WXHxdyovhPnmfnWSqgs3Wyy1jJTu72AJg0Kz5vIy2yTFcenU
        K3gmMrZPE2IO/JkguEFLejU2ySxT8ag5PjdfkWoLplGu6GVJtNitTf+a7TjlqiW5cfRWIb
        GaL/I2VlOh9CWSy1/dXaVCvn9erFdYrKI8C5CiPlAJvboL9LsmYCCKFv0UkfU17mmomwtk
        UGZkQHUJTk/RAIpN9ZXaaxja9NrSonL7RlkUVeOcT8dqHi9KGptHl8t9+CC+u9a4l52Km3
        H+L97rIeCiZwfrK/9mM42BcXZlEh60uzB+NYDCfNKLRzzhhA1DtHzW+1tdHelA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673522001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYwZRT7mnDnD+1Ys7Sftal0USfXOpImO6PMVvnFoRF8=;
        b=Ayk6KLw9TKqzWx4Z3qRALbmaPTf3FvnlEVwKYkct9ZQ7uELvY7GNpe19SdrgZCozX7dZk+
        iqBI0g/6ePDk2SCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PM: Allow calling dev_pm_domain_set() with raw
 spinlock
Message-ID: <Y7/rUHCjPyNA0YNt@linutronix.de>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221219151503.385816-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-19 16:15:02 [+0100], Krzysztof Kozlowski wrote:
> device_pm_check_callbacks() uses dev->power spinlock, which on
> PREEMPT_RT sleeps.  However some PM domains on PREEMPT_RT might be using
> raw spinlocks as genpd_lock(), thus dev_pm_domain_set() must not call
> device_pm_check_callbacks().  In fact device_pm_check_callbacks() is not
> strictly related to dev_pm_domain_set() and calls for these two can be
> made separately.
> 
> Add new helper dev_pm_domain_set_no_cb() which will only set PM domain
> but will not check the callbacks, leaving the checl to the caller.

s/checl/check/
But this I comprehend.

> Cc: Adrien Thierry <athierry@redhat.com>
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: linux-rt-users@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Sebastian
