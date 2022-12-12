Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925AB64A86F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiLLUJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiLLUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:09:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2D713F68
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670875718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YaZJ2CbuwgbVkA0RaNPOuvEHLL5fDjsyd+GSBlWjRpw=;
        b=KMyEkILjh0CPco/1PnySBcim+0HywYYFWij7xHNhETzYUOwmbInDlZKlXVJdmm1UpiVPdl
        wADdrChMP3yEhKdLeQePQbBNaU8MkSs6Lv+EwZjn8e2EQwUm4Ohl9aZnu8nwmXWrH77qvS
        rAPsiTOV3tf6MAMwanD21u+Q9j73QUs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-GCRAmxgjP5CDBR8UkXrNIQ-1; Mon, 12 Dec 2022 15:08:36 -0500
X-MC-Unique: GCRAmxgjP5CDBR8UkXrNIQ-1
Received: by mail-pf1-f200.google.com with SMTP id d3-20020a056a0010c300b005728633819aso535811pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaZJ2CbuwgbVkA0RaNPOuvEHLL5fDjsyd+GSBlWjRpw=;
        b=DWT2ZvqzqTLNCO1VgWuxhBgSVcJOPDvnHCt+9pnE/kMh9oLB3378hDVSVnXu4usmC7
         lm+l6h4vBQJOP9BjEJIIv0rmir121GZ0rYXUifsyATDk+hB4IX8f6XrcIHoIEoKjYwRb
         Xyscikj/bl7VC8IR0rvKAPy0BAfx98jj5CmjdGZKViWDchecvD7xFf3t0FUaQRdqyeLb
         0W30AjDwIOoh4zXnHyQHhjt8chdFBqjKgNg1zXQYE/3c+2dfak5xQgkNWSt8HOdqf0ic
         vuIdKlUeeO/6XTCSGbReh4ZXqqmmWtYj936/tSy2KzJ2vRFHGwxmC3me6gRHNM3d+jeq
         mzlw==
X-Gm-Message-State: ANoB5pkJpLysH8JxFHcrxDGmDAbKNmWyUpcp4kNCIXtcq4LW/EjhMSBv
        +WkWBAJAvh/x/ucpvJActilmYVJeUFBYVPmoOnixVPIg6Bf9PWknBT3UuCFExijd8HSl8WQNx4U
        8SIn88/vAAn9DUfxfccCgMz3O
X-Received: by 2002:a17:903:330d:b0:18f:9b13:5fc2 with SMTP id jk13-20020a170903330d00b0018f9b135fc2mr5062476plb.52.1670875715546;
        Mon, 12 Dec 2022 12:08:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5PgguEbNlLff9osZLyrIpiz5jOnV9NboISKen6lqRkFFaH0SwHvKt92C9RtgsGoxpGSP0V6Q==
X-Received: by 2002:a17:903:330d:b0:18f:9b13:5fc2 with SMTP id jk13-20020a170903330d00b0018f9b135fc2mr5062456plb.52.1670875715285;
        Mon, 12 Dec 2022 12:08:35 -0800 (PST)
Received: from smtpclient.apple (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b00186b3528a06sm6799683plx.41.2022.12.12.12.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 12:08:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] idxd: avoid deadlock in process_misc_interrupts()
Date:   Mon, 12 Dec 2022 13:08:23 -0700
Message-Id: <446A5C1E-E50B-4270-9781-5D945109541E@redhat.com>
References: <IA1PR11MB6097183F44E96BE3FAF119DA9BE29@IA1PR11MB6097.namprd11.prod.outlook.com>
Cc:     linux-kernel@vger.kernel.org, "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
In-Reply-To: <IA1PR11MB6097183F44E96BE3FAF119DA9BE29@IA1PR11MB6097.namprd11.prod.outlook.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (20B110)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2022, at 11:47 AM, Yu, Fenghua <fenghua.yu@intel.com> wrote:
>=20
> =EF=BB=BFHi, Jerry,
>=20
>> idxd_device_clear_state() now grabs the idxd->dev_lock itself, so don't g=
rab the
>> lock prior to calling it.
>>=20
>> This was seen in testing after dmar fault occurred on system, resulting i=
n lockup
>> stack traces.
>>=20
>=20
> Please add Fixes: cf4ac3fef338 ...
>=20
>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Cc: dmaengine@vger.kernel.org
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> ---
>> drivers/dma/idxd/irq.c | 2 --
>> 1 file changed, 2 deletions(-)
>>=20
>> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c index
>> 743ead5ebc57..5b9921475be6 100644
>> --- a/drivers/dma/idxd/irq.c
>> +++ b/drivers/dma/idxd/irq.c
>> @@ -324,13 +324,11 @@ static int process_misc_interrupts(struct idxd_devi=
ce
>> *idxd, u32 cause)
>>            idxd->state =3D IDXD_DEV_HALTED;
>>            idxd_wqs_quiesce(idxd);
>>            idxd_wqs_unmap_portal(idxd);
>> -            spin_lock(&idxd->dev_lock);
>>            idxd_device_clear_state(idxd);
>>            dev_err(&idxd->pdev->dev,
>>                "idxd halted, need %s.\n",
>>                gensts.reset_type =3D=3D IDXD_DEVICE_RESET_FLR ?
>>                "FLR" : "system reset");
>> -            spin_unlock(&idxd->dev_lock);
>>            return -ENXIO;
>>        }
>>    }
>> --
>> 2.37.2
>=20
> Thanks.
>=20
> -Fenghua
>=20

Hi Fenghua,

I think this was merged back in August. Not at my system to get the exact da=
te.

Regards,
Jerry=

