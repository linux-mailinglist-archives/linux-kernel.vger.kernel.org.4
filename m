Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20E7359ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjFSOn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjFSOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:43:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2898592
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:43:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so186551e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687185799; x=1689777799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jg4ozZVfolPqyn/t5WEFg1Uls/OOAkHpHShj9UmDbj0=;
        b=XM/YRcXn05iISSP7KE+IKbXpoTRTcJ718yU5TO6gcp/oHw+hYoh0ZSL4WhK5bcd+jf
         6mAAKvJM6L/16KW2cU/etYW1s4n/kP+ZnqPLRw8j4gkGd0gBhg1EckAqltFK62g5BFYv
         F4qZ8WHPYxeuBDUf/227tO1lNgF62oIqWUhWUrhBf9LFkoyFtowqLyVpxk38pWpTioks
         T7z7sbBXhgtHTmX23pNuwBDYalbF+BQqJh5pyC+/pn403N4z5DFsbO0q8GwU0+Gh0Tmo
         BacDMSvWblkXQmOTRpcEQLKJNp4qvOSKcG6e6P5B9YRsKldgvakXMH2eSJMQySdw+iGm
         LCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687185799; x=1689777799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg4ozZVfolPqyn/t5WEFg1Uls/OOAkHpHShj9UmDbj0=;
        b=AcuTjVm0VYafuZ2dQ0zxztr4fmPUIqlESXvWgqhbJ3R55vuOplmtpIoPVFuWS6opgI
         jztSbm9MQEF8jnECSNz6appGeHpToXXyt/gzaQhHFzPEL3tz5SmMv2qpOzhnm1UZjjg1
         4MJOR4fZyfRpX/ebmhJc7NMbNYcxNhIKkDKUnuluizL02BdNX9JI3ZVNaCKM5URVW0eG
         Dgcdun42aDqRVpbY1TcuvWV+PysnoIPnyHTxFnE0TD4FgMONWAZ+11Z3oyR7u8XXB1Ig
         +JyvBFtCYY35lWuM2Rf63jv91nGftPyBiZ5WIGmuUKAklKikSN/uv5IVHhH/ylZK0nOn
         fVIA==
X-Gm-Message-State: AC+VfDy4BoNTO0EZReA15+p925/0b/MevjcfJJE1Egj+Kl2ALwyBdB3A
        j8M1ReL/FuSFkYQ1zLLsHEJX9g==
X-Google-Smtp-Source: ACHHUZ6jK/vkslU8B7BumS0VEdj9EzsfjsiTwLT42WV7OsJvLgsBm6xMwCmMKVvxkyum5HDdV4pj/Q==
X-Received: by 2002:a19:da01:0:b0:4f8:3b15:b878 with SMTP id r1-20020a19da01000000b004f83b15b878mr4868043lfg.67.1687185799177;
        Mon, 19 Jun 2023 07:43:19 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k6-20020adfd846000000b003111025ec67sm13972121wrl.25.2023.06.19.07.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:43:18 -0700 (PDT)
Date:   Mon, 19 Jun 2023 16:43:17 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH net-next] netlabel: Reorder fields in 'struct
 netlbl_domaddr6_map'
Message-ID: <ZJBphdB/7k0Hk8y2@nanopsycho>
References: <aa109847260e51e174c823b6d1441f75be370f01.1687083361.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa109847260e51e174c823b6d1441f75be370f01.1687083361.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Jun 18, 2023 at 12:16:41PM CEST, christophe.jaillet@wanadoo.fr wrote:
>Group some variables based on their sizes to reduce hole and avoid padding.
>On x86_64, this shrinks the size of 'struct netlbl_domaddr6_map'
>from 72 to 64 bytes.
>
>It saves a few bytes of memory and is more cache-line friendly.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
