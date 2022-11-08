Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BE8622070
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKHXtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKHXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:48:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAA045EFA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7D62B81CB7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F1DC433C1;
        Tue,  8 Nov 2022 23:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667951327;
        bh=Fcu2qv9zwXGmJE/pBRUkdiIpewsCdUgeUAAdyR1Vl6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qLx9SpuwIqKig1y5bJ60qem3PGGvfT5r3ke/qbkfxuubLb8yLZ5Mg4OV5rvOmzpid
         qScV+9dTVEqnW2w9hBrogWu5AiQevRlbb12NlmyP+QCVrRl8qAlEJRJ8pWeANYNbUc
         pGl5e8pOizvJygRknyXw4GBPeZzBiy87BGTMri7U=
Date:   Tue, 8 Nov 2022 15:48:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] vmcoreinfo: Warn if we exceed vmcoreinfo data size
Message-Id: <20221108154846.11584119794413c7682280fc@linux-foundation.org>
In-Reply-To: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
References: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2022 13:50:08 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> Though vmcoreinfo is intended to be small, at just one page, useful
> information is still added to it, so we risk running out of space.
> Currently there is no runtime check to see whether the vmcoreinfo buffer
> has been exhausted. Add a warning for this case.
> 
> Currently, my static checking tool[1] indicates that a good upper bound
> for vmcoreinfo size is currently 3415 bytes, but the best time to add
> warnings is before the risk becomes too high.
> 
> ...
>
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
>  	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
>  
>  	vmcoreinfo_size += r;
> +
> +	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
> +		  "vmcoreinfo data exceeds allocated size, truncating");
>  }

Seems that vmcoreinfo_append_str() will truncate (ie: corrupt) the
final entry when limiting the overall data size to VMCOREINFO_BYTES. 
And that final entry will be missing any terminating \n or \0.

Is all this desirable, or should we be checking for (and warning about)
sufficient space _before_ appending this string?

