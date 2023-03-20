Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2453E6C0CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCTI7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjCTI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:59:46 -0400
Received: from smtpdh19-1.aruba.it (smtpdh19-1.aruba.it [62.149.155.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD724113E3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:59:41 -0700 (PDT)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id eBMgpEZyvnXXEeBMgpM5nB; Mon, 20 Mar 2023 09:59:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1679302778; bh=Cq5Dye8X8O5trw79lQdPEWPbKgS8o+caztlPpau7VzQ=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=cCDs2P8kSEWkiruSOrTLmKFg7Cs9c77fM6PVAt/uvhqix7yADtPNf+zUOXSFcfoaR
         mzQX0zJfICWIQ3k1N1XyWmmIN9Wa9RIBplxsL4Dh9Lqt5E1+JaYNFBc5rykJJ5B/Qn
         BSXTheyPitQnxM/Fr5kSwQvQU1jKNJLbALh0q5a8T4JJd/MmbwGLUR2vZUzZiZViUG
         Sdx1JnS6YW93V3c5USUnN4i4yndeUgxQRg/n1j+DWr44YJ+9TW6kFhMaWMPJ93C67M
         UkPEBOJxGxlgNwA9h7Hhbv5ReKGtkB0ZYDkdhczEx3LkFIBxAgI6qwz66326kd9lv/
         bZvcN9WiSMglg==
Message-ID: <9febcd8e-bc03-8ad9-3f22-ffdeeb92e512@enneenne.com>
Date:   Mon, 20 Mar 2023 09:59:38 +0100
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
 <f8ea9ab9-e1c1-7962-dab4-126beda74046@enneenne.com>
 <ZBSeGjBEEzeBv35c@kroah.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <ZBSeGjBEEzeBv35c@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKrHUnG4hqwdF3LKKFwEcp5HTw8Ou7w7yQLpsmhwk8FjQe1ZAUHKqj+GLH1ACkXDD3/Y94Cuyt/i5xIT/FVb/5VafQUqdUZHBcqHGkoA1sQ52TPfoQiO
 Nt2N7Zupq5w90pTIQlmoa9eVUfClPDdjlKM2+rvATOLDPGfVtvvZ3IbogtZFuW/6xpOeQnnuoOy8Sk80enxA7R5kSYHfeGQuz71rpMnzrF2mQi8N+9VLy4Tq
 agzixRZElJJZbvGRXvdBEwGz3ZFYQV48JhiDgMZG2D4BD1eoWH+C4VxoIr6vkhgS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/23 18:06, Greg KH wrote:
> On Fri, Mar 17, 2023 at 05:34:28PM +0100, Rodolfo Giometti wrote:
>> On 17/03/23 15:22, Greg KH wrote:
>>> On Fri, Mar 17, 2023 at 03:04:31PM +0100, Rodolfo Giometti wrote:
>>>> On 17/03/23 10:51, Alex Komrakov wrote:
>>>>>> +     if (!(pps->info.mode & PPS_CAPTURECLEAR))
>>>>>> +             return 0;   Why are you not returning an error?
>>>>> [AK] I used the style in this file sysfs.c.
>>>>>     assert_show() and clear_show()  have the same condition.
>>>>> When '& PPS_CAPTURECLEAR' -- 0 means no interrupt asserted  and it is not error
>>>>> Probably Rodolfo can get more info why return 0
>>>>
>>>> It's just as Alex said, if the PPS source has no PPS_CAPTUREASSERT or
>>>> PPS_CAPTURECLEAR mode it should not print ASSERT and CLEAR info.
>>>
>>> But shouldn't you return an error instead of an empty string?
>>
>> This is not an error... it's just a disabled capability. :)
> 
> Then maybe return "0" or something like that?

Yes, it could be a valid solution.

>>>>> And why are these sysfs files even present if the mode is not set
>>>>> properly?  Can the mode be set while the device is attached or is this
>>>>> only defined at probe time?  If at probe time, just never create these
>>>>> files.
>>>>> [AK] we can understand mode is set when interrupts asserted and
>>>>> file assert_elapsed will be updated.
>>>>
>>>> PPS source's "mode bits" can be set at runtime via PPS_SETPARAMS.
>>>
>>> Ok, that's good to know.  But I think the error return value is a better
>>> indication that something went wrong here and this attribute does not
>>> work for this device at this point in time.
>>
>> I see... however I suppose several code relays on this behavior.
> 
> If that's the case, then you are right, you can't change it, and I'll
> stop complaining here :)
> 
> What tools use these sysfs files?

Mainly are debugging tools via scripts. Normal usage should be via C API.

> How did you test your changes?

As above, I use scripts whose get access to sysfs to test a PPS source 
functionality. Regarding the C API I use the pps-tools:

https://github.com/redlab-i/pps-tools

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

