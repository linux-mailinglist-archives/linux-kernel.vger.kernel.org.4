Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21617315D7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbjFOK4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjFOK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:56:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01F1FE5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:56:43 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686826600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=87qEr03Mw6Omvl9aclq5VuKtx0t+3+NpWz2F/tYIajI=;
        b=m7ChPZfxzDgsPSf8u3qoG6Bjk1pqbegELa5Xy/3MawjqNupB2hC7/16r4IZVQ+mRRcPY0x
        2AxqdxFpm+TSsL9zK74Fyk/lkyQJshh+8+3+pvN735QdOeuWBv5yCl+sK04LijzL+fu4+q
        I3MbGLZbE4ppd5Y1zj/WDDAZKsjyBUXiFb3kZu6woVAdTinh0F5tVTzOBKmag9792xEca4
        3+M/TNnndjN+Yd+sfDVYxYrQlHObnVGkDhp3JWqFtAz2bmXYlVDn4UG+p3AzcRgm9OSYi5
        E5fpQ0f5izDF+078gTvKn3Eh2x6iy1f6lvHcqxQwDPV3HsbZTsPC3lbBFYQtow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686826600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=87qEr03Mw6Omvl9aclq5VuKtx0t+3+NpWz2F/tYIajI=;
        b=X+v850/KKVRhD5CfWSJxVNP1c8RlQ1RwdPjmpNAGkBkM9ah6iOcSFPYLpny0MZVT4mfGtt
        9WVlP668133T8GCw==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 0/2] signal: Avoid preempt_disable() in ptrace_stop() on PREEMPT_RT
Date:   Thu, 15 Jun 2023 12:56:25 +0200
Message-Id: <20230615105627.1311437-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this mini series updates the comment to properly explain why the
preempt-disable section has been added and then disables this on
PREEMPT_RT explaining why it can not be done.

v3=E2=80=A6v1
  - Include the update comment of the second patch which was posted as
    v2 within the orignal thread.=20
  - Add Oleg's Acks.

Previous post:
	https://lore.kernel.org/20230606085524.2049961-1-bigeasy@linutronix.de

Sebastian


