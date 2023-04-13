Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610FB6E0F61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjDMN6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjDMN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:58:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E456793E4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F4E763EDE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281B9C433D2;
        Thu, 13 Apr 2023 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681394284;
        bh=jgYJ22d0VugCNoyfbfuik0EWw1aUpMuR4wxj3654MxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngZoJJH9BfenVHPQojG43eB7ZAQ02gqndJm1Kl7BskhUkN+7KbMclKQmHAX1SSLaH
         Ax5BXyGz0yoCPYBk3S7N0FnX2rzBjcqBLfocgbUanAhqcxQfvfGlIg2m2DtBignWAi
         /HRv2uJLDK5Ja9jJ04K2COyvpia9BxMrIqtscCkOKGDcIEDIwkP7+hpoWISr+bJAwI
         OJIclxHjfMgkAI5NOm41cSr2kd6p1hCHfB1gSKMW1iYi6GcJMg7htKEa82+vOrBmJ0
         qRg3KGtqOTdurrdoLkrwdehbHZ2VdeMv89zU/eR5Ey/hxu3opfx6SI1S/FY6NRYXLp
         yA8oJ+U7AHKtQ==
Date:   Thu, 13 Apr 2023 15:58:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH 1/3] context_tracking: Fix KCSAN noinstr violation
Message-ID: <ZDgKaUxIZTMlb1di@localhost.localdomain>
References: <cover.1681320026.git.jpoimboe@kernel.org>
 <dc93f45abdec90c171108b4b590b7fff5790963c.1681320026.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc93f45abdec90c171108b4b590b7fff5790963c.1681320026.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Apr 12, 2023 at 10:24:06AM -0700, Josh Poimboeuf a écrit :
> With KCSAN enabled, even empty inline stubs can be out-of-lined.
> 
> Force the context_tracking_guest_exit() stub inline.
> 
> Fixes the following warnings:
> 
>   vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x1be: call to context_tracking_guest_exit() leaves .noinstr.text section
>   vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0x85: call to context_tracking_guest_exit() leaves .noinstr.text section
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
