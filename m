Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41074665BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjAKNAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbjAKM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:59:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4D1A078
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iNG3XOZSx6tsrw4TFQy3M7kX0dahEVafq/7qDclmz/Y=; b=m/UGwURdem/v7if/S3yr8tSixD
        i4fGmmnPbLge/2aR2/UV18xrKZ7u2GBYrrr7wRPAdbdVQxTVzWEzhJ99HaNPpJew0Fxcs7Zo4lc8g
        gRhZNogJSEYcRdpolG0ly04F1GqqEDHeE/xn3OAkxGKqsnQDW3qWlEEUmNB3WQ+agsHNldndCLBIG
        czp7wnmDV7u4lG5Mcc3zHcC5Sl/9z7NFFew9YaSyJJPalv1Ahp81ooogXmiI6xWRKkpQjFzdHXagw
        uHNupZMMAsHVmgBeRI+iLwGXhhG3haVcJHq83GOjfE9uXFxmHAlqQsCkHQbWph6VO18JYGH7Rk0xa
        c5HFhThg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFahp-004986-3g; Wed, 11 Jan 2023 12:59:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95B8E300472;
        Wed, 11 Jan 2023 13:59:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 744C82CA101AD; Wed, 11 Jan 2023 13:59:34 +0100 (CET)
Date:   Wed, 11 Jan 2023 13:59:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
Message-ID: <Y76ytk6GkMfeu9Ho@hirez.programming.kicks-ass.net>
References: <20230108030748.158120-1-joanbrugueram@gmail.com>
 <20230109040531.7888-1-joanbrugueram@gmail.com>
 <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
 <baa1b55b-8415-0c33-a6e5-f568c48f455f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa1b55b-8415-0c33-a6e5-f568c48f455f@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:52:41PM +0100, Juergen Gross wrote:
> I have verified that the suspend path when running as Xen PV guest
> is NOT calling restore_processor_state().

Oh excellent, that makes things a lot simpler, thanks!
