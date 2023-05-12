Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4010A7005DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbjELKpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjELKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FA51208E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683888254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NOl7x+Psyj4YgahuDt2DgXbzK7bC66/jiEWCo+kEnGE=;
        b=U7FKVourZx7H417POPVhM+Sv7+rsNoF66ZJK33tZLBBHXn5aI0gqM4yJMoGHMWWrrVPWJ2
        VZLa2npA2QGnGnVfA2u7QC21UPTcOfNMWu9bGs6xGVyN2ns4QMCe+3jHhecw0ONVoZ0H6H
        d7XrsB7e+BwpvsiJB4xffkuRPFgTsWA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-s0bepFT8PyyvTgCpxhjl6A-1; Fri, 12 May 2023 06:44:06 -0400
X-MC-Unique: s0bepFT8PyyvTgCpxhjl6A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D2D73C0D845;
        Fri, 12 May 2023 10:44:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8055314152F6;
        Fri, 12 May 2023 10:44:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 12 May 2023 12:43:52 +0200 (CEST)
Date:   Fri, 12 May 2023 12:43:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Josh Poimboeuf' <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vernon Lovejoy <vlovejoy@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/show_trace_log_lvl: ensure stack pointer is aligned,
 again
Message-ID: <20230512104349.GA6220@redhat.com>
References: <20230427140054.GA17800@redhat.com>
 <20230428043158.r5omehiaqawcac2y@treble>
 <20230428065513.GA22111@redhat.com>
 <20230428235747.b5smutdttv5eeopi@treble>
 <aa8537d81dc747a097e9e30491b5081b@AcuMS.aculab.com>
 <20230512022059.ltlzs7irvbvoj2cl@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512022059.ltlzs7irvbvoj2cl@treble>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11, Josh Poimboeuf wrote:
>
> I do like that better, except... put the initialization in the 'for':
> 
> 	for (stack = stack ? : get_stack_pointer(task, regs);
> 	     stack;
> 	     stack = stack_info.next_sp) {
> 		const char ...
> 		stack = PTR_ALIGN(stack, sizeof(long));
> 

please see v3.

Oleg.

