Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD374F271
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGKOiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGKOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B42198A;
        Tue, 11 Jul 2023 07:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E9161518;
        Tue, 11 Jul 2023 14:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A8BC433C8;
        Tue, 11 Jul 2023 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689086241;
        bh=nWhVL1oGxyYtbgKyqjKMLF25iGQtkGEccJG7zkSW9aE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XuggEb9aYC/ZkO0XZAB9Hh/zGpRCFFBFNP/rN0T7c3NpX+ISSDklO6nO8UjwWqsGo
         iks1brUHQzrzsVhkboRBS5WQhHOsa6ExnEfMlL6EPhkODqBSnDYmcbNwE0hfpqFbnm
         4gA4+5glSHXPcQd9cvD33qmP1heI8qMbDifvdYng=
Date:   Tue, 11 Jul 2023 16:37:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, kraxel@redhat.com,
        dovmurik@linux.ibm.com, elena.reshetova@intel.com,
        dave.hansen@linux.intel.com, Dhaval.Giani@amd.com,
        michael.day@amd.com, pavankumar.paluri@amd.com,
        David.Kaplan@amd.com, Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org,
        Larry Dewey <larry.dewey@amd.com>
Subject: Re: [PATCH v3] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Message-ID: <2023071151-sprinkler-aids-a07a@gregkh>
References: <20230711141257.232312-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711141257.232312-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 09:12:57AM -0500, Carlos Bilbao wrote:
> Kernel developers working on confidential computing for virtualized
> environments in x86 operate under a set of assumptions regarding the Linux
> kernel threat model that differs from the traditional view. Historically,
> the Linux threat model acknowledges attackers residing in userspace, as
> well as a limited set of external attackers that are able to interact with
> the kernel through networking or limited HW-specific exposed interfaces
> (e.g. USB, thunderbolt). The goal of this document is to explain additional
> attack vectors that arise in the virtualized confidential computing space
> and discuss the proposed protection mechanisms for the Linux kernel.

When you have a "and" in a changelog text, that's a huge hint that it
needs to be split up into multiple patches.

And that's the case here, you want to do two things, describe your crazy
model of different attack vectors AND propose new ways to protect from
them.

The "propose new ways" should be coming in ONLY with actual patches that
do such a thing, as it's a useless document without that (we don't take
proposed document updates without actual kernel changes that implement
them for obvious reasons, nor would you want us to.)

So how about triming this down more to just the first part, where you
all agree on a different threat model, and then you all can go of and
propose different potential solutions to this newly designed threat
model and we will be able to evaluate them based on working code, not
just design documents.

thanks,

greg k-h
