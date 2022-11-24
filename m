Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3D63748D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKXIzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiKXIy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:54:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709919BA30
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669280039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiwYY0ArmcwNEs3ZnhJIxu5/iohIROkA/VLDy8Y5Zqg=;
        b=Has6Qu/i+lKk3KKB/AMhFF1dZvlO3Uj6A8nWAVrfSbOahIgNnDbl+UsSUbp00dup6iJTP/
        x+LTV1vaq24FBrl5+frLuEM73xYaS7J1XwHHcX1TImTMIi4mmVeqx/ZsPkN7LWkMGWbswd
        1aivPkgm76libjk0LoJJjL0yytbrpdA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-qsOcMBMvN3GaejeDQuudXw-1; Thu, 24 Nov 2022 03:53:58 -0500
X-MC-Unique: qsOcMBMvN3GaejeDQuudXw-1
Received: by mail-wm1-f69.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so2306853wme.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiwYY0ArmcwNEs3ZnhJIxu5/iohIROkA/VLDy8Y5Zqg=;
        b=N+HT2a235S2zOi9NnUniwMbNd5A8n6tBrcJcnfbYuvJkZIxAde/WGvrM7Tebjdh5uK
         eYHHJgIe+5+PfTB+h2XitAH5ABy+tvn2CwiX7FiDa1bJ+wrqv8SfK5eGTQAFtQoRyTT6
         cRqd3Wq6/G+Qc6WyDo2ElM6u+sSQhr6J4Pj4ufgYTRfEzAe/4DUFBTq7Tw0f+5+T2Uf+
         uHrHH/kS8M5+4/69qgKaTbYJlJw5E2rH+0J0YYpBbuia/jP/wLvVvrAg0Jd7f/7PEjXr
         OobbjlHxFa42ohocRKZoENcDKkRvcB4YeRej1/DZ54Z3wijbDQ7CwWQvYFpLOr0B7e9a
         U4UA==
X-Gm-Message-State: ANoB5pnPZzeJqwqQQdXMbmRoiSR+SAQnSudmSeYLkLwmv901SCoBiiqy
        Zo8R80OAe5g03p77cqnkF53XM2l0cxoFF20wNqgRit35CS89OzUxICaGCl+uJ9dMVIGiWX7esFu
        evyfsRAZY0xO8HTfzjUm5rN9G
X-Received: by 2002:adf:eb8a:0:b0:22e:31b2:ecb9 with SMTP id t10-20020adfeb8a000000b0022e31b2ecb9mr19913568wrn.693.1669280037227;
        Thu, 24 Nov 2022 00:53:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Q3UK1gtwV9Cl6cT5+gn6Q35c0U9XtUClfYgVPHs0+t78TenmzqkMgjcKnXNrJF1yXjR6ieg==
X-Received: by 2002:adf:eb8a:0:b0:22e:31b2:ecb9 with SMTP id t10-20020adfeb8a000000b0022e31b2ecb9mr19913554wrn.693.1669280036964;
        Thu, 24 Nov 2022 00:53:56 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id n6-20020a1ca406000000b003d005aab31asm4802235wme.40.2022.11.24.00.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 00:53:56 -0800 (PST)
Message-ID: <cf297dd17750f988128df88c824f956f2a4bb719.camel@redhat.com>
Subject: Re: [PATCH net] net: hsr: Fix potential use-after-free
From:   Paolo Abeni <pabeni@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, arvid.brodin@alten.se
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Nov 2022 09:53:55 +0100
In-Reply-To: <20221123063057.25952-1-yuehaibing@huawei.com>
References: <20221123063057.25952-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 2022-11-23 at 14:30 +0800, YueHaibing wrote:
> The skb is delivered to netif_rx() which may free it, after calling this,
> dereferencing skb may trigger use-after-free.
> 
> Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

The code looks good, but the above is not the commit introducing the
issue, it just move the netif_rx() and later skb access from somewhere
else.

Please go deeper in git history and find the change that originated the
issue.

Thanks,

Paolo

