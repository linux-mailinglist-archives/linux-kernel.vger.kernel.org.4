Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8542E723C46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbjFFIzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjFFIzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:55:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313358F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:55:48 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686041746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xxf6/4cJYYTpOQB6tx4aSzYUMakzUO0Qv0kMWtk5z5o=;
        b=OcbmX6EL95BqS1bTyGRUR/GAAi1T6rKRMoqRb4aEwKT0Zv/lhIDbh5QH8zsj4lYDbtiNlD
        V0cFbYhP7kMpq2j0LtLsBUJwtUdhVvsZymY7JQ1HrY1NxOh0D0ASZRRTxRC+XiW2w+Sq74
        rMX/kKQk62BZ6xNZ+epOnwPSqe6u/kIky+tqvJbmPO9ngggdn3Qmj02lemoLeJp/c0fubC
        SrXq+3HsFwxbwBY9EW4V6C7n68rOxIKqHvbrqnv2OA18gxDo3JsTav6iWLUQaULsmLVF4h
        c7wklDxWG2AgSgCBfHxVXoAGiSm4Wy7hZHEVjtHxWfzQ+0LUVGPTj8z4C8Y/rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686041746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xxf6/4cJYYTpOQB6tx4aSzYUMakzUO0Qv0kMWtk5z5o=;
        b=sgezh/wKSNgg+qrTdwzlww0js29NfiTjMKng3zcEoSbnxaJo08/pMo7sTt0hcoo5XvP8Jx
        a1WB8joH1A3eYEAA==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH REPOST 0/2] signal: Avoid preempt_disable() in ptrace_stop() on PREEMPT_RT
Date:   Tue,  6 Jun 2023 10:55:22 +0200
Message-Id: <20230606085524.2049961-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this mini series updates the comment to properly explain why the
preempt-disable section has been added and then disables this on
PREEMPT_RT explaining why it can not be done.

This is a repost of
	https://lore.kernel.org/20230406205713.1843072-1-bigeasy@linutronix.de

Sebastian


