Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E2765A527
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiLaOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 09:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 09:47:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA39FEE;
        Sat, 31 Dec 2022 06:47:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E4C1B8074C;
        Sat, 31 Dec 2022 14:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32DCC433D2;
        Sat, 31 Dec 2022 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672498049;
        bh=UGpp3BQnLywMc+IwqrXFtehnt+EBA7KjAILtO0nqptM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIY7vzm4K43+75icSufgFEc0kgcxL2ZP8dUliPhh9JB3duD9CTs54u3AOOMSQZrF1
         UQB2f1IN4ei+bZrUQO6RRgzYAJTMGZaiWxOV2kgOPz9NnUaL2vB3NR3C+Oxse4t5h3
         eUmyO61nSBc3f9D7AT9EkZF05YJciNwhIYsEZEX5NXEzhLYNPDq/8HLAp+Icv5mZEw
         +ubE0VsZPeljN6JV9IaKmAs09D9G16fHIV0soh8ihctsw2rerJI5kZwLl0wjIsICX2
         QWmBwxPPcbOri1mUmdut0m6WXealsXERwCa7G4O0ZYUazbiSZu40MOJZTs2kF3PNWr
         fdHIZfRHyYX9A==
Date:   Sat, 31 Dec 2022 14:47:26 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        luto@kernel.org, dave.hansen@linux.intel.com, slp@redhat.com,
        pgonda@google.com, peterz@infradead.org,
        srinivas.pandruvada@linux.intel.com, rientjes@google.com,
        dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        dgilbert@redhat.com, ashish.kalra@amd.com, harald@profian.com,
        Brijesh Singh <brijesh.singh@amd.com>,
        Pavan Kumar Paluri <papaluri@amd.com>
Subject: Re: [PATCH RFC v7 37/64] KVM: SVM: Add KVM_SNP_INIT command
Message-ID: <Y7BLfq9TB3iYIUjp@kernel.org>
References: <20221214194056.161492-1-michael.roth@amd.com>
 <20221214194056.161492-38-michael.roth@amd.com>
 <Y7BG6pSuoZsBQYrx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7BG6pSuoZsBQYrx@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of fixups.

On Sat, Dec 31, 2022 at 02:27:57PM +0000, Jarkko Sakkinen wrote:
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 6c4fdcaed72b..462c9aaa2e7e 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1381,6 +1381,12 @@ static int __sev_snp_init_locked(int *error)
>  	if (sev->snp_initialized)
>  		return 0;
>  
> +	if (!sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR)) {
> +		dev_dbg(sev->dev, "SEV-SNP support requires firmware version >= %d:%d\n",
> +			SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR);
> +		return -ENODEV;

        return 0;

It is not a failure case anyway.

> +	}
> +
>  	/*
>  	 * The SNP_INIT requires the MSR_VM_HSAVE_PA must be set to 0h
>  	 * across all cores.
> @@ -2313,25 +2319,19 @@ void sev_pci_init(void)
>  		}
>  	}
>  
> +	rc = sev_snp_init(&error, true);
> +	if (rc != -ENODEV)


if (rc)

Because other wise there would need to be nasty "if (rc && rc != ENODEV)"
so that this does not happen:

[    9.321588] ccp 0000:49:00.1: SEV-SNP: failed to INIT error 0x0

BR, Jarkko
