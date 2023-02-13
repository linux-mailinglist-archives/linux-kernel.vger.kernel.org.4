Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63B69515A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjBMUGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBMUGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:06:31 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957D91DBB2;
        Mon, 13 Feb 2023 12:06:05 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-15fe106c7c7so16484424fac.8;
        Mon, 13 Feb 2023 12:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qocm/KHxkvqzT8k/bpHmNW+PSj6cXLlUolt4tjyFl+E=;
        b=JkXJi95vQcsUzo51+MeRB0MO/6Qnsyp3AuJzG2ty6VxKFBgQDgFKdF1o293R6YPlsZ
         rnv4N/2w/+hqKbMZHbpWCdEvgL70QvGfuGTGp9v0rCJAibHY4c4iMc0u2otvYW/9P/UE
         jQuvn7q93m78Dco7tkgtMwaM3X0x6TrqoAdriROQWGa7+BGueff+n5GcH0fNampXgjfa
         zRYmJGMa+EE3sBt+5Od9fZp5HdQqQ6LFQ9KI0DfxdV/fRPdm3HD3vSropR6HWGCT5Te0
         /aSrQM0k7iWmfrl2Ftqhan8ySkd1f5Bo8j63xDj4ZvStHaETCYLj/g3oGwbKuvDOc7ha
         orSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qocm/KHxkvqzT8k/bpHmNW+PSj6cXLlUolt4tjyFl+E=;
        b=PBEtf2LyTKIgvD/zj4WtOrl7iWwyLdaA0j2UBZIP05l7CC2+JNZu3P4dLpozx0bfv5
         NEoVNmwjY7FZN1ssiD/gJGCDVKaxfEtSYCL8bc3S54kn3iCaUuQJkgcOqr5SyzGwlyFy
         KJ6YLB27DN/V7ZOXfkt4B4xUrIjvQXYfkY45Dx7sH8AYvkcxx3vQuZXJzDcJJx1bA2u0
         ZQotThK3hNoMNYnCbrd5lrBKeGoCk2F7CzwJ02sAsvImig/2DWh3wBkfxI0j/iFh6DDk
         BiabMwKdP0mtS9tH7joe3WxLHjkbeqmLnYI01gA+XbnTimmtebaxPuEy44bUIseqLd4Y
         msQw==
X-Gm-Message-State: AO0yUKWytK1NyRFYR8AT16/ZrtYVdFOe0wXcTwAxCrh3GANMcj/f+W96
        xGYGmhhu/i4+m/cfsTq8E1xy6w9pjMk=
X-Google-Smtp-Source: AK7set9UILrrA7QwH0pt32603M6erZ5p3R4YEyLQJlSYXPCEaG47zmSnJIMsiNHBJf4F7aUriUCNvQ==
X-Received: by 2002:a05:6870:d10d:b0:16a:b526:59a6 with SMTP id e13-20020a056870d10d00b0016ab52659a6mr13061134oac.43.1676318757902;
        Mon, 13 Feb 2023 12:05:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h15-20020a4abb8f000000b004f21af81e0csm5176889oop.46.2023.02.13.12.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 12:05:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e742a790-5322-666d-5f27-33a51445bd07@roeck-us.net>
Date:   Mon, 13 Feb 2023 12:05:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] ACPICA: Replace fake flexible arrays with flexible
 array members
Content-Language: en-US
To:     Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-hardening@vger.kernel.org
References: <20230127191621.gonna.262-kees@kernel.org>
 <20230213003546.GA3280303@roeck-us.net>
 <66C64DB0-94A2-47E8-932C-519544C5FE90@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <66C64DB0-94A2-47E8-932C-519544C5FE90@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 11:51, Kees Cook wrote:
> On February 12, 2023 4:35:46 PM PST, Guenter Roeck <linux@roeck-us.net> wrote:
>> Hi,
>>
>> On Fri, Jan 27, 2023 at 11:16:25AM -0800, Kees Cook wrote:
>>> One-element arrays (and multi-element arrays being treated as
>>> dynamically sized) are deprecated[1] and are being replaced with
>>> flexible array members in support of the ongoing efforts to tighten the
>>> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
>>> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
>>>
>>> Replace one-element array with flexible-array member in struct
>>> acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
>>> padding in a union with a flexible-array member in struct
>>> acpi_pci_routing_table.
>>>
>>> This results in no differences in binary output.
>>>
>>> Link: https://github.com/acpica/acpica/pull/813
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> This patch results in boot failures of 32-bit images.
> 
> Weird -- I didn't see any binary differences. I'll investigate. What compiler and arch?
> 

gcc 11.3, binutils 2.39, x86 (32-bit build). This is pretty much defconfig
with ARCH=i386 and various debug options enabled.

64-bit builds do not have the problem.

Guenter

> -Kees
> 
>> Reverting it fixes the problem.
>>
>> On the failing boot tests, I see messages such as
>>
>> ACPI: \_SB_.GSIA: Enabled at IRQ 117440528
>> ERROR: Unable to locate IOAPIC for GSI 117440528
>> ahci 0000:00:1f.2: PCI INT A: failed to register GSI
>>
>> ACPI: \_SB_.GSIG: Enabled at IRQ 117440534
>> ERROR: Unable to locate IOAPIC for GSI 117440534
>> 8139cp 0000:00:02.0: PCI INT A: failed to register GSI
>>
>> Given that 117440534 == 0x7000016, that looks quite suspicious.
>> Indeed, after reverting this patch, the messages are different.
> 
> Yeah, seems like a high byte not getting cleared. Hmm.
> 
>>
>> ACPI: \_SB_.GSIA: Enabled at IRQ 16
>> ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
>>
>> ACPI: \_SB_.GSIG: Enabled at IRQ 22
>> 8139cp 0000:00:02.0 eth0: RTL-8139C+ at 0xd0804000, 52:54:00:12:34:56, IRQ 22
>>
>> Guenter
> 
> 

