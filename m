Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189C367B9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjAYSsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjAYSsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:48:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474C8298CC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:47:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3117B81B8C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 18:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4E7C433D2;
        Wed, 25 Jan 2023 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674672466;
        bh=V9HMcj3Id8+rd8Sfg/lUraQee/4tqPEOYGGNHBOoXdw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=be97u3YI2FMI8ajLSC8wGeoj0lzIZFinLJ+BENzoDR4crbRNmaIjq9XOuclA1DtIi
         N6qQY9TdsIqyYF1RU0VywLHm60xUSObXgyWIINqg15qL24mIj/3ir1ABIbNgSF3hT5
         Z+0i4LfnqRzvKDloaGZHFSc/R5ZBXi3gQ4E8MuANeGr5NE34mA6NDhQsRCijoc386r
         kxrfIgkSrTqv3nHTuPGyDCKe2AzYBSiNH9wjekNVDe59MpfXKt9UP40KZ5w2nb+OiT
         6rIpCCOeVZz4ZAqM08L3r5bagW+JhpbeNsjtMuQdh0ltWAoiUMXnOLTNx4ziFHk9LD
         VXpadnN3/F0pA==
Date:   Wed, 25 Jan 2023 19:47:38 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
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
In-Reply-To: <Y9FHsvVoPbgMR2s3@kroah.com>
Message-ID: <nycvar.YEU.7.76.2301251819300.3004@gjva.wvxbf.pm>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com> <Y9EkCvAfNXnJ+ATo@kroah.com> <Y9Ex3ZUIFxwOBg1n@work-vm> <Y9E7PNmSTP5w2zuw@kroah.com> <Y9FDZPV7qENtNNyk@work-vm> <Y9FHsvVoPbgMR2s3@kroah.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
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

On Wed, 25 Jan 2023, Greg Kroah-Hartman wrote:

> Argument that it doesn't work?  I thought that ship sailed a long time 
> ago but I could be wrong as I don't really pay attention to that stuff 
> as it's just vaporware :)

Greg, are you sure you are talking about *SEV-SNP* here? (*)

That ship hasn't sailed as far as I can tell, it's being actively worked 
on.

With SEV-SNP launch attestation, FDE, and runtime remote attestation (**) 
one thing that you get is a way how to ensure that the guest image that 
you have booted in a (public) cloud hasn't been tampered with, even if you 
have zero trust in the cloud provider and their hypervisor.

And that without the issues and side-channels previous SEV and SEV-ES had.

Which to me is a rather valid usecase in today's world, rather than 
vaporware.

(*) and corresponding Intel-TDX support counterpart, once it exists

(**) which is not necessarily a kernel work of course, but rather 
     userspace integration work, e.g. based on Keylime

-- 
Jiri Kosina
SUSE Labs
