Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2798365DC48
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbjADShi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbjADShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:37:21 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3C13F15
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672857440; x=1704393440;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ML+G8wE8HvVBjGchvfSyQ+8atDsoyJghtlCJAdYi6HE=;
  b=NeJrxP/dafOzEXKhTWM4kasHenJpaKDxdBQqacNZMXYNwUjpMf63QDIl
   sJJbCJ6qN7qIS8RfGviYjuKROV0l7jKIInkSSS3DuoPaVexLD+O7r52kH
   W+cJOmWhCH06tYem7rjJ2Wv2aekCmxj7cWUBFGEqpdXjgbA0gpC7l/gWR
   VNs5lLCiwd350ffZDPBNdiksIkJagWm9tUlIt88bT+8XWxVRGibiwJdsB
   9apuUsnSDd7NT4J4HB0K9EEARXfjUNHnYXTrbelT03Uw2V/0CyQkpLi/t
   GOZBG26YtAbQu3qSEuVpD2dds7z79TywoXEr7yc43nrygcLKllUNDnMPJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322085767"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="322085767"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 10:37:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="687619182"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="687619182"
Received: from cheungbr-mobl.amr.corp.intel.com (HELO [10.209.91.155]) ([10.209.91.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 10:37:13 -0800
Message-ID: <e587eebc-5f28-0a63-9200-b67ba20ea347@intel.com>
Date:   Wed, 4 Jan 2023 10:37:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20221215182339.129803-1-helgaas@kernel.org>
 <Y6KiH2Nf/hMiaPmD@MiWiFi-R3L-srv> <Y7TwnyixithmnizI@MiWiFi-R3L-srv>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y7TwnyixithmnizI@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 19:21, Baoquan He wrote:
>> Since it cleans up the last arch specific version of
>> arch_kexec_kernel_image_load in x86, maybe this patchset can go into x86
>> branch?
> Could you consider picking this patchset into x86 branch? This is a
> clean up on kexec, while the last ARCH using it is x86.

I'll stick it in my queue to take a closer look.
