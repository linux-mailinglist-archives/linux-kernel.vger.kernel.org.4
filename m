Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03E45F4BC3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJDWVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJDWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:21:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565036566D;
        Tue,  4 Oct 2022 15:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECF40B81A73;
        Tue,  4 Oct 2022 22:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431A7C433C1;
        Tue,  4 Oct 2022 22:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664922090;
        bh=nknUvIAw3621/tczw7v+m61cTYHmFty9sDG6DzZ78d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWMt3y03P/j1JOOlgSis3tO6Gzh1RhdevMCIG60B6K7Vwu4iLNZThVC+ao5FsNxbS
         5vHD1DjrjvbAMQGy1wmcx3REvn46VdNp05uxBZ/d/aiqaR2ynW3hkH3Byxa0NMttr2
         rbSdHhhILgPXoW73VctZvKABjYpAkZPKAkXNVH0FDeznV7pmIddifzS+Tm3WMOq02H
         JT3Nlr1u+1goAbHcbQaTzSETaBrbjUswHFIsJyMkp+HS02uB6LtUQzvZtV/SVFXFFB
         OMon4MZ1DMR45CBBP0t4JNsqg5AwYA2+VuYJ0ft0hUHEczRy8HndPtRJyY8ojQ2P7O
         hEJ610/ciBU1A==
Date:   Wed, 5 Oct 2022 01:21:27 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kai Huang <kai.huang@intel.com>, dave.hansen@linux.intel.com
Cc:     linux-sgx@vger.kernel.org, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, reinette.chatre@intel.com
Subject: Re: [RESEND PATCH 3/3] x86/sgx: Add xa_store_range() return value
 check in sgx_setup_epc_section()
Message-ID: <Yzyx5333eIuX0zaT@kernel.org>
References: <cover.1664834225.git.kai.huang@intel.com>
 <c02b60d3b92469a2ccfc0780e974d29da578be73.1664834225.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c02b60d3b92469a2ccfc0780e974d29da578be73.1664834225.git.kai.huang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 11:04:29AM +1300, Kai Huang wrote:
> In sgx_setup_epc_section(), xa_store_range() is called to store EPC
> pages' owner section to an Xarray using physical addresses of those EPC
> pages as index.  Currently, the return value of xa_store_range() is not
> checked, but actually it can fail (i.e. due to -ENOMEM).
> 
> Not checking the return value of xa_store_range() would result in the
> EPC section being used by SGX driver (and KVM SGX guests), but part or
> all of its EPC pages not being handled by the memory failure handling of
> EPC page.  Such inconsistency should be avoided, even at the cost that
> this section won't be used by the kernel.
> 
> Add the missing check of the return value of xa_store_range(), and when
> it fails, clean up and fail to initialize the EPC section.
> 
> Fixes: 40e0e7843e23 ("x86/sgx: Add infrastructure to identify SGX EPC pages")
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

This needs:

Cc: stable@vger.kernel.org # v5.17+

Dave, can you pick this independently of rest of the patch set
(unless ofc you have change suggestions)?

BR, Jarkko
