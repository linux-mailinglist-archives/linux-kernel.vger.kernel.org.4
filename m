Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466D763690F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbiKWSfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiKWSfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:35:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AD913F94
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:35:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so2628568pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpDf9OxzAy1VP0XClxFMnzs891tMVQH/cAEFMD0xtYE=;
        b=SQBx7rbnJ0G27gn3WjgNmlFE3ODm5RF97U2x5uHCdBpD947CSf6dZibhY19rwRixUf
         FJAiMIHyLdRPOpy4cd54xX3HJ1wz6v0S11ee6MKuvl/eiRo5EExzMBHr6e+qX8dI92oQ
         SXGOvgRrswIlw6IdoAvBR97km9qNYPU/6IBfniqcygWyxnOQ6+BBRt4QkLpKyrSW+/3r
         MbszPwUUscrbzlby5XCC8Sx09wMRFMV9h6N+jcLwV5zzXkC2uJvBsohXKr0ie0IrmFw+
         E/d1sfoIo9xAluPKrhKHEHTiwGWzQgam9X6zE+wPwCfWEie9Obz6cJ9SS/cZNlXGnPp+
         SFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpDf9OxzAy1VP0XClxFMnzs891tMVQH/cAEFMD0xtYE=;
        b=kFsSs1qELvpgSJZe9eZmxRFVrS/AfwN1wYJ/cAy5DKaoec7rQRMbCqAMkWJjgvJF0Y
         NKarHjvEYPym52IMTIKrHb8PJPoTYgSui4SwcYhv8GMngNrmdi0YFQ6jdX3+O3Wx2mwe
         Y8caj7NNFoySRsyeb3cWtF2l1pGJclhkQZFejE537ETbv9v0S5A1AzTAhHZWy4YfN+Xe
         +U8rjl/7+eY4UyL3RvfhiaTRR7/3xygIQuD7CNRfO89QF8P7JUJI4aYdhSLjIaAHYvq6
         o5WVkfOGiUOYcZJ0EVPOAJD1ytdlij5wYbctoSXfw/1T85glj25uYGS+K+337EoHQtTy
         ECEw==
X-Gm-Message-State: ANoB5pnnaObDc+t2Oc8jIi3Ssu/IUO4/FHzIbV6+GnuMXxdteVVImoRo
        jTXGh0CsxaqTSr+f3Gld2UA=
X-Google-Smtp-Source: AA0mqf4+bnEWFv/HCKEyOKfWsBQ1HZhapNIDziXbul+phoNEiJMTc+pvR6nbDJPZ6z9ixBGQuWQ0MA==
X-Received: by 2002:a17:902:6a86:b0:187:722:f4db with SMTP id n6-20020a1709026a8600b001870722f4dbmr10750267plk.87.1669228519348;
        Wed, 23 Nov 2022 10:35:19 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a2b8900b00218e8a0d7f0sm1514647pjd.22.2022.11.23.10.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:35:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:35:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        linux-kernel@vger.kernel.org,
        syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/kernfs: Fix lockdep warning in kernfs_active()
Message-ID: <Y35n5b8dFQuDWOL6@slm.duckdns.org>
References: <0000000000002473fd05eca7540a@google.com>
 <20221109120415.55759-1-zhouchengming@bytedance.com>
 <Y35mqfhdIxnDvCn4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35mqfhdIxnDvCn4@kroah.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 07:30:01PM +0100, Greg KH wrote:
> Is this still needed in 6.1-rc6?

1edfe4ea16ca ("kernfs: Fix spurious lockdep warning in
kernfs_find_and_get_node_by_id()") already fixed the issue. So, not needed.

Thanks.

-- 
tejun
