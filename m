Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16EC640E60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiLBTXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbiLBTXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:23:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA5EC23F8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:23:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670009009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bV2EzwLCAkqStO5X/oBmuNeHZefcqIt2y+2D2SEUA4o=;
        b=YfPgqs8IbL3kav7yhqANGovHCCrWdn6TBgsU3wgl65dMjITMeOR1KJq7wfpOhaKItSgAah
        gQ9sNYn4rjcXcImf3h/0pQ1b9tU6xSdxxo0EVdc3y7p3Z3ROwbJn7mlEkOY+Sx0T6YCbsM
        xu93IRu0Xlnn9NM6gIf/Mn6w5Rs3I2Kx2+jrQjXJyF/vPuCDtMOilrcqzbM7gjw3UsCr8l
        Chx/pWtMlDO3/e21JEZ9Lv+Rc7Fu3+yeEYKp57wQ3wiqRs70LZcuns9Iq0gzJn4bY/W3/J
        vyLu5IWb9xHMRcn040CvVDNpo3BguScH0XBP4w+yUqqCNBPyZli4003k1DkVSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670009009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bV2EzwLCAkqStO5X/oBmuNeHZefcqIt2y+2D2SEUA4o=;
        b=q6Fn78WsaZ+Matzg3UEpvndL5IBj3BVbl2UVKImBEWERfil92Wv/9q6mzmkoLfNznv762X
        MhD4oXzlKgyw3XDQ==
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 5/7] x86/microcode/intel: Prepare the print_ucode_rev
 to simply take a rev to print
In-Reply-To: <20221129210832.107850-6-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-6-ashok.raj@intel.com>
Date:   Fri, 02 Dec 2022 20:23:28 +0100
Message-ID: <871qphpq33.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29 2022 at 13:08, Ashok Raj wrote:

> Instead of passing a struct ucode_cpu_info, just pass the rev to print.
>
> Next patch will permit printing old and new revisions after an early
> update. A subsequent patch will print a message when early loading fails.
>
> struct ucode_cpu_info is always the current version in the CPU. When
> loading fails this is the old rev, when its successfully applied its the
> new rev. That makes the code bit ugly to read.
>
> Remove the struct ucode_cpu_info parameter from print_ucode() and let
> the caller to pass in the revision number to print.

Back to word salad mode?

  Subject: x86/microcode/intel: Use a plain revision argument for print_ucode_rev()

  print_ucode_rev() takes a struct ucode_cpu_info argument. The sole
  purpose of it is to print the microcode revision.

  The only available ucode_cpu_info describes always the currently
  loaded microcode version. After a microcode update this is on success
  the new version or on failure the original version.

  Subsequent changes need to print both the original and the new
  version, but the original version will be cached in a plain
  integer, which makes the code inconsistent.

  Replace the struct ucode_cpu_info argument with a plain integer which
  contains the revision number and adjust the call sites accordingly.

  No functional change.

Hmm?

Other than that.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
