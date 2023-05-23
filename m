Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3470B70DD6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbjEWN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjEWN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:26:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CC8109
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:26:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso21238165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1684848392; x=1687440392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wa8882brqQgfaqBSNJBl6uslG94ncgU4uoIf58nOBLw=;
        b=hdIPaBpjmBbqcN3z/LBvM13heonTzENrjLNOAmN61bjlkA4i2DYkpHXbtD2cq1teuY
         A7PxoQtJy5yrhpf3Q77PNeWeu8EER5SPmAbDb+SOKSxLIN+HJnjmhyh3MafFe9Y1Jqdj
         c6Mh8cGB1o9lzktYb454ARyJ+GBdGFUyeyvm8AsSfNagUEGymxFf/hDqVSWxEqCCR2E+
         xP0AQZm52mA73lAFywKWwJTz/NHFcfpg3GLoysZw4z5dWc0LGQFwXoqj9sT2q2fSYRjP
         RIzrJTJlZX+byxxlCp+CBLXrz8pEDaD8lOAe/18VotOXjQAUBusvvqf4MiPcQFQqw1nO
         apkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684848392; x=1687440392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa8882brqQgfaqBSNJBl6uslG94ncgU4uoIf58nOBLw=;
        b=W1IkcB8elfp8p/YBbZZTZ/4Pbs08fKenRjTGB362mFOdgTscVE6pkyLdMIsWF29AUV
         Z65p0rCpJ7veiFBuulocG04QAmj3R6oMJhe3I36qy5rVsvmA/aYP2SedyDsm1H6KHaEw
         KU1bOrtdP8ULPQTHBRSs5BIz7cq4YPY3dunP9uPAogohKZlsLpl6fk9ZoAX2XTX1DIIj
         0FE/EZ084k3EeLoawYEbD8iF+W8luiq/m+YqiGoZnYN5Z61hwoDBpDOP1T3tDumhzQq9
         tm3A969d5ODZvyh34cMYdua3gVDUqgxeNzwbt7NDX4cKbYOP3fQTHAJJrCiE0CUn9enq
         hqJA==
X-Gm-Message-State: AC+VfDzyn/8J/VojfHhLPW7dOvLCNE9cRJCwarjSc+Xy4gYjsesDETdT
        b80je0MKsr/rjQK3Ux/XSYZH6w==
X-Google-Smtp-Source: ACHHUZ4e5cRbt4cxwX5emt+5fpWZHlvYcRSNhQa3SR8qnr5dS6GXOwY9LQ3zqH5O4WVGbRWW2wDCSw==
X-Received: by 2002:a7b:c8d9:0:b0:3f4:1ce0:a606 with SMTP id f25-20020a7bc8d9000000b003f41ce0a606mr10206652wml.1.1684848392523;
        Tue, 23 May 2023 06:26:32 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bcb99000000b003f195d540d9sm15044720wmi.14.2023.05.23.06.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 06:26:31 -0700 (PDT)
Date:   Tue, 23 May 2023 15:26:30 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vlad Yasevich <vyasevic@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] ipv6: Fix out-of-bounds access in ipv6_find_tlv()
Message-ID: <ZGy/BrpnnxALpjqF@nanopsycho>
References: <20230523082903.117626-1-Ilia.Gavrilov@infotecs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523082903.117626-1-Ilia.Gavrilov@infotecs.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 23, 2023 at 10:29:44AM CEST, Ilia.Gavrilov@infotecs.ru wrote:
>optlen is fetched without checking whether there is more than one byte to parse.
>It can lead to out-of-bounds access.
>
>Found by InfoTeCS on behalf of Linux Verification Center
>(linuxtesting.org) with SVACE.
>
>Fixes: 3c73a0368e99 ("ipv6: Update ipv6 static library with newly needed functions")
>Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
