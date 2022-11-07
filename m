Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD6261FED0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiKGTkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiKGTkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:40:45 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D73193D9;
        Mon,  7 Nov 2022 11:40:44 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so10814552pjs.4;
        Mon, 07 Nov 2022 11:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lr2LJh1ynsT6o7QECxrCpd8COAMFXtNJpOsEdVPq6mA=;
        b=Jr9uTsc3hShwQ7UX2Tm2tx7F4XmAu9jfoZX9sYL1gH4GV0IK0c7jM2ADozP+FVLK3f
         Y2Eg2BUdbWvwaNL4BCY2BOMc4a/NxJ2qn3phYseVokjP7f9+/LgaO0P1E+Hn9G+WH2wq
         4kasZWGcR5RUgGz7bh3Yeutr9FijqrFbbRi9n+NBJPxUrANZG1Q9BJn18SJBjnxUVz3y
         8Jy1TqwaL+Sv5q/ewqUzH0+pC6gT9KZIVdv2ACMxaPkqfzeGwNBUkP43aXSueCgRTr61
         L04ukJ5uLTzY0cJkybksbAvC3VRHVKdb7WxfU9dvCZ3u4zO9OQtrMYIpFneaW6fx5eNB
         dLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr2LJh1ynsT6o7QECxrCpd8COAMFXtNJpOsEdVPq6mA=;
        b=M9x9l3Ws3P4KB4uvb7FGdLCKDwHd6CgBctPDNdj4XcIGSqOpGUegB0ui0n6DlaQX9D
         1NrAe2XLMSal0mdrI9Mxp6FTBe2yQVsPPTXQKK7Kl16NhkkY5ryje7/9EnUNkWQbs//g
         nGFG1VT9oUJb0DZijK15E0iAKklv/Yu59/nLIHUEYsEi4ikovnQbhLVC9PFOL5iZlhe4
         ypYHeD8UhG8bPLbcsrC7Zec/RFWjL3rNqA+D5jirqPnBijnJjRwuapTXzS0g8yPbMQb9
         ieXiqVvESuU5npDEudeQg3HVhlzx1+SieDS/QYpKmYmwOH7UG1TfXEpaiOj30hH6ui0V
         oDiQ==
X-Gm-Message-State: ACrzQf2Ng/dVJQA77B8yNbGR1/YUnNHbejvrL8JTRRfc4E7f2sjBzUxP
        zd7ihnSvjdBUsWpiNLvSZCU=
X-Google-Smtp-Source: AMsMyM4Z1WSLG/2s+85sT5YwneM/XauDZnGvse8TolrZ9Zs1DIAvczdZAQ2Z5UH9Z7fHC4PrnIbGWA==
X-Received: by 2002:a17:902:da82:b0:186:ee5a:47c7 with SMTP id j2-20020a170902da8200b00186ee5a47c7mr52582931plx.82.1667850044133;
        Mon, 07 Nov 2022 11:40:44 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:626:eb80:9eb9:1fd7])
        by smtp.gmail.com with ESMTPSA id x1-20020a633101000000b00464858cf6b0sm4510500pgx.54.2022.11.07.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:40:43 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:40:40 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 12/30] input: Use kstrtobool() instead of strtobool()
Message-ID: <Y2lfOBAFo7jcpeTO@google.com>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <4311e9cb62687449f4175e2b062abcd77aada059.1667336095.git.christophe.jaillet@wanadoo.fr>
 <Y2Qowvjn+7jT767t@google.com>
 <a0a59528-6af4-adb2-e4e2-cb4cbe15e986@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0a59528-6af4-adb2-e4e2-cb4cbe15e986@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:37:19PM +0100, Christophe JAILLET wrote:
> Le 03/11/2022 à 21:46, Dmitry Torokhov a écrit :
> > On Tue, Nov 01, 2022 at 10:14:00PM +0100, Christophe JAILLET wrote:
> > > strtobool() is the same as kstrtobool().
> > > However, the latter is more used within the kernel.
> > > 
> > > In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> > > the other function name.
> > > 
> > > While at it, include the corresponding header file (<linux/kstrtox.h>)
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Please feel free to merge with the rest of the series. Or let me know if
> > you want me to pick just this one through my tree.
> > 
> > Thanks.
> > 
> 
> Hi,
> 
> the patch can go through your tree.
> There is no plan to merge the whole serie at once, and some other
> maintainers have asked for some patches to be re-sent as individual patches.

OK, applied, thank you.

-- 
Dmitry
