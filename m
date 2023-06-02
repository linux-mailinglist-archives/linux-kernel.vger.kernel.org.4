Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA37205B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjFBPQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjFBPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:16:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3B136
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pgb2cGtRy6NJQivMZxkD79cF6GM0vBckpsl09sZbJQM=; b=GtixR3arzlIUnN+MRUtIl7LulW
        TiLyidJERPAaL7c5Mh6GneFkAPNYE/0LD7qOlA4D2IKsGc3z2SrhmO5uWzLxXepeY9ZKK6ic+kM50
        z7mp3bqiCUFtv2891vSMrBu6/jbeFHQ07lKjULvcRjLgqvyvu9P8rbjJRBC/IE8kwo26obluaWnpY
        OV8z/DCyuMkAZrnl3Or7RlPxrgxMNSQl3gmLdB/1MAbUsT7SE2/m3+MBRjmudOwLYS6VwBl/Qf4Lt
        MihiRQzcdQdFlSxamwFLiJOQ6RG124BVh5VGdAIQ0mgxfg05Wb34PFr7Bg1D3ZL25ZBBKi40aRlN4
        jM0UmaQg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q56W9-001MP5-02;
        Fri, 02 Jun 2023 15:16:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78825300220;
        Fri,  2 Jun 2023 17:16:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F6842058125E; Fri,  2 Jun 2023 17:16:39 +0200 (CEST)
Date:   Fri, 2 Jun 2023 17:16:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Zack Rusin <zackr@vmware.com>, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/vmwgfx: Silence RBP clobber warnings
Message-ID: <20230602151639.GK620383@hirez.programming.kicks-ass.net>
References: <e9388b1ad4d955b43b44e8a5dcd6cf6da7d260a0.1685717659.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9388b1ad4d955b43b44e8a5dcd6cf6da7d260a0.1685717659.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 07:56:34AM -0700, Josh Poimboeuf wrote:
> VMware hypercalls take the RBP register as input.  This breaks basic
> frame pointer convention, as RBP should never be clobbered.
> 
> So frame pointer unwinding is broken for the instructions surrounding
> the hypercall with the clobbered RBP.  There's nothing that can be done
> about that.  Just tell objtool to ignore it.
> 

That's a pretty horrific ABI, one that violates the oldest x86 calling
convention in existence.

VMware folks, shame!!
