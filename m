Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C019D600C87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJQKga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJQKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:36:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5A85A164
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:36:25 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e793329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e793:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE6F01EC05ED;
        Mon, 17 Oct 2022 12:36:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666002979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zUGXHOIELPlkwbnqxPoLXVPt8kDmkPtADUGuCEtuyzM=;
        b=geJsRTACZTKOhOIOVypIRWZu4z6kyKM9pdri34Y/8uoik9ukq7kJfc5i3NaJTXNVyadiXa
        uCUvh4Lkl1Xq10DnRk2CAL4E/40ivA18vPdpLYhXcSMWRYcweb1kkqxnvYxT3wIVHAODT7
        7FayoOIe22WyNfvOxEEJevYD6Ir+V84=
Date:   Mon, 17 Oct 2022 12:36:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RAS: Fix the trace_show() function to output
 trace_count
Message-ID: <Y00wIFEN9h9YPGe1@zn.tnic>
References: <Yz3KI5qY70rvJV63@zn.tnic>
 <20221005194644.311204-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221005194644.311204-1-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 12:46:44PM -0700, Tony Luck wrote:
>  static int trace_show(struct seq_file *m, void *v)
>  {
> -	return atomic_read(&trace_count);
> +	seq_printf(m, "%d\n", atomic_read(&trace_count));

Still misleading:

$ cat /sys/kernel/debug/ras/daemon_active
1

and it is 1 and not 0 because:

[   13.177644] trace_open: trace_count: 1, comm: cat
[   13.178675] trace_release: trace_count: 0, comm: cat

we toggle trace_count when we read it.

I don't know, maybe we should teach RAS daemons to ->write() into that
file their name and PID so that the trace_count counts *only* the RAS
daemons not any reader...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
