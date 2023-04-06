Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241DE6DA421
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbjDFU5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjDFU5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:57:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF5E7683
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:57:18 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680814637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g66rbrLMWAICjbmLEgOtnmo74dC2FAhw7YThBeLn22A=;
        b=Ims94C9qnjtKJqmcp9lWvzziCbKEi7FgKZiZ3kgSjFbApAp22OEDXVFqSWMCJ61+e/sh5o
        JOf2JAsUIc/LxxiIUUWseSaQpS0/DdqhbP4FbKu0j6WoDTApnk3em+GbBnX7+eg0a/r4jn
        DL+NqHsLN10WKSWyTRu2bO6YrStbEYNDh1Kvo0sHQmTeGc/wQRG3B56hfOCZAMQFQ+eqhc
        9rBEZ8Tkh4L8349FwJCJtYQT1OeBIH0rocFzvOj/PV8jpj5MByIB0ZBnhAr3OUQ4noWNJN
        aJI86NtoiIod5W4FULMHFioGbLwftAsKU+/VJa68Lqez4zbU6ffQKa0ZpHR0yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680814637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g66rbrLMWAICjbmLEgOtnmo74dC2FAhw7YThBeLn22A=;
        b=HF/wdc8ze9hlZ5aVfmqeA1SJwHOEd2sdvxoS/b3GCFJYVMTYKmYgrwTpS4XRTjUQvtFeM5
        AufDa7Qkg4g6sFCA==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] signal: Avoid preempt_disable() in ptrace_stop() on PREEMPT_RT
Date:   Thu,  6 Apr 2023 22:57:10 +0200
Message-Id: <20230406205713.1843072-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this mini series updates the comment to properly explain why the
preempt-disable section has been added and then disables this on
PREEMPT_RT explaining why it can not be done.

Sebastian

