Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C856CB662
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjC1Fxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC1Fxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:53:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456151BFE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 22:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679982818; x=1711518818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FF+DUqCGHy8oPyFBqiYg8s10DunJo6T+TgdcwHN7O5g=;
  b=ESv2E2dNjMHASUtegF+EayvwPAK6RCh8Soc3l07IZvHlYJm5mDlJD45g
   DvpqBqTHk+wuAzcn5YthmLIxbIqcOjE4ItYnxcjP32hiZWrCFY07x0TJq
   1OeSdNkdN2lCcw3Ob8HbEVWCGmZA4+aZ7zwveGWDt78lmjgkXtl6LGtyX
   SdeXQt48wPG2DlHU71isKS2rDDTgMF5m2/ehPZth+KG1gyEkxGM9BIMmq
   BSkQ6I5p2N+axBu48UcN/hY5MmpK5mDRoWnWvKr+8n7UyLeMdhoIHiwJd
   ytU+dkGSedaTOaN9WgbEn8bq92R3psFqHZrFMwgGYE9cEIukaSCDvPza0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="403088288"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="403088288"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="752987372"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="752987372"
Received: from skunchit-mobl.amr.corp.intel.com (HELO [10.209.35.30]) ([10.209.35.30])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:53:36 -0700
Message-ID: <dfd8466a-9693-e469-31be-3d9158f19263@intel.com>
Date:   Sat, 25 Mar 2023 09:20:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/23 09:01, Kirill A. Shutemov wrote:
> The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
> secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
> it has woken up.

I'm not sure I like this approach.

TDX uses the MADT exclusively.

MADT-based systems can't offline CPUs.

kexec() requires
