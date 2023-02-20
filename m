Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211AB69C6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjBTIpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjBTIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49904CC22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676882698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVwbB9vj5JGqHdtOSPTFqf81luv/Tjq9qbnrv1u6j1A=;
        b=btdT/c8aNf+c4g9kFHgUlxoa3TXkNOaZurDMJMhC252BoQkJVT3MWbbNRGbJ3u7BtHb7mK
        9nUTSlEZ0DqukTWhL4vXKsYHxqjIQJAb8tg9sHd/UAj9XCr5lj+rV1eUWesmWHkvvqmTOD
        7d+7b1NsVC/Z2VRSvYAiVMY4bhQGBlo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-D5W7T6d1MkadOBoC1Sbn3g-1; Mon, 20 Feb 2023 03:44:56 -0500
X-MC-Unique: D5W7T6d1MkadOBoC1Sbn3g-1
Received: by mail-ed1-f71.google.com with SMTP id ck7-20020a0564021c0700b004a25d8d7593so256678edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVwbB9vj5JGqHdtOSPTFqf81luv/Tjq9qbnrv1u6j1A=;
        b=QVnvUhzOPrQKxPp8q5dF9CBvdX+iSH4dJuAXDoqzV69p3lMStW5CJFuGvbg48r5i/r
         JZE7wPIiSur0kBDsT2vhODq+NfqkkdEgQkYuB1UGGWVLrHV11FFUwNOyfYMd2/zYcmgX
         SnnHBeh8WIBGBEdyWUbFkiljPRy6ydg30vqidMZoYyGyP/pj9t9NjeVLUrh2E7IkIu7I
         SG7esh6gcqiI/Z6tNA3VjObIp40YWTCGjr4CbzN/taz0lHQA0bfGR68R3wqiMtJqxhU3
         pcLJ5hxb6eC8T/512YiTDFPQVNVfz3eGNuk9I0jrkVZmjbxVWG/tZAVyq5x3FgVryZhi
         AoBg==
X-Gm-Message-State: AO0yUKUjwND8pzS9s1u2EyA+vaMQHwaA2v310Wsn11hMtsKwZdxnr7Az
        EHthJ7WdQciguf/5s8nFnOZYzeX4JLFRhN2aPjYUViROj20P9B3WpNLYriF5dPtwkhsUYwMgpJt
        hlENanmSE5W7FVdprTeQ2SMKZ
X-Received: by 2002:aa7:d048:0:b0:4ab:554:37ea with SMTP id n8-20020aa7d048000000b004ab055437eamr863285edo.4.1676882695616;
        Mon, 20 Feb 2023 00:44:55 -0800 (PST)
X-Google-Smtp-Source: AK7set+dK6utNFx1klK6L8QHAdHzNgx1cFyKD6UbBPI4X5Tz1NKwtst7hxuAgxNJSDdxEWTM7hX3mQ==
X-Received: by 2002:aa7:d048:0:b0:4ab:554:37ea with SMTP id n8-20020aa7d048000000b004ab055437eamr863277edo.4.1676882695373;
        Mon, 20 Feb 2023 00:44:55 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id co10-20020a0564020c0a00b004aab66d34c7sm1088295edb.7.2023.02.20.00.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 00:44:54 -0800 (PST)
Message-ID: <8f2cdd8e-70a5-e2fa-6b63-45ca029e39be@redhat.com>
Date:   Mon, 20 Feb 2023 09:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/5] apple-gmux: support MMIO gmux on T2 Macs
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
References: <20230216122342.5918-1-orlandoch.dev@gmail.com>
 <20230216122342.5918-5-orlandoch.dev@gmail.com>
 <cd6beabe-3026-d84e-63fd-3833948ecc1f@redhat.com>
 <20230217110531.6d3c07a1@redecorated-mbp> <20230219133956.GA4946@wunner.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230219133956.GA4946@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/19/23 14:39, Lukas Wunner wrote:
> On Fri, Feb 17, 2023 at 11:05:31AM +1100, Orlando Chamberlain wrote:
>> On Thu, 16 Feb 2023 14:27:13 +0100 Hans de Goede <hdegoede@redhat.com> wrote:
>> It looks like iMac20,1, iMac20,2, and iMacPro1,1 have APP000B:
>>
>> apple_gmux: Failed to find gmux I/O resource
>>
>> iMac20,2: https://linux-hardware.org/?probe=ec2af584b3&log=dmesg
>> iMac20,1: https://linux-hardware.org/?probe=fee7644b9c&log=dmesg
>> iMacPro1,1: https://linux-hardware.org/?probe=6c26c9ff8c&log=dmesg
>>
>> But I'm not sure if they actually have it or not.
> 
> A number of iMacs support Target Display Mode, i.e. you can plug in
> an external computer to the iMac's DisplayPort and use the iMac as
> its screen.  Those iMac models do contain a gmux to mux the display
> between internal GPU and external DisplayPort connection.  Linux
> does not have support for this, sadly.  It would require generalizing
> vga_switcheroo for use cases beyond dual GPU laptops.  Florian Echtler
> has been looking into Target Display Mode but I'm not sure he got it
> working:
> 
> https://lore.kernel.org/all/e6b44662-8b05-fb8d-660e-77153680d11b@butterbrot.org/
> https://lore.kernel.org/all/71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org/
> https://lore.kernel.org/all/1497603751-22360-1-git-send-email-floe@butterbrot.org/
> 
> I believe the Mac Pro (the trashcan one) also contains a gmux and
> an APP000B device in DSDT.  I recall seeing a bug report due to a
> splat in the gmux driver on that machine.  Back then I confirmed
> in the schematics that it does contain a gmux, though I think it's
> only used for brightness, not GPU switching.

Erm, the Mac Pro (the trashcan one) does not have an internal LCD
panel, right?  So I don't think the gmux will be used for brightness
control there ...

Regards,

Hans

