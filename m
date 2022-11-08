Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6B621D58
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKHT7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKHT64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:58:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D153C6CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667937479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RSR7RoU0b/+7lmv0VUCTRtwwQJe3lGysckB67kXlM2I=;
        b=Kxz8J78N7AjvicYCI7SIR+XM5DXYPFX8hZeiZ5fwi88SPb6F+UKo8vfS9deChvvx4s6lhQ
        MCOAqar7AG+cY2vMZFrqoDtp7qLWtbK2+kAOBKB9sA8WPOxyr8qp39Emv5fJn54YLd5fzz
        gd1Aa/Yp3Uq7Y3x0ssrGN61GSTo4lFE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-QlWlFe9qNPe2YBduha1Qzw-1; Tue, 08 Nov 2022 14:57:58 -0500
X-MC-Unique: QlWlFe9qNPe2YBduha1Qzw-1
Received: by mail-ed1-f69.google.com with SMTP id q13-20020a056402518d00b00462b0599644so11453926edd.20
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 11:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSR7RoU0b/+7lmv0VUCTRtwwQJe3lGysckB67kXlM2I=;
        b=AM8e3cE94vF6xO4DgZXZ7Da+LNUYwte+5dr7gPhNuKwQFTQZCc59SVDt7AZ8kvJDOd
         KWXeOtxfXON54bEu+ZBv3/XxRrSkiludS8bTZC1lKvuIhLKlf60Y3SdIVXwQnCCCRyeZ
         SlU6IBTXW/5oBmevXt9AYHCdwo3IrPWfsVvdw0M5RCOJgtm/VhQvIYUXFTCS/ILZ1EkD
         ykFH2aMOaOP5T8S3Xg5UjrUInEulkXvUXgI6J5f8sJ0wcpxhXDSaRFPL/5Q6TTCOsju8
         u1aEgC/nOMYMnFOj3DeOUWwccr6KdLCcKDLCsU0xrgOsPyBrdmEgfTJssMIDBG0LLqOH
         18eg==
X-Gm-Message-State: ACrzQf3Z+XJFQXBxagxKFMGxBtMYKri+f0q/eMrKkfYfFzkUEAe1Itej
        e8D7W6EhZ1AQab9kPGLr1c/kUD0gTtE0u7G4I7hJyJI4hDmGBl58qFhm5EWnwIRzwZ059ZIuceL
        NC13ecfgGHYWqt3Q+ijzT8WBO
X-Received: by 2002:a05:6402:1c0a:b0:463:3cda:3750 with SMTP id ck10-20020a0564021c0a00b004633cda3750mr52173985edb.341.1667937477539;
        Tue, 08 Nov 2022 11:57:57 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7/EXvztwjki8HXi9IfBYEFKcACDK2gkCo4rHMM5Z3uzzi1ZtEy1aQvOJ4cn08gfEXrUdw6Yw==
X-Received: by 2002:a05:6402:1c0a:b0:463:3cda:3750 with SMTP id ck10-20020a0564021c0a00b004633cda3750mr52173969edb.341.1667937477321;
        Tue, 08 Nov 2022 11:57:57 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906210a00b0078d21574986sm4912530ejt.203.2022.11.08.11.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 11:57:56 -0800 (PST)
Message-ID: <c05f7e24-ab3e-f1e8-f553-381755cd5c40@redhat.com>
Date:   Tue, 8 Nov 2022 20:57:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH drm-misc-next v4 0/4] drm/arm/hdlcd: use drm managed
 resources
Content-Language: en-US
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221026153431.72033-1-dakr@redhat.com>
 <Y2VX9Egvh91/u9es@e110455-lin.cambridge.arm.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Y2VX9Egvh91/u9es@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liviu,

> The only issue that I'm seeing that is not critical is that at reboot/shutdown time
> I'm getting an "Unexpected global fault, this could be serious" from the smmu:
> 
> [ 6893.467910] arm-smmu 7fb30000.iommu: disabling translation
> [ 6893.473550] ohci-platform 7ffb0000.usb: Removing from iommu group 1
> [ 6893.479909] ehci-platform 7ffc0000.usb: Removing from iommu group 1
> [ 6893.486931] arm-smmu 7fb10000.iommu: disabling translation
> [ 6893.492521] hdlcd 7ff50000.hdlcd: Removing from iommu group 3
> [ 6893.492650] arm-smmu 7fb10000.iommu: Unexpected global fault, this could be serious
> [ 6893.505959] arm-smmu 7fb10000.iommu:         GFSR 0x80000001, GFSYNR0 0x00000000, GFSYNR1 0x00000000, GFSYNR2 0x00000000
> [ 6893.516511] arm-smmu 7fb00000.iommu: disabling translation
> [ 6893.522195] dma-pl330 7ff00000.dma-controller: Removing from iommu group 2
> [ 6893.529607] arm-smmu 2b500000.iommu: disabling translation
> [ 6893.535221] pcieport 0000:00:00.0: Removing from iommu group 0
> [ 6893.541135] pci 0000:01:00.0: Removing from iommu group 0
> [ 6893.546604] pcieport 0000:02:01.0: Removing from iommu group 0
> [ 6893.552511] pcieport 0000:02:02.0: Removing from iommu group 0
> [ 6893.558418] pcieport 0000:02:03.0: Removing from iommu group 0
> [ 6893.564329] pcieport 0000:02:0c.0: Removing from iommu group 0
> [ 6893.570393] pcieport 0000:02:10.0: Removing from iommu group 0
> [ 6893.576314] pcieport 0000:02:1f.0: Removing from iommu group 0
> [ 6893.582214] sata_sil24 0000:03:00.0: Removing from iommu group 0
> [ 6893.588270] sky2 0000:08:00.0: Removing from iommu group 0
> [ 6893.594616] reboot: Power down
> 
> 
> The reboot/shutdown succeeds, so I'm not too worried about it for now, but hope that
> this is something you'll keep in mind in the later series when you do drm_dev_unplug().

Yes, I'd expect this to be related to the missing protection of platform 
device bound resources.

> 
> With that, for the whole series:
> 
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Thanks for the patience and going through the series iterations with me.
> 
> I can pull this series into drm-misc-next on Monday if you don't have any other plans.
Thanks, I saw you already applied the series.

Have you had a look on the same series for malidp?

- Danilo

> 
> Best regards,
> Liviu

