Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40604716A50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjE3Q7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjE3Q70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:59:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E32188;
        Tue, 30 May 2023 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685465957; x=1717001957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nGdccLwIUp9WzO5WvRcldvrod6QymUjgGMPvNsyJeHc=;
  b=H780xPQUEzdP4MKu1bdiXzG/W2zAty6FkLpXhu4tG3tJpXLkDVbkswtY
   zTx4OSGX/qjTxv4jTGZj7gwZxwINY1PaIWTsswS0EF2NDGEXuv7eIJg4e
   kqhlBCDuDf7yWDQBBK1AraH9D9SITdPl/RYxN4NFRyECujX6ihjjN6v7j
   fRZgY8VKi6oKzZ19jW0S9qpxhUB7jX/Fa286OyxJN0XawohcvJZXLtSnj
   sDEy+c4voBWPSzc/FoXOSXh3F2T4LZXvA3iB//bkh+rFx0pF/hodJBJ2f
   6MYt3yVwSa2ZIdKN40WOMdvBIDrCq5uesqVVtx3yp9336vhujI1NAgqiw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357360902"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="357360902"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 09:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="776408045"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="776408045"
Received: from rajeshag-mobl.gar.corp.intel.com (HELO [10.213.99.59]) ([10.213.99.59])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 09:58:58 -0700
Message-ID: <5470de6d-1b2d-688b-5a6f-301ba888c054@linux.intel.com>
Date:   Tue, 30 May 2023 22:28:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5] usb: typec: intel_pmc_mux: Expose IOM port status to
 debugfs
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230524104754.4154013-1-rajat.khandelwal@linux.intel.com>
 <2023052917-juicy-calamity-4b35@gregkh>
 <0367a134-cb04-8a1c-bb46-bb5553df6f8a@linux.intel.com>
 <2023053049-dexterous-flatware-df04@gregkh>
 <2da06c06-6617-bd02-f20a-a5ea7f9ae0b4@linux.intel.com>
 <2023053013-playhouse-dad-1444@gregkh>
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <2023053013-playhouse-dad-1444@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/30/2023 3:14 PM, Greg KH wrote:
> On Tue, May 30, 2023 at 03:06:15PM +0530, Rajat Khandelwal wrote:
>> Hi,
>>
>> On 5/30/2023 2:57 PM, Greg KH wrote:
>>> On Tue, May 30, 2023 at 02:45:03PM +0530, Rajat Khandelwal wrote:
>>>> Hi,
>>>>
>>>> On 5/29/2023 7:48 PM, Greg KH wrote:
>>>>> On Wed, May 24, 2023 at 04:17:54PM +0530, Rajat Khandelwal wrote:
>>>>>> IOM status has a crucial role during debugging to check the
>>>>>> current state of the type-C port.
>>>>>> There are ways to fetch the status, but all those require the
>>>>>> IOM port status offset, which could change with platform.
>>>>>>
>>>>>> Make a debugfs directory for intel_pmc_mux and expose the status
>>>>>> under it per port basis.
>>>>>>
>>>>>> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>>>>>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>>>> Does not apply to my tree :(
>>>> I have pushed the patch on top of the Linus's tree.
>>>> Had a quick check with the USB Linux tree and seems like its a lot
>>>> behind?
>>> What branch did you use?
>>>
>>> Please use the usb-next branch of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git, which as
>>> of right now, is at 6.4-rc4 + a bunch of USB-specific patches.
>> I see. There is one commit additional in the usb-next tree:
>> ef0a3642b320 usb: typec: intel_pmc_mux: Convert to platform remove callback returning void
> One?  I count a lot more:
>
> $ git log --oneline main..usb-next | wc -l
> 143

I was referring to Linus's master branch. :)

>
>> Anyways, do you want me to re-work the patch for the usb-next branch?
> Given that I can not take the patch as-is, it's up to you to rebase it
> if you wish to have it accepted.

Ok. I will make a v6 on top of usb-next.

Thanks
Rajat

>
> Isn't this all covered in the Intel kernel developer training class?
>
> thanks,
>
> greg k-h
