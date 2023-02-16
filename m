Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02999699AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBPQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBPQ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:59:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD5E13506
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:59:26 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C92F1EC086F;
        Thu, 16 Feb 2023 17:59:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676566764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c7gJ7ThlATppSnCKM5wzsbFyaA1t7EIglqhT2LCjmwk=;
        b=SLz4HCs3MLtnKwtaiNOESvMgCKSTMGyBmb5sMdC9zcdVxU81Vk6IMyg6o8FhOUdhGJwaQ6
        V4r5dRFln65xjxwqSNZR62n+qtys+0dgUB3ijLQORNQHkxveqR8tkZ2i64fmjYl1wNIbJ2
        9S2a/8bP7ACcEHEikLtA1pKSB4FDmsM=
Date:   Thu, 16 Feb 2023 17:59:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        linux-coco@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH 11/11] x86/sev: Change snp_guest_issue_request()'s fw_err
 argument
Message-ID: <Y+5g6Hjm9oxRjwJX@zn.tnic>
References: <20230216124120.26578-1-bp@alien8.de>
 <20230216124602.26849-1-bp@alien8.de>
 <20230216124602.26849-6-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230216124602.26849-6-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 01:46:02PM +0100, Borislav Petkov wrote:
> @@ -390,18 +390,16 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>  		goto retry_request;
>  	}
>  
> -	if (fw_err)
> -		*fw_err = override_err ?: err;
> -

As Tom pointed out offlist, we still need to do the error override.
Frankly, I'm not crazy about this request retrying as we do it but
I guess it is what it is and it is too late to change that now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
