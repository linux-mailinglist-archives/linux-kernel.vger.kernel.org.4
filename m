Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C22699C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjBPSc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjBPSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:32:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9365611179
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676572374; x=1708108374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zfp7UkFHu3uObj2djITRWHGzW92NYU2r9XQ28CZ8TzM=;
  b=ACNPwepvrJ/J8xAltYo1kmKofj5LzoAKMqPtF8xU/MQKb48J5f4XsP7q
   n+nRtnCr4wTi3uPka5M5wWrsjUrkLKYWqERLp8WpYRPLvIayC51nO93PN
   f5VTCn60CHLlu4j+KKAZ7lgNrhmWtqBA/UDDG4lxEu7/D56CRZ4hd7BPu
   PRMUglUQ9BIQuc43e+29uekRHsBmu52TFwU3oq20V//DF3Mvvd9r+Vh3O
   FOyBKmd5v9NWWWF1UuDP38nlOpy6DC+IeCss26t02Wy3vsaLAIPWTanD4
   6u4p/h90lWWLren2Fq3/QQZYFWyqSkGqQtnT6q5dxpS0yJkdLktqm7eCS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333998540"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333998540"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 10:32:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="670255337"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="670255337"
Received: from bjelliot-mobl1.amr.corp.intel.com (HELO [10.209.100.192]) ([10.209.100.192])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 10:32:47 -0800
Message-ID: <3ecc4208-9165-bc7c-d71b-2b93571f42af@intel.com>
Date:   Thu, 16 Feb 2023 10:32:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <65fc95bb-5ad9-b589-d6a4-762289b3f6bc@intel.com>
 <20230216181230.3jn5hebv3xkdivbx@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230216181230.3jn5hebv3xkdivbx@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/23 10:12, Kirill A. Shutemov wrote:
> On Thu, Feb 16, 2023 at 09:50:32AM -0800, Dave Hansen wrote:
>> On 2/13/23 15:48, Kirill A. Shutemov wrote:
>>> The patch brings basic enabling of kexec in TDX guests.
>>>
>>> By "basic enabling" I mean, kexec in the guests with a single CPU.
>>> TDX guests use ACPI MADT MPWK to bring up secondary CPUs. The mechanism
>>> doesn't allow to put a CPU back offline if it has woken up.
>>>
>>> We are looking into this, but it might take time.
>> This is simple enough.  But, nobody will _actually_ use this code as-is,
>> right?  What's the point of applying it now?
> Why nobody? Single CPU VMs are not that uncommon.

Here's one data point: the only "General Purpose" ones I see AWS
offering are Haswell era:

	https://aws.amazon.com/ec2/instance-types/

That _might_ be because of concerns about SMT side-channel exposure on
anything newer.

So, we can argue about what "uncommon" means.  But, a minority of folks
care about 1-cpu VMs.  Also, a separate minority of folks care about
kexec().  I'm worried that the overlap between the two will be an
*OVERWHELMING* minority of folks.  In other words, so few people will
use this code that it'll just bitrot.

I'm looking for compelling arguments why mainline should carry this.
