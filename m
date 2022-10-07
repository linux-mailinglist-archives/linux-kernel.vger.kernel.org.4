Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F675F7763
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJGLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJGLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:25:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA2BCBA2;
        Fri,  7 Oct 2022 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665141951; x=1696677951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/11VDUP7t7Su244uf2aNGRclLR+R+OX0BbNHJ8xjx44=;
  b=MMKjVibBjSLjI3tDgNWG/7mOaPXLa+400VMtdrMT7VUIMELzASLVe5tW
   yJhm3Qbh/YgiWJR+w3QdSgq2sPoa0oyjKNVx3Zb+Uk/LukGnG3TaOhPxf
   hMycGRMvCMgtYhRO7y7rZ3yTRtR7VGXIz8Np5Bz7/brF9SytBm91yXdxx
   kLne6QUEXIP82K53/RkwUDaj22pexUJMRANjOo6SMiWMnNWYIPW6FP4zj
   TlZjCvJwTV4dFX4gQZoUQfSZY0wezvbuG+TjLvF3SWHyTxXTgRbxVHEgq
   035KEqdwLlS+j0zi/02kwKhjaf7k5y2sb7rOUCM+PpkfiVTVHd4Oeu1L/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="365654013"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="365654013"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 04:25:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="625118747"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="625118747"
Received: from silin-mobl2.ger.corp.intel.com (HELO [10.252.61.25]) ([10.252.61.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 04:25:49 -0700
Message-ID: <6d820385-6118-4d90-6ffe-a9df20febe75@linux.intel.com>
Date:   Fri, 7 Oct 2022 14:25:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] HID: input: Add support for USI style events
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220812103519.2142290-1-tero.kristo@linux.intel.com>
 <nycvar.YFH.7.76.2208251140420.19850@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2209301109030.16823@cbobk.fhfr.pm>
 <YzcyUgLbZ2pVJSMO@google.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <YzcyUgLbZ2pVJSMO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/09/2022 21:15, Dmitry Torokhov wrote:
> On Fri, Sep 30, 2022 at 11:09:12AM +0200, Jiri Kosina wrote:
>> On Thu, 25 Aug 2022, Jiri Kosina wrote:
>>
>>>> Add support for Universal Stylus Interface (USI) style events to the HID
>>>> input layers. The events are mapped as follows:
>>>>
>>>> type	id	event
>>>> ----	--	-----
>>>> MSC(4)	6	Pen ID
>>>> MSC(4)	7	Pen Color
>>>> MSC(4)	8	Pen Line Style Ink
>>>> MSC(4)	9	Pen Line Style Pencil
>>>> MSC(4)	0xa	Pen Line Style Highlighter
>>>> MSC(4)	0xb	Pen Line Style Chisel Marker
>>>> MSC(4)	0xc	Pen Line Style Brush
>>>> MSC(4)	0xd	Pen No Preferred Line Style
>>>> ABS(3)	0x1c	Pen Line Width
>>>>
>>>> All the listed MSC events are new, the ABS one is mapped to an existing
>>>> event.
>>> Dmitry, could you please Ack the MSC_PEN_* additions?
>> Dmitry, friendly ping on this one.
> Very sorry, I meant to answer and forgot...
>
> We need good descriptions of what exactly these events are, and when and
> how userspace should expect/use them.
>
> In general, I am wary of MISC_* namespace as it needs to be sent in
> every packet as we do not retain state and do not give userspace way of
> querying it, unlike ABS_* or KEY_* or number of other events.

Hmm ok, do you have a counter proposal for this? Should all of them move 
to some other namespace? I have been using Benjamin's HID-BPF support to 
handle the quirks of the USI support so far, and the events are passed 
via that interface also, allowing for writing of the parameters too.

However, it would seem like it would be good to pass the details via the 
input event route also, if the user does not want to tap to the HID-BPF 
for whatever reason, and the pens do work as is, except for the new 
parameters.

>
> Also, what do we do with multiple pens used at once? Maybe we do not
> have such devices now, but multitouch devices did not exist in the
> beginning either, and now are ubiquitous.

Multiple pen support is expected to happen somewhere in future, the spec 
sort of supports it already but the controllers really don't (and I am 
not quite sure how flexible the controller interface is for multiple pen 
support either.) Should we use ABS_MT_* for the new params?

-Tero

>
> Thanks.
>
