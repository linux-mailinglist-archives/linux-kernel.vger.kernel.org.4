Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE1A5BD9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiITB5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiITB5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:57:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6666A4C607;
        Mon, 19 Sep 2022 18:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663639040; x=1695175040;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u4sxqOJNM7hytlNSx9Agakrf43YjJ2r5/SXR7tcBW60=;
  b=ildhZIuV3ysTKF56KAcwkx3+xXKflyg3wPuD6BUYEl1rhApW6pzKinEk
   3kmRSNuXZLNDS+4KNkp0i79QfdWDh0794Tlyiz/90NmXImk+oaypitPaA
   uJefVdYPKM4auwPHcRU21UAMBt2fsjId8vq3b84IuqtkahqDOCSeRk+oi
   PE7czjQZQIQIGQr554e1Bp8lHuDMW91ve1wzscWcS8V0tIjpVfA9hoOhl
   NHs3Z6gtLlbLYkgOtwCa/xM3K/rGO38MEhP3yaRUPHP2h/2eTZYC2TmUn
   s9NVq/tzbHr+NkElbyWk7BRfax4Bwe7VU4l76375xMhKkoBh/4YeItHM3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325867384"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="325867384"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 18:57:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="947465315"
Received: from chewjias-mobl.gar.corp.intel.com ([10.213.152.145])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 18:57:13 -0700
Message-ID: <b765f3930756927dc8df6580c04eceedde40ff87.camel@intel.com>
Subject: Re: [PATCH V2 0/8] x86/topology: Improve CPUID.1F handling
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, Peter Zijlstra <peterz@infradead.org>
Date:   Tue, 20 Sep 2022 09:57:05 +0800
In-Reply-To: <20220816051633.17775-1-rui.zhang@intel.com>
References: <20220816051633.17775-1-rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-16 at 13:16 +0800, Zhang Rui wrote:
> On Intel AlderLake-N platforms where there are Ecores only, the Ecore
> Module topology is enumerated via CPUID.1F Module level, which has
> not
> been supported by Linux kernel yet.
> 
> This exposes two issues in current CPUID.1F handling code.
> 1. Linux interprets the Module ID bits as package ID and erroneously
>    reports a multi module system as a multi-package system.
> 2. Linux excludes the unknown Module ID bits from the core ID, and
> results
>    in duplicate core ID’s shown in a package after the first issue
> solved.
> 
> Plus that, a third problem is observed on Intel Hybrid ADL-S/P
> platforms.
> The return value of CPUID.1F SMT level EBX (number of siblings)
> differs on
> Pcore CPUs and Ecore CPUs, and results in inconsistent
> smp_num_siblings
> value based on the Pcore/Ecore CPU enumeration order. This could
> bring
> some potential issues although we have not observed any
> functionalities
> issues so far.
> 
> This patch series fixes these three problems in CPUID.1F handling
> code,
> together with some related fixes and document updates.
> 
> 
Hi,

These patches are mainly bug fixes for ADL-N and Intel Hybrid
platforms.
May I know if there are any further changes needed?

thanks,
rui


> thanks,
> -rui
> 
> ---
> Changes since V1:
>  - fix/improve changelog/comment wording issues
>  - reorder the patches to eliminate bisection breakage window
>  - add a new patch for coretemp driver variable renaming
>  - update coretemp driver patch to fix a case of ida_free(&ida, -2)

