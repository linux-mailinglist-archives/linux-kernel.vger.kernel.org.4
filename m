Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD76CA587
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjC0NXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjC0NXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74730268B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679923350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swmjhnNjkaqtpqt5Pl5MGYtRoGQ0+bZAAWUhMT4BRK0=;
        b=UOjvW/UR/LW1cMSbiKq9kuHMtKwhlb2BBF6FRyoFXnP0k8JhYKPlzIK9BOD/EHcAq2sSfD
        AGCB3mm5mcTwDQH0yZd/jQ/px4YAJqlOZr+cEtQwtJKYtMdVoYNVfG/hxhenfsGufT7Jwv
        iZ7XqM19Z4wZ9ce+j0tOeJ1d8vu0iHw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-uuLtO8nJOp2DNTv4I6oN0w-1; Mon, 27 Mar 2023 09:22:29 -0400
X-MC-Unique: uuLtO8nJOp2DNTv4I6oN0w-1
Received: by mail-ed1-f72.google.com with SMTP id s30-20020a508d1e000000b005005cf48a93so12571791eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swmjhnNjkaqtpqt5Pl5MGYtRoGQ0+bZAAWUhMT4BRK0=;
        b=U9UepMt8DPIscOrFchMVC38n2iAG2VqzA1Cuo2OCBWG3hTm+vPjHP1acQNZHJKSSUO
         6I0fOyE3MNkLm7sFiQ3WE6wpTIA1KNMWV74wkaWIr7Ie5PWaHQAb9W54gSnsA8zbapNQ
         3f0Cqm/NacEx9sOUS+YUVNwlsiXHeiVLKRc1NEugjYY6hJ0FTQgHgTsQdPXr2Y0hQlen
         cLRJbAlSOxgiYlZSBbGa4qMhxH6VL6tXHo3LSF8N/1TxKGU9eHYGoVnNNwxVFaEhmhfo
         rgsvJhzR4EpMmgk2SfboG6nawaGv9FSuWznAvCXgual+cemBenPlGKs8zYqGLEKxKAbM
         NLmg==
X-Gm-Message-State: AAQBX9fQlrzur9muUM8zMT2N32C/opeD3FTlcoZFuSAyymes5s7Q5caf
        FY/sZF7Az4m4HOBBd1PL7XchbRc1RGBnsviwJhcCXCVWBKDE1yiVDDGA0+5hBqZ2xU2EL9cJxTV
        ZTPfBxCPA7nK8RU8rvgsFpdkq
X-Received: by 2002:a50:e70d:0:b0:4fb:f2db:a654 with SMTP id a13-20020a50e70d000000b004fbf2dba654mr12478359edn.12.1679923348095;
        Mon, 27 Mar 2023 06:22:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350b4UaXv+XZH07n/yn7/2WM1DdUToTaKHOUQV906oWpHknoHH5Ayl+UBoumuWCRysYszp0+LhQ==
X-Received: by 2002:a50:e70d:0:b0:4fb:f2db:a654 with SMTP id a13-20020a50e70d000000b004fbf2dba654mr12478344edn.12.1679923347837;
        Mon, 27 Mar 2023 06:22:27 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a25-20020a50c319000000b004bc15a440f1sm14792601edb.78.2023.03.27.06.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:22:26 -0700 (PDT)
Message-ID: <7057612b-f82a-5d57-df03-1986b23127fb@redhat.com>
Date:   Mon, 27 Mar 2023 15:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] platform/x86: gigabyte-wmi: add support for B650 AORUS
 ELITE AX
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@weissschuh.net>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        got3nks <got3nks@users.noreply.github.com>
References: <20230327-gigabyte-wmi-b650-elite-ax-v1-1-d4d645c21d0b@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230327-gigabyte-wmi-b650-elite-ax-v1-1-d4d645c21d0b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/27/23 15:05, Thomas Weißschuh wrote:
> This has been reported as working.
> 
> Suggested-by: got3nks <got3nks@users.noreply.github.com>
> Link: https://github.com/t-8ch/linux-gigabyte-wmi-driver/issues/15#issuecomment-1483942966
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/gigabyte-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index 322cfaeda17b..078afa98e6c6 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -150,6 +150,7 @@ static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550I AORUS PRO AX"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M AORUS PRO-P"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B550M DS3H"),
> +	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B650 AORUS ELITE AX"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660 GAMING X DDR4"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("B660I AORUS PRO DDR4"),
>  	DMI_EXACT_MATCH_GIGABYTE_BOARD_NAME("Z390 I AORUS PRO WIFI-CF"),
> 
> ---
> base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
> change-id: 20230327-gigabyte-wmi-b650-elite-ax-003f0b58e3c3
> 
> Best regards,

