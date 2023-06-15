Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B0A731ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjFOOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344829AbjFOOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:02:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEDB1FCC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:02:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f8cc042e2bso17072945e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686837732; x=1689429732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iuyq1q4Civx77PzFHDpUKjHueDOZzYAPik1VN/lXMjU=;
        b=N4QpRNULdQTn1NUO/iUp8WyMddebbz+L8BZPtSAVMqhZ4jS80V1cWa4Pil0diJQkAw
         DhCHbqsSjI4uM7MgeYO67u5tP/INNBO5NKUjFlmbqaK7LSsGuxrZGQWp6lOhD8LotFLQ
         DupgDjg0yJmIL+/oLVAytEkkpOCG++boHf44jnB3L1ZBz14x2TD6git3VPmDOcfODst6
         aXTgk7lMzTtEc981/Gs1re5ndsa+DPQ0llX5aig1q+CmmP8EKhD7Or/BlHFcswyY5ZQm
         HYX25Pl2pbe0UPEtiJdgxy6LXQvqmy/67SuTOX41SnbFadNOjucM9s1lkqjt6TyXPJmu
         LhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686837732; x=1689429732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iuyq1q4Civx77PzFHDpUKjHueDOZzYAPik1VN/lXMjU=;
        b=GI/nNnPO5fP+qP6+yI1QHraj6J6jPFjnzVs2+5woD3JNUeer2BcQQKRE0q9O6BaSGV
         0MLWp/wbr7vtKanjoP8Yg/YoENolSjiT+2MgCGR7EqINl1m9LWoylEZs2Q/br0jlfWKG
         Dlq8L8W2QNAg4SI0TQjksdWs0WcK7BTm9Jy/sbmVOf+hEgVIJsDJcS/6Z4Ao2fQ0L7g+
         0mSUYJn3LGDECP6y37erS0X4weIt6HYAaVL6fgyzAfEAQqXysi/70oT4Y2njRRX6c2H8
         yJv7m3PwuZiTFaRMXh9ItFOGwd7f0lTo8rWyC2Mjv0C8HWxmeypSPTP0KRWeZdrCagJe
         /DaQ==
X-Gm-Message-State: AC+VfDykRI2iS1x4B09Rj8Mmr5rsvjoG8HNZ4B2CzzfwXrOn5a6yNcCc
        6R4GWV6+J6YF6QJwTlOqbtkpLQ==
X-Google-Smtp-Source: ACHHUZ4iD1QD4PcU+1Mi7cLd3fj4RqTIZLLfpbM5IniOHsfJxvG3gxKMkIe8r+04/YXuNVSV3DhkBw==
X-Received: by 2002:a05:600c:2204:b0:3f6:be1:b8d9 with SMTP id z4-20020a05600c220400b003f60be1b8d9mr12830537wml.6.1686837731830;
        Thu, 15 Jun 2023 07:02:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003f42d8dd7d1sm20851147wmr.7.2023.06.15.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:02:10 -0700 (PDT)
Date:   Thu, 15 Jun 2023 17:02:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: Re: [PATCH v2 net-next 6/9] net: netdevsim: create a mock-up PTP
 Hardware Clock driver
Message-ID: <64c98e79-2de5-419a-9565-2523635bd3dc@kili.mountain>
References: <20230613215440.2465708-1-vladimir.oltean@nxp.com>
 <20230613215440.2465708-7-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613215440.2465708-7-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:54:37AM +0300, Vladimir Oltean wrote:
> +
> +	spin_lock_init(&phc->lock);
> +	timecounter_init(&phc->tc, &phc->cc, 0);
> +
> +	phc->clock = ptp_clock_register(&phc->info, dev);
> +	if (IS_ERR_OR_NULL(phc->clock)) {
> +		err = PTR_ERR_OR_ZERO(phc->clock);
> +		goto out_free_phc;
> +	}
> +
> +	ptp_schedule_worker(phc->clock, MOCK_PHC_REFRESH_INTERVAL);
> +
> +	return phc;
> +
> +out_free_phc:
> +	kfree(phc);
> +out:
> +	return ERR_PTR(err);
> +}

Simon added me to the CC list because this code generates a Smatch
warning about passing zero to ERR_PTR() which is NULL.  I have written
a blog about this kind of warning.

https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

Returning NULL can be perfectly fine, but in this code here it will lead
to a crash.  The caller checks for error pointers but after that it
assumes that "phc" is a non-NULL pointer.

The IS_ERR_OR_NULL() check is not correct.  It should just be if
if (IS_ERR()).

However, the question is can this driver work without a phc->clock?
Depending on the answer you have to do one of two things.
If yes, then the correct thing is to add NULL checks throughout the
driver to prevent a NULL dereference.

If no, then the correct thing is to ensure that CONFIG_PTP_1588_CLOCK is
enabled using Kconfig.  We should never have a driver where we compile
it and then it can't probe.

regards,
dan carpenter


