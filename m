Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250385ED850
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiI1I6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiI1I6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:58:04 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B223AD69DD;
        Wed, 28 Sep 2022 01:58:00 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso741757wmq.4;
        Wed, 28 Sep 2022 01:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kj7qWhThnkCasW9E7g/Ax+n/vLHOH8UYoTEvBX7wULk=;
        b=VScwN39OsRj+s93C5fFoqZR3Vj7LvbVp5ejEQsYxPd1a3INk8nRvJ+ywhJPMFfiXKc
         0TbKUCUtTO0kLj/T8rMCMHDm1w0vTA21kW3U6gHauONUG6xxfacwi//fVYCt923mBt28
         xqI6woeFXmHytCnTpzmjt/3phQmel8AQo/r4uC675qd+3E2HmxPgLqzjxBc+jyKIREEt
         pKgrqTyCnkFTTWK2IJzPk200WBD4tp2zAgHDwJlVUAzRt0Ow5SkzsiBf/ApvO56Ch6TM
         B1nqZXlpc+ocPH665dS7UGMlYtpcW6BLiAsMXkhzwxXkKcgKrvoz+4SMsXA2EKwk8HOb
         +8Jg==
X-Gm-Message-State: ACrzQf1g7I7Z4G/D+RBw+SwqmHm7TDE1iFXsyDNvPha0DE/QCcZw7SeL
        RW8aWiMo9Zlnzms6YGFwl3M=
X-Google-Smtp-Source: AMsMyM6NfOVLzED2+lsfXxN82a80KxyLIKK0KMf5GR22Ic/NQcb1qpXww4VNYKXRtVcKzFwdBXmA8w==
X-Received: by 2002:a1c:721a:0:b0:3b4:641c:5d99 with SMTP id n26-20020a1c721a000000b003b4641c5d99mr6086058wmc.71.1664355479154;
        Wed, 28 Sep 2022 01:57:59 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003b33943ce5esm1232750wme.32.2022.09.28.01.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:57:58 -0700 (PDT)
Message-ID: <9b60d9c5-7d2c-a6ed-29d1-aa5dabee5426@kernel.org>
Date:   Wed, 28 Sep 2022 10:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6] ACPI: skip IRQ override on AMD Zen platforms
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-acpi@vger.kernel.org
Cc:     Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220712020058.90374-1-gch981213@gmail.com>
 <0450c7c0-4787-2aa2-de3e-c71522e467ce@kernel.org>
 <498a9097-8ecf-0a47-abbb-8b64fb7ee2de@kernel.org>
Content-Language: en-US
In-Reply-To: <498a9097-8ecf-0a47-abbb-8b64fb7ee2de@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 09. 22, 10:31, Jiri Slaby wrote:
> Something like the attached. It's:
> 1) untested yet
> 2) contains more debug messaging
> 3) contains both cases for ACPI_ACTIVE_* as I don't know the original 
> polarity

Now, I have DSDT which says for both of them:
                 IRQ (Level, ActiveLow, ExclusiveAndWake, )

So the patch should actually have:
         { lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, 
true },
         { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, 
true },

thanks,
-- 
js

