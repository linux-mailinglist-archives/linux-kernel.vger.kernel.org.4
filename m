Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA26BEAB2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCQOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCQOFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:05:37 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Mar 2023 07:05:35 PDT
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752FD1A2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:05:35 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id dAh5peDmMlwgQdAh5p6DM7; Fri, 17 Mar 2023 15:04:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1679061871; bh=WflWTIh9j2tSU54l5h8eJJvWwKqlkFvF68Qe3qMjt2I=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=Kn/QE2fpoWiSEBxAjMK7HMGImE1qun2dwZBC5WMAgGC7s7tWwQuK8/Hv1VkbyrDT4
         RB5cL7VyHEinFMge1FI5d9rLDS1wIi4j2ZcmfLZie+1I3XzmEETbQft13SnzYL2KVP
         ThOsSCbjFUuPjAa+1PB5vNT4H+3XOFPqSW5A0LozmrSYAjF9wPCQihF2AtAA6kV3Hb
         Hi0tQltT3JUrKcNJtIaqOhEPLEGmw2StAwALE/UDtNSaMvMZbJkK2ipq6IJq3xD4RL
         Uk7QX/S3qrbvPNkqYijPni9JxWvZ14H6NQWDE0B6DBFkvURYeODI8tAYjDska0FdJB
         OisjsYsQxEtDg==
Message-ID: <2713f092-5d21-ad5e-c5f4-87c927b18a27@enneenne.com>
Date:   Fri, 17 Mar 2023 15:04:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] pps: Add elapsed realtime timestamping
Content-Language: en-US
To:     Alex Komrakov <alexander.komrakov@broadcom.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230317074739.193965-1-alexander.komrakov@broadcom.com>
 <ZBQdWRHzakFLzSkb@kroah.com>
 <CAMedr-_ssg-baCz94ExMVTeXr2Qivzop1kEpx0S4PWuQdAiGaw@mail.gmail.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <CAMedr-_ssg-baCz94ExMVTeXr2Qivzop1kEpx0S4PWuQdAiGaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNdxL369wUWuovvRjXsxQPGn3a1fJDukeBvwZ8jbETPnDLUStkJk3Bk0ekD3dqzWTpx1RZmpYsNnvi+TgxxHLv8tOUjbGBVRbtNkmCus0wsbe9hV92Pi
 PpUmxvY6UMpoSkcEBfleSjD2yi4wfw2Xj+ebaKTX0a+8oPQ+0O9xL+E2mTEhridebS8wpe1wUvLLs0ro3cEV7VFSEzT6wSjF/kSVlPQxrUax0njDr0zUP52C
 gKt7aI6ebOqbap08RjcQFygwV6Jis11qtMmkFrNOkF36YTl5IDJ+0vQBY6m91rFG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/23 10:51, Alex Komrakov wrote:
>> +     if (!(pps->info.mode & PPS_CAPTURECLEAR))
>> +             return 0;   Why are you not returning an error?
> [AK] I used the style in this file sysfs.c.
>   assert_show() and clear_show()  have the same condition.
> When '& PPS_CAPTURECLEAR' -- 0 means no interrupt asserted  and it is not error
> Probably Rodolfo can get more info why return 0

It's just as Alex said, if the PPS source has no PPS_CAPTUREASSERT or 
PPS_CAPTURECLEAR mode it should not print ASSERT and CLEAR info.

> And why are these sysfs files even present if the mode is not set
> properly?  Can the mode be set while the device is attached or is this
> only defined at probe time?  If at probe time, just never create these
> files.
> [AK] we can understand mode is set when interrupts asserted and  
> file assert_elapsed will be updated.

PPS source's "mode bits" can be set at runtime via PPS_SETPARAMS.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

