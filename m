Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B60A5BE403
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiITK6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiITK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:58:23 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9136872ECD;
        Tue, 20 Sep 2022 03:58:08 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id y17so5198502ejo.6;
        Tue, 20 Sep 2022 03:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DIf4A6MJfckarZjD46d4BsfCfgbtP0HUjIfcnatCVF4=;
        b=MtxzBxJckZt202x3WkcyuKwwdUpR/UE2O+GhTXXvcBrugYt+qcHWwexSnbpYwnJ6wN
         voRhBQN2ayJ7iR7fS34bOC/zN0hZtcVXKZRyc27GKFDLMBHpD938fQEB41/vwI5RqBl3
         qRr+SE0fqY3Rg3khEq6RC3y6KDoSUj9PgOvdBkzYSwdNDISIxNXDpPaLwEEiDwet6hoo
         I4OSCbShg5G/HAca5IpWAZrCfrJe2n0SW6pjAwFCqX0FHioHMx5peoC2dcEpBSDCmi4f
         Q3KtxBxIyAwNQ+Ilxm65Xhjj0MWJQYNCgwgqrPflx6IydvR7AkznDDbcImKKKxusMgkY
         ZxNQ==
X-Gm-Message-State: ACrzQf0sCFNE3PU4Nj/jYNTH7bDFXyZMYTEP1HZvCwud8xjYjQ0mIg4V
        7/eiBKU/n1a85Upc/Ua9hkQ=
X-Google-Smtp-Source: AMsMyM5kxMnMuhMcHTwEZeZUOWkC/2ffdKn/oARxrizmy9SaILemUN35/307/v8LTz/ze3YlWW9CkA==
X-Received: by 2002:a17:906:cc10:b0:77a:fe95:eae2 with SMTP id ml16-20020a170906cc1000b0077afe95eae2mr16531605ejb.466.1663671486796;
        Tue, 20 Sep 2022 03:58:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id bi14-20020a170906a24e00b007803083a36asm651296ejb.115.2022.09.20.03.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 03:58:06 -0700 (PDT)
Message-ID: <bb3fa609-858f-ab16-95b4-06fd43ec6129@kernel.org>
Date:   Tue, 20 Sep 2022 12:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 10/10] tty: serial: use uart_port_tx_limited()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
References: <20220920052049.20507-1-jslaby@suse.cz>
 <20220920075844.29360-1-jslaby@suse.cz>
 <f2653c92-1769-fc7c-8ad8-abf34affef6b@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <f2653c92-1769-fc7c-8ad8-abf34affef6b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 09. 22, 11:19, Ilpo Järvinen wrote:
> One improvement suggestion below.
> 
>> diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
>> index 23f339757894..f224f5141726 100644
>> --- a/drivers/tty/serial/altera_jtaguart.c
>> +++ b/drivers/tty/serial/altera_jtaguart.c
>> @@ -137,39 +137,17 @@ static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
>>   static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
...
>> +	space = readl(port->membase + ALTERA_JTAGUART_CONTROL_REG);
>> +	space &= ALTERA_JTAGUART_CONTROL_WSPACE_MSK;
>> +	space >>= ALTERA_JTAGUART_CONTROL_WSPACE_OFF;
> 
> This is FIELD_GET(ALTERA_JTAGUART_CONTROL_WSPACE_MSK, ...) & then allows
> killing ALTERA_JTAGUART_CONTROL_WSPACE_OFF. I'd probably do it in a
> separate patch though.

Right. Prepared for v5.

thanks,
-- 
js
suse labs

