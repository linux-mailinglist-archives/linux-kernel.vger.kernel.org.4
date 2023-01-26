Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F31367C6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjAZJUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbjAZJUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:20:53 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 850296C542
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:20:25 -0800 (PST)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id ABC22262EA8;
        Thu, 26 Jan 2023 10:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1674724797;
        bh=+IYPH91KQBpaVvfEvHwNYbcJiBe8bhUvPLpBQ86Vwq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2KwPiCl3rMXxyB9Sfu4usDXDiZuMDv3Yu36xosn8eecBi5Ca6oNdrxoFCPiqaCRR
         rNFPzald8cTP5aHZOJ/AK1/FE3x2EcJaxDJxnPWOrPvb8UaH9Mhb6+4NNblkZx+o96
         UOEmdWdjd7TfkyVFJ+o3cr1HKCbHfgfHtzYhyHY5OU9lfTVTa2MdRJ/pFcyW87frGj
         h/pSQZ0BacVCd3XeTVFRIWuxznyeboOP4d/cbWPA5AdOm5LAOSdGJr6K1a5HpW2s5M
         XnPVK9+kiU2dU9ZrPjJstnb9M/WFkDCPzmulhXja6jmtCZ2cNSdJYRJuYMo503rQAi
         89xs3ZTfrrlRA==
Date:   Thu, 26 Jan 2023 10:19:54 +0100
From:   =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <Y9JFuvNEIdICz7NA@8bytes.org>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <Y9FHsvVoPbgMR2s3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9FHsvVoPbgMR2s3@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 04:16:02PM +0100, Greg Kroah-Hartman wrote:
> Argument that it doesn't work?  I thought that ship sailed a long time
> ago but I could be wrong as I don't really pay attention to that stuff
> as it's just vaporware :)

Well, "vaporware" is a bold word, especially given the fact that one can
get a confidential VM using AMD SEV[1] or SEV-SNP[2] the cloud today.
Hardware for SEV-SNP is also widely available since at least October
2021.

But okay, there seems to be some misunderstanding what Confidential
Computing (CoCo) implicates, so let me state my view here.

The vision for CoCo is to remove trust from the hypervisor (HV), so that
a guest owner only needs to trust the hardware and the os vendor for the
VM to be trusted and the data in it to be secure.

The implication is that the guest-HV interface becomes an attack surface
for the guest, and there are two basic strategies to mitigate the risk:

	1) Move HV functionality into the guest or the hardware and
	   reduce the guest-HV interface. This already happened to some
	   degree with the SEV-ES enablement, where instruction decoding
	   and handling of most intercepts moved into the guest kernel.

	2) Harden the guest-HV interface against malicious input.

Where possible we are going with option 1, up to the point where
scheduling our VCPUs is the only point we need to trust the HV on.

For example, the whole interrupt injection logic will also move either
into guest context or the hardware (depends on the HW vendor). That
covers most of the CPU emulation that the HV was doing, but an equally
important part is device emulation.

For device emulation it is harder to move that into the trusted guest
context, first of all because there is limited hardware support for
that, secondly because it will not perform well.

So device emulation will have to stay in the HV for the forseeable
future (except for devices carrying secrets, like the TPM). What Elena
and others are trying in this thread is to make the wider kernel
community aware that malicious input to a device driver is a real
problem in some environments and driver hardening is actually worthwile.

Regards,

	Joerg


[1] https://cloud.google.com/confidential-computing
[2] https://learn.microsoft.com/en-us/azure/confidential-computing/confidential-vm-overview
