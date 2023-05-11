Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DB56FFD83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbjEKX54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbjEKX5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:57:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF149E8;
        Thu, 11 May 2023 16:57:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so6239540b3a.1;
        Thu, 11 May 2023 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683849474; x=1686441474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2h69nhToDVZbyjQX2oWwiTb7dkD95akNUfm0wOkfgQ=;
        b=Um17SmwS45I4PBkU+IOxjjdL8kv/2+KBklavxxKDfc3n5mXlcmws8jlG41ySudtGrG
         d7R6+3zN4XDOGKNPQlj1jybAwibHwscWHvNdSQITKnmZOuMkSH9LU8A68NcvaD+UFKgd
         rgB07JW8TNyMaUqGdThxHJaQ6G6B1HKuc7HxcJ4zhezUa+b6rIAZ/fBdPnH90eAMuqOt
         F9qFyZla+0w18ql4qOrRMEhKNCDyP8xUR4WUL2Tysil8W4/TsZD5GrjaeaKq3C9Rg54c
         fyOYvfFWs84EqjnLIsWlt7Al+LlGox9F1ijyuEsDtNy8VE052DALCkDxBe6uAFwbgegr
         74QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683849474; x=1686441474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2h69nhToDVZbyjQX2oWwiTb7dkD95akNUfm0wOkfgQ=;
        b=f4Go2+NWimgkkUyP8nF6iQAE5spmcw2RtwgbFqsl1yLw8AddFd5b8ZGgiHCL5UPa4q
         rJzKeaxXl2d1lIXnBa5JmbzOLngNIKdL7KbvdcqGsMROL23JH8HJDiWinIvUB65x/19J
         DlF3wbEC7Kzh8VPsjaUpF1f8xYpzwDS6JlYss8wF+C7fTVhIim+vgVl4lF6twugJ025E
         /n1Iq3PQmtuX/cGKVFG5gfP0fZNa+FTSq9WDKdIIioi8PWBHpkTGYhAEzHWDjd+OgdsE
         NB1MQG+Qvz8xyaXZGuB/Pa2TeESDQfK/rsmoY+VPIJxxInGfc6nx8VLYKi+XRWLsPRfU
         kyeg==
X-Gm-Message-State: AC+VfDxGTbqh0aKJa6nA3CIieUl/sBQoWC/gE8qM3edNZiyZ8LY8iufL
        QvkDchMazTavv7gzFL61TdI=
X-Google-Smtp-Source: ACHHUZ44R0EzFOe886ZeR21MsoCAgOCi/FQW/tCP0gvqq46gqRpM2r6NTzviqH023KF6u0AU+lobCw==
X-Received: by 2002:a05:6a00:22d2:b0:647:e45f:1a4c with SMTP id f18-20020a056a0022d200b00647e45f1a4cmr10749967pfj.11.1683849473542;
        Thu, 11 May 2023 16:57:53 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:53f7:c9da:338e:6206])
        by smtp.gmail.com with ESMTPSA id d9-20020aa78149000000b00639eae8816asm5822788pfn.130.2023.05.11.16.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:57:52 -0700 (PDT)
Date:   Thu, 11 May 2023 16:57:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Valek - 2N <jiriv@axis.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH 2/2] Input: cap11xx - add advanced sensitivity settings
Message-ID: <ZF2A/STY66sqoOLX@google.com>
References: <20230414233815.4004526-1-jiriv@axis.com>
 <20230414233815.4004526-3-jiriv@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414233815.4004526-3-jiriv@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sat, Apr 15, 2023 at 01:38:15AM +0200, Jiri Valek - 2N wrote:
> @@ -474,7 +645,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
>  	if (error)
>  		return error;
>  
> -	irq = irq_of_parse_and_map(node, 0);
> +	irq = irq_of_parse_and_map(dev->of_node, 0);

Do you know if this is actually needed or we can rely on I2C core to
figure out the interrupt for us?

Also, could I ask you to move the driver from of_property_*() to
device_property_*() API?

Thanks.

-- 
Dmitry
