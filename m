Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5916A626F4E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiKMLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:36:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440E81144F;
        Sun, 13 Nov 2022 03:36:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5so5498746wmo.1;
        Sun, 13 Nov 2022 03:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zEdIkkHvKR4gk0w43HK5snq1259xyuy3gybMfLvW/jU=;
        b=qFsk+k23otSyWR8OV9N0jUvbyfP/DHR7vbI7sW+v9FFuMn5UVHyMXiGDDvtzR1oeWc
         A1MtxYxQUeNcYyK+jStIBgXVCC6a+/eQjwSDm1jCUjpw1yeTV54MryGZmnHeZ0N8oFIv
         1HJhXyvop1bsrcnExO4q0q7C1zeo1BKHna4604/IoTKyzoiz/Frc4qMs3v86Q+eo2iV7
         0djE5sHI0PfXrygHfyGbX1gJDJxPkm8PBdV1VjJwIQnyqYmS2DJh9R9vRIeZTkCg5GAZ
         o+ADsRpZZ2cEFxeTOHPHwJUweZMwlGmz4u+5ze3FsH0JC4/z4PMlejJCTInwztVqXvFq
         i0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEdIkkHvKR4gk0w43HK5snq1259xyuy3gybMfLvW/jU=;
        b=hRSA7V8BmC8cus3uM1esDWU7RIaDl1Gge5JOC+h1/uERNgu02Is47RtIIZw5nAutEC
         emaTtuX4z7MX2fsNIDuz5VoLYyND07lcKm3xByC1WMon/M5FLOP+mhgBN/smomPrrVUn
         UgNtBSYnBz8jZH+X2Ml61K/ylM9Y/zeTLESJzojjqyYp2CGEFGx+sK0X6gwYiUJJuHlR
         Y3uvlBstw5nkxDUxUXmPQObPSQ+zoHd82Pyk5y4dfWZ4iLor5ZkGotkaN2JQjI3iri6y
         /I4WJU2LxfV1pnER3+iqlfJxV0LAC6zl043+GLABbWTvt/nKrnc/5fMHXv/QjIn3zpbk
         p0ng==
X-Gm-Message-State: ANoB5pnijEy3nEAjax0PSgXJsqfd9r6KalCPMA2DQ1VKoSwB0oPatnjy
        zR5ZSVGFaZ0XePHXaLtU6y6fI1RQhZnXSA==
X-Google-Smtp-Source: AA0mqf6v83xFeQorrHGS00vmZtoIGJoI9v14LcidKcxRQVIb4h3B0fzLCom7ZPmlbWvGz9up3mBhtQ==
X-Received: by 2002:a05:600c:4e4d:b0:3cf:81b1:bc7b with SMTP id e13-20020a05600c4e4d00b003cf81b1bc7bmr5486284wmq.121.1668339371702;
        Sun, 13 Nov 2022 03:36:11 -0800 (PST)
Received: from [89.138.235.186] (89-138-235-186.bb.netvision.net.il. [89.138.235.186])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b00236722ebe66sm6775658wrn.75.2022.11.13.03.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 03:36:11 -0800 (PST)
Message-ID: <100ff22d-8aab-e07a-9aba-0608a05e02a6@gmail.com>
Date:   Sun, 13 Nov 2022 13:36:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] char: xillybus: Prevent use-after-free due to race
 condition
Content-Language: en-US
To:     Hyunwoo Kim <imv4bel@gmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu
References: <20221030094209.65916-1-eli.billauer@gmail.com>
 <20221113080558.GA5854@ubuntu>
 <2a8f59ac-9d49-ffa3-b035-809f2fac38ec@gmail.com>
 <20221113084740.GA6458@ubuntu>
 <c9a03f08-8117-cd24-b4e3-9e097e3069f2@gmail.com>
 <20221113091415.GA8314@ubuntu>
From:   Eli Billauer <eli.billauer@gmail.com>
In-Reply-To: <20221113091415.GA8314@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2022 11:14, Hyunwoo Kim wrote:
> 
> It seems that you only need to move the location of unit_mutex
> in xillybus_find_inode().
> 

Agreed. I'll prepare a follow-up patch to fix this issue as well.

Thanks a lot for drawing my attention to this.

   Eli
