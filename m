Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F70872D426
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbjFLWID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbjFLWH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:07:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08771EE;
        Mon, 12 Jun 2023 15:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 901FB62EDC;
        Mon, 12 Jun 2023 22:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C643C433D2;
        Mon, 12 Jun 2023 22:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686607676;
        bh=9iKK1p0kFNdxIbzsTtA0v3TwfLlhr6RY1S6PuLqz+yo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lv+l3ef9XHrKF/2RB20fuyGBm2F7mHaqpMXlWr7I4FbQB2zt+sknQioXPSYaduVYT
         oH/zOm9mTR6n5a4mMvlpVeIxpSF2vEo03SOGhtbd7ojc921NN1yA8WWeoNbwFu9CVI
         aAvsrJwwrIbSxk849IANxD2VakGgaJ0L5+A21R36hLcXSr4KuhMPKicrir/y18Su5y
         dbuqErHjLN0xqeExZ9f/QuYTlDq1MxLtpU5AYjWg7rnmFFWiO7s2NLgi1ba8TnCoYR
         IsWaNwMMPt3x+T6i+29f+C95GTEVotQAbueM+lwxDhzD/7MClkwone/QlNh3D4PvRB
         of5AoLwwSHinw==
Message-ID: <61beeb4f-9341-e461-57bb-7394483409fa@kernel.org>
Date:   Tue, 13 Jun 2023 07:07:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/3] ACPI: Move ACPI_DEVICE_CLASS() to
 mod_devicetable.h
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20230609154900.43024-1-andriy.shevchenko@linux.intel.com>
 <20230609154900.43024-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0i29u7RUnhatOANBgjdrH4uoWK_8VCHWK2UO7RS8L3H1A@mail.gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAJZ5v0i29u7RUnhatOANBgjdrH4uoWK_8VCHWK2UO7RS8L3H1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 02:32, Rafael J. Wysocki wrote:
> On Fri, Jun 9, 2023 at 5:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> The data type of struct acpi_device_id is defined in the
>> mod_devicetable.h. It's suboptimal to require user with
>> the almost agnostic code to include acpi.h solely for the
>> macro that affects the data type defined elsewhere.
>>
>> Taking into account the above and for the sake of consistency
>> move ACPI_DEVICE_CLASS() to mod_devicetable.h.
>>
>> Note, that with CONFIG_ACPI=n the ID table will be filed with data
>> but it does not really matter because either it won't be used, or
>> won't be compiled in some cases (when guarded by respective ifdeffery).
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> or please let me know if you want me to apply this.

Probably better if you take the whole thing. But if needed, I can take this
through the ata tree.


-- 
Damien Le Moal
Western Digital Research

