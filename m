Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7CA7359E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjFSOme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjFSOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:42:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6042AA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:42:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31109cd8d8cso3263066f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687185747; x=1689777747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6epH37hdpG+43zHnm1jYAPdZwnsNsyegwEKE9/FA+rc=;
        b=pklYDm5xRYSW2AFNSWM+3VocxKr9BLg1Hr53FKkK9tKikvleoVDkWoGy0DGyvMtRhS
         1wf7MwFV/UENAd2a/dnHUPUgEEF4ffzQ5MJsDVu6iTkZIO5/NvnDLHHVrjYy9uOINf/2
         yaljpVx4+7G3iXza22CoRJTMXPNIc3nonETbQWvwiO86FNPUZ71BbOfSUiF21VGHrP1i
         /CwDxFubryo7T0HSuylB0Rx2jXGdIOjC/4gCT8rAHWk9IW7MHDaT+hL/gm+8w+Es61Dj
         sGgZgmpZaYX9DtUcG/vfOKZ73X9p6nDP1Fr/XcESVn3UbAr1ZSAheCCK5VCXYcQxmzof
         x5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687185747; x=1689777747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6epH37hdpG+43zHnm1jYAPdZwnsNsyegwEKE9/FA+rc=;
        b=GciAWcfWHIq0Tu8UG7OZEpf5AWCnMYhprPQBFgOF2xn6F/6ZhxaCKhufR7QP0yBbVd
         RWWYtLMxl6WX8xj7DibU2CfG0PEZReWJdtD1vl7OkFGJgiEth/c47FMfqjUBgNqY62A5
         SdCjNMVWqobP0ymFYD4DPHjLGMVCt01gJwtip3/fvvKeU59vfjFCCL9qloSn585vRdFH
         q47LQYIYX+k0Veq7pbgGDPg8ZmovVLlke2pEaJGMd0hZm4b03HZKFpmiAUUCzMBwC5Qi
         zJ+7XuZO+N2GawNe6YtShg3B1jJE14y9cxE14bCRbpC1KpboMSNTqIYruClBuLYY1nRU
         2Gzw==
X-Gm-Message-State: AC+VfDxCmBYhEhnAra90j+CE1ZVwFm6d+3mjanEvR2V6Uig0KaMydEus
        Ma98IoRM+ynziV0T0AuJh3/WXA==
X-Google-Smtp-Source: ACHHUZ5GsLFi7Eftr+GWDtD5vjtCFIBvjRQh0Vm+yoQ+n8kb4HQsZW8B15VQxQMJV9e38t0hfcFPFA==
X-Received: by 2002:a5d:574c:0:b0:30f:d05f:debc with SMTP id q12-20020a5d574c000000b0030fd05fdebcmr7467466wrw.43.1687185747252;
        Mon, 19 Jun 2023 07:42:27 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t12-20020adfeb8c000000b0030ae6432504sm31705801wrn.38.2023.06.19.07.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:42:26 -0700 (PDT)
Date:   Mon, 19 Jun 2023 16:42:25 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        mptcp@lists.linux.dev
Subject: Re: [PATCH net-next] mptcp: Reorder fields in 'struct
 mptcp_pm_add_entry'
Message-ID: <ZJBpUaUoAmIPpU70@nanopsycho>
References: <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Jun 18, 2023 at 11:46:46AM CEST, christophe.jaillet@wanadoo.fr wrote:
>Group some variables based on their sizes to reduce hole and avoid padding.
>On x86_64, this shrinks the size of 'struct mptcp_pm_add_entry'
>from 136 to 128 bytes.
>
>It saves a few bytes of memory and is more cache-line friendly.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
