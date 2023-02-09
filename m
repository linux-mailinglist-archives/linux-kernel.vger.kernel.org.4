Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4719E690D78
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBIPqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjBIPqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:46:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5EC1F49B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:46:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1279161AD2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D77C433EF;
        Thu,  9 Feb 2023 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675957583;
        bh=4aHZlBX9l/bOuICthQjw5N6vmi8DVGwwgHUPxcnJJvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sn8szQdEBAlXy0hosk5RI5gEtq9iZ9dljixQ7Nrwb8q+G5djwIOEYX3YSHdgzOwbe
         1BjEOCMXLUaYw7CKxXbUUQVHVLwvH2dImkZUHwmdSl0gRRgmc7/koo5Vyyu6Fqv7XO
         tYL8xMWkf2nKDGe81Jk3Wf3rdV6Wg9OdA6TxC0UJ7vZg+/aVxnFbO+sx+8TX9aRgF8
         74wsOLFlsEQ0Kg0MfNiv9VPfiCXBOWsMX3JIANDJ03SR3h3qhOUq0jjT4ia6FLlNah
         njap7hGxlL68GRwDu/K8Iek5vadxa2a/A6P5k4u1Hp6/uLiJCZqAnq0sgBbV9ndUdA
         hDyLDCapKXXlg==
Date:   Thu, 9 Feb 2023 08:46:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     qemu-devel@nongnu.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH RFC 0/7] revert RNG seed mess
Message-ID: <Y+UVTFseqHLhxRXR@dev-arch.thelio-3990X>
References: <20230208211212.41951-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208211212.41951-1-mst@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:12:23PM -0500, Michael S. Tsirkin wrote:
> All attempts to fix up passing RNG seed via setup_data entry failed.
> Let's just rip out all of it.  We'll start over.
> 
> 
> Warning: all I did was git revert the relevant patches and resolve the
> (trivial) conflicts. Not even compiled - it's almost midnight here.
> 
> Jason this is the kind of approach I'd like to see, not yet another
> pointer math rich patch I need to spend time reviewing. Just get us back
> to where we started. We can redo "x86: use typedef for SetupData struct"
> later if we want, it's benign.
> 
> Could you do something like this pls?
> Or test and ack if this patchset happens to work by luck.
> 
> Michael S. Tsirkin (7):
>   Revert "x86: don't let decompressed kernel image clobber setup_data"
>   Revert "x86: do not re-randomize RNG seed on snapshot load"
>   Revert "x86: re-initialize RNG seed when selecting kernel"
>   Revert "x86: reinitialize RNG seed on system reboot"
>   Revert "x86: use typedef for SetupData struct"
>   Revert "x86: return modified setup_data only if read as memory, not as
>     file"
>   Revert "hw/i386: pass RNG seed via setup_data entry"
> 
>  include/hw/i386/microvm.h |   5 +-
>  include/hw/i386/pc.h      |   3 -
>  include/hw/i386/x86.h     |   3 +-
>  include/hw/nvram/fw_cfg.h |  31 ----------
>  hw/i386/microvm.c         |  17 ++----
>  hw/i386/pc.c              |   4 +-
>  hw/i386/pc_piix.c         |   2 -
>  hw/i386/pc_q35.c          |   2 -
>  hw/i386/x86.c             | 122 ++++++++++----------------------------
>  hw/nvram/fw_cfg.c         |  21 ++-----
>  10 files changed, 49 insertions(+), 161 deletions(-)
> 
> -- 
> MST
> 

For the record, all three of the cases that I tested (i386 no EFI,
x86_64 with and without EFI) worked fine with this series. In case it is
useful:

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan
