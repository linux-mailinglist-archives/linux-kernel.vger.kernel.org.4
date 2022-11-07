Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34096200C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiKGVOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiKGVON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:14:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B107317C7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667855411;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S5uHAm/YMaHSV2rOFAm9u7M75Iy7HbODE/InmExnaAE=;
        b=PRoAuTx6ivBM4dcWT6Elj0ieI/8F8YyTwMWEJ3LnJZXLzoHLilPpFpSqQW7iCqCcI6zJDs
        DvNmuybthNlfj/odrOmdZ8rF8T7JkqRplyI6n8EmxMiWFQH6sEn7eG9b2URvM6p11D6FM1
        XCXbdswLzKgROtHhyp4LFA0O1Yq0VjE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-228-Cxp1HO0FMz66qkQ-8vARXw-1; Mon, 07 Nov 2022 16:10:09 -0500
X-MC-Unique: Cxp1HO0FMz66qkQ-8vARXw-1
Received: by mail-wr1-f71.google.com with SMTP id d23-20020adfa417000000b002364a31b7c9so3236769wra.15
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5uHAm/YMaHSV2rOFAm9u7M75Iy7HbODE/InmExnaAE=;
        b=N7DlzYJDck8dRy7B9ZGfRmp0ZuC9qnsaaSPAwWXA1nSW0u+wN81x8kwqDIdTWBPL7H
         R6ejaRwln6y4yOVBk7tGtkGwUoGl7CWxNjexee+1hMXa7MjAvXZjVI/OP2h1Pjb25FAO
         uKF6sVY/BKq4TM3bwVtExkvikxz/konevFbNr2/FriJ27TE9RBoycVYVhKCqFs6pfdrM
         cpx4aTnK2RAp1L+moUzRg5kwNyYJDjH0A479co7JIyh1YE7gbpL42k6iavggtITnV4NC
         tjctRMXd5BiW6a2FmXORlftgQHzdg4X5PNQ3vEkEVG+KuQSPDM2a+kLmsH6ffxGa8Dmn
         M+IQ==
X-Gm-Message-State: ACrzQf3sca55AZyw/cE0D2f/OKy661yY6ddEFxxWo5+6xTimlqReRtl8
        Ei/eNP4U7qFgs5d7T2csEoGYKfide2S054u4Et+JJ5hI/X89u6jV+e2Y1Fwq+P96OmNzQlj9op6
        NvkbsK4XGk64sJbeAYF/sDQVx
X-Received: by 2002:a5d:4b45:0:b0:236:501f:7a41 with SMTP id w5-20020a5d4b45000000b00236501f7a41mr33248882wrs.516.1667855408485;
        Mon, 07 Nov 2022 13:10:08 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7OiDI4F9MI4Y77S9G7vRAA8ji/J8GVqtN7aNFdugsfuItxHBGzX5veSqv7kZTArZsQcUceGA==
X-Received: by 2002:a5d:4b45:0:b0:236:501f:7a41 with SMTP id w5-20020a5d4b45000000b00236501f7a41mr33248873wrs.516.1667855408285;
        Mon, 07 Nov 2022 13:10:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id i5-20020adffc05000000b0023660f6cecfsm8312230wrr.80.2022.11.07.13.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 13:10:07 -0800 (PST)
Message-ID: <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
Date:   Mon, 7 Nov 2022 22:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     eric.auger.pro@gmail.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20221107153924-mutt-send-email-mst@kernel.org>
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

Hi Michael,
On 11/7/22 21:42, Michael S. Tsirkin wrote:
> On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
>> When the vhost iotlb is used along with a guest virtual iommu
>> and the guest gets rebooted, some MISS messages may have been
>> recorded just before the reboot and spuriously executed by
>> the virtual iommu after the reboot. Despite the device iotlb gets
>> re-initialized, the messages are not cleared. Fix that by calling
>> vhost_clear_msg() at the end of vhost_init_device_iotlb().
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  drivers/vhost/vhost.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 40097826cff0..422a1fdee0ca 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
>>  	}
>>  
>>  	vhost_iotlb_free(oiotlb);
>> +	vhost_clear_msg(d);
>>  
>>  	return 0;
>>  }
> Hmm.  Can't messages meanwhile get processes and affect the
> new iotlb?
Isn't the msg processing stopped at the moment this function is called
(VHOST_SET_FEATURES)?

Thanks

Eric
>
>
>> -- 
>> 2.37.3

