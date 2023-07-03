Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52A74625E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGCS3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGCS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:29:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A6121
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xv2iVQxMPEAE5QW23mN+S6PmBY/FobKHXWm5wRoa/ac=; b=mcCX73XmmAgaW7kBs8kIKVMtYl
        TazsGMKq2FvG3q9CD4VjJSaswHYy/2BJvGy6vZ6qAdCcW7nbacBJSFGkkbLiI38R5Tz9oZ1MurFtt
        za0omQ4stOAGEgwhc9JAGKhQQF8BDR/monERm1+7TsxY4lHRp802NKCM6yxeMdoSSDNxw9dlZmsc4
        GEPgxz09NjLcJEefmNw82KS3AeOYq7/tZcIaIvl8F6+YLG2wiK+aLbi3ilP12MJdnARBKgQHNp0X8
        MX8qfBOPc48yPFCDoK0CgANoM7+D9ufvONd2yPzR0RoV2Q5QYKjW+szcJuwRJsUUVtyqmfeBf5l6e
        Z5Zodu3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGOIG-00A9Jy-2l;
        Mon, 03 Jul 2023 18:29:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6290A3001E7;
        Mon,  3 Jul 2023 20:29:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E30D820292D0E; Mon,  3 Jul 2023 20:28:59 +0200 (CEST)
Date:   Mon, 3 Jul 2023 20:28:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: Buggy rwsem locking code in fs/smb/client/file.c
Message-ID: <20230703182859.GO4253@hirez.programming.kicks-ass.net>
References: <20230703114318.1576ea24@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703114318.1576ea24@rorschach.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 11:43:18AM -0400, Steven Rostedt wrote:
> I just reviewed a patch that copied a solution from
> fs/smb/client/file.c (original was fs/cifs/file.c), which is really
> just hiding a bug. And because this code could have possibly caused
> this buggy solution to be repeated, I believe it should be fixed,
> before others use it as precedent in other areas of the kernel.
> 
> Commit d46b0da7a33dd ("cifs: Fix cifsInodeInfo lock_sem deadlock when
> reconnect occurs") has in its change log:

Oh man, that's .... I gotta go buy a new WTF'o'meter again :/
