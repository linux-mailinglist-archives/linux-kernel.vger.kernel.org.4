Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12966B72C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCMJil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjCMJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:38:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C9557D30;
        Mon, 13 Mar 2023 02:36:45 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:36:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678700203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMzFh7fvdbobB01BlTluHQ92/K/MC3vwvbvz+/sibis=;
        b=IG+MwBsbm4dukJ8o8MfpzxtrymmoCoggA/6gpM/Bd2uq17lFnPUPlkqjQc7f5wLdI9rxGF
        3g41n8Bu+QdldqAkZdxEDZ1TKXlraPuBFxdsciR1O/MoNcyfVAKLhKBh8WS5htV/7C4pdN
        5jNDgd+QJ9NSoTu/R8gsR54Huhhw+0M9+8460uM3C9NixxWbQb3BK2TDqBAPHC8l1e9z20
        01aY5TXu5DQW8JuqnXe7v293LmJr04LsaxPmq6meOnU7KdtvB0aHSZGnmsJMhEYaCcjeHY
        lqG8U6dqDs9HQKX5HFEL/9k/GXrr/hecHRJZhS9QxJCNK0LxMAwoMW6DUY/FQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678700203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMzFh7fvdbobB01BlTluHQ92/K/MC3vwvbvz+/sibis=;
        b=4lNmV8XuV8YZWXX1KunLeqSeagXcFlHwTaIeQfniYqnaR4I6BPcA9h16vZTlEfDoy/K9Gj
        R0Q/m/SxUR5tGDCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Brennan Lamoreaux (VMware)" <brennanlamoreaux@gmail.com>,
        Daniel Wagner <wagi@monom.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        blamoreaux@vmware.com, frederic.martinsons@gmail.com,
        srivatsa@csail.mit.edu, vsirnapalli@vmware.com,
        amakhalov@vmware.com, keerthanak@vmware.com, ankitja@vmware.com,
        bordoloih@vmware.com, srivatsab@vmware.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4.19-rt] workqueue: Fix deadlock due to recursive locking
 of pool->lock
Message-ID: <20230313093641.pxvwFHCJ@linutronix.de>
References: <20230228224938.88035-1-brennanlamoreaux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230228224938.88035-1-brennanlamoreaux@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-28 14:49:38 [-0800], Brennan Lamoreaux (VMware) wrote:
> Upstream commit d8bb65ab70f7 ("workqueue: Use rcuwait for wq_manager_wait")
> replaced the waitqueue with rcuwait in the workqueue code. This change
> involved removing the acquisition of pool->lock in put_unbound_pool(),
> as it also adds the function wq_manager_inactive() which acquires this same
> lock and is called one line later as a parameter to rcu_wait_event().

Daniel, I double checked and this patch is correct - the backport was
faulty. Could you please pick it up and release an update?

Sebastian
