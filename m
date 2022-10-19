Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0EA605219
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiJSVjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiJSVi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:38:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB27C1956F5;
        Wed, 19 Oct 2022 14:38:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666215536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VNePVIgPGNqgS+SwB/8484A+Is/lBhjxfV0Sa3OBHZk=;
        b=ACgXFXxaJSbl5RRlRXmhzmHnGjrq4h4hsirx/c2WZ0OPRARyeYklxLSl2fMMyUJdsKN6jr
        P0lbq6qt6X2GvzPN7eRzvSJnKpz0Ht2TbQggA7ok1pXOqW8LNvbpsbvXvJro7AoQHp7hnL
        BXuOEVL4ExL+4ORURm9kiC6IgDK/8tpWo20o0wAbYQOOq8RtfyhavdgWvu0Z9tyY6iADJR
        wLx1YpKCIaE3xsA5k/e8GQmZAFXwGVr79DzJ9BZvmoKHBVgWt1SElrXT5hCLsFYTB/iy6O
        H9DlLrzHKoztp/7Y6MGoNEbyvC+361+FCPv9WdGIZPW2hIJc53cMzOLF3DhB1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666215536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VNePVIgPGNqgS+SwB/8484A+Is/lBhjxfV0Sa3OBHZk=;
        b=KiO7CbEEYZGc2wK8BV3m3o2VLOu8/3aBPJjoI0wFI6pr+yryxmgX1XhaKkaUmVKgcYHfp5
        tDIARXB4sx3eqCBA==
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        pmladek@suse.com, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
In-Reply-To: <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <87k04x4e0r.fsf@jogness.linutronix.de>
 <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <87ilkh0y52.fsf@jogness.linutronix.de>
 <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
 <87pmeoawwe.fsf@jogness.linutronix.de>
 <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 19 Oct 2022 23:44:55 +0206
Message-ID: <87tu3z334g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-19, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> my thought is to make this change in the name of bisectability,
> then produce a new srcunmisafe branch.  The printk() series would
> then need to rebase or remerge this new series.
>
> John, would that work for you?

Yes, that is fine. It really is just a bisectability issue, so for the
review of my v2 series it does not matter. I will rebase on the new
branch for my v3. ;-)

John
