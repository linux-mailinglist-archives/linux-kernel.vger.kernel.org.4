Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7547635806
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbiKWJty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbiKWJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:49:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425BFBAB3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:46:09 -0800 (PST)
Date:   Wed, 23 Nov 2022 10:46:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669196768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gEHYYYinQKii6UXbZiHo4QQC7LLKnf6KeIjesz5RhiA=;
        b=h+Do5ug5IFwtzNFWUpCe4UhYN7SCeTy9msZHeFZ7rRrh3JkyjwH/q6Zm7dic4YbBQMHGXX
        xk1vpyotlcj7BBQTciT6fRthKVzsVZ9Tn89jiA486wPi6puqUx5wKNBAmF4QJyhvuYM4on
        fqtjs9j9M5HsUI+7WT68Pqpr8cqITRsxbAWSUHGFvMQiEP5mVNemru2NDoayQ2dYaS8T38
        MhJgiB5WfWxgmBmT7jF/3HgIV5fNHSAhUVoETeMB0QAWEkh4fLqIPa3OSiqVcqmo6aQkwV
        dE2xsz6ePi4EEzT29iS4fepAx7rdG3INiLl9SDI3gMa+aPjnMOLi1Inz+qpZ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669196768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gEHYYYinQKii6UXbZiHo4QQC7LLKnf6KeIjesz5RhiA=;
        b=Ob60wXAGG+lYyJbmgIJTzwvL02sVm+7h9S8ymsWm/P/z9rY6cLatwZrRyjYpKXFKYdbXmV
        XOpOJnxK8k97RaDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RDTSCP | IA32_TSC_AUX on x86-32
Message-ID: <Y33r3w6xvEeZH2XY@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the RDTSCP opcode is translated as "Read Time-Stamp Counter and
Processor ID". It does not read the Processor ID is merely returns the
value of IA32_TSC_AUX which has been previously written by the OS. This
is documented but is misleading if you never made it past the headline.

Now. On 64bit there is __vdso_getcpu and IA32_TSC_AUX is setup (it also
contains the node number but=E2=80=A6) for its purpose.
On 32bit there is no __vdso_getcpu and IA32_TSC_AUX is not setup.
RDTSCP is not privileged and returns the proper timestamp but the "CPU"
field is always zero.

Is the format OS specific and not for user purpose or could IA32_TSC_AUX
be setup on 32bit?

Sebastian
