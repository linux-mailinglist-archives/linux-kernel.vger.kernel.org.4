Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C31738E67
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjFUSRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjFUSRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:17:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B47E199B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FdCR98/sLzhZlnfNo3T8ChItiaTji7caPofyJONKP+o=; b=MyjD0UzCs4xmOkHQWgjjDUNOyb
        RoOS2d/J0gDsTrR/B+RNXxMe3S1/mntR1WJrxcO25tngcLuGdQmfYYv3QViSPoKsuW1YN2EINyta5
        j796ih7zGgDJrI4Mek0S1i4akHgTvcmVE5Th/o+VS6djpJocMrOfQM19Z9CJn+9IrNAm1jfxsTNTg
        pIjl77ecKk4+aixdNZY82yJVQKColQj9eLzJ8UcCjqxUQUwkAtBb/LxHFrTUhifa53/yYfln3PFJJ
        LHzLD87yFxHn5e1AuHkUIcOS5QRuOOtZQ6tigLO5GUnV/LihaLF/RW/IiMhL90uKYRbbW7CQbnO+S
        5Jx7N94w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qC2O5-0002M7-0f;
        Wed, 21 Jun 2023 18:17:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 996333002A9;
        Wed, 21 Jun 2023 20:16:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F7B22130B3BB; Wed, 21 Jun 2023 20:16:59 +0200 (CEST)
Date:   Wed, 21 Jun 2023 20:16:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 1/2] x86/cfi: Fix ret_from_fork indirect calls
Message-ID: <20230621181659.GB4253@hirez.programming.kicks-ass.net>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.127844423@infradead.org>
 <202306201455.AF16F617A@keescook>
 <20230621085217.GI2046280@hirez.programming.kicks-ass.net>
 <20230621092759.GJ2046280@hirez.programming.kicks-ass.net>
 <202306211107.4D529222C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306211107.4D529222C@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:08:46AM -0700, Kees Cook wrote:

> Ah yeah, it should be direct-called only. I keep forgetting about the
> endbr removal pass.
> 
> > I can't seem to manage to have it clobber it's __cfi hash value. Ideally
> > we'd have an attribute to force the thing to 0 or something.
> 
> Doesn't objtool have logic to figure out this is only ever
> direct-called?

It does; let me also use that same thing to clobber the kCFI hashes for
these functions.

