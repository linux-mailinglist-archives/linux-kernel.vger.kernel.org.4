Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF386E4995
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjDQNMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjDQNLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE0A5C6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681736945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9MqaIYBLmFSm1ptnAL0Yl/d5VMKemh+p/YpkWEA8fl0=;
        b=GcB7I3qlu6PhzEuJjk50vYiM0WsvO/SRKXt9witQGa1y3ya05XxsnF+KA/yZDJ/7TerFzB
        WlPd8PQ//PhQLRzv9tlPAKcqt952HzaAeCqv7UY389h3/JSHeBXyirMatHW37wsEY0+wNu
        VKgKw0CxbX24d9i4oNeQ881xDcdXRDQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-KBnLrAxHPxu7vGh_0GoLXg-1; Mon, 17 Apr 2023 09:09:04 -0400
X-MC-Unique: KBnLrAxHPxu7vGh_0GoLXg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50489dce38aso3497663a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681736943; x=1684328943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MqaIYBLmFSm1ptnAL0Yl/d5VMKemh+p/YpkWEA8fl0=;
        b=JQDSRrgpa3fv32tS0DWB5WpAQNo/K1/0VG/Z4dAysoh/6sN/FeOqJHLG39JRKlXgwk
         y9Ih3kkQ5aR92T6mPsVMyJPV9+pMmk6M1q1A5wTWdeU6GLyazAzHUKpfd8B7jIuuBmiu
         3jc1pHdE9/CC57r9ck4chwKqRL6aTtmHVXi0uODSEheLRn4RrFfC5U9CqVL6rZjoqAj6
         k8+2hKxG/nVb4jES2M/wtUUfqadZ/s3z163e6mky7q2bS1IDg8RsQn3oMBxlLhyTtztR
         Smu4lnhL2XDBDQ2jfPP9kj3lLTXruIeJaXbx6qRkmVvo0xqx77FHcBXoY/19cpWmLyBj
         wGGg==
X-Gm-Message-State: AAQBX9dccSp4ohChsXWgZPueq/JxNAxWfivRU4dif9NQPs+Bdu04RYmE
        PUfXToLDUkFqhKMrxpmNW55pj9Yv8ecyKKR/elGGof54qn2q6pQwKAbbS/vxP/iPUZ1SsAZIlTv
        GSNgC/2UbI2+jyw6cjF8BYuJB
X-Received: by 2002:aa7:c907:0:b0:504:a1ca:d1c2 with SMTP id b7-20020aa7c907000000b00504a1cad1c2mr12675746edt.26.1681736943298;
        Mon, 17 Apr 2023 06:09:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YbGT/yxZBrEaHuOZ/5jMmArjdzKRtRBUSnKAl2eyk95b/tIr4RS0p6dt4n0eaYbKF3JB64bg==
X-Received: by 2002:aa7:c907:0:b0:504:a1ca:d1c2 with SMTP id b7-20020aa7c907000000b00504a1cad1c2mr12675727edt.26.1681736942977;
        Mon, 17 Apr 2023 06:09:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b0050477decdfasm5779306edb.3.2023.04.17.06.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:09:01 -0700 (PDT)
Message-ID: <ab900b77-5e8f-4a4f-7e0f-c3358b784c01@redhat.com>
Date:   Mon, 17 Apr 2023 15:09:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Lenovo
 Ideapad Z470
Content-Language: en-US, nl
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230417104817.30254-1-jirislaby@kernel.org>
 <CAJZ5v0iYRxGLWgiTD5ouWLy84YN4ddnVshCNgiYJMbLdpK_ZRA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0iYRxGLWgiTD5ouWLy84YN4ddnVshCNgiYJMbLdpK_ZRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/17/23 13:40, Rafael J. Wysocki wrote:
> On Mon, Apr 17, 2023 at 12:48 PM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>>
>> From: Hans de Goede <hdegoede@redhat.com>
>>
>> The Lenovo Ideapad Z470 predates Windows 8, so it defaults to using
>> acpi_video for backlight control. But this is not functional on this
>> model.
>>
>> Add a DMI quirk to use the native backlight interface which works.
>>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1208724
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Hans, can you please give your S-o-b for this one?

Hmm, I do not believe that I wrote this patch
(also see the suse bugzilla link in the comment it adds) ?

I guess it started as a copy of my "ACPI: video: Add
backlight=native DMI quirk for Acer Aspire 3830TG" patch
and that is why I was kept as the author ?

Anyways I'm fine with me being the author, or with Jiri
being the author. Pick a tag depending on the answer:

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans






> 
>> ---
>>  drivers/acpi/video_detect.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
>> index 69ef2d9710c2..af5cea005f54 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -459,6 +459,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>>                 DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
>>                 },
>>         },
>> +       {
>> +        /* https://bugzilla.suse.com/show_bug.cgi?id=1208724 */
>> +        .callback = video_detect_force_native,
>> +        /* Lenovo Ideapad Z470 */
>> +        .matches = {
>> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +               DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Z470"),
>> +               },
>> +       },
>>         {
>>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
>>          .callback = video_detect_force_native,
>> --
>> 2.40.0
>>
> 

