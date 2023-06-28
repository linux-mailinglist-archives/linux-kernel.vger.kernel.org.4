Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2047411F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjF1NJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF1NJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:09:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1482118
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7027861328
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EA5C433C0;
        Wed, 28 Jun 2023 13:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687957742;
        bh=85FtdKdIsbU0gIgDRGh26jmPCHuf4Hh/V1a25xorEFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNnS0hRj6a/l1D8+PX9jSiDkxVpQAOez4ziw/2dQy8QloZ3M9kqaWhyuGnQAQDzvR
         oKUs8pjA5Y81tegFP6PqBZsMv5Ku4cb03LiuJ79yzB2Nka+tOV0gml6qLaqKv3jBU/
         yXCgQ5tIGKX0Ydqyw1cd/zbqJ6ejY/cKRoRapZRytv+iozEA1+1UGTfbsSlKN8CMJ9
         IuW4vafO/F6VVZZd48vZEt6Syj/6fkmSRx9VBsB+bjSS0ganrC5TFy4BKfaaxgP541
         N34yleJB9nlI98lKel4ArtVHyxqF9PaPnz/VQGOImFXgh/BlA2sdekjLVpBg9mRtxy
         FF+dDhELqs6dg==
Date:   Wed, 28 Jun 2023 15:08:59 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 14/45] posix-timers: Consolidate interval retrieval
Message-ID: <ZJww66Svi84Bvw9Z@localhost.localdomain>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.816970056@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230606142031.816970056@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Jun 06, 2023 at 04:37:40PM +0200, Thomas Gleixner a écrit :
> There is no point to collect the current interval in the posix clock
> specific settime() and gettime() callbacks. Just do it right in the common
> code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

The only difference I see is that we now return the old interval
even if the target is reaped, which probably doesn't matter anyway.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
