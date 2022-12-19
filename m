Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45067650A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiLSLLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiLSLLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:11:00 -0500
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DB7A5F73;
        Mon, 19 Dec 2022 03:10:52 -0800 (PST)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 65E0B2EE4C;
        Mon, 19 Dec 2022 12:10:50 +0100 (CET)
Message-ID: <a858367d-5953-1fba-0cb6-20ea917194e0@gpxsee.org>
Date:   Mon, 19 Dec 2022 12:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 0/1] Digiteq Automotive MGB4 driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@amd.com>,
        =?UTF-8?Q?Martin_T=c5=afma?= <martin.tuma@digiteqautomotive.com>
References: <20221123140431.4730-1-tumic@gpxsee.org>
 <Y59iurFF9CM21p7o@duo.ucw.cz>
Content-Language: en-US
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <Y59iurFF9CM21p7o@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 12. 22 19:58, Pavel Machek wrote:
> Hi!
> 
>> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>
>> Hi,
>> This patch adds a driver for the Digiteq Automotive MGB4 grabber card.
>> MGB4 is a modular frame grabber PCIe card for automotive video interfaces
>> (FPD-Link and GMSL for now). It is based on a Xilinx FPGA and uses their
>> XDMA IP core for DMA transfers. Additionally, Xilinx I2C and SPI IP cores
>> which already have drivers in linux are used in the design.
>>
>> The driver is a quite standard v4l2 driver, with one exception - there are
>> a lot of sysfs options that may/must be set before opening the v4l2 device
>> to adapt the card on a specific signal (see mgb4.rst for details)
>> as the card must be able to work with various signal sources (or displays)
>> that can not be auto-detected.
> 
> Uff, that's "interesting". What kind of platform does this run on? You
> should be getting non-probeable parameters from deice tree (or APCI).
> 
> Best regards,
> 								Pavel
> 								

Hi,
It is a PCIe card, so it runs on any platform that supports PCIe cards. 
We do use the HW on x86_64 and arm platforms.

The parameters are in no way connected to the platform where the card is 
used, they are properties of the video signal that can change arbitrary 
as you can connect different car infotainments (the signal source) to 
the card (the same applies to the outputs - the car displays). Usually, 
there is no auto-configuration on the signal level, that's why you have 
to provide the various properties externally according to the 
infotainment that you have at the moment connected to the card.

Any kind of device tree or ACPI parameters make no sense for the HW/the 
intended usage.

M.
