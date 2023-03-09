Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADA26B25DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjCINua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjCINtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:49:45 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01699DF739;
        Thu,  9 Mar 2023 05:48:59 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id i20so1865254lja.11;
        Thu, 09 Mar 2023 05:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678369738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3FudcHKQ9C/ngiFd0m6bXjPnSdZmZHDOaPcXEf1NoUY=;
        b=QH1E80R931to/itzqCLl/92TGvWsT34/Xg1+SIoWE5K4mZMKhmrrZraQO9xOled4P/
         cgTz6Yq7biSlbv1GgFP7UbzpUKodz6us+pOLxDwJpdn4YbnKzPvi6HK7JzlFiqD5SQM7
         0GdmsvKVDLfiE4xbqs8S4zVo9SqH/j4MXFJr9YxTKifH1ZL5Nn1q2ysaJ7cWJ5KBOBbg
         3gYTSs8rxRfTpPQDl+eHwnTViNaEm76g7ZTP8VwBOzaM+z0U/6TEdWK2A3b+lT3CHRMP
         ZrhJlP0Co6nVoukUyE+2Aqi1d7f64T678ft8oqnWsofJECY3TkVW30s38cN1zf2dpvJY
         VskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FudcHKQ9C/ngiFd0m6bXjPnSdZmZHDOaPcXEf1NoUY=;
        b=8HtFU5lf19PI50s52tHaizIXNB7wMNoPCTLcArh/xzaIu6XzPg4eDrLChSD2nhiZvf
         maWMcAgruACs1/AzhJzGReXpbabTdasUbX7xNX0DrXlW7IEQVCStIfIUmV5lt7Tkf0o9
         xF+kguBOaTUngFT4v4O0e0i6QN2cwGhvXNki2DPqRohDJv+q1xrOhwXKPnutqnyGGJd+
         FfnQAHu3PGwbuEpn/3yDO/8QNXSXBKQ74lCn2sVc/5SSmkrl9CIcHZ5kDiTlwUL8mjZW
         R71Yfk2rrurgO6ThlA4UyOCGTysH4bn5A2cK6a+Nb+LWuEmyJNDNEeS8beKndZzAQSn3
         w/BQ==
X-Gm-Message-State: AO0yUKWyiQlktYXx2EWd/JGNJx3fsehi/xOGQJ00e1r1THYRs59vgkCB
        Ast9vWQkcEz1t7F2I3hb8kI=
X-Google-Smtp-Source: AK7set+3y+9sIZ9bwERBoAgL/96ayOf2fLhRTH7d36V/q64JwvSZt5/eUSvcDDvcetwLKaCeYI3WGA==
X-Received: by 2002:a2e:2ac3:0:b0:294:697a:d6af with SMTP id q186-20020a2e2ac3000000b00294697ad6afmr6295232ljq.39.1678369738066;
        Thu, 09 Mar 2023 05:48:58 -0800 (PST)
Received: from pc636 (host-95-193-108-241.mobileonline.telia.com. [95.193.108.241])
        by smtp.gmail.com with ESMTPSA id f9-20020ac24e49000000b004db48ae69cbsm2641622lfr.206.2023.03.09.05.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:48:57 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 9 Mar 2023 14:48:54 +0100
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 06/13] net/sysctl: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <ZAnjxuXPR6j14W8u@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-7-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201150815.409582-7-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:08:12PM +0100, Uladzislau Rezki (Sony) wrote:
> The kvfree_rcu()'s single argument name is deprecated therefore
> rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
> underline that it is for sleepable contexts.
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  net/core/sysctl_net_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Could you please add you reviwed-by or Acked-by tags so we can bring
our series with renaming for the next merge window?

Thanks!

--
Uladzislau Rezki
