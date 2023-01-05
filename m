Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF665EE7B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjAEOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjAEOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:11:59 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEC851310
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:11:55 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e10so10674058pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 06:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JoOKD3fhvjltOz/BKivLTcbhttDC/bdQobavcXcDp9Q=;
        b=gAzUJJZY5TesWCbvlLm0Nvx5S8CWI/OFNcWGJRSXMa4u88qBLtq5Z57hlmLeVUiUXT
         Q8qjI/S0cMW9p8VYrieFiq0UGy5hnC86U+wYcFYymtPtgcdR/0SMbf0iXhDaBCaYTWVM
         6EV941rjN0MvpnXmnAsYcu+KRfPbRLXLKs5RFKov6UP4Z/rLlMqHNZTWzc0GjfGZ98vL
         7bK6FnyecXCpEKUA/oLqjRvQgzrsb270C9MAuES3bQRVOJIjEaB8QihVyc4pLscEdypU
         yNTS7dDPW3Idv+LDW+1kKfPZSvzqYRKttpcOuTb5lR7YyW8LbbVVpp2tQm+NbqpazAAB
         xKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoOKD3fhvjltOz/BKivLTcbhttDC/bdQobavcXcDp9Q=;
        b=cMHY7S6bnb4rKKWU8lwC9jLHb8xJ4OLNDysX5rZocUVP6yTCxZ0sKIji/v1tcPotWY
         o5sCKnKbkvL7B495juIcJ/CcZKTdEK5UbhsYHjZy8aWTjQnJNN9LbeGjFRYgQ7N7dPUl
         TxHYPR4su61tuhjMGcDXJpdKk+tiiycorEr1L7AOPgryQvBsx9LwbU2xVJNykD1RuQDu
         KS/FtxFBk+zS0I6QSVd5/caW7UAg913QOycI5mM9/Ps5YWq3W6lmdVYRLvdYG6WBH9Y8
         8Qa2+y+f7q4behbtP/mSjAI8oebgGl8ezHQyn91/BIaXG+vao5n9NGr1fSuAyoIFzANf
         LTvg==
X-Gm-Message-State: AFqh2kp2cAIkL8GcJkl6Xsizy012dSXQhWA9vIOLxt0dH5vxST2B9y3B
        mDfwTnxsbdV2EKXk+Z6Ntg5yXA==
X-Google-Smtp-Source: AMrXdXt6ixVFYcF7JJc/xVT+7SfOpce9UgPPB+H+PfeNMBECoEDdXUIxAj9b40GeUTZxLY9XysPaXQ==
X-Received: by 2002:a05:6a00:c5:b0:582:6173:c6c5 with SMTP id e5-20020a056a0000c500b005826173c6c5mr18357064pfj.14.1672927914729;
        Thu, 05 Jan 2023 06:11:54 -0800 (PST)
Received: from localhost (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f76-20020a62384f000000b005810a54fdefsm20048453pfa.114.2023.01.05.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 06:11:54 -0800 (PST)
Date:   Thu, 5 Jan 2023 15:11:51 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] fjes: Fix an error handling path in
 fjes_probe()
Message-ID: <Y7bap08pgqs1LL48@nanopsycho>
References: <a294f5f3af7e29212a27cc7d17503fba346266b5.1672864635.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a294f5f3af7e29212a27cc7d17503fba346266b5.1672864635.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jan 04, 2023 at 09:40:47PM CET, christophe.jaillet@wanadoo.fr wrote:
>free_netdev() already calls netif_napi_del(), no need to call it
>explicitly.
>It's harmless, but useless.
>
>Remove the call, make the  error handling path of the probe and the remove
>function be consistent one with the other.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
