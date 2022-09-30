Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA145F06FD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiI3JAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiI3JA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B10157573
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664528427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e5ZYOZmjWVg8D52uEiY1GVsoniAEpU3zbZzf0uuSNYs=;
        b=ShV4MaVPoUbTW3nXleC1egUjvYJWC6UjNhygTHt9YJKstEslcYPkwGvavbmavPVm1KW3Y9
        1gITD6KMuQQHjmEW/YGrK2RgeAaVfAWCg4azbc98Yf84QVN9yNsyg6JvmGOBv15kEmEU9k
        LlV3fVYNJxS4Q9F6STHsYE//HgbNT+g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-x49ZceMyNWahCo6dCIWhlg-1; Fri, 30 Sep 2022 05:00:25 -0400
X-MC-Unique: x49ZceMyNWahCo6dCIWhlg-1
Received: by mail-wr1-f72.google.com with SMTP id s5-20020adfa285000000b0022ad5c2771cso1333586wra.18
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=e5ZYOZmjWVg8D52uEiY1GVsoniAEpU3zbZzf0uuSNYs=;
        b=zJAwWj3wvhpQnxavuDXf6BbY5PADzU/Rf2ctw8aUiV8CgeWvD9I+lsyO1AZNt0NTvN
         SMtAHR9LZBcxRmFktrMJrW+Lj/fWlQvn5Kl8oPIVnT4qGUcY1G/agw1tWV+XoAAcQM+v
         7te7vgT5CDorcMduiNLnJ4MAcjX3O3TitlAlf1iYpdCWIKT4lvFyAJl94osS+gZVye9M
         RCERENSVACLxt4flyzhlrwn7t0cKz/I19fyz4zXogwkMgQercZt+1Dx1AmMJEYkCpp/u
         T0yGlGVwswaJT+cCJgVb7gOHH2+rl4AaQopaII5EkSwawyOe0jrIJHaP2tpkRRNfCOM3
         1uXA==
X-Gm-Message-State: ACrzQf1TXcWQRFiJAXEFmnDJ8pXFIDOePDZ4SRT6qZ+rBJFnxjo4qt/B
        D+ITBm3al5RzO1gbiCl/e6q7j05Yunkoa61wNQm4qaIdS16UEFHltzRYfiUQAGY0uvdFq7tt+Tg
        fj/FOeZMHio7h8FEuMyRh07WL
X-Received: by 2002:a05:600c:218d:b0:3b4:7749:c920 with SMTP id e13-20020a05600c218d00b003b47749c920mr14038635wme.190.1664528424678;
        Fri, 30 Sep 2022 02:00:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM56kix7o7o0o8acTXkRZX11JFs2khtHABKoMBpzE3+fY/pl2285mS4RWYAgsnPu5u6Mha/J1g==
X-Received: by 2002:a05:600c:218d:b0:3b4:7749:c920 with SMTP id e13-20020a05600c218d00b003b47749c920mr14038613wme.190.1664528424401;
        Fri, 30 Sep 2022 02:00:24 -0700 (PDT)
Received: from [192.168.100.81] (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d6dca000000b0022917d58603sm1459613wrz.32.2022.09.30.02.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:00:22 -0700 (PDT)
Message-ID: <1ec3ff28-04e7-1b31-5cb0-fd0fde8f582c@redhat.com>
Date:   Fri, 30 Sep 2022 11:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] exfat: use updated exfat_chain directly during renaming
To:     Sungjong Seo <sj1557.seo@samsung.com>, linkinjeon@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20220608020502epcas1p14911cac6731ee98fcb9c64282455caf7@epcas1p1.samsung.com>
 <20220608020408.2351676-1-sj1557.seo@samsung.com>
Content-Language: en-US
From:   Pavel Reichl <preichl@redhat.com>
In-Reply-To: <20220608020408.2351676-1-sj1557.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/8/22 04:04, Sungjong Seo wrote:
>
> Fixes: d8dad2588add ("exfat: fix referencing wrong parent directory information after renaming")

Hello,

I just wonder, since the fixed patch had tag: 'Cc: stable@vger.kernel.org' should this, fixing patch, go to stable as well?

Thanks!

