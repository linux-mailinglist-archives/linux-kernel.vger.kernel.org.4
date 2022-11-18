Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9FA62F604
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbiKRN36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241597AbiKRN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:29:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D883D532E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:29:26 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j16so8179653lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/TyOqr73oo6gB6yR08kHAfoWVVQLDrClTo0sJTWwhc=;
        b=CmrWBXFllKIQAsoSTeOMuz2gdKXRU9BA6YQPz6GcNHw8gIIb2PyFCYmnzOn5Wm0OK0
         jUN07r6dzLtojBMomFaxN6WRPZ0nhvGH0A1AN2owJjGfUN+3lRO6NYdKktYQipEkTfOb
         DrJeCsufw8b69Yp+fQqqj8pVaHYkchrK2ibwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/TyOqr73oo6gB6yR08kHAfoWVVQLDrClTo0sJTWwhc=;
        b=hG0YfbDLtssfM5qKQE0ku68S5rPIyMXldkW9FLdehyQFoGKxmKfBYk6dvji5VfAEpS
         SHCLzOkcH5OSZDdy9Fmfq4S9IUJEaDlxGG3ms35mgvW6sKCP+TPYrcPsLVbddEve8KQm
         Krsy9oYNMakrMcCkHGRGTefcsvBJVZuBul02typZC5if3HuPDWAkzPbfz+C/XI6lzVZg
         P2hiR24/JwffrYRgoxvFQ4PxkB6b3gedMqWHHImq5bd5XAiUKpnSHCL+v21jH/BOYqXr
         3cbJafnpZLbT3jdLzp11mSP8bCb+wp4S+ZPKpH5dyMmji7wiFl2hoKbpfNEJjrQqsmUX
         0IuA==
X-Gm-Message-State: ANoB5pm3CQBeGqRNm/3K0puJhHvlrQmMAAT5pmBgGnMbcgTkYbAt08zv
        0O4IJBNppOfNbvwUucyAGnS/iA==
X-Google-Smtp-Source: AA0mqf7PW78FYCP+kjvydfHU5oMH2AIMPUs7xKcByPxInuLc8lVC/femYfseh7ZMaBgKL53nRyPDPA==
X-Received: by 2002:a05:6512:34c7:b0:4a2:2b23:f17f with SMTP id w7-20020a05651234c700b004a22b23f17fmr2285963lfr.688.1668778165188;
        Fri, 18 Nov 2022 05:29:25 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 13-20020a2e164d000000b00277078d4504sm656431ljw.13.2022.11.18.05.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:29:24 -0800 (PST)
Message-ID: <b81d2ffe-efc3-8e2d-de7b-ed2bfa2449d0@rasmusvillemoes.dk>
Date:   Fri, 18 Nov 2022 14:29:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] iio: addac: ad74413r: fix integer promotion bug in
 ad74413_get_input_current_offset()
Content-Language: en-US, da
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221118123209.1658420-1-linux@rasmusvillemoes.dk>
 <SJ0PR03MB6778D6C0682294002296E54C99099@SJ0PR03MB6778.namprd03.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <SJ0PR03MB6778D6C0682294002296E54C99099@SJ0PR03MB6778.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 14.17, Sa, Nuno wrote:

>> Casting to int avoids that promotion and results in the correct -32767
>> output.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
> 
> After adding proper Fixes: tag,
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>

That would be

Fixes: fea251b6a5db (iio: addac: add AD74413R driver)

Thanks,
Rasmus

