Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54842674048
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjASRsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjASRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:48:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8607C44AE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674150520; x=1705686520;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FPQjkSgyOLoSk8C0J4CNAhrSv/EGmeASIHkuMk8fK1E=;
  b=M/T4Hw73Sq+IQLQn4BjCF4uKqddKIkCi6HF5xPid5o96SZoJb5zvF6fU
   xAPLTNm6qjhK+ffxsrSBR9PY+4QDuqAiPQ/rVlacKPAXKRt72Gm6GGi6z
   v76bdIhevBzK0fUruHPbjzMBxnyQd3WPmCOUFJlzjfnZvr2u0IlWFEf78
   nI5w7OWCfAw7sidwbGN2u3OwPyXJJ09EzneNBQH+UnGCD2ZuvBLaM4fhV
   BB/XTru+LeC4/26o5oPc19HA43cuOA9ozJisMbTczWbRIxXl0iuEtP9qf
   8UyV0pAqlX8IiFPou8/As1V1jidDW9F87QcE+lRSHe6+OmXvctQvu/jMv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="324049324"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="324049324"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="802719995"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="802719995"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2023 09:48:36 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
In-Reply-To: <Y8lfz8C5uvx2w4fC@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com>
Date:   Thu, 19 Jan 2023 19:48:35 +0200
Message-ID: <87ilh2quto.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Jan 19, 2023 at 03:57:17PM +0200, Alexander Shishkin wrote:
>> From: Andi Kleen <ak@linux.intel.com>
>> 
>> The ADD_PORT operation reads and sanity checks the port id multiple
>> times from the untrusted host. This is not safe because a malicious
>> host could change it between reads.
>> 
>> Read the port id only once and cache it for subsequent uses.
>> 
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Amit Shah <amit@kernel.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  drivers/char/virtio_console.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
>> index f4fd5fe7cd3a..6599c2956ba4 100644
>> --- a/drivers/char/virtio_console.c
>> +++ b/drivers/char/virtio_console.c
>> @@ -1563,10 +1563,13 @@ static void handle_control_message(struct virtio_device *vdev,
>>  	struct port *port;
>>  	size_t name_size;
>>  	int err;
>> +	unsigned id;
>>  
>>  	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
>>  
>> -	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
>> +	/* Make sure the host cannot change id under us */
>> +	id = virtio32_to_cpu(vdev, READ_ONCE(cpkt->id));
>
> Why READ_ONCE()?
>
> And how can it change under us?  Is the message still under control of
> the "host"?  If so, that feels wrong as this is all in kernel memory,
> not userspace memory right?
>
> If you are dealing with memory from a different process that you do not
> trust, then you need to copy EVERYTHING at once.  Don't piece-meal copy
> bits and bobs in all different places please.  Do it once and then parse
> the local structure properly.

This is the device memory or the VM host memory, not userspace or
another process. And it can change under us willy-nilly.

The thing is, we only need to cache two things to correctly process the
request. Copying everything, on the other hand, would involve the entire
buffer, not just the *cpkt, but also stuff that follows, which also
differs between different event types. And we also don't care if the
rest of it changes under us.

> Otherwise this is going to be impossible to actually maintain over
> time...

An 'id' can't possibly be worse to maintain than multiple instances of
'virtio32_to_cpu(vdev, cpkt->id)' sprinkled around the code.

Thanks,
--
Alex
