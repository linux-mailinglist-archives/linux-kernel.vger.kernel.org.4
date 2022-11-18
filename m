Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1C362EC98
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbiKRD7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiKRD7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:59:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1C48DA4F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:59:06 -0800 (PST)
Received: from [192.168.1.102] (unknown [103.251.226.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AE6584DD;
        Fri, 18 Nov 2022 04:58:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668743944;
        bh=6oOaTMB/v9QU4ojRYCNukfq71v21+xVeeAcdhfMrSwI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OlOo2O/LBzDt9bq9tXJpsn/urtWBC/iW0HR4EQgaL8NrR08Pi2N5ZHCNVQIq9Jcmp
         zFLmetQEjL64iBPi77sMajNdzGJ+FCFFTn1532G4YbQRR/DbsxWPu+GpX2fQ8Q40aH
         nEgCrbZbXRGOKv+KNN7cKrRoD+mY0ZM2wcrldcFk=
Message-ID: <79cc1057-bd62-02bb-a8e4-a440aa469109@ideasonboard.com>
Date:   Fri, 18 Nov 2022 09:28:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] Revert "staging: mmal-vchiq: Avoid use of bool in
 structures"
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
References: <20221117160015.344528-1-umang.jain@ideasonboard.com>
 <20221117160015.344528-2-umang.jain@ideasonboard.com>
 <166870135963.50677.14827688186331561108@Monstersaurus>
 <c718624a-bb6f-5474-5cc3-4319b1fdb282@ideasonboard.com>
 <Y3Z3Is8u4wGZfKU5@kroah.com>
 <c5e03c65-2994-6518-c79d-f6ad1557c4e0@ideasonboard.com>
 <Y3bN8I7DlxRUZumH@lunn.ch>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <Y3bN8I7DlxRUZumH@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/18/22 5:42 AM, Andrew Lunn wrote:
>>>>>>     struct vchiq_mmal_port {
>>>>>> -       u32 enabled:1;
>>>>>> +       bool enabled:1;
>>>>> Is this a direct revert with 'git revert' ?
>>>> No. It had conflicts plus I added the ':1' initialization to keep the logic
>>>> same (in case 'enabled' gets used directly). Similar pattern come up with:
>>>>       ($) git grep 'bool' -- '*.[h]' | grep '\:1'
>>>>
>>>> So it shouldn't be an issue.
>>> Please don't do that "bool foo:1" makes no sense.  Drop the ":1"
>>> please.
>> It won't affect this patch but if you take a look at 2/3 - you'll see a bool
>> flag 'in_use' that needs to be initialized (as it's getting used directly).
>>
>> I can move the initialization part in the function (_init() or something)
>> and drop the ":1" as you mentioned. That's  fine as well but I do find
>> patterns of 'bool foo:1' in the codebase so I assumed it would be safe to
>> use.
> Does :1 really initialise the variable? In "u32 enabled:1" it means
> this is a 1 bit wide bit field. It seems odd that bool is somehow
> special and :1 means something else.


Yup you are correct - seems I mis-read :1 as initialization

>
> 	Andrew
