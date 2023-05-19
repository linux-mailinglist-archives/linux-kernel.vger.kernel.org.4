Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53B7098A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjESNrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjESNq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA778AA
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684503972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooaoDXWiYqNHwpwAlZ5TH2xlrXBySJTTzRpl4impsO0=;
        b=dJ0qj6SJWQ7Ne59BfByRoO9NJcWTPpKmUms4f9D+toBDuMP+M8UgEptgEiyloObn3jAQ5Q
        xy4iL5wub1v65W7FyNPUF+mvcbWQ8mfPWYR6fMMzmWmQhUNaJr9A+DD4ECUdxQHSv1j1MP
        4SPzDaQEVWah5Q8v/O081cyKvL27aU4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-ghpMEZwcOGq8Uxo8G9L_mA-1; Fri, 19 May 2023 09:46:10 -0400
X-MC-Unique: ghpMEZwcOGq8Uxo8G9L_mA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5118fc8abd0so508567a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 06:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684503969; x=1687095969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooaoDXWiYqNHwpwAlZ5TH2xlrXBySJTTzRpl4impsO0=;
        b=Uyd3ZLhmsSSt/ACKkAeB71BzeMrd9lEO9zzj8UllgO5LhlPoBvl9YJVQopUsefoZax
         vUDsCT9a1Y3kH82Lkxp0bt8VpBHR2l8T2kUjSDGjptM+Yqg2RqwNjH8mCmBAzn3lqChp
         RZ9Hr4GVwbF8MUAmnz3Tr+w4Lvy4KUN/zSrQRF2K7XlpjWEk5rXpxlQ/cXkOXw29ZsIO
         ao0hNSG5D4I17dS0tL8/StIMSnUHwY3AUGcaggtGP0zmNDGlUcT6rEeBmye8NdElTVMb
         6AAxTcMOUPzkyocccuUXhJ3ivDnsa6o9qiMNXjTt2Gm5ZkuRnYNObUtcWyNH7SlnIaf2
         1CuQ==
X-Gm-Message-State: AC+VfDz+6QtNT9vwv9bRpz9uk632mWOMmvyv7Gghfxqtt5A1N9VHY/yA
        4Au9Ti62d9FG4TRjaYzQ8+x2Wugts3z9DkUnXFZePXaljhnM1YTt5t+jPrcYPfO4y/Wf45soLXU
        toos2XKDplcLjN7eZw1zGN7eK
X-Received: by 2002:a05:6402:1b0c:b0:50d:ff73:64ef with SMTP id by12-20020a0564021b0c00b0050dff7364efmr1749671edb.20.1684503969777;
        Fri, 19 May 2023 06:46:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kbSpzzRMNk2yhk0jXBgwaJ85kMVYUNGda42rdnEP81KbEsJQBybc1tTyjvhwsxgEOc2a2OA==
X-Received: by 2002:a05:6402:1b0c:b0:50d:ff73:64ef with SMTP id by12-20020a0564021b0c00b0050dff7364efmr1749646edb.20.1684503969445;
        Fri, 19 May 2023 06:46:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m11-20020a50ef0b000000b005067d6b06efsm1681645eds.17.2023.05.19.06.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 06:46:08 -0700 (PDT)
Message-ID: <2d7ee116-5985-021f-0dfb-b0485a465c86@redhat.com>
Date:   Fri, 19 May 2023 15:46:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Fwd: ThinkPad L540: suspend not working (deep / S3 / standby,
 regression Linux 4.19 -> 6.1)
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux i2c Devices <linux-i2c@vger.kernel.org>,
        Benjamin Tissoires <btissoir@redhat.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kolAflash@kolahilft.de
References: <73883c7d-42db-7ac6-fa43-b9be45cdc795@gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <73883c7d-42db-7ac6-fa43-b9be45cdc795@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This looks like something for Benjamin Tissoires (who will
be available to look at this in 2 weeks or so) to look at.

Adding Benjamin to the Cc.

In the mean time passing psmouse.synaptics_intertouch=0 on the
kernel commandline should restore the old 4.19 kernel behavior
of simply using the touchpad in ps/2 mode.

Regards,

Hans



On 5/19/23 15:19, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> ThinkPad L540 failed suspend deep dmesg output - Linux-6.1.27 from Debian-12
>>
>> Since updating from Linux-4.19 to Linux-6.1.27 suspend deep is not working anymore.
>> (a.k.a. S3, standby or suspend to ram)
>>
>> Notebook: ThinkPad L540 20AU-S00N00
>> OS: Debian-12 "Bookworm" (was Debian-10 "Buster" before)
>> Kernel: Linux-6.1.27 from Debian-12 (was Linux-4.19 from Debian-10 before)
>>
>> Can I provide any other helpful information?
>> Do you need a test with a vanilla Linux-6.1 kernel?
>> Should I perform any other tests or maybe try out boot parameters?
>>
>> Full dmesg output attached.
>> Excerpt:
>> rmi4_f01 rmi4-00.fn01: Failed to write sleep mode: -6.
>> rmi4_f01 rmi4-00.fn01: Suspend failed with code -6.
>> rmi4_physical rmi4-00: Failed to suspend functions: -6
>> rmi4_smbus 0-002c: Failed to suspend device: -6
>> rmi4_smbus 0-002c: PM: dpm_run_callback(): rmi_smb_suspend+0x0/0x40 [rmi_smbus] returns -6
>> rmi4_smbus 0-002c: PM: failed to suspend async: error -6
>> sd 4:0:0:0: [sda] Synchronizing SCSI cache
>> sd 4:0:0:0: [sda] Stopping disk
>> PM: Some devices failed to suspend, or early wake event detected
>> sd 4:0:0:0: [sda] Starting disk
>> OOM killer enabled.
>> Restarting tasks ... 
>> rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to change enabled interrupts!
>> psmouse: probe of serio2 failed with error -1
>>
>>
>>
>> Maybe related:
>>
>> 5.17-rc regression: X1 Carbon touchpad not resumed
>> https://lore.kernel.org/lkml/YgF%2F0QGFN4SppLKg@shikoro/T/
> 
> FYI, I guess the regression is also introduced by 172d931910e1db
> ("i2c: enable async suspend/resume on i2c client devices") and
> should have been fixed by 7b1f781f2d2460 ("Input: psmouse - set up
> dependency between PS/2 and SMBus companions"), but it doesn't
> fix the reporter's issue.
> 
> Anyway, I'm adding this to regzbot:
> 
> #regzbot introduced: v4.19..v6.1 https://bugzilla.kernel.org/show_bug.cgi?id=217462
> #regzbot title: psmouse suspend failed on ThinkPad L540
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217462
> 

