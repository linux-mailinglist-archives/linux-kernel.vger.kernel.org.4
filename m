Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1775770D629
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjEWHz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbjEWHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:55:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E5910FF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:54:38 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 59AD041272
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684828449;
        bh=2vdfEhfEbhGKToEgGCpfJjjBo5+jZgZhhMio7IC1pec=;
        h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
        b=t9Ba7F7f6gmywLtxzNsGrpz37HxL4LB995IfkeeQRscpu3DqP8b5JsYpGNq1T24Rf
         jbuvCFemvL70mtxlQoPR3r1CEsXvvKXPbTiycwLyjw9RKbFm1Wt3HUfMvjsF5H+7FD
         nI5nMX4JFYmpSRY3ksnTgnlONc8m/jLPbCawXAJ5xPZKrbcxaq0++jMwa+KExC/UiF
         ULXrE9mEVBvsXvU5qFeBg+07KDEgtr8BOxNxsxjDGqjhQkYfQc3jFPtlTjs2HB4/O9
         ODPJRoBiH++V/DtrQbN54iot6NlQ83Zh6ZOBY1ilhC32GgqMTGd4zaYk0p9phXDSck
         kpDPVqd6M3eVw==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50bcd245040so778687a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828448; x=1687420448;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2vdfEhfEbhGKToEgGCpfJjjBo5+jZgZhhMio7IC1pec=;
        b=Jg91kfPJdXS2ZwsFK4TZaDRhtU9y5GYh2pfi5oJ/a3hRkbS1TMEqr/fNaBgMVgXp6w
         pIrYQGaIZcS6YVjYp3ClJaPlluSak/ITd8J1cxAY3R0xRB042xGv+a2eYjxR+1xkX8c/
         bi21kZHn2qk5ic4FRTfHjp0p8UbdYDlFYwOTNKsfWZ2flVfEf4qRN5dRMkoN98GpaSPd
         0H8Z0LjbO+fhz5T9M6UUvgJCGr6dMJ2M47766l6/MreNxThsqqZEHDTFBkstjyp6RP25
         KB6kQ6a5k3t++FJvheII6bnyOEFsPQ4DzANUieAu/LoOKqtTKKRjjz+tm1pW7N0rqk3C
         LZiQ==
X-Gm-Message-State: AC+VfDxtnIBggmsgYqzGNgxX5hjvVbDQ3U2t2QvOWPEB+M7cJ7y97hGh
        gLTJuCdGgBxx+784lWeQ9ZN747n96FRj7N4Gy6lH712EQYUmumZabG0GZwoV3+R4OZZ4PD6qfbE
        92Bp5zTCZqK9opt0PXPMlqooCf/jduI6gcHf+Yy0d7Q==
X-Received: by 2002:aa7:c387:0:b0:50b:fb85:8608 with SMTP id k7-20020aa7c387000000b0050bfb858608mr9512198edq.25.1684828448235;
        Tue, 23 May 2023 00:54:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ614T5qd3IOAYDd+hKdw79g7t/FzO5vlLLmvpMnQIMxNWV1Fe70N74Ytv61sx4QHR7rblD++g==
X-Received: by 2002:aa7:c387:0:b0:50b:fb85:8608 with SMTP id k7-20020aa7c387000000b0050bfb858608mr9512191edq.25.1684828447974;
        Tue, 23 May 2023 00:54:07 -0700 (PDT)
Received: from [172.16.80.41] (10.238.129.77.rev.sfr.net. [77.129.238.10])
        by smtp.gmail.com with ESMTPSA id k3-20020aa7d8c3000000b0050bfc4a9020sm3830973eds.38.2023.05.23.00.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:54:07 -0700 (PDT)
Message-ID: <f19a6d8a-c85a-963e-412e-efaa7f520453@canonical.com>
Date:   Tue, 23 May 2023 09:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-efi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bungert <daniel.bungert@canonical.com>,
        Olivier Gayot <olivier.gayot@canonical.com>
From:   Olivier Gayot <olivier.gayot@canonical.com>
Subject: [PATCH v2 0/1] block: fix conversion of GPT partition name to 7-bit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

This is a no-change resubmission of a patch that I originally sent to
LKML without CC-ing the relevant subsystem maintainers:

https://lore.kernel.org/all/4ae6d363-2f9b-5028-db1a-061b6f1e8fbe@canonical.com/

I apologize for the oversight in my previous submission. 

--

While investigating a userspace issue, we noticed that the PARTNAME udev
property for GPT partitions is not always valid ASCII / UTF-8.

The value of the PARTNAME property for GPT partitions is initially set
by the kernel using the utf16_le_to_7bit function.

This function does a very basic conversion from UTF-16 to 7-bit ASCII by
dropping the first byte of each UTF-16 character and replacing the
remaining byte by "!" if it is not printable.

Essentially, it means that characters outside the ASCII range get
"converted" to other characters which are unrelated. Using this function
for data that is presented in userspace feels questionable and using a
proper conversion to UTF-8 would probably be preferable. However, the
patch attached does not attempt to change this design.

The patch attached actually addresses an implementation issue in the
utf16_le_to_7bit function, which causes the output of the function to
not always be valid 7-bit ASCII.

Olivier Gayot (1):
  block: fix conversion of GPT partition name to 7-bit ASCII

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Olivier
