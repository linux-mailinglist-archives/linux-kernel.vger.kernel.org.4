Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10A66568B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiL0JHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiL0JHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C7E1E0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672131979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nz1SnC0gAVnfhR/QDRjT/YSO9ZI+vbqwUHzyKwphYUc=;
        b=daeMOgAQ0VWoX6nB4kcpGAq4OYMxFmR+pzacQhU8Jqm4ForPsBUYoo8ct5aUFcxH8SddC2
        zEmN1kOWf46UoOY8gSPi6mXn0+sTCQKQSIp/rMvsjAvSZuR++0MHJzhO54v5WXn5jNFMzT
        2FPtU8Oq5q3vRhnQXyiP4A+172FeWlo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-RbFP6dQsPQ-R2Y9Tqb3fJg-1; Tue, 27 Dec 2022 04:06:17 -0500
X-MC-Unique: RbFP6dQsPQ-R2Y9Tqb3fJg-1
Received: by mail-pf1-f198.google.com with SMTP id n22-20020a62e516000000b005817b3a197aso216573pff.14
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nz1SnC0gAVnfhR/QDRjT/YSO9ZI+vbqwUHzyKwphYUc=;
        b=tHGxN/S3aBBe/lURv+n1QpNTDyvxErCduFwf6N+UVC9C4wUOIiL7D8UkriohJs1Qhc
         yyoWMfBn0yM13uz2czPdzAknhUTeQVlS7EHexalBxCy4BCGvhOF6jS+C+pSCbsH4WZFv
         och89TgJoZVPbhQZtMUX9F56nxAVRUK1+PdotWvWzHGkR24yVFEJykGj7BGxon1TaGpy
         Fui4yViP4Qd2tnVQiNR+asTI9IsbpfnLjCqF6hH+uApx/lH/BPMD86sOcSiWqAHBcov9
         pRpskUOsGLaAWgWzFb5StJnInS2VR3l0fp+00SV7uasm8w+6WDZIQBB4PfuhHQcEypCk
         YgJw==
X-Gm-Message-State: AFqh2kqVRyFliXJVtd0qbkOO2gDKYzRM8LR/swGasKl2LdnwrafEy6Nb
        SDZbUiEZxkp41+IeV9+jO7FHKbEGKUEs6nvWNd/I8OSTru2usaAOdTD0XB7fsMiCpsh+n05mt6c
        0EJEgY79k7BCQj5Uyc6JRDsn9
X-Received: by 2002:a17:90a:4744:b0:21a:fd7:210d with SMTP id y4-20020a17090a474400b0021a0fd7210dmr23290667pjg.2.1672131976914;
        Tue, 27 Dec 2022 01:06:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu93UpcjkbltIaP0U0Rt09nzSfJefeq48CvQOBnDYBKMyh1vT3OdwcM5vSFTtb3thaw2XTprg==
X-Received: by 2002:a17:90a:4744:b0:21a:fd7:210d with SMTP id y4-20020a17090a474400b0021a0fd7210dmr23290648pjg.2.1672131976643;
        Tue, 27 Dec 2022 01:06:16 -0800 (PST)
Received: from [10.72.13.143] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o61-20020a17090a0a4300b00225ffb9c43dsm2168531pjo.5.2022.12.27.01.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 01:06:16 -0800 (PST)
Message-ID: <6026e801-6fda-fee9-a69b-d06a80368621@redhat.com>
Date:   Tue, 27 Dec 2022 17:06:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] virtio-net: convert rx mode setting to use workqueue
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com, alvaro.karsz@solid-run.com,
        eperezma@redhat.com
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-2-jasowang@redhat.com>
 <20221227023447-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221227023447-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/27 15:39, Michael S. Tsirkin 写道:
> On Mon, Dec 26, 2022 at 03:49:05PM +0800, Jason Wang wrote:
>> @@ -2227,9 +2267,21 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>>   				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
>>   		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
>>   
>> +	rtnl_unlock();
>> +
>>   	kfree(buf);
>>   }
>>   
>> +static void virtnet_set_rx_mode(struct net_device *dev)
>> +{
>> +	struct virtnet_info *vi = netdev_priv(dev);
>> +
>> +	spin_lock(&vi->rx_mode_lock);
>> +	if (vi->rx_mode_work_enabled)
>> +		schedule_work(&vi->rx_mode_work);
>> +	spin_unlock(&vi->rx_mode_lock);
>> +}
>> +
>>   static int virtnet_vlan_rx_add_vid(struct net_device *dev,
>>   				   __be16 proto, u16 vid)
>>   {
> Hmm so user tells us to e.g enable promisc. We report completion
> but card is still dropping packets. I think this
> has a chance to break some setups.


I think all those filters are best efforts, am I wrong?

Thanks


>

