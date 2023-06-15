Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8763D731105
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244907AbjFOHlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245115AbjFOHlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:41:13 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFC273D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:40:45 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686814841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gho11wZoZWLWG4zZ+7agmz14TOT07IFWiEGilb6nY6k=;
        b=VqRNGYVx4Z9iOL/91ztR/lTHoOP7nYFdDhT5qQ+jVDUHkvIYNRiaGxqGqVjuQEGWk5zAKa
        7jcG/5P+iFydavjwGyHALVCOjYkWLjujEm7bHszQDWlJHwqQ+LOOmjZ8ucKz0cnUXkCAQp
        Nn3cjw24KWiX0Xcxqp2gHnspI7Yd8OQlMi7haAztlzL2D+4kfPHtrLCVjgwNUzggynH/Yq
        sip3+HJg5RCGtN05cixA/A8vtQV7CplFS33Au2J9PSBvSw/CEeUf78YIvnYi9IZiGAUJ3s
        uktJ8Hv/PENN2ngZnzSPgcIPdOiLtXa2s4CWrVUsc7GHzAvA+XmgAtR+02hCsg==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1E31FF802;
        Thu, 15 Jun 2023 07:40:40 +0000 (UTC)
Date:   Thu, 15 Jun 2023 09:40:40 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Aaron Thompson <dev@aaront.org>, linux-kernel@vger.kernel.org
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230615074040d166068b@mail.local>
References: <20230614113536.GJ1639749@hirez.programming.kicks-ass.net>
 <20230614125320.GA1640563@hirez.programming.kicks-ass.net>
 <20230614130348.GF7636@redhat.com>
 <20230614130945.GK1639749@hirez.programming.kicks-ass.net>
 <20230614145348.GB1640563@hirez.programming.kicks-ass.net>
 <20230614150717.GG7636@redhat.com>
 <20230614151920.GN1639749@hirez.programming.kicks-ass.net>
 <20230614153108.GC1640563@hirez.programming.kicks-ass.net>
 <20230614155016.GI7636@redhat.com>
 <20230614173430.GB10301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614173430.GB10301@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 14/06/2023 18:34:30+0100, Richard W.M. Jones wrote:
> 
> FWIW attached is a test program that runs the qemu instances in
> parallel (up to 8 threads), which seems to be a quicker way to hit the
> problem for me.  Even on Intel, with this test I can hit the bug in a
> few hundred iteration.
> 

I'm just chiming in to say that we do hit the same issue on the Yocto
Project CI. We are using qemu 8.0.0 on Intel hardware and a 6.1 kernel.

I see that f31dcb152a3d0816e2f1deab4e64572336da197d hasn't been
backported so it may not be the culprit. However, this seems to have
started happening when we switched from 5.15 to 6.1.

Regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
