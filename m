Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53AE62D376
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiKQGaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiKQGaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:30:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D178DEF6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 22:30:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0C39B81F88
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E68C433D6;
        Thu, 17 Nov 2022 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668666602;
        bh=SSUm3upjyQsbVG8IDiE/j1VTpVbYRQxa+bjigUbOYO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B7OSaU2lgKabP5Hq+g9vtn+SbxI4u8J5MjDHpif30tubGqkv3mm3HKxTb4fxQmNPd
         kzKaLs1i/Esiuvkv/y7wPk0VsdGPmaamB+UVzRndx5hN1SgVyanzSpmujVrALaRcmd
         OItoDM0VWD8Hg1X/2+uFnz/gGCpFVFZgDGqMt1RQ=
Date:   Thu, 17 Nov 2022 07:29:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vmlinux.lds.h: fix BOUNDED_SECTION_(PRE|POST)_LABEL
 macros
Message-ID: <Y3XU59mj80wvTD6Y@kroah.com>
References: <Y20+PqtF+dFAe7hX@kroah.com>
 <20221117002022.860237-1-jim.cromie@gmail.com>
 <20221117002022.860237-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117002022.860237-2-jim.cromie@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 05:20:21PM -0700, Jim Cromie wrote:
> commit foo added BOUNDED_SECTION_(PRE|POST)_LABEL macros,
> encapsulating the basic boilerplate to: KEEP/pack records into a
> section, and to mark the begin and end of the section with
> linker-symbols.
> 
> But it tried to do extra, adding KEEP(*(.gnu.linkonce.##_sec_)) to
> optionally reserve a header record in front of the data.  It wrongly
> placed the KEEP after the linker-symbol starting the section,
> so if a header was added, it would wind up in the data.
> 
> Putting the KEEP in the "correct" place proved brittle, and too clever
> by half.  The obvious safe fix is to remove the KEEP, and provide
> separate macros to do the extra work.
> 
> While here, the macro var-names: _s_, _e_ are nearly invisible, change
> them to more obvious names: _BEGIN_, _END_
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

This change fails to apply to my driver-core-next tree.  Are you sure it
is correct?

confused,

greg k-h
