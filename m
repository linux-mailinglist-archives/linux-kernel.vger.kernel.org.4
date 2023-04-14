Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53F26E1F32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjDNJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:22:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB8259FF;
        Fri, 14 Apr 2023 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681464177; x=1713000177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ebf6LIMNhryNaqylHZcAfkVO+1R1IJ4F5ZzDNTo8xYQ=;
  b=HrHMRY4j9e1cKrQNxS66sFiWyIVFyuMTmr4u/MZtJmUd89uUBfkRmhv7
   V6JbU+Ze709gQlxLY8mhz0ZVzF1Viig4DxdN4ejBT9nEXx0deAkhK7dpj
   EDxiVLMQhFexKS/czkpIL0rp9b6Lp3ImGjbRP6RSygknWwcEPj7hidSKs
   GDs2gyQxJUNy7NuwiLie642Pvo6gHyYnUhyhVvVSUOKuKNFZ1SrZaVxRY
   5/ybwUuPUYSmJrbzC25GoLeNuMhJzNzao6/dBJZdJODxECXw6KwCbd9Og
   bR37GMPswdryEfNqj4G8swZvoiw1qGetQVkWgf8afbZDMYohsxT8cpsaZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346255518"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346255518"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 02:22:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="935944807"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="935944807"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 02:22:53 -0700
Message-ID: <8978fc5c-73fc-c654-dce2-d3b22511da64@linux.intel.com>
Date:   Fri, 14 Apr 2023 11:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] firmware_loader: rework crypto dependencies
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
References: <20230414080329.76176-1-arnd@kernel.org>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230414080329.76176-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/2023 10:03 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The crypto dependencies for the firmwware loader are incomplete,
> in particular a built-in FW_LOADER fails to link against a modular
> crypto hash driver:
> 
> ld.lld: error: undefined symbol: crypto_alloc_shash
> ld.lld: error: undefined symbol: crypto_shash_digest
> ld.lld: error: undefined symbol: crypto_destroy_tfm
>>>> referenced by main.c
>>>>                drivers/base/firmware_loader/main.o:(fw_log_firmware_info) in archive vmlinux.a
> 
> Rework this to use the usual 'select' from the driver module,
> to respect the built-in vs module dependencies, and add a
> more verbose crypto dependency to the debug option to prevent
> configurations that lead to a link failure.
> 
> Fixes: 02fe26f25325 ("firmware_loader: Add debug message with checksum for FW file")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Tested on a few hundred randconfig builds
> ---

When I thought I've tested all combinations... ;)

Thanks!

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
