Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E7E6BEE6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCQQej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCQQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:34:36 -0400
Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590D833CC5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:34:32 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id dD2Cp0lUtlwgQdD2Cp7Y0V; Fri, 17 Mar 2023 17:34:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1679070868; bh=tQ+9MMbSyKEwB5c9FRbKPgfZFtzqJftNHMoDhcibqsI=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=aFBySqQqwb3tDDSaIzEK//OkEYa8jO4IKSVRNaxRnmp6yK/b6jj4NwI38FuxKJXgG
         IrlQNwGnKB/95dDRHw+TY2XcnVoto/Pgp7xRyLKVhZjB8W1EXGAEgOgtB7U9lG9HWt
         NLk/nu2FS13ap/3MQazs2S+8Kb+3htC2KDNRshKdWMxSpixTIhnAClvIlbXh2LjcuN
         ychYeAkKf6ms/D/ESlOqh8rQoOlCl3+/K+xWAReFGmDW40xK5QWZtaTFUNBFrtK/iQ
         7huY27OjUvB9YMTR8/5CN0XiO412EBqodE9m3OCyaFf6Qqe4Pk/IvQ+eyBmAElTWFX
         akpY5Te7M8tpg==
Message-ID: <f8ea9ab9-e1c1-7962-dab4-126beda74046@enneenne.com>
Date:   Fri, 17 Mar 2023 17:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] pps: Add elapsed realtime timestamping
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alex Komrakov <alexander.komrakov@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20230317074739.193965-1-alexander.komrakov@broadcom.com>
 <ZBQdWRHzakFLzSkb@kroah.com>
 <CAMedr-_ssg-baCz94ExMVTeXr2Qivzop1kEpx0S4PWuQdAiGaw@mail.gmail.com>
 <2713f092-5d21-ad5e-c5f4-87c927b18a27@enneenne.com>
 <ZBR3t0D0JEl8feRt@kroah.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <ZBR3t0D0JEl8feRt@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCJo3kEz9c5MaW0qoi03UP/coqAAWPEkJBLXJ93Oxpm0gIpnJaT+uA/21lCWywpxmevI/RmHTvlQwMWYevVgJ+UMtysfiiZRa5mqscqi04Dwrc6Jp7Ws
 UtBZBAolB0lgBj8ezRxd9UAu1WTm7h/rYtmigjtLiCPUhbmDq+iPr+p3y7nVy/eNhQTH/St8wDEHnM2LjN2J0yxdlDY0mOokpbCQvQDpVMs5s6SDjTDvX3RM
 rtrwBp+CLv9EIvr5p90jG9G6q9TYXOhaji9Y0fIn0t5U6xmnZ87tFh6xP0LPNBeA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/23 15:22, Greg KH wrote:
> On Fri, Mar 17, 2023 at 03:04:31PM +0100, Rodolfo Giometti wrote:
>> On 17/03/23 10:51, Alex Komrakov wrote:
>>>> +     if (!(pps->info.mode & PPS_CAPTURECLEAR))
>>>> +             return 0;   Why are you not returning an error?
>>> [AK] I used the style in this file sysfs.c.
>>>    assert_show() and clear_show()  have the same condition.
>>> When '& PPS_CAPTURECLEAR' -- 0 means no interrupt asserted  and it is not error
>>> Probably Rodolfo can get more info why return 0
>>
>> It's just as Alex said, if the PPS source has no PPS_CAPTUREASSERT or
>> PPS_CAPTURECLEAR mode it should not print ASSERT and CLEAR info.
> 
> But shouldn't you return an error instead of an empty string?

This is not an error... it's just a disabled capability. :)

>>> And why are these sysfs files even present if the mode is not set
>>> properly?  Can the mode be set while the device is attached or is this
>>> only defined at probe time?  If at probe time, just never create these
>>> files.
>>> [AK] we can understand mode is set when interrupts asserted and
>>> file assert_elapsed will be updated.
>>
>> PPS source's "mode bits" can be set at runtime via PPS_SETPARAMS.
> 
> Ok, that's good to know.  But I think the error return value is a better
> indication that something went wrong here and this attribute does not
> work for this device at this point in time.

I see... however I suppose several code relays on this behavior.

If we decide to change it, which should be the better way to do it? Any 
suggestions are appreciated.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

