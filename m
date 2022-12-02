Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A123463FD33
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiLBAkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiLBAkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:40:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95347CB20D;
        Thu,  1 Dec 2022 16:40:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28DA4621D2;
        Fri,  2 Dec 2022 00:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B11C433D6;
        Fri,  2 Dec 2022 00:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669941605;
        bh=aPCDE4oDtKQRlBE0jHVNWWfRxO1eGe2oqARab825bJY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=IMF+eCBFcxhupYNXrMD9qDFVLzfQ0YbDEptTZ3nlZNLHU903oeha3gYVqnKAGVIVN
         5domBI7+yxS7H5bcqHB8+IznfDeShaCEXw70agjFVxbQG2Q0pgzqTpRikpT+bqd8/a
         KUhRcnJhOAdgGVQAcmpKlMh19GLK/NC7rmZ5UYu97tlh4besAIN36RqQ4kqejMO6EY
         KakuvkFmf+Bs07toev9QpCrdJHuAsLX+Xxz2APW6J/nVdrkbUnZPV9hLqHrRpJo70E
         m6I09XUGk5SjE4somg74Ld+hWH7dnFUEsbBrmPUCKm040butHbg6VYT6lxJbRlqsMQ
         dQRc6lOtBn6cw==
Date:   Fri, 2 Dec 2022 01:40:04 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Florent Revest <revest@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: bpf: enforce HID_BPF dependencies
In-Reply-To: <20221130101021.1868764-2-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.2212020135390.6045@cbobk.fhfr.pm>
References: <20221130101021.1868764-1-benjamin.tissoires@redhat.com> <20221130101021.1868764-2-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022, Benjamin Tissoires wrote:

> As mentioned in the link below, having JIT and BPF is not enough to
> have fmod_ret and error injection APIs. This resolves the error that
> happens on a system without tracing enabled when hid-bpf tries to
> load itself.
> 
> Link: https://lore.kernel.org/r/CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com
> Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/bpf/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/bpf/Kconfig b/drivers/hid/bpf/Kconfig
> index 298634fc3335..498232f9faa9 100644
> --- a/drivers/hid/bpf/Kconfig
> +++ b/drivers/hid/bpf/Kconfig
> @@ -4,7 +4,9 @@ menu "HID-BPF support"
>  config HID_BPF
>  	bool "HID-BPF support"
>  	default HID_SUPPORT
> -	depends on BPF && BPF_SYSCALL
> +	depends on BPF && BPF_SYSCALL && \
> +		   DYNAMIC_FTRACE_WITH_DIRECT_CALLS && \
> +		   FUNCTION_ERROR_INJECTION

FUNCTION_ERROR_INJECTION is a purely debugging feature, and not something 
we want to have enabled in production kernels (which is where HID-BPF 
should, on the other hand, be enabled). I am afraid this needs to go back 
to the drawing board.

JFTR, to make sure this gets properly discussed before 6.2 merge window 
opens up

	Nacked-by: Jiri Kosina <jkosina@suse.cz>

Which unfortunately means the whole hid-bpf implementation would need to 
be revised and postponed for 6.3 at least.

Sorry,

-- 
Jiri Kosina
SUSE Labs

