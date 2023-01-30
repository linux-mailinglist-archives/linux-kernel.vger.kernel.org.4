Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD1E680A05
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjA3Jyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjA3Jya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A724C2D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675072422;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oC9mkSXmhg5R3yB+IPp3y2JMPWQpGEK7krJEALbSb48=;
        b=aRWIa1KHqhrZaCl2kaTXLje9J9S1Vh95ozE/50NRVNcbmU5WjgdU2Rgyg1c+DdI8E1QH2O
        jEJaaoT9REAOuUHRkNHQNacUxLxYK5d8jjEAKIpFoXoowFZKWSv7Nx5RGA6X6B1URDrI6Q
        1SXXLS2rXx2KVRiN6Cff5aQTo8CeRLw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-18--IEcLegZPLiMU61Z-_k_Yg-1; Mon, 30 Jan 2023 04:53:40 -0500
X-MC-Unique: -IEcLegZPLiMU61Z-_k_Yg-1
Received: by mail-qk1-f200.google.com with SMTP id g6-20020ae9e106000000b00720f9e6e3e2so493046qkm.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oC9mkSXmhg5R3yB+IPp3y2JMPWQpGEK7krJEALbSb48=;
        b=CyUADK7M3QUU1wf+ahesGSCEGFKXKZCZsi0Xgi1cFJQ+J59J3nLczDzG3zP6mF0K2L
         jghoL410rKerDWLT0isi0oSwps1QqDuaI428VtzKt25LmL17n1m3GhaPas2IbLLcFWTc
         2HBJGrVkHe/ZeG14of+qA3GjHhjkFpTq7LXguLSqIgEFlpxS5UZFgNoldCh5aJEQnPIQ
         eyk3SAFK1BcHTkqBzVzcgnqI8PVH3pBOuo8bnpav0FVvfRVzjHaYQYhJhItQ00e0EJbI
         6mXoopI2PupzP2rh5c+4gdbjInYwgGT2rDOykkZ+3bunP1fNrnRIpLBxAucz1jROPiwU
         4lNQ==
X-Gm-Message-State: AO0yUKXmENqRr9Idp0MQrBel0SXkPVJNCTTYjIWNyeVbt9pXhePqA6EN
        NIzCtcwNIRxzGooY7Tzlhkdl4jsnOeykNW11Z2lxUFmp3KXkZVpw7zf4hWYFDy6F3/KN3iToCW4
        ryS53zVxsKCKVwJ2Bg/p5TFFY
X-Received: by 2002:ac8:7c53:0:b0:3b9:971d:4e2c with SMTP id o19-20020ac87c53000000b003b9971d4e2cmr389260qtv.45.1675072419921;
        Mon, 30 Jan 2023 01:53:39 -0800 (PST)
X-Google-Smtp-Source: AK7set80CR/nVTtkwCAfEd/IosABre9253z+xcb1dPuLTEZo0Xvm2rHI9QMIYNf/0aiswG0Y3K1ebg==
X-Received: by 2002:ac8:7c53:0:b0:3b9:971d:4e2c with SMTP id o19-20020ac87c53000000b003b9971d4e2cmr389249qtv.45.1675072419670;
        Mon, 30 Jan 2023 01:53:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id b25-20020ac844d9000000b003b82cb8748dsm5345531qto.96.2023.01.30.01.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 01:53:36 -0800 (PST)
Message-ID: <161272ef-eebc-7b86-1290-d0d77f887700@redhat.com>
Date:   Mon, 30 Jan 2023 10:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH] vfio: platform: ignore missing reset if disabled at
 module init
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Tomasz Duszynski <tduszynski@marvell.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:VFIO PLATFORM DRIVER" <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     "jerinj@marvell.com" <jerinj@marvell.com>
References: <20230125161115.1356233-1-tduszynski@marvell.com>
 <BN9PR11MB527630B903EC14BC61351C668CD39@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <BN9PR11MB527630B903EC14BC61351C668CD39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/30/23 10:05, Tian, Kevin wrote:
>> From: Tomasz Duszynski <tduszynski@marvell.com>
>> Sent: Thursday, January 26, 2023 12:11 AM
>> @@ -653,7 +653,8 @@ int vfio_platform_init_common(struct
>> vfio_platform_device *vdev)
>>  	if (ret && vdev->reset_required)
>>  		dev_err(dev, "No reset function found for device %s\n",
>>  			vdev->name);
>> -	return ret;
>> +
>> +	return vdev->reset_required ? ret : 0;
>>  }
>>  EXPORT_SYMBOL_GPL(vfio_platform_init_common);
> It reads slightly better to me as below:
>
> 	if (ret & vdev->reset_required) {
> 		dev_err(...);
> 		return ret;
> 	}
>
> 	return 0;
>
agreed.

Thanks

Eric

