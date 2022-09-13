Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39BF5B6AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiIMJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiIMJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:40:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECBC13DCF;
        Tue, 13 Sep 2022 02:40:13 -0700 (PDT)
Date:   Tue, 13 Sep 2022 11:40:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663062011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U6AOT9uSgxz9+ZVqgDff6qlA53R0fV8Jzn82x1C6ibI=;
        b=eMFkdbUsLoFa8r2eec4jd1ahrAQ8K2QMrDgTBNS9gxdZskDrh5KwGofAenaRu8nZQ/o9ap
        Cz8cO7M3AYsqBOBmdb17crZ7nksF4ykVCAJ55nQe7RWEoS64OIC1K97XTGcfKGOWofhNRk
        Pc02s2IFy4B/HwtTfCnh8V00YKZq99IC/tnfpD/go4XyQHqiQw2WL1hMVHwv6uo6IC2id5
        UD3lBuPwQklmusAYitVlLOzivO5uhoHhWMu2QnSr7ZTlTjhmYMv/g/AdufkeW1p3M0oMlE
        JPnhx91oSj2EPXeIeCL5apQ6iSL1ZXsdIdyzyXZxnAb22cuAV+TIyoXxCCvxSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663062011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U6AOT9uSgxz9+ZVqgDff6qlA53R0fV8Jzn82x1C6ibI=;
        b=bKo7MzQnFeGJk7v7dL9PVXkfwL7xnpdoNiByAXLErgyYcY0V0Yt5JGyPHMSUy00VOzWRtc
        PmwL/TWo9MIWrzDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Eric Chanudet <echanude@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: qcom-ipcc: Use generic_handle_irq_safe()
Message-ID: <YyBP+eNIBCN0OsGt@linutronix.de>
References: <20220909162043.2734873-1-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220909162043.2734873-1-echanude@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-09 12:20:43 [-0400], Eric Chanudet wrote:
> PREEMPT_RT forces qcom-ipcc's handler to be threaded with interrupts
> enabled, which triggers a warning in __handle_irq_event_percpu().
> 
> Use generic_handle_irq_safe() that can be called with or without
> interrupts enabled instead.

wouldn't IRQF_NO_THREAD be a better match here?

> Signed-off-by: Eric Chanudet <echanude@redhat.com>

Sebastian
