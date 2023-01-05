Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1627A65ED19
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjAENbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjAENa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:30:57 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16966D71;
        Thu,  5 Jan 2023 05:30:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso1310514wmq.1;
        Thu, 05 Jan 2023 05:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XW98DVrs0+Jly8h1gtMatPwTE1I6WBstQY29vkxVduE=;
        b=oV57iYoR7l6B/Scumx7tivkt+6tkqLuGNmuHDne8f9719J5Xs8QQHuRMpndKCZfAUQ
         y6I/qRUs/9SJRBZSqhczjBDaJLsXmw53kCGSYbreS92L0o/JhjGww/bhOlzumdirzquG
         EW6k3WMaUz8O9wLrAWHENvHWl02lnADPNjNQJ9rn8L3F8riZGEK/kI+OQqpe7mxW/rbx
         AlXjS7sc1mOHQ2cDhrpPnUCm8w5R/vD/XrVbbnS7xf/EEmc5FVtvNzRnqCOgMdh6aFSY
         n523pvqho0pslAL6b7RXFOgRFltTliPqXeSLHzuxlT+M+ychTAbvZlRBSaEJ0Xm2rzWx
         V1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW98DVrs0+Jly8h1gtMatPwTE1I6WBstQY29vkxVduE=;
        b=epheGXsiXijwoA7tDySSr0NCC35Q6n4mqNonbjhjRz7AdEJimAE9dnr492QIB8fKDW
         xVkEPqm7drb2hX02M0gvT9kM+c5Xhc2hjMvBHVyrGEleTm3WCrK+iNg7MCryRuycCvEF
         j66ak/VyMcWho3InWZrXg0I6FJhPnZt3rj2noYPkaQZckt2kwkgMuKJniukUswvQuBD5
         vA1AUwSfxEXzkp5VST7ySWg5RUXTkX5bcQTdkJYfHErpQ/14AUtiaj5UCwHqZL/miAvT
         WgFomn79OUi5C270iFI1RfR9rm9WjxzC2mycPhZjNU7EILhsRgxQL4gbxsqfn3RhQbBm
         CVow==
X-Gm-Message-State: AFqh2koTNQpYZBQPRj/cBaDLl5G/2kDvH4hQH6KXPD1VH9Bei4ysjr0Z
        fB68klWpO6EJEJuWLClbM5k=
X-Google-Smtp-Source: AMrXdXuWumIsrjNFbb2l0gWAOmk5Zn0BArd1QVRz956TyiH/2eN+e/GRUk6W1sbn78Io1e+J3+JuFA==
X-Received: by 2002:a05:600c:a0f:b0:3cf:7704:50ce with SMTP id z15-20020a05600c0a0f00b003cf770450cemr37181991wmp.38.1672925452598;
        Thu, 05 Jan 2023 05:30:52 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c350200b003d9b351de26sm2814486wmq.9.2023.01.05.05.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:30:52 -0800 (PST)
Date:   Thu, 5 Jan 2023 16:30:37 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alex Elder <elder@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: dcc: Signedness bug in
 config_reset_write()
Message-ID: <Y7bQ/SjUlzt6iLts@kadam>
References: <Y7asNqoIapctHmbI@kili>
 <7017c4e0-16c0-225f-028d-2cf2cb34f360@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7017c4e0-16c0-225f-028d-2cf2cb34f360@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 12:47:45PM +0100, Konrad Dybcio wrote:
> The commit message should be written in an imperative manner,
> such as "Fix X, make Y do Z"
> 

Imperative tense requirements are a symptom of bureaucracy run mad.  I
always want to push back against that.  We accrete layers of
requirements like case-bearing leaf beetles making armor out of poop.

regards,
dan carpenter

