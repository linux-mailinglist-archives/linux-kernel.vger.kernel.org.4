Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E270C6DA58C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbjDFWJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDFWJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:09:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6EEA5FF;
        Thu,  6 Apr 2023 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680818943; i=w_armin@gmx.de;
        bh=qmJ+/4Ue3g8o1CJoMn072vsDbsMK1C8ZG190Qee5Pjk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H3BNdBYaUQ9zyPrSBzSYq8+6g+31OuysHz/87jDHkf32TYXnd7cUAtoUgpK4/RrRv
         gSNJVwBt24FQcDRZIX1evJ75B3lKJiOPiKADOnpQzKKOPtn7pQddEE1l7+JwfOeS3S
         M6KwApkGdEkeVlop/mPqaR8GgsFSfIt8e4ZdG2hy++/GWFyMEibaWzyHD7Q29lrxvH
         K1mlGj24ccbsiB8ROqYKieZtzlm4HHBWdlnmVC5qiE/pNznKNm+5imquQZIsaOsb2R
         tTrvf/zsuz27x6t+zJpTygLjChwjOE6waZkYv+1h+g+3YmgKg3/SoI6iFa7lw+keoJ
         dVhrm2UUdTB2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1pjRrH0XhM-001Dff; Fri, 07
 Apr 2023 00:09:03 +0200
Subject: Re: [PATCH v3 0/3] ACPI: SBS: Fix various issues
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230324202628.76966-1-W_Armin@gmx.de>
 <CAJZ5v0g8K6wHpefig=2RNspp018FqYiZQoCP3hEScJwM4HY7qw@mail.gmail.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <7ec1350e-6584-ed7a-d25a-75136b0ba966@gmx.de>
Date:   Fri, 7 Apr 2023 00:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g8K6wHpefig=2RNspp018FqYiZQoCP3hEScJwM4HY7qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:yq7pYDrVqO8RtoCbi07Ilfa+mT7SbdD5DD7R15xqlQ66dqOi47M
 5Zfs7twqk6u9l0b/cd0gztSbJRjuYkUOrH7OBk487P1PSN5jYGu4WkEUqEqcXMexK5yd+sI
 FKpAxqC6WrQg6F801Tym+cDWPOT1wtgAtiRTLCnhs2nh1pXLnI+lB9uJ3rFvr9LR3JaaDSH
 Nk4n2NJssR/9jj+MKi37Q==
UI-OutboundReport: notjunk:1;M01:P0:fEMb9ahVljo=;Sxdw0v4WVC+yzMKs6zBWK2U/1l0
 gvmjw0KuADgIEM4h5Z+KbqZA5iNVIPPMivp65HWlF0UPChUloYz2aMwV145Vq3VTA6s0R2QPO
 jfcYi6wANB+LaPRXX/JE9ZZzb/bEeDGlKdy+8EEEQcDHxTIz/Si003bZr9cg23RGQ+oFFF8k7
 ghtt2XLVqhTqWlG17TO9LeH4Gcv/NeTeWA0BLwVRKyRqXEfGLmBtdj+Edn0rLZtZEw1dOI2vm
 Jrfr+2BlNOCB75O7kVl3XVoaWLgATL4BahES9hDvE4R6w8m1jiY1Nm+tY3KgfLXNIu/D2yqCn
 0rQWz6htr/g4cCp1c1PElrju82/uokN6xfq+XbLvy1kIjd5n2Unw1JUhX69Z/7dqKjq1Ik7kP
 J28PjXxCqOSQ71fr/6Xk8hekD+ABmuLlGkHHQUHmzvYtFCnRhKummYo/H4pCmvMpEyfkO5Ny5
 AiIaCChSFGWogSejp2BGfVOLfKMAQaMC263IFrpFNWhW4Bh4eq4nhYaE/UXkWMZ+bWabt1LNr
 UHJwz1NoPn7o9VYwbCePiSF9gP9GI5DvG+hhk4RbF3oyDqvL3x4gFAgUgOWqmi5LvYxqfjN8c
 AwdozyN201Q55s7SYdgd7wJvPBxZEOC7qH9KQn4fE6CcBvzEgPbp0AJCeXxx1KaDGpFctiazO
 o/GxnNpMz+7g+iQAbwgOG3Uh1WubD65huIQifqbWitKxeMCQQ1JYODl9pLld921ULZizIrAcx
 9pp/8RiNbIcg/xId/I3CwvYbEIZ6JL4llPH4iyI3gBa+/2pwv5rbT903tew5dJMsUlRBBrzKw
 DiTo8+Abpm8eRvLrFs+MbEVd7CRqYuGMphwABsu/T0of13xctysnCduH1LMjcC/wTl+3QJVac
 UofgBU8fZGN0Cjt/0vlD1D3fflwTwqg2yeqshXcc8yBwrFWxqLJi4y/LpoU43yqZsuU0/S+TL
 A+XEWg==
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.03.23 um 19:02 schrieb Rafael J. Wysocki:

> On Fri, Mar 24, 2023 at 9:26=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> On my Acer Travelmate 4002WLMi, the system locks up upon
>> suspend/shutdown. After a lot of research, it turned out
>> that the sbs module was the culprit. The driver would not
>> correctly mask out the value used to select a battery using
>> the "Smart Battery Selector" (subset of the "Smart Battery Manager").
>> This accidentally caused a invalid power source to be selected,
>> which was automatically corrected by the selector. Upon
>> notifing the host about the corrected power source, some batteries
>> would be selected for re-reading, causing a endless loop.
>> This would lead to some workqueues filling up, which caused the
>> lockup upon suspend/shutdown.
>>
>> The first patch fixes an issue inside the ec driver regarding the
>> removal of query handlers discovered thru ACPI. The second patch fixes
>> a kernel oops on module removal caused by a race condition when removin=
g
>> custom EC query handlers. The last patch finally fixes the
>> suspend/shutdown issues.
>>
>> As a side note: This was the first machine on which i installed Linux,
>> to finally fixing this took ~5 years of tinkering.
>>
>> Tested on a Acer Travelmate 4002WLMi.
>> ---
>> Changes in v3:
>> - Rework solution for the kernel oops on module removal
>> Changes in v2:
>> - make acpi_ec_add_query_handler() static to fix warning
>>
>> Armin Wolf (3):
>>    ACPI: EC: Limit explicit removal of query handlers to custom query
>>      handlers
>>    ACPI: EC: Fix oops when removing custom query handlers
>>    ACPI: SBS: Fix handling of Smart Battery Selectors
>>
>>   drivers/acpi/ec.c  | 17 ++++++++++++++---
>>   drivers/acpi/sbs.c | 27 ++++++++++++++++++---------
>>   2 files changed, 32 insertions(+), 12 deletions(-)
>>
>> --
> All applied as 6.4 material with a minor comment adjustment in the first=
 patch.
>
> Thanks!

Thank you!

