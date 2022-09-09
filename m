Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235805B35B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIIKxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIIKxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:53:09 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C75012F235;
        Fri,  9 Sep 2022 03:53:08 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id lz22so3093719ejb.3;
        Fri, 09 Sep 2022 03:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GagilPxqP4vgEIRQpipTIIkrScgT2/c3h/h3daNSK+w=;
        b=Q+nXwv1ofMvlO4HRJfePVdasS2nsqZ3vXuuwdjKqBoeyzuO/sIGo4yd+dWJHJfIq/8
         N3C+PhRVxfmF6XA+kR6mwUOEFqUPTU2Ow3dgNP1j0kSElDzg++7nOt/0OiImCtlfoBup
         Gyr5vz8b7xkUX3heQMMrmNYwdDjy23ODEAHBhNZnW343dEkgSFmycI+8JUU7PAGNMbne
         o0glebGEmXRVRtC5pqCtC/079hMne6kvKeP+//PPXes+cWveajfiDDTfmlolCGYmfow0
         k26SSbki3Aohk7VoyRWEIG77MK4nvS3Qgj3p1viPLeF4BMl/k0OauH8N/TQ5nQ2UYSXo
         qJwA==
X-Gm-Message-State: ACgBeo2LFJusDK8BvoiQIpiux00/Mqu0O6JC1p1htHvLwHKGEHlkmoIB
        gerJM8ScVxJ79ADcLb2eRCo=
X-Google-Smtp-Source: AA6agR4fWzrV6e43ghxyalL9bTe1slmh2rP02W0tqiS9UAizobs3euQ103aK9hHmJBRyrcdcbEb0kQ==
X-Received: by 2002:a17:907:75f5:b0:77a:7a93:feb4 with SMTP id jz21-20020a17090775f500b0077a7a93feb4mr103503ejc.582.1662720787030;
        Fri, 09 Sep 2022 03:53:07 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id ky21-20020a170907779500b007707e4d1835sm138549ejc.10.2022.09.09.03.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 03:53:06 -0700 (PDT)
Message-ID: <5feff23c-9458-616c-66ce-13cca5829162@kernel.org>
Date:   Fri, 9 Sep 2022 12:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 0/4] tty: TX helpers
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
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
References: <20220906104805.23211-1-jslaby@suse.cz>
 <Yxcvbk281f/vy4vb@hovoldconsulting.com>
 <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
 <4e9b4471-a6f2-4b16-d830-67d253ae4e6a@linux.intel.com>
 <715b40ba-1bcc-4582-bed1-ef41126c7b94@www.fastmail.com>
 <cfd16d53-6aa0-e848-91d0-dce8ff72bb4d@linux.intel.com>
 <YxiONiDgGYp8MGQA@kroah.com>
 <c66f9c98-dcef-27c-d74a-ea826f6a799@linux.intel.com>
 <YxiQVTN/jX8AfO4L@kroah.com> <YxiiOWQxGCUz9ktF@shell.armlinux.org.uk>
 <2197faa3-0217-41e0-8ff0-b5396561c623@www.fastmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <2197faa3-0217-41e0-8ff0-b5396561c623@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 09. 22, 16:56, Arnd Bergmann wrote:
> On Wed, Sep 7, 2022, at 3:52 PM, Russell King (Oracle) wrote:
>> On Wed, Sep 07, 2022 at 02:36:37PM +0200, Greg Kroah-Hartman wrote:
>>
>> Of course, it would have been nicer to see the definition of this
>> macro, because then we can understand what the "ch" argument is to
>> this macro, and how that relates to the macro argument that is
>> shown in the example as a writel().
> 
> I pulled out the 'ch' variable from the macro to avoid having
> the macro define local variables that are then passed to the
> inner expressions.

Note that I had "port" and "ch" as a part of the macro parameters in 
[v2], but it didn't help the situation much.
>> Maybe a more complete example would help clear up the confusion?
>> Arnd?
> 
> Here is a patch on top of the series that would implement the
> uart_port_tx_helper_limited() and uart_port_tx_helper()
> macros that can be used directly from drivers in place of defining
> local functions, with the (alphabetically) first two drivers
> converted to that.

If there are no objections, I will push the patches this directorin. I 
like this more than [v2] or [v3] (the helper macros). Actually, I 
mentioned this wait_event() style in [v1], but I perhaps simplified the 
concept too much to completely eliminate the need of a wrapper function. 
And that made it too complicated/too hard to understand.

Except I'd drop the "_helper" part from the name. Originally (in [v1]), 
I had uart_port_tx() and uart_port_tx_limited() functions. In [v2+v3], I 
added _helper to avoid confusion as we were generating a helpers using 
the macros. Yes, technically, uart_port_tx() is still a helper, but I 
think it's superfluous to have it in the name now.

thanks,
-- 
js
suse labs

