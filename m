Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10B70F1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbjEXJJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbjEXJJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8A212B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684919315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Ba3cVMN5JYb7eY+YLCMjuGa5u5FrljiykCHYgPsetc=;
        b=Z7i17bKd0HCxeQuCsEqI7KfcNnHm+RocW5huI6X4X4BPn99jhI4k+TUyBGnYXy7VRLrWS7
        //gc8ZSyKI0/RcwTwLtDbt3xKl95mbuy8I30NeYvVKErqS/pnzS3Uv/DeJAy+nsWBc9+Jt
        Vu941+h8waVAQDJSp0KY3A0Sd7Ss1qI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-O72GTlDhMay1qBXBt54qmQ-1; Wed, 24 May 2023 05:08:30 -0400
X-MC-Unique: O72GTlDhMay1qBXBt54qmQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-510ddadbec6so939618a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684919309; x=1687511309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ba3cVMN5JYb7eY+YLCMjuGa5u5FrljiykCHYgPsetc=;
        b=hcCNDrM2iFroef91G3vyzylDc+WNaPNvj+yPLf2XEjyIez1huixtlzyLsJZaRBqcaZ
         8Cf7kG7M2kUZHHs8+uO1SkkBz9Nwz+SsdDFbD4DJ5GwiJTf81sxcKzdDEpeXyAbP0XGA
         GsbLYIIGwVoLGF6GAppYfq/wjTO2fds66oPGDMi/ry3CrXtN0flJkWMkTswTpIznQ8NK
         OyzmXewn1SgwdOaTVpiur8j92v+cKO4vpbWQqJwaVzoMVffr15OfVfNzaPn2liIWOfEH
         VMqB6vTDB9s48WLEHlQgitnLGM9L0iqE6Vgz3CMlJODOtH7khAt5tgh1slmxmzQ6esiw
         ojCQ==
X-Gm-Message-State: AC+VfDxo24fi3mm+HWp1HeDVZSrHBjpMhc2HGz+4EWqwwawxuwMSjydD
        yhcGC9bPCjDsd723Bt6D7BYF8gKkEdRay8LG7Am2YdGiqQktHY1TVrBylZhSiF3wut9KemFrn2y
        sdBw5pftQnhmPQ1Z45AugZ2Cp
X-Received: by 2002:a17:907:7ea3:b0:96a:57fe:3bfb with SMTP id qb35-20020a1709077ea300b0096a57fe3bfbmr17636581ejc.26.1684919309216;
        Wed, 24 May 2023 02:08:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73F3kbO0SmGWBsYMmVzety237b+nVthkK/CLP2W6JhWQfl6pbCE7hOBDeO04CB7wWiFaOCXg==
X-Received: by 2002:a17:907:7ea3:b0:96a:57fe:3bfb with SMTP id qb35-20020a1709077ea300b0096a57fe3bfbmr17636561ejc.26.1684919308953;
        Wed, 24 May 2023 02:08:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090607cd00b0096f603dc8ddsm5561226ejc.142.2023.05.24.02.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 02:08:28 -0700 (PDT)
Message-ID: <4f9e3da1-5cfa-c3cd-a8e5-f97a2dd1cede@redhat.com>
Date:   Wed, 24 May 2023 11:08:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Content-Language: en-US, nl
To:     Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, jsnitsel@redhat.com,
        oe-lkp@lists.linux.dev, lkp@intel.com, peterz@infradead.org,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
 <20230523074443.GA21236@wunner.de>
 <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
 <20230523151642.GA31298@wunner.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230523151642.GA31298@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 5/23/23 17:16, Lukas Wunner wrote:
> On Tue, May 23, 2023 at 12:14:28PM +0300, Péter Ujfalusi wrote:
>> On 23/05/2023 10:44, Lukas Wunner wrote:

<snip>

>>> The corresponding message emitted in tpm_tis_core_init() for
>>> an interrupt that's *never* asserted uses dev_err(), so using
>>> dev_err() here as well serves consistency:
>>>
>>> 	dev_err(&chip->dev, FW_BUG
>>> 		"TPM interrupt not working, polling instead\n");
>>>
>>> That way the same severity is used both for the never asserted and
>>> the never deasserted interrupt case.
>>
>> Oh, OK.
>> Is there anything the user can do to have a ERROR less boot?
> 
> You're right that the user can't do anything about it and that
> toning the message down to KERN_WARN or even KERN_NOTICE severity
> may be appropriate.
> 
> However the above-quoted message for the never asserted interrupt
> in tpm_tis_core_init() should then likewise be toned down to the
> same severity.
> 
> I'm wondering why that message uses FW_BUG.  That doesn't make any
> sense to me.  It's typically not a firmware bug, but a hardware issue,
> e.g. an interrupt pin may erroneously not be connected or may be
> connected to ground.  Lino used HW_ERR, which seems more appropriate
> to me.

This issue seems to have mostly been seen on x86/ACPI systems and
the issue seems to mostly be a misconfiguration of the IOAPIC
(e.g. wrong trigger type).

Besides this, the IRQ info always comes from either the ACPI tables
or from devicetree both of which are firmware and if the IRQ does not
work on a specific board then the firmware should simply not provide
any IRQ info to the driver rather the pointing to a broken IRQ.

Hence my suggestion to use dev_warn(dev, FW_BUG "....", ...);

Regards,

Hans


