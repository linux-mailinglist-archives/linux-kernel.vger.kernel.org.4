Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F121B62413B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKJLSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKJLSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:18:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD969DE7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668079025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+muvBkZLZGJhUWEuMfjEjy7/lkmMxnkjLutmEjVI01k=;
        b=ccTox6Xj1qvfUHsMn9GK6qL/L6GDpLuJ+Jq09vI4ersh5tF5Cscs/sDtLBTAlJKZQ7JGqr
        OgsG+5Mohz5vhL92/5qU+LbDm+Cv/nWT7HV2D2413WcPt9i0MjM64r7v8QFva/Tihjsd4k
        d/zC4zny+HY1Z2PgKDupCWYZHwe0uw0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-vf4Ffn_WOxO65K3hQrDwIA-1; Thu, 10 Nov 2022 06:17:01 -0500
X-MC-Unique: vf4Ffn_WOxO65K3hQrDwIA-1
Received: by mail-ed1-f72.google.com with SMTP id q13-20020a056402518d00b00462b0599644so1283548edd.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+muvBkZLZGJhUWEuMfjEjy7/lkmMxnkjLutmEjVI01k=;
        b=Vtyn8IKxdTs2QZKQl8j9+y6aW6W0CJVyWtK/yfij1JqOgh9OYHuEyLAFbgu4fL10Un
         wFuxlnPxK8NF8cAF8sZRZWagazOTG94ol2xi9KpB8enzzIoHps9FdQACYrznRpkbKE2M
         8oHuBWqIfS9lbLi2aMr+yR2zAvHj9K6vbYglb2IFiv6zugH0UfEXhZ1bFcqu4VVA4vRM
         SrNCnikTdn3XqgfZ1JbXTVy7vbtzPwY+Zjl5Y2J0FsHWV5P8ju8TBupq8aRAhJPeCUKy
         6by/SrvnvkeeCfq2iVEi1izUWEDc3KdRHI62vRngDBaiWAZUWKMKK0tG+SQEpKaTK+kA
         wc/A==
X-Gm-Message-State: ACrzQf0pmISBWDaI9e4e5ZxYJJesvrPbr0p/iEau22o3cMGk9FbcfY3R
        gIRNGoZqb8SV5OzXMlBExtZATOFIqPx4J5MssNAScF3JqExFQTQoPcJTPbQHziPF81GLRmCS3Re
        OgMGiaAyk1Xh2Iw0OoSCt4gwd
X-Received: by 2002:a17:906:85cc:b0:7ad:db82:d071 with SMTP id i12-20020a17090685cc00b007addb82d071mr2761969ejy.200.1668079020170;
        Thu, 10 Nov 2022 03:17:00 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6FXG985xkGc/06Zy/PC9znx8nG5fUVqvHycIE2C/UkOmnf0vOLDRhVuy1p6ZKwoZ2lx5Oy8g==
X-Received: by 2002:a17:906:85cc:b0:7ad:db82:d071 with SMTP id i12-20020a17090685cc00b007addb82d071mr2761955ejy.200.1668079019930;
        Thu, 10 Nov 2022 03:16:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7d597000000b004638ba0ea96sm8244703edq.97.2022.11.10.03.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 03:16:59 -0800 (PST)
Message-ID: <25cfe9e2-f097-0b5e-9342-1ed6308bbdbc@redhat.com>
Date:   Thu, 10 Nov 2022 12:16:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/3] Bluetooth: btusb: Add a parameter to let users
 disable the fake CSR force-suspend hack
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Swyter <swyterzone@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, luiz.von.dentz@intel.com,
        quic_zijuhu@quicinc.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        Jack <ostroffjh@users.sourceforge.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20221029202454.25651-1-swyterzone@gmail.com>
 <20221029202454.25651-3-swyterzone@gmail.com>
 <CABBYNZKnw+b+KE2=M=gGV+rR_KBJLvrxRrtEc8x12W6PY=LKMw@mail.gmail.com>
 <ac1d556f-fe51-1644-0e49-f7b8cf628969@gmail.com>
 <CABBYNZJytVc8=A0_33EFRS_pMG6aUKnfFPsGii_2uKu7_zENtQ@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CABBYNZJytVc8=A0_33EFRS_pMG6aUKnfFPsGii_2uKu7_zENtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

On 11/9/22 23:39, Luiz Augusto von Dentz wrote:
> Hi Swyter,
> 
> On Wed, Nov 9, 2022 at 1:30 PM Swyter <swyterzone@gmail.com> wrote:
>>
>> On 09/11/2022 21:49, Luiz Augusto von Dentz wrote:
>>> Hi Ismael,
>>>
>>> On Sat, Oct 29, 2022 at 1:25 PM Ismael Ferreras Morezuelas
>>> <swyterzone@gmail.com> wrote:
>>>>
>>>> A few users have reported that their cloned Chinese dongle doesn't
>>>> work well with the hack Hans de Goede added, that tries this
>>>> off-on mechanism as a way to unfreeze them.
>>>>
>>>> It's still more than worthwhile to have it, as in the vast majority
>>>> of cases it either completely brings dongles to life or just resets
>>>> them harmlessly as it already happens during normal USB operation.
>>>>
>>>> This is nothing new and the controllers are expected to behave
>>>> correctly. But yeah, go figure. :)
>>>>
>>>> For that unhappy minority we can easily handle this edge case by letting
>>>> users disable it via our «btusb.disable_fake_csr_forcesuspend_hack=1» kernel option.
>>>
>>> Don't really like the idea of adding module parameter for device
>>> specific problem.
>>
>> It's not for a single device, it's for a whole class of unnamed devices
>> that are currently screwed even after all this.
>>
>>
>>>> -               ret = pm_runtime_suspend(&data->udev->dev);
>>>> -               if (ret >= 0)
>>>> -                       msleep(200);
>>>> -               else
>>>> -                       bt_dev_warn(hdev, "CSR: Couldn't suspend the device for our Barrot 8041a02 receive-issue workaround");
>>>> +                       ret = pm_runtime_suspend(&data->udev->dev);
>>>> +                       if (ret >= 0)
>>>> +                               msleep(200);
>>>> +                       else
>>>> +                               bt_dev_warn(hdev, "CSR: Couldn't suspend the device for our Barrot 8041a02 receive-issue workaround");
>>>
>>> Is this specific to Barrot 8041a02? Why don't we add a quirk then?
>>>
>>
>> We don't know how specific it is, we suspect the getting stuck thing happens with Barrot controllers,
>> but in this world of lasered-out counterfeit chip IDs you can never be sure. Unless someone decaps them.
>>
>> Hans added that name because it's the closest thing we have, but this applies to a lot of chips.
>> So much that now we do the hack by default, for very good reasons.
>>
>> So please reconsider, this closes the gap.
>>
>> With this last patch we go from ~+90% to almost ~100%, as the rest of generic quirks we added
>> don't really hurt; even if a particular dongle only needs a few of the zoo of quirks we set,
>> it's alright if we vaccinate them against all of these, except some are "allergic"
>> against this particular "vaccine". Let people skip this one. :-)
>>
>> You know how normal BT controllers are utterly and inconsistently broken, now imagine you have a whole host
>> of vendors reusing a VID/PID/version/subversion, masking as a CSR for bizarre reasons to avoid paying
>> any USB-IF fees, or whatever. That's what we are fighting against here.
> 
> I see, but for suspend in particular, can't we actually handle it
> somehow?

Note this is not about suspend. This is about a workaround where
we runtime-suspend the HCI once, before initializing it and
then actually disable runtime suspend (unless BT is turned off)
because the USB remote wakeup functionality is also broken
on these.

IIRC the problem was that without the runtime suspend the HCI
seems to work, but any events from the HCI to the host which
are not direct responses to a request from the host, like a known
previously paired BT device trying to connect would not get
registered by the HCI.

At least not until the host actually requested something from
the HCI, e.g. starting a scan for new devices would all of
a sudden cause the known paired device to show up.

My theory here is that during init the Windows drivers at
least runtime suspend the HCI once (or leave it idle
long enough for Windows to do this) and somehow these clones
rely on that for setting up some of their host notification
functionality.

> I mean if we can detect the controller is getting stuck and
> print some information and flip the quirk?

Detection of devices which need the "runtime-suspend once"
workaround is almost impossible since the problem is the
lack of unsolicited messages from the HCI, which can be
normal if no BT "clients" are in use during probe.

> Otherwise Im afraid this
> parameter will end up always being set by distros to avoid suspend
> problems.

The flag is Swyter is suggesting is actually to disable
the workaround, which is currently enabled for all
USB BT dongles identified as being a CSR clone.

Most clones work fine with it, with many needing it, but some clones
seem to not like the workaround and behave undesirable if we runtime
suspend them once. So the flag is to disable the workaround to make
these last 5% of these (really cheap, bottom of the barrel quality)
clones work.

Since 95% of the clones do work with the workaround distro's enabling
the flag by default would be a bad idea and I don't expect them to
do this.

Regards,

Hans


