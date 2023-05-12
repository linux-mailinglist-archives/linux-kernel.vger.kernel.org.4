Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CFB700AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbjELOyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbjELOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:54:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F41100F2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:54:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f315712406so325594015e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683903277; x=1686495277;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa56CQSLIY9XRDCrhgSxQPZvD5KOoRFX1rWe5FLuGog=;
        b=QJbIwCQXbyKqbU9XD/TWMILTiUnaOPLZqno9mBtwLKaOLOR0iLgcDBOLUZ2bhlfRLm
         28Pp6ETjALUbs0YTGfd7Mloelapk5jP5/3d3f3oKh2kTwx+ugyMk3vpZYpNAvkqbOqkj
         CVLXCgTDPDrwmgBK/wrjDBCNaqYDmagqczwAvh7OMKZSqOZazFJ3t3SX+fiLuotBbgoR
         tCbwZUmX/09C5XbFRnA31VfD8QBxtfm6uZWLb5P0bOzCVPJ5PxQxljBUKzz8AYf0Roxh
         Jxl0f5BDZX0+B+3lqcQTwcpCB4CfU/xw8f5KpF1n+Lcq1KgwXs9V81VZt/+3JOi8MM3g
         gA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903277; x=1686495277;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa56CQSLIY9XRDCrhgSxQPZvD5KOoRFX1rWe5FLuGog=;
        b=CsdDflESmDNs4qqutGIgI55SC8JEWb5Q1WRbVbPgginC55rWwC/YGwNDBZahTYGXio
         rwd+J2quIYyDynJ6cKrYHDMVpqLGud3xgr0QcQSX7muexYym70OuoNtWXBema25iNqx+
         gldz88Ef9/YHHyXygwx8Lyq7t/VmN/M6JheamZ2CAqNZwvX7HPz3T+/DfJgq80a0gNNH
         rByb9slg3l5mctfAyjIyxkZyVOcY81ef11tR7RlhYGnEY38CGEcH6xsXQHVzr8kGIMBy
         3kuahr5O4qLkd8OhKFvP7lGAOO8kS5W7ITjJih6C0jaZdXSFdroJxYc77plvrNkt8k3s
         bkBQ==
X-Gm-Message-State: AC+VfDxKaxy8jDxJnC8OwFbWmBiSO/IhxytDZJbiICAL8cNsYHB5wRg+
        kag3YZoaduk3xNxyBsbGRq0H5gK6uf6XXa/0OdM=
X-Google-Smtp-Source: ACHHUZ5UJNJNsrUUaGFSWCNh7rWJiExxry4+bJ6e39Kt4i97uqRhotym0YFBwJ2jD2AfwBMnc5lDSg==
X-Received: by 2002:a7b:ce98:0:b0:3f4:e3ed:98e9 with SMTP id q24-20020a7bce98000000b003f4e3ed98e9mr5942528wmj.0.1683903277367;
        Fri, 12 May 2023 07:54:37 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003f32f013c3csm28953540wmh.6.2023.05.12.07.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 07:54:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linux-arm-msm@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bkumar@qti.qualcomm.com,
        fastrpc.upstream@qti.qualcomm.com, stable <stable@kernel.org>
In-Reply-To: <1679906929-25711-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1679906929-25711-1-git-send-email-quic_ekangupt@quicinc.com>
Subject: Re: [PATCH v2] misc: fastrpc: Pass proper scm arguments for secure
 map request
Message-Id: <168390327620.185210.10646429324801631880.b4-ty@linaro.org>
Date:   Fri, 12 May 2023 15:54:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2023 14:18:49 +0530, Ekansh Gupta wrote:
> If a map request is made with securemap attribute, the memory
> ownership needs to be reassigned to new VMID to allow access
> from protection domain. Currently only DSP VMID is passed to
> the reassign call which is incorrect as only a combination of
> HLOS and DSP VMID is allowed for memory ownership reassignment
> and passing only DSP VMID will cause assign call failure.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: Pass proper scm arguments for secure map request
      commit: dc37d43b894e5b146f7b6ae64c9d864bd3069b6b

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

