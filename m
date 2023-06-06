Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC8724A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbjFFRaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbjFFRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:30:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D5B10F0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686072604; x=1717608604;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=H+4zbG4OFfWvL2qhgJOK+pD0Hi5SD6cUhTNXoIf9reI=;
  b=CVvPozXnXJ0GzrCyE7r4KqV2tKQcCzb2BAuNHx98E9SJk9F3FT2uCkF8
   1nxuPKEr1hnHAosOjGatBn09TTUbtKqf1gCOdKyJHycttJmZs526j3daj
   s8npNzlu9U8KRSUwd4XAu6PAkslFALIlNWQnvLeFqzpqnKgT5kbbittG2
   y5bWR4FmX2Bbd9Z/LnMJQNR1kOD/Pa6/mGU6+JdVAYtGU8XZ2yu8DuxoE
   WlEzIkgWvK9iFHP97QHCzoWwcA1ly4zie6drma6FQ6Ibc581sCBrGMtlt
   4e/or11AggjBttd0nbNXEMbC5PUDVTLxSjAJoVX/Jw82N1X1kcEFiuNTY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="360065767"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="360065767"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 10:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="955852093"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="955852093"
Received: from hganapat-mobl1.amr.corp.intel.com (HELO [10.212.191.102]) ([10.212.191.102])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 10:28:41 -0700
Message-ID: <84292c84-6f12-2df5-dc4c-3a7abc6659ea@intel.com>
Date:   Tue, 6 Jun 2023 10:28:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] x86/cpu: Update Intel model naming rule
Content-Language: en-US
To:     kan.liang@linux.intel.com, tony.luck@intel.com,
        peterz@infradead.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20230606170257.3213720-1-kan.liang@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230606170257.3213720-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 10:02, kan.liang@linux.intel.com wrote:
>   * MICROARCH	Is the code name for the micro-architecture for this core.
>   *		N.B. Not the platform name.
> + * PROCESSOR	Is the code name for the processor

I think we should refine the definition of "MICROARCH" here.  We want it
to refer to the combination of cores, not just "this core".

ALDERLAKE is a fine name to refer to a processor that has a mix of
"Golden Cove / Gracemont" cores.  Let's just have it say:

   * MICROARCH	Is the code name for the collection of micro-
		architectures for this processor.  N.B. Not the
		platform name.


