Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8EA726A55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjFGUDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFGUDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:03:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBECE2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:03:45 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24AAF1EC0589;
        Wed,  7 Jun 2023 22:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686168224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K4I0V/hubQTsNd2IGgWHCW17HQtObQhYdKpQS5C4Z58=;
        b=FjEag43fOedPR6c11b6HbBAnBkfk84JNCBxBTuYtUWp7jO8hEMlxSMqNtCsvA7qQ8tp6YB
        1x3ismAgIDYtWkoURCHcOShpGtcgNX2MWFzVHMU9zLcDe3TSDmul+RN8pcv4ZVY3i/UEXb
        D26dra2Qub44mf6QgcviB8MYBZYfUrc=
Date:   Wed, 7 Jun 2023 22:03:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        stable@kernel.org
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
Message-ID: <20230607200339.GDZIDim1s0FYkoeNDK@fat_crate.local>
References: <20230605141332.25948-1-bp@alien8.de>
 <d3be3b2b-7c58-36eb-cd25-acea494e608d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3be3b2b-7c58-36eb-cd25-acea494e608d@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:36:53PM -0700, Dave Hansen wrote:
> What's the benefit of doing the loading on both threads?  I would have
> naively thought it was just wasted work.

I have the perfect example for this, see:

e7ad18d1169c ("x86/microcode/AMD: Apply the patch early on every logical thread")

so it is for reasons like that.

> I think I even have a back-burnered Intel patch around somewhere that
> ensures that we *never* load on both threads.

Interesting - I guess there are considerable differences in microcode
architecture between the two. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
