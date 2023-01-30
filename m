Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A2B680BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjA3LOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjA3LNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:13:34 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493B14C15
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 03:13:32 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D3B61EC063A;
        Mon, 30 Jan 2023 12:13:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675077210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=op9U5ztvTUToOeUH0qXw+duaM2c6zRnZJMzDBuRTviA=;
        b=ZsGzuxUrosrknktOvJ5xl+eb1TitWt9f1cl3BqLkHmVjZaYr7lxZ5RgxSU9vUZ97nbpwia
        t7Z/R62stnV4Y+MZ9uVvro2hnFCnMBT/X//IhinbFen/xQ3mmHxp3dnEUIcKoHOWMpurHs
        bmDnptX6EJyvtdvszpH1lj4/EOIdU4s=
Date:   Mon, 30 Jan 2023 12:13:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Subject: Re: [PATCH v13 1/4] virt/coco/sev-guest: Add throttling awareness
Message-ID: <Y9emVjoTBrM2+Y5P@zn.tnic>
References: <20230124211455.2563674-1-dionnaglaze@google.com>
 <20230124211455.2563674-2-dionnaglaze@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124211455.2563674-2-dionnaglaze@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:14:52PM +0000, Dionna Glaze wrote:
> The host is permitted and encouraged to throttle guest requests to the
> AMD-SP since it is a shared resource across all VMs. Without
> throttling-awareness, the host returning an error will immediately lock
> out access to the VMPCK, which makes the VM less useful as it can't
> attest itself. Since throttling is expected to be a common occurrence, a
> cooperative host can return a VMM error code that the request was
> throttled.

So where is this concept of guest throttling documented?

It sounds like this is something hypervisors do and it is all fine and
great to do that but where does it say: yes, this is what we do and this
is the usual behavior that's expected from guests and HVs to adhere to
when accessing this shared resource?

Tom, is that in the spec somewhere perhaps? Or was this decided upon on
some call?

In any case, I'd like for us to document it somewhere eventually if that
hasn't happened yet so that all parties are clear on what is supposed to
happen and what the protocol is.

> +retry:
>  	/*
>  	 * Call firmware to process the request. In this function the encrypted
>  	 * message enters shared memory with the host. So after this call the
> @@ -346,6 +347,14 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>  	 */
>  	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
>  
> +	/*
> +	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
> +	 * throttled. Retry in the driver to avoid returning and reusing the
> +	 * message sequence number on a different message.
> +	 */
> +	if (err == SNP_GUEST_REQ_ERR_BUSY)
> +		goto retry;

I don't like even potential endless loops.

How about you turn this into a loop with a sufficiently large retry
count which, when depleted, gets this request failed with a -ETIMEDOUT
or what not?

You could also stick a cond_resched() in that loop so that it can take a
breather between the requests and doesn't hammer the hw as much.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
