Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A30744AED
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 21:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGATQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 15:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGATQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 15:16:22 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A411710
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 12:16:14 -0700 (PDT)
Received: from [10.0.0.182] (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id DF2F9160365;
        Sat,  1 Jul 2023 21:16:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1688238969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nzN5M0Aj6HckyCdKJygWarn8tMUOVYCV7PJvrCf93Gs=;
        b=dmSlowOWXMhjTtOpvn/TI43Uht6K3UcEJhis9/3hgjgV8oMX90x2Og8ezCDsKzv2cwBBqQ
        OeNkUJbnFp6yliIibhsBSnkLW6gBq4X5W0q9eNMff1OqR4Kzf+lLi4CvT//6wpXTbcGePr
        qwdVvGZRU84Mh/L8LRQ3fkE8IhqTpSI=
Message-ID: <3a9041c0-6ae2-4231-2a72-32212ff12f16@ixit.cz>
Date:   Sat, 1 Jul 2023 21:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] usb: serial: add support for CH348
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, johan@kernel.org
References: <20230628133834.1527941-1-clabbe@baylibre.com>
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <20230628133834.1527941-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: David Heidelberg <david@ixit.cz>
Reviewed-by: David Heidelberg <david@ixit.cz>

Thank you

On 28/06/2023 15:38, Corentin Labbe wrote:
> Hello
>
> The CH348 is an octo serial to USB adapter.
> The following patch adds a driver for supporting it.
> Since there is no public datasheet, unfortunatly it remains some magic values.
>
> It was tested with a large range of baud from 1200 to 1500000 and used with
> success in one of our kernel CI testlab.
>
> Regards
>
> Changes since v1:
> - use a data structure for encoding/decoding messages.
> - check if needed endpoints exists
> - fix URB leak in ch348_allocate_status_read error case
> - test for maximum baud rate as stated by datasheet
>
> Changes since v2:
> - specify ch348_rxbuf data length
> - Use correct speed_t dwDTERate instead of __le32
> - test for maximum baud rate supported according to datasheet
> - Use a define for CH348_TX_HDRSIZE
>
> Changes since v3
> - Fixed all reported problem from https://lore.kernel.org/lkml/Y5NDwEakGJbmB6+b@Red/T/#mb6234d0427cfdabf412190565e215995a41482dd
>    Mostly reworked the endpoint mux to be the same than mx_uport
>
> Changes since v4:
> - The V4 was sent against stable and next have ch348_set_termios ktermios
>    parameter const that I forgot to change
>
> Changes since v5:
> - Fixed all reported problem from https://lore.kernel.org/lkml/20230106135338.643951-1-clabbe@baylibre.com/T/#m044aab24dfb652ea34aa06f8ef704da9d6a2e036
> - Major change is dropping of all status handling which was unused.
>    It will be probably necessary to bring it back when using GPIO.
>    This will be done when I will finish my next devboard.
>
> Corentin Labbe (2):
>    usb: serial: add support for CH348
>    usb: serial: add myself as maintainer of CH348
>
>   MAINTAINERS                 |   5 +
>   drivers/usb/serial/Kconfig  |   9 +
>   drivers/usb/serial/Makefile |   1 +
>   drivers/usb/serial/ch348.c  | 491 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 506 insertions(+)
>   create mode 100644 drivers/usb/serial/ch348.c
>
-- 
David Heidelberg
Consultant Software Engineer

