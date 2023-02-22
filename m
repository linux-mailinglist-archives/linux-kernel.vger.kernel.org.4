Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4069FCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjBVUN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjBVUNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:13:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A425BBC;
        Wed, 22 Feb 2023 12:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677096778; x=1708632778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v93VOV+gt3R5T1tPMwoB5pb0cOgtbnAz2F53IOxXfXs=;
  b=ELV6pX3W3Qaz0Bd4hfa3oZbwrvukvUN/URqbzICJcx3f9AyTDs9Yve6l
   qa6WZTL2nRkYNPh+/4780AGldLPfFopRaPtzkegr6lkgeS9jwIFQPWX6T
   IpnQO6aumdJWt9f2GLOOLzbS6dLclTsHwU/zKVdjbOIyFyJTKXbG3qFWt
   l41IE2eZqIngzuTx5lIGSLdCr9HyVGD94irgN5vg4MZfbTxGUsd0LW4P4
   XLrUyx4Xfuj3FRwQLU/QH5+HfhnsYH9i5z28CVrT1OVuTOc2TL1qXiXTf
   1BokwxT82SuKqgtXkqeTU1Mm5nw0s1TYxMmeME5mUtX0+H59hiwi9ZabB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="335234872"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="335234872"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 12:12:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="740973058"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="740973058"
Received: from tzinser-mobl.amr.corp.intel.com (HELO [10.209.49.182]) ([10.209.49.182])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 12:12:56 -0800
Message-ID: <9c55a34b-c17e-2a62-9989-902ce940dde5@intel.com>
Date:   Wed, 22 Feb 2023 12:12:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/7] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     "Joseph, Jithu" <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-5-jithu.joseph@intel.com>
 <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
 <d9d18954-8434-4c85-88b8-8e1d99cd6a4b@intel.com>
 <dd501d6a-e7e9-be82-24fb-33b18fb6192b@intel.com>
 <b67d2125-4075-4eac-4cad-8e315b866144@intel.com>
 <5d57f42a-1bfc-5e6a-bb49-556ecb7402af@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <5d57f42a-1bfc-5e6a-bb49-556ecb7402af@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 13:13, Joseph, Jithu wrote:
>  And for the last argument, we need to dump the whole 64 bits within "command"
> into trace output . 

No, no you don't.

Just split it up in to human-readable logical pieces.  You don't need to
dump the whole 'command'.  If you want to trace the completion mask,
then extract the mask and print *that* with a proper field name.

I actually really think this tracing should go away, *ESPECIALLY* if you
insist on dumping out raw, non-human-readable MSR values.

I say NAK on the tracing.  You haven't convinced me that it's necessary
on top of what we have today (MSR tracing).
