Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074756FC355
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjEIJ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjEIJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA05830E4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683626208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oaTOQ0K27eQKF5yA9KfJtjHQBDHHdEjUJFt7kiZHIPo=;
        b=ETlcmeKfmSpmxQcLtbkNMgclOoIk9w3c4tWs5iXt/UBcE/MfVDTBA8UWuy0n2VEjo1emI2
        NFhgKeoHM6TnTpo3JZZDzcN1kZ1goe5AT2w1FLk4b20f8+lwts/hnd74RtnPft9q0mrYz/
        F+dg2+6Z/RNomSd5rkkldMl8/8I/yIs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-gwLvPgUGNmKdwVfu_4sKVQ-1; Tue, 09 May 2023 05:56:44 -0400
X-MC-Unique: gwLvPgUGNmKdwVfu_4sKVQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-50bcb45f749so5340380a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683626202; x=1686218202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaTOQ0K27eQKF5yA9KfJtjHQBDHHdEjUJFt7kiZHIPo=;
        b=SEGGV4aaVe825Xkz9I84e3qjuoZhBas8/rqdLXBIHVFtB4PDQsKoAHKhH6a5MH3iiN
         g5x5BI6LjuIIXWc83DTtviekI8YovfToX4lYnM3LYLhdM3FQ0LaAur902+2/TNSshrtl
         y6aLP2f4iMQWQebiZ7isgHnHC2FEbuJlcjVAKIvK2gqWSzJ8dk3dY04alUXQW3m4wG3C
         4Mw1AHjmvJ7vz7Q56kC7MCCrtl3pZYESz0AKpsJxBQrzanXzPywE7UXEHNGV8xM6XhUz
         OU4IqgTql27anP9VR8f1tDucNduYzryf9jxuprB/tR/7yuiPYMBF3frFUSfYCHL5lwKV
         JsTQ==
X-Gm-Message-State: AC+VfDzHX4IpdXzhhiO4+is2/ad7gRlG3vTFd9N5Dq6OVW9rdw2443V+
        /CcNrncMANKqTJerQXtl3wQLtgeAIPxNDnxusguPj4zZZPMStPAc6qRHssVdsCdtCAOAiG7HG6N
        5OZw/q4E9E6QBA9lroKIrPkp7
X-Received: by 2002:a17:907:2d12:b0:969:98eb:3fdd with SMTP id gs18-20020a1709072d1200b0096998eb3fddmr3682171ejc.3.1683626202557;
        Tue, 09 May 2023 02:56:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pX3yMA1Jb7LATaSK68YRIv0ateTECpkbTpTf2fAXJwsPe5XwUK84/dvwoM1fY/s2nzL6R5w==
X-Received: by 2002:a17:907:2d12:b0:969:98eb:3fdd with SMTP id gs18-20020a1709072d1200b0096998eb3fddmr3682154ejc.3.1683626202221;
        Tue, 09 May 2023 02:56:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j16-20020a1709062a1000b0094ed3abc937sm1106953eje.82.2023.05.09.02.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 02:56:41 -0700 (PDT)
Message-ID: <4a2a701c-f764-8b98-015f-0aee776d921f@redhat.com>
Date:   Tue, 9 May 2023 11:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/1] platform/mellanox: fix potential race in
 mlxbf-tmfifo driver
Content-Language: en-US, nl
To:     Vadim Pasternak <vadimp@nvidia.com>,
        Liming Sun <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Mark Gross <markgross@kernel.org>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <b98c0ab61d644ba38fa9b3fd1607b138b0dd820b.1682518748.git.limings@nvidia.com>
 <BN9PR12MB5381316B1E76612838BBB762AF769@BN9PR12MB5381.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BN9PR12MB5381316B1E76612838BBB762AF769@BN9PR12MB5381.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/9/23 11:35, Vadim Pasternak wrote:
> 
> 
>> -----Original Message-----
>> From: Liming Sun <limings@nvidia.com>
>> Sent: Wednesday, 26 April 2023 17:24
>> To: Vadim Pasternak <vadimp@nvidia.com>; David Thompson
>> <davthompson@nvidia.com>; Hans de Goede <hdegoede@redhat.com>;
>> Mark Gross <markgross@kernel.org>
>> Cc: Liming Sun <limings@nvidia.com>; platform-driver-x86@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: [PATCH v1 1/1] platform/mellanox: fix potential race in mlxbf-tmfifo
>> driver
>>
>> This commit adds memory barrier for the 'vq' update in function
>> mlxbf_tmfifo_virtio_find_vqs() to avoid potential race due to out-of-order
>> memory write. It also adds barrier for the 'is_ready'
>> flag to make sure the initializations are visible before this flag is checked.
>>
>> Signed-off-by: Liming Sun <limings@nvidia.com>
> 
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



>> ---
>>  drivers/platform/mellanox/mlxbf-tmfifo.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c
>> b/drivers/platform/mellanox/mlxbf-tmfifo.c
>> index 91a077c35b8b..a79318e90a13 100644
>> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
>> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
>> @@ -784,7 +784,7 @@ static void mlxbf_tmfifo_rxtx(struct
>> mlxbf_tmfifo_vring *vring, bool is_rx)
>>  	fifo = vring->fifo;
>>
>>  	/* Return if vdev is not ready. */
>> -	if (!fifo->vdev[devid])
>> +	if (!fifo || !fifo->vdev[devid])
>>  		return;
>>
>>  	/* Return if another vring is running. */ @@ -980,9 +980,13 @@
>> static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
>>
>>  		vq->num_max = vring->num;
>>
>> +		vq->priv = vring;
>> +
>> +		/* Make vq update visible before using it. */
>> +		virtio_mb(false);
>> +
>>  		vqs[i] = vq;
>>  		vring->vq = vq;
>> -		vq->priv = vring;
>>  	}
>>
>>  	return 0;
>> @@ -1302,6 +1306,9 @@ static int mlxbf_tmfifo_probe(struct
>> platform_device *pdev)
>>
>>  	mod_timer(&fifo->timer, jiffies + MLXBF_TMFIFO_TIMER_INTERVAL);
>>
>> +	/* Make all updates visible before setting the 'is_ready' flag. */
>> +	virtio_mb(false);
>> +
>>  	fifo->is_ready = true;
>>  	return 0;
>>
>> --
>> 2.30.1
> 

