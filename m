Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0CB62205C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiKHXco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiKHXck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:32:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A46AE02
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667950359; x=1699486359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kzTE424pFzXVf9IENFeVVx4TxNlGGTb4uFNWa9RUX7s=;
  b=YRaKMpSN41sxL88h/+NklJFYBHd72qHAisLhZ+ClUXjvTdQ9eos+jmVp
   qn4nXUWzu7xy4l5sjxH9AntFVhMfEz8dDLHYts5OtZbtuQ5CtUp33LurL
   gzVbQOCTfH9YECeR55mPkoj5aLq3MJ9cEtgHilcnzl+nT6BmdaPBBOQNC
   wBaN7pwTx6bUnSDBZ0SOTXWDg5VQ7CWNi8WGH1ta6ZSNe5LEeBVkIt46l
   LeTk++jZyyZqLUQ+dO3lyYkMh65qx9cax0wKXAl115OSCUc+GOEgH4WxN
   HlzacfS859f76FvXB2q9nY+n4y5v81NCi2cVctfd1yZ+pwj9bFqtJFxUg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312630635"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="312630635"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 15:32:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669732728"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="669732728"
Received: from vibhusha-mobl1.amr.corp.intel.com (HELO [10.252.133.56]) ([10.252.133.56])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 15:32:38 -0800
Message-ID: <01fbc03e-bef0-bf07-d035-dac695800996@intel.com>
Date:   Tue, 8 Nov 2022 15:32:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [v2 01/13] x86/microcode/intel: Prevent printing updated
 microcode rev multiple times
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-2-ashok.raj@intel.com> <Y2e4PgwAEXuFzoMd@zn.tnic>
 <Y2kuixb0RU9BxKls@araj-dh-work> <Y2lSyX+YS51dxAnr@zn.tnic>
 <Y2rg7OYkhtTWQVNL@a4bf019067fa.jf.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y2rg7OYkhtTWQVNL@a4bf019067fa.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/22 15:06, Ashok Raj wrote:
> Patch3 is a bug fix. I suspect some earlier upstream reports of ucode 
> failure after update (early loading) might be related. The symptom is 
> similar, but those are too old to followup. I got into a similare situation
> when i tried to update an incompatible uCode from initrd and system hung.

Hi Ashok,

If this really is a bug fix, could you please break it out and send it
separately along with appropriate tags like Fixes and a cc:stable@?  We
handle bug fixes differently from new features.
