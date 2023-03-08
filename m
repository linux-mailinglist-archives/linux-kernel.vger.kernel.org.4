Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61566B04DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCHKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCHKpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:45:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B266B06C7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:45:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC5A61750
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A642C433D2;
        Wed,  8 Mar 2023 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678272302;
        bh=iSWueHLUrs/NaHPLqnCJKn35uwGRs6PonZvH/yLtCok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eM1hx0OT8/GNZBEa1BxUyuST6f+85rQQnLacuGaSg9rybe2eO61TtRGog7yF4vEGC
         v6+9NIG/HwQ/xIjGUJxBfmoQnl7p7Td5pC8KMaz/NEFQpMmfaWtWE6kKmEuSlxK+HS
         XHozLR6yRReIYEe+EdsizeqmX1F2b1WpCmiVduLES9MlNrWff3RXGOgXvn4pEVHmGk
         PjAhTXMboB6u19dNdjy/Kn+fhVVXmXjQGWrTsvV8TThdvYO8bDjz9lWtCiMYvQwBOc
         wapr25OhzaysSsuMqb5ZsqK1KwQmxmLZPApjRED5nTz8M873JXShNQzBcclxmhPamA
         1LNZDAo6R/jNQ==
Date:   Wed, 8 Mar 2023 11:44:57 +0100
From:   Simon Horman <horms@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] x86/kexec: Remove unnecessary
 arch_kexec_kernel_image_load()
Message-ID: <ZAhnKdXbf2fa9Ql8@kernel.org>
References: <20230307224416.907040-1-helgaas@kernel.org>
 <20230307224416.907040-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307224416.907040-2-helgaas@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 04:44:15PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The x86 implementation of arch_kexec_kernel_image_load() is functionally
> identical to the generic arch_kexec_kernel_image_load():
> 
>   arch_kexec_kernel_image_load                # x86
>     if (!image->fops || !image->fops->load)
>       return ERR_PTR(-ENOEXEC);
>     return image->fops->load(image, image->kernel_buf, ...)
> 
>   arch_kexec_kernel_image_load                # generic
>     kexec_image_load_default
>       if (!image->fops || !image->fops->load)
> 	return ERR_PTR(-ENOEXEC);
>       return image->fops->load(image, image->kernel_buf, ...)
> 
> Remove the x86-specific version and use the generic
> arch_kexec_kernel_image_load().  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>
