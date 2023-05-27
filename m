Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8632571330E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjE0HgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjE0HgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478F810A
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACD3B60AC2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 07:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985CAC433EF;
        Sat, 27 May 2023 07:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685172961;
        bh=r0jAlv/+Hp7zwRPZj8ECBxitoB+pPQba2YC+LIUW0x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXSaBN9JOc9iA1+qcbbOzQXbhabuPcbbgtoY2rhk9izWwigQDB67ya7HLJdDMRIkt
         ckeUt1mqPy0sgoE+7rLuWkYelLHvtJN2gGNqzMOqwhBTF4Vsii4ywbDHIE8AioJhDv
         fhcFJ8BhEce9fBn6NZcNZ2pktdJr1gN3zwS9/6Yw=
Date:   Sat, 27 May 2023 08:35:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prathu Baronia <prathubaronia2011@gmail.com>
Cc:     dan.carpenter@linaro.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 1/2] axis-fifo: use devm_kasprintf() for allocating
 formatted strings
Message-ID: <2023052705-modular-unpleased-0e62@gregkh>
References: <CAJp9fsfJxoY2=fFK3-R_XoDatMB9z5WT4BaeSw3-nMScicERJQ@mail.gmail.com>
 <20230518145154.33377-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518145154.33377-1-prathubaronia2011@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 08:21:53PM +0530, Prathu Baronia wrote:
> In various places, string buffers of a fixed size are allocated, and
> filled using snprintf() with the same fixed size, which is error-prone.

Maybe error-prone, but all is fine with the original code, right?

> Replace this by calling devm_kasprintf() instead, which always uses the
> appropriate size.
> 
> Also fix an old smatch warning reported by lkp introduced by commit
> d2d7aa53891e. In the mentioned commit we had used "%pa" format specifier
> for a void* type and hence smatch complained about its use instead of
> "%p".

When you have "also" in a changelog commit, that usually means this
needs to be split out into a separate patch.  And that's the case here,
make the first patch of the series fix the problem.  Then do your
cleanups on later patches.

> Fixes: d2d7aa53891e ("staging: axis-fifo: convert to use miscdevice")

changing to a different string function does not fix anything.

> Reported-by: kernel test robot <lkp@intel.com>

It did not report that you need to replace a string function, right?

See, things got messy when you mixed in changes into one.  Please break
these up.

thanks,

greg k-h
