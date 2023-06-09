Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABA772974F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbjFIKrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbjFIKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:46:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962644AF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:45:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f658a17aa4so970477e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 03:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686307517; x=1688899517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l264HfNhj+I1zkWrab2NzgSBNFP/DUaaconpEt52myg=;
        b=B6z+QsPVviwU5H+5LlhxbNDzDuEjDCO5y2yOazZM9y8hZ2YBIhMeLGFo3mT2GUR3vx
         lpDfAoaaa7u2g9v0GaB9sUQZZRNLxCJG16wZXZECGw/IzGe/g/y+aRaXm3xsf2p9dHvj
         NOhOEdmwYpQaHSTy5Hyfvcy1cng13Dygz8ZCKIVD57KtMsHARK2t0vbjfAK7SIQUnkPh
         5GF2oPKx2rQLS5Y/z5FOa7dbTNk+7XVWsIeTDi+5w/ZlkQXR8ZfWj52eqQcJ7FnspHuh
         7TSncW2Bc3RJee05S2DKXhqDxZ6uITZjI76yd18Hk0r75DT26iyGJmw7LMVJG2uCPC5K
         eO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686307517; x=1688899517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l264HfNhj+I1zkWrab2NzgSBNFP/DUaaconpEt52myg=;
        b=P0rnvunsBdUAq+eAOI4AJ4jyf8XgTf+E7IxlLVFn7K2mhZTxDZmDPIU4dLyKcnEmPx
         wN4OwXj2bO9xKopXns0Zs5ByeOVMabgKWKPIsxCiwXNPkQ/dqxQBnpS9HRaEbCsUaSWM
         E8jpsqCtFh/9A/t7ExlTCb1ZsnYaHL0iX9u7oeJB4OBBivufDyzEzgVycBVegHXkqniA
         XOKkE1Lqi9mBCU6DtGACHEX3UH7nUfvXqObW256nvFJSJfKXCJoPvfniq2sN2eOCkMlr
         1xx5z9NLC9TEw601HIkyo0BrMPVZPB2ozqDl4/zWOg01ivNHF8WKkKJztjoupCcVuSuD
         IJSg==
X-Gm-Message-State: AC+VfDx8K4O5DnpeUHEpgmrb0+GwCb40AYA44JFBjE8rBB3sZOszGg5+
        C5PoQPNMB8zbTGMG2UZi/v0=
X-Google-Smtp-Source: ACHHUZ5gL87Vi6C0CY5jFyU11r4cHGkTP6mC/+vKp5n+FdG92YKf9JPAWxZP4tlsu9T3j2oGzwYBHQ==
X-Received: by 2002:a19:8c0d:0:b0:4f4:c973:c97f with SMTP id o13-20020a198c0d000000b004f4c973c97fmr645304lfd.49.1686307516870;
        Fri, 09 Jun 2023 03:45:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id q29-20020ac2515d000000b004f39868bef1sm506966lfd.209.2023.06.09.03.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 03:45:16 -0700 (PDT)
Message-ID: <c9947378-419b-cd35-73fe-aa1564340d2b@gmail.com>
Date:   Fri, 9 Jun 2023 13:45:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] regulator: Use bitfield values for range selectors
Content-Language: en-US, en-GB
To:     Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230608075651.3214540-1-wenst@chromium.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230608075651.3214540-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 10:56, Chen-Yu Tsai wrote:
> Right now the regulator helpers expect raw register values for the range
> selectors. This is different from the voltage selectors, which are
> normalized as bitfield values. This leads to a bit of confusion. Also,
> raw values are harder to copy from datasheets or match up with them,
> as datasheets will typically have bitfield values.
> 
> Make the helpers expect bitfield values, and convert existing users.
> Include bitops.h explicitly for ffs(), and reorder the header include
> statements. While at it, also replace module.h with export.h, since the
> only use is EXPORT_SYMBOL_GPL.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

For the helpers.c and bd718x7
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

