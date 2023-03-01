Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9317D6A6AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCAKmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAKmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:42:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04F13B664
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677667307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HxbAZdFTdnp0zkdCbvj3RZFLfW7S0PsSk1ODrPqPrk=;
        b=c+rydkEFPFoAwkNVF8FxPqUMe7ioXU2xXOPYC0tutIPHTg0TgFVeziJx7htj4MbVFgKbzg
        5LpD/i0lTyTrFY2Z86v1a8QxMaE0pcoeWrq+tZeQD55LxmUNymJV5bYhgDPOUVL/DWLlKb
        DBtcXCuNn0EigCBPxYgIvt1t2Q6h2QE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-O-m6axBfMUyUMVK89WoTSg-1; Wed, 01 Mar 2023 05:41:46 -0500
X-MC-Unique: O-m6axBfMUyUMVK89WoTSg-1
Received: by mail-ed1-f72.google.com with SMTP id fj7-20020a0564022b8700b004bbcdf3751bso2999248edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 02:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HxbAZdFTdnp0zkdCbvj3RZFLfW7S0PsSk1ODrPqPrk=;
        b=m7Zvh/j87tBUeR16zMl4xjnbydXwuqBGsxOdjk/ksj0xPwn4lXsFyr+x+1eX5HWNP5
         GtQW7Orfx1aF0UEja9EmbtC1YTrLNvRGEQyxY9nUQ5u4hAwwTl32bYIqweZ1yEkILRjX
         iYvqW+/b3kuIrGy7TZ1hFAH5UsJ7AMfu5YMyJfdRcf/cdkZtrhs7KBocUn7Ywx8aj45p
         lkJ6UuqCCnXgBitEjLEPNdut5Bs2j6SNromHHRnUj96hClchmkNLX067P2MD9qTZ9JAa
         O5qQ9GQBM25764VZe80c2pbLz9O1ljySV5YWI0J/ZJpA9DvkCPrq7LRJkQrMAP3X/fw3
         C4yQ==
X-Gm-Message-State: AO0yUKVMKi6pOvCy9sDWbrFm/qJVWvNux38LOvfgMv3ebIRIPtkZ0NBC
        jaUM2hblZerTz9EVH8P7wlpfoieYTUVtURovCbHw//UvbfsLIx+yiBJTtKXHE50Ax3PznNoo9QJ
        UUkO4SCb5nyWZk2iGps5Jp9Wx
X-Received: by 2002:a17:907:a090:b0:8a5:3d1e:6302 with SMTP id hu16-20020a170907a09000b008a53d1e6302mr8328946ejc.56.1677667304600;
        Wed, 01 Mar 2023 02:41:44 -0800 (PST)
X-Google-Smtp-Source: AK7set9uUypKyMfmYd9MswS9i2cF1QytAOp5wk1WXq1QOr6zLSfsuR9Tau9OoLJEhBxNnyTofSUqEQ==
X-Received: by 2002:a17:907:a090:b0:8a5:3d1e:6302 with SMTP id hu16-20020a170907a09000b008a53d1e6302mr8328929ejc.56.1677667304283;
        Wed, 01 Mar 2023 02:41:44 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f2-20020a170906824200b008f0143dfa9dsm5702009ejx.33.2023.03.01.02.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 02:41:43 -0800 (PST)
Message-ID: <ae28faf8-c8a4-3f75-08d0-8e5233f2fa5d@redhat.com>
Date:   Wed, 1 Mar 2023 11:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
Content-Language: en-US, nl
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Wentong Wu <wentong.wu@intel.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        srinivas.pandruvada@intel.com,
        pierre-louis.bossart@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com, bingbu.cao@intel.com,
        linux-kernel@vger.kernel.org
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y/8qJzScTfFucpP9@kekkonen.localdomain>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y/8qJzScTfFucpP9@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/1/23 11:34, Sakari Ailus wrote:
> Hi Wentong,
> 
> On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
>> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls", is a
>> companion chip designed to provide secure and low power vision capability
>> to IA platforms. IVSC is available in existing commercial platforms from
>> multiple OEMs.
>>
>> The primary use case of IVSC is to bring in context awareness. IVSC
>> interfaces directly with the platform main camera sensor via a CSI-2 link
>> and processes the image data with the embedded AI engine. The detected
>> events are sent over I2C to ISH (Intel Sensor Hub) for additional data
>> fusion from multiple sensors. The fusion results are used to implement
>> advanced use cases like:
>>  - Face detection to unlock screen
>>  - Detect user presence to manage backlight setting or waking up system
>>
>> Since the Image Processing Unit(IPU) used on the host processor needs to
>> configure the CSI-2 link in normal camera usages, the CSI-2 link and
>> camera sensor can only be used in mutually-exclusive ways by host IPU and
>> IVSC. By default the IVSC owns the CSI-2 link and camera sensor. The IPU
>> driver can take ownership of the CSI-2 link and camera sensor using
>> interfaces provided by this IVSC driver.
>>
>> Switching ownership requires an interface with two different hardware
>> modules inside IVSC. The software interface to these modules is via Intel
>> MEI (The Intel Management Engine) commands. These two hardware modules
>> have two different MEI UUIDs to enumerate. These hardware modules are:
>>  - ACE (Algorithm Context Engine): This module is for algorithm computing
>> when IVSC owns camera sensor. Also ACE module controls camera sensor's
>> ownership. This hardware module is used to set ownership of camera sensor.
>>  - CSI (Camera Serial Interface): This module is used to route camera
>> sensor data either to IVSC or to host for IPU driver and application.
>>
>> IVSC also provides a privacy mode. When privacy mode is turned on,
>> camera sensor can't be used. This means that both ACE and host IPU can't
>> get image data. And when this mode is turned on, host IPU driver is
>> informed via a registered callback, so that user can be notified.
>>
>> In summary, to acquire ownership of camera by IPU driver, first ACE
>> module needs to be informed of ownership and then to setup MIPI CSI-2
>> link for the camera sensor and IPU.
> 
> I thought this for a while and did some research, and I can suggest the
> following:
> 
> - The IVSC sub-device implements a control for privacy (V4L2_CID_PRIVACY
>   is a good fit).
> 
> - Camera sensor access needs to be requested from IVSC before accessing the
>   sensor via I²C. The IVSC ownership control needs to be in the right
>   setting for this to work, and device links can be used for that purpose
>   (see device_link_add()). With DL_FLAG_PM_RUNTIME and DL_FLAG_RPM_ACTIVE,
>   the supplier devices will be PM runtime resumed before the consumer
>   (camera sensor). As these devices are purely virtual on host side and has
>   no power state as such, you can use runtime PM callbacks to transfer the
>   ownership.

Interesting proposal to use device-links + runtime-pm for this instead
of modelling this as an i2c-mux. FWIW I'm fine with going this route instead
of using an i2c-mux approach.

I have been thinking about the i2c-mux approach a bit and the problem is
that we are not really muxing but want to turn on/off control and AFAIK
the i2c-mux framework simply leaves the mux muxed to the last used i2c-chain,
so control will never be released when the i2c transfers are done.

And if were to somehow modify things (or maybe there already is some
release callback) then the downside becomes that the i2c-mux core code
operates at the i2c transfer level. So each i2c read/write would then
enable + disavle control.

Modelling this using something like runtime pm as such is a much better
fit because then we request control once on probe / stream-on and
release it once we are fully done, rather then requesting + releasing
control once per i2c-transfer.

Regards,

Hans



> 
> - The CSI-2 configuration should take place when streaming starts on the
>   sensor (as well as IVSC).
> 
> - Device links need to be set up via IPU bridge which now is called  CIO2
>   bridge (cio2-bridge.c).
> 
> Any questions, comments?
> 

