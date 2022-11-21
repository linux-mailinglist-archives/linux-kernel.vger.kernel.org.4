Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6246632705
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKUOzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKUOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:54:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B94CDA4FF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669041841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvsBImsu/BbpivoFIissXZCk1tsGDBqdresNn8IaQpg=;
        b=VpIgQfeWQsSBpoHxHI0NVwow6tuMoVPwBGdxLbSMOZuEpNqEVNaLcrEMdBFeVsbg2Uz3CN
        aBEXn8pl6cZvGhjM8g0OJxzpzfgtrl2z+409wWmScDY6S5LZPxWsCRy4lYaXFNweDZbJyY
        ErHGEBqSPOt3opvLkgt8RXlV1n7OJtY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-7-saa78LnKOV-qq_b3KC-unA-1; Mon, 21 Nov 2022 09:40:49 -0500
X-MC-Unique: saa78LnKOV-qq_b3KC-unA-1
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a056402359200b004635f8b1bfbso6995083edc.17
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvsBImsu/BbpivoFIissXZCk1tsGDBqdresNn8IaQpg=;
        b=HufKt7Sv1KDkoERbrDrMqhHlCXJjMzCK2SdveJV4mL0Frpn54Ms2ljPA3Au9Mh4wMK
         DV7ApGuMki4kyFzhxGfNZA5MUoxeOQ1DzE6FfUVe3DiO9eMIx3CKvoWSjcwBhMmRubVZ
         83ONoSTh+/l6A/lwcMTSApCD8u14ye94aS+A7ouWZRS0fcUt6FWkLAcBbpnsKpQdVLlZ
         Wu+jXvQeR2bavqRxrFdaT1cQ4Kgk6hj3xe4/68TbG2PGCM4QST5HcnOafg1QrOs9tRJI
         eN48Dh3IH6t1/6ExzLpo+kgNRd6L5HJkD7AEpmZPYQBwbHeoV2b6hDQJPmAV8Ndz6Tgy
         Fo4w==
X-Gm-Message-State: ANoB5pm5rq24KMycmbxjOjjplgw6KM3rZZ6pFZnUGRLDLpxw8YO5vgI/
        Xvwnf2u004jAhfwC1bfgDd7dWU/LZTZ/G5TzhJP3t12LqBBjq1wpC24OpetpMpGIvkP/4YV4XU2
        YXiIfnx85+ZRi8e7qFsWx2i2d
X-Received: by 2002:aa7:c7d5:0:b0:44e:bee5:4242 with SMTP id o21-20020aa7c7d5000000b0044ebee54242mr3206798eds.128.1669041648605;
        Mon, 21 Nov 2022 06:40:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6doXWveL5eTRZgqwC3+y1yNawxc5ciMGkg1djT6qXLkcVEcPZTjJAgWi/2CTjBojbqOYsqEg==
X-Received: by 2002:aa7:c7d5:0:b0:44e:bee5:4242 with SMTP id o21-20020aa7c7d5000000b0044ebee54242mr3206783eds.128.1669041648454;
        Mon, 21 Nov 2022 06:40:48 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906805400b007919ba4295esm5089993ejw.216.2022.11.21.06.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 06:40:47 -0800 (PST)
Message-ID: <1d838451-5bd0-96c2-b341-d991e920ef34@redhat.com>
Date:   Mon, 21 Nov 2022 15:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 2/4] media: ipu3-cio2: Convert to use
 software_node_register_node_group()
Content-Language: en-US
To:     Dan Scally <dan.scally@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
 <20221118185617.33908-2-andriy.shevchenko@linux.intel.com>
 <2c69ae41-7920-1438-8bfc-8581aad0ee00@ideasonboard.com>
 <93eb74bf-58c4-1a77-af2f-3a0df4404acf@redhat.com>
 <Y3tSj20qwJZ23VAY@smile.fi.intel.com>
 <f02b5a25-9263-f396-14de-3a7781835222@ideasonboard.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f02b5a25-9263-f396-14de-3a7781835222@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/21/22 15:32, Dan Scally wrote:
> Hi Andy and Hans
> 
> On 21/11/2022 10:27, Andy Shevchenko wrote:
>> On Mon, Nov 21, 2022 at 11:22:17AM +0100, Hans de Goede wrote:
>>> On 11/21/22 11:19, Dan Scally wrote:
>>>> On 18/11/2022 18:56, Andy Shevchenko wrote:
>>>>> The currently used software_node_register_nodes() is going to
>>>>> be removed. Prepare driver by switchich to new API.
>>>> Also looks good to me:
>>>>
>>>> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
>> Thank you!
>>
>>> Any chance you can also give this series a test run on an IPU3 device to
>>> ensure that it does not cause regressions ?
>> Yes, it would be really appreciated!
> 
> All seems fine (including the kunit test) - you can add
> 
> 
> Tested-by: Daniel Scally <dan.scally@ideasonboard.com>

Great, thank you!

Regards,

Hans

