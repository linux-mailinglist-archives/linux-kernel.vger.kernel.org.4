Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E536E5D09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjDRJJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjDRJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:09:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AEB7ED9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:09:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681808973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z6zePYgWahUe1cN6UNqkceIhZoYiRQILpLgWnkf2dr8=;
        b=yCLbL1vVSFZMlDyO07Q2de7KMgGnhCMrXGfTDsWvBg9aSXenylaPkL63VFPcI4mOtwkzjW
        Lf8delYt3FsmmGk5Cb5sk+iy1LmbgCujuh5sq602RMDp2gLNfIq3xXQ4YKK+WhNpT9KDPM
        BiFRAzuHWmHs3VTqTxBEDowObLxDwyWNsbEtdeIGiiA+Jk8dfVcx9B0TuQBVETdzW5Ggr2
        DQA3wtlASrznyC5JkIXTWhUfEMSAiqmM+IkIYjc8pviQFj5yhz1KzmM46cJfAWPzXgwhBN
        W91m7t8thp81FK+ebIs9QNX3wXo0vkXCpGG91gZByAF1s5A3C2uQozoCnUWTrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681808973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z6zePYgWahUe1cN6UNqkceIhZoYiRQILpLgWnkf2dr8=;
        b=0pjHP+xFlQiaBg9o0cxLedKC1Ez4ekeBsq4D9dq8RuOUnLo+WT5xVvwBWewInB+kFPPpjG
        TU8LYrHHJyEq4IAw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
In-Reply-To: <87mt354lr5.ffs@tglx>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx> <ZD1fdvr1Eh8aAdnU@localhost.localdomain>
 <87mt354lr5.ffs@tglx>
Date:   Tue, 18 Apr 2023 11:09:32 +0200
Message-ID: <87jzy94kvn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Tue, Apr 18 2023 at 10:50, Thomas Gleixner wrote:

> On Mon, Apr 17 2023 at 17:02, Frederic Weisbecker wrote:
>> Le Sat, Apr 15, 2023 at 11:01:51PM +0200, Thomas Gleixner a =C3=A9crit :
>>> There is a second problem with broadcast device replacement in this
>>> function. The broadcast device is only armed when the previous state of
>>> the device was periodic.
>>
>> Any chance the patch could be cut in two then?
>
> Let me try.

Not really as fixing that part depends on fixing the original issue and
once the original issue is fixed the issue for the replacement case is
more or less automatically there.

Thanks,

        tglx
