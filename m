Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA86C47CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCVKiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCVKiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:38:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D169D618BD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:37:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679481468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyVRxjh5q/+akVdyB6Vd/bUAgLJcmkQGDxTRSlbP+DQ=;
        b=Uh6y6IADv5wXLJo6U7xJ+s2XlJ37r3cZ0V6yJPiKSBx3Em+Yfjrmmtc7097bNaNM4WYs6h
        bu9UdbKnohD3QM/cDg6Qy+r+5YKce2O2RKfxyPYSGRBZsWaRUFfdglduGJ5U+ebBBpR7th
        4SakssT8RvFtC4D9GWNLLj4RK5glFI+WcikMtp1C9xazjn88eNx7fOyAUoqp4jl/KVT0cb
        Z8h6j1UwDYiHWWIgpvWM8JPsDFvE6mH37rWzoTcSFsK6WXswF8EFVna6lEMGcOlVxyejbs
        /RvX5qRZ40+OVMzXHKxveg1EHrKenoH26Jvsxj3MdYvijl0HNyrP5ue5uVPAbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679481468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyVRxjh5q/+akVdyB6Vd/bUAgLJcmkQGDxTRSlbP+DQ=;
        b=c+6LR+VX5pFezeOX489N0xoKXdpbf8N7zVhwq6B3Pwcnuu0XSbsyP1Y10lF3+sh2xhqOQb
        k3ow/W51sqa13NAA==
To:     "Gowans, James" <jgowans@amazon.com>,
        "zouyipeng@huawei.com" <zouyipeng@huawei.com>
Cc:     "maz@kernel.org" <maz@kernel.org>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
In-Reply-To: <fd5588e5b0b1b5d21b1c0df7290844907ebcf367.camel@amazon.com>
References: <20230317095300.4076497-1-jgowans@amazon.com>
 <f0879a30-6f88-30e0-ce30-e230df8f2936@huawei.com>
 <001d516c1bb6f0b6d2344f1ae160e796d003c24c.camel@amazon.com>
 <6d1859b0-20f3-05a8-d8d6-dfb0c9985985@huawei.com>
 <fd5588e5b0b1b5d21b1c0df7290844907ebcf367.camel@amazon.com>
Date:   Wed, 22 Mar 2023 11:37:48 +0100
Message-ID: <871qlh9imb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22 2023 at 07:48, James Gowans wrote:
> On Wed, 2023-03-22 at 14:26 +0800, Yipeng Zou wrote:
> Thomas, would you be open to taking the patch to tweak the handle_fasteoi_irq
> handler? Or is there a different solution to this problem which you
> prefer?

It's in my backlog.
