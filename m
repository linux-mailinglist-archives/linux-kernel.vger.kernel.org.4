Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5711A729142
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbjFIHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjFIHfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:35:21 -0400
X-Greylist: delayed 243 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Jun 2023 00:34:55 PDT
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222312D7B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:34:55 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 7Wa7qv0VqlVLu7Wa7q9kk8; Fri, 09 Jun 2023 09:30:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1686295848; bh=CxJiABjMAbHEoXWwETMmIKubD9O+HOaM3QhDPUauua8=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=E+vEcnLwJYxXi0Gyfgvu4aL6dlENVtq+BAhgkDLKjlrs9Ho1kW6xARJmTC58uC6f6
         tuHQD0lo550m+X4aWCOeXlkF9aTN/1H3Qwwex6HCzO+1GlbO84IaDfPYojItGHYDgB
         0ecRVu3iuYk1ZmCfoHf/HhmuKnSm8i+eiB2PG4CH4AXDyJDKuXCW+FVIhe0W9RY6XJ
         sUm4V4afDQq89PmQeNfNFRGFD+w3ObbNB5Q7zIWBT5YL1Z6BCEWBsaALCwyL1GZmEL
         dSnb7A4HmQqYEn7i3UObtGOCyq5NfAg2O3iXWlClf+wqaRSi4yG/TZZC+zPbBLQ5kM
         rrzuIVLKhfshw==
Message-ID: <70ce864c-ca13-4fc4-fcb5-9b7f91579a90@enneenne.com>
Date:   Fri, 9 Jun 2023 09:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] pps: Increase PPS_MAX_SOURCES value.
To:     Charlie Johnston <charlie.johnston@ni.com>
Cc:     linux-kernel@vger.kernel.org, brenda.streiff@ni.com
References: <20230605203147.694716-1-charlie.johnston@ni.com>
 <fe435e68-8e05-9078-0fe6-63ef7cce2fc9@enneenne.com>
 <b794bccc-0233-4d78-df6f-bf7c688a7d7d@ni.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <b794bccc-0233-4d78-df6f-bf7c688a7d7d@ni.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBdLcGhVejdbWjhVRfFbW9TqOI4aUuIGqmEZtbLbLD6zBuKR+yJw9CC89mX2Y2rUA89TSlbW31ngqQU0bK8bkj7HivK6TCS/WAToJCBqxZBmYIhF/lOw
 Gb1JuAPRpGptuh9iKOrUHBN2dgjPrjfsnSQfKvnIdglqmICEKUStW81QX0FmGuDBIAfY5grXtC0hvmY/r0RLPnTbDyouChd7etAGeL9YSyiJx7hUV1d85/1J
 ii1mrWOh28WkPoGm8UiGkE8WrNtXws8pAgIM0dVOhNM=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/23 00:07, Charlie Johnston wrote:
> On 6/7/23 02:33, Rodolfo Giometti wrote:
>> On 05/06/23 22:31, Charlie Johnston wrote:
>>> For consistency with what ptp uses for minors, this
>>> change sets PPS_MAX_SOURCES to MINORMASK + 1.
>>>
>>> The PPS_MAX_SOURCES value is currently set to 16. In
>>> some cases this was not sufficient for a system. For
>>> example, a system with multiple (4+) PCIe cards each
>>> with 4 PTP-capable ethernet interfaces could run out
>>> of the available PPS major:minors if each interface
>>> registers a PPS source.
>>>
>>> Signed-off-by: Charlie Johnston <charlie.johnston@ni.com>
>>> ---
>>>    include/uapi/linux/pps.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>>> index 009ebcd8ced5..85f472330da8 100644
>>> --- a/include/uapi/linux/pps.h
>>> +++ b/include/uapi/linux/pps.h
>>> @@ -26,7 +26,7 @@
>>>    #include <linux/types.h>
>>>      #define PPS_VERSION        "5.3.6"
>>> -#define PPS_MAX_SOURCES        16        /* should be enough... */
>>> +#define PPS_MAX_SOURCES        (MINORMASK + 1)
>>>      /* Implementation note: the logical states ``assert'' and ``clear''
>>>     * are implemented in terms of the chip register, i.e. ``assert''
>>
>> I have just one question: are you sure that it's safe to call idr_alloc(..., 0, (MINORMASK + 1), ...)?
>>
>> Ciao,
>>
>> Rodolfo
>>
> 
> Thanks for taking a look!
> 
> My understanding is that idr_alloc(..., start, end, ...) can take any end value up to INT_MAX. It also handles any values <= 0 by treating them as equal to INT_MAX + 1 since the end value is non-inclusive. I can't think of any reason using MINORMASK + 1 here would be an issue since it's much less than the maximum value idr_alloc() allows.
> 
> A number of drivers (e.g. ptp) just explicitly use a start and end value of 0, but I don't think that change would fit here.

I see and maybe I should replace the usage of idr_*() with ida_*() as PTP does...

However the right-thing(TM) to do here should be dropping PPS_MAX_SOURCES at all!

Let me go deeper in this issue. I'm going to produce a patch set in next days. 
Have you any chances to test it?

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

