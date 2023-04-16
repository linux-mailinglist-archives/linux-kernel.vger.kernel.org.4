Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA38D6E3952
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDPOfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDPOfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:35:17 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F887210B;
        Sun, 16 Apr 2023 07:35:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-760f5070ccfso8251639f.2;
        Sun, 16 Apr 2023 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681655716; x=1684247716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9KpJPbflQXiEf80alEmLHqabDQeRGmdrd1yTysWYt0=;
        b=qAZFn2gH3LvXz4mZOwXu789cAJoBQsrJOy4++peDdsvhJphXOmrT1jU1POKwf0LS8s
         YFmiJV4LWgPcc1vUWzy1i4oqpifC2FV8ZgmSPfoGN5trktOsWYjmMUeDaBSSGObuIP1I
         +SiLYcS2wsRwidD4TZ9Om5dW0foOiW552wKrdevdUumP/LFJIGdg7k/xbiY2Lplv0qK7
         0KJnF/rEpzkPam7tKscmaVNoEpuYNiPKjyrme1SN1Ha1lpfPPY2NRk3udTPKY8k12IvS
         1cj8CJTd8HHknE+VLqIuRkgub8oExfLhKnZVGNBYAXar9wotnW1dltLbcWrfFYjks/Bz
         Q54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681655716; x=1684247716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9KpJPbflQXiEf80alEmLHqabDQeRGmdrd1yTysWYt0=;
        b=C4mIbIZFFgP9zDtE3CbpB7LxJT0X4rBlJWLNEPQcT08eft0z5VK5u2WEp060h/9ln4
         ytgUXLfBJP86tko1mrA2Y7O8haGzTZGOD5wUYoMB5QY2/Mv6DKFtJLYc1hdsRyR3LY9b
         dNu+0m3Q+mwcyvQ8RW/RQLHdGW9FjOunjWJ58N694fBOhnQHkkcWsdvxq8dPbrteDUYA
         9rl4ZjcLQAdkuSE0UOU4yM0EEeVM1HQOAPUnF//NdMZSOwOuX/DBzhenTfQSy3DQ6JCW
         1f7av2WgnPVYmVTut8wWUEw/rqxEfoLikPqBhmjb7dhoZ7n0x91FC28C3kqXHxE/NQHj
         FTIg==
X-Gm-Message-State: AAQBX9eoT+eT2/KH/KftKJZjaMnS1qLVnzmBrOBTV/J0JC6p3Z5MHEpP
        ov3CBQMdV7ObD2Pb6p0UrhIKK4WIuVQ=
X-Google-Smtp-Source: AKy350YAVnDhsREuWeyJPfIshNjOz1BwxduyrE7Og3xQsyke8n4KwvohLauIkunC/pamjPDJBbmDwA==
X-Received: by 2002:a92:c8cf:0:b0:32a:b78f:e7d5 with SMTP id c15-20020a92c8cf000000b0032ab78fe7d5mr4595380ilq.27.1681655716411;
        Sun, 16 Apr 2023 07:35:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l15-20020a02cd8f000000b0040bd610a08asm2626623jap.18.2023.04.16.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:35:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 07:35:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Babu Moger <babu.moger@amd.com>
Cc:     clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Baski.Kannan@amd.com,
        yannick.hemery@corp.ovh.com
Subject: Re: [PATCH] hwmon: (k10temp): Check range scale when CUR_TEMP
 register is read-write
Message-ID: <1afe95f1-cea1-418f-b9a1-23be6817157f@roeck-us.net>
References: <20230413213958.847634-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230413213958.847634-1-babu.moger@amd.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 04:39:58PM -0500, Babu Moger wrote:
> From: Babu Moger <Babu.Moger@amd.com>
> 
> Spec says, when CUR_TEMP_TJ_SEL == 3 and CUR_TEMP_RANGE_SEL == 0,
> it should use RangeUnadjusted is 0, which is (CurTmp*0.125 -49) C. The
> CUR_TEMP register is read-write when CUR_TEMP_TJ_SEL == 3 (bit 17-16).
> 
> Add the check to detect it.
> 
> Sensors command's output before the patch.
> $sensors
>  k10temp-pci-00c3
>  Adapter: PCI adapter
>  Tctl:         +76.6°C <- Wrong value
>  Tccd1:        +26.5°C
>  Tccd2:        +27.5°C
>  Tccd3:        +27.2°C
>  Tccd4:        +27.5°C
>  Tccd5:        +26.0°C
>  Tccd6:        +26.2°C
>  Tccd7:        +25.0°C
>  Tccd8:        +26.5°C
> 
> Sensors command's output after the patch.
> $sensors
>  k10temp-pci-00c3
>  Adapter: PCI adapter
>  Tctl:         +28.8°C <- corrected value
>  Tccd1:        +27.5°C
>  Tccd2:        +28.5°C
>  Tccd3:        +28.5°C
>  Tccd4:        +28.5°C
>  Tccd5:        +27.0°C
>  Tccd6:        +27.5°C
>  Tccd7:        +27.0°C
>  Tccd8:        +27.5°C
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Applied. Please update your e-mail address configuration to avoid the
following checkpatch message.

CHECK: From:/Signed-off-by: email comments mismatch: 'From: Babu Moger <Babu.Moger@amd.com>' != 'Signed-off-by: Babu Moger <babu.moger@amd.com>'

Thanks,
Guenter
