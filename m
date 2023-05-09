Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08DF6FCA2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjEIPZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjEIPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:25:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6252D63;
        Tue,  9 May 2023 08:25:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a50cb65c92so42648995ad.0;
        Tue, 09 May 2023 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683645928; x=1686237928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BapK3YZat2JrgkQ27y5fKqAf0JI1AsmzEqrfbJH0CP0=;
        b=T0Xc7i+iruIpfW3f/ePg4G2BwS871YDGZQJvpnfUOmKjgT+0ikyl3Bw2+nSNVJ2Al5
         21Nl8FIfQby1t6KuZ7IDXQObd6EzuQvSQXnrXoDSU59rOP1kToq0UMFsR5tsmNLN/ice
         YmZS6g/xra07johxCZ1D6N2gfmvQZ57sxGqBWkuY5xKd+esdzYT3reTAnP6Vt22lBC9i
         pqlG6d/f9EaL+6lQJ16Cwtv2M6RkOE2nPpLysjjqW/UvtN3+gand0PWgYKvwYyYUOriF
         z4/GidS0HxRi6M9piZWTW7VNTYV/ghTNvmXbRpCQUkUyklCTR1X9cetM4Gyf3/K0wCVb
         +y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645928; x=1686237928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BapK3YZat2JrgkQ27y5fKqAf0JI1AsmzEqrfbJH0CP0=;
        b=lKY9oXXpDQwSuBUD65hy5bQo2fRlJiPXbTjmraoLb0ez5VFGAZsYgN900ih8uJg46R
         7aqDHqqpvukzaghE7NwQf0QH8P8d3T/7fRBAkVbNr9ag8L4SlXqfkdPqOJf4vXnEwJ8Y
         3hPty5gTZPQN/VnZP0ZkTjzqgKufXhtcRaDfpgUPI/J7c2Ge7Xr20rdWlgqRL7tCjYEi
         XTk0UDKRPLXu2hAFu2agqzIMVBGq5iar/bwjYNiI0NFWY4cmeNHFpqJazbqTnmQN91K4
         lIFO1uKGA1racLUXh8ZfzDzuF7OKsQj/HkL8edRivYZq93XXP9fJZl2o2tvld3g2HgeY
         I/YA==
X-Gm-Message-State: AC+VfDy9pcm8NoE+MKzzOejBLXK+qm2ujPyuoa3ztVNgWzbp/YMOPg/A
        c32VZqvkhUyqniJRwUh09as=
X-Google-Smtp-Source: ACHHUZ6yYycY4c2Qj/Cp1fVn1nBKhwmXWZN8uaMWGSzOfPsErIKzM9qhtuUgkwdpZ59idvuUIspnRA==
X-Received: by 2002:a17:903:32c2:b0:1aa:e938:3ddf with SMTP id i2-20020a17090332c200b001aae9383ddfmr17893612plr.7.1683645927612;
        Tue, 09 May 2023 08:25:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902b60d00b001aafdf8063dsm1722771pls.157.2023.05.09.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:25:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 May 2023 05:25:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Avraham Stern <avraham.stern@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        "Haim, Dreyfuss" <haim.dreyfuss@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 09/22] wifi: iwlwifi: Use alloc_ordered_workqueue() to
 create ordered workqueues
Message-ID: <ZFpl5UFRXVdEyJcQ@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-10-tj@kernel.org>
 <ZFmM3taSTiq7Mv4L@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFmM3taSTiq7Mv4L@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 01:59:26PM -1000, Tejun Heo wrote:
> Applied to wq/for-6.5-cleanup-ordered.

This notification is on the wrong patch. The updated one w/ 0 @max_active
was applied.

Thanks.

-- 
tejun
