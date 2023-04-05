Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988426D720C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjDEBf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 21:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjDEBfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:35:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1926C1BD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 18:35:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y15so44661324lfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 18:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680658552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoyBCXStsqxpfmpVlFcXygr4xYwfXrntl6u3DwEVxas=;
        b=rdBjaUsHhiuWUMKYoRit98wt2EcyiqcOLAn0u1YvUxr2ZxgM4Rdm4qHXFe95dBcN0Z
         wo20Hj9faKL31PTxOTPM79L0PUmRVK39fWSsYjWdBQQSbF9jwxqTBOMjweqdpEBNA4IH
         g0OFbxrZ5dTW7W+9HxloUtL40a2OPpOQoL6C10HxZhYwJ8m83JAcwRG60tLPaQ+UJwN+
         GhhABgoHoQL8g1iERq+Zoklx10HfAI+XQ/DyQ+srcUxV6RhixnzzBQ+1IC1uNxHvdjzN
         3IKYNNEA5bN37+altTVvwCikBAR6FkDsABRR1m/0bmBIkvSivfMejOb9G54x+VnQmHgW
         n83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680658552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoyBCXStsqxpfmpVlFcXygr4xYwfXrntl6u3DwEVxas=;
        b=xnFjxz/E8Xeoxt47h1i5EcqvrpNXfAt93/VjLpe472UYx8rb5QnhZ0g5Nwtc4bBRe5
         cMEsrUu1ZQEgw8c3KubLwlJmsch4awoyGMwjxsM+DkzlcaKFuMx2roEGnPeYmpQI2BpZ
         BsONDPyx+KXP1WbdTwJOq7E9YOEFg1S+wp1I51/jUCESiqAP5tG2OyJs5VuUOabRpUJE
         cg+lT3DKPB8DW0xh9shslWy212MToeHB9hvnKZBsK21Z4LRQnuRWeKVhxcEJ0woUIfR8
         qN/9LJUkXlfyaWNlSj8iqrNMB+wWW+qqUzQrSBnI3k4tqpgD51dFXVKqbxL35vzmLpMu
         GuJw==
X-Gm-Message-State: AAQBX9fMJU+ofEw306TM+DBHqC7zDykI+f28L5XdupkjH4yCm/CRbg34
        6gMWZUZ3Vu/TA7PtnGbb0Z2ORg==
X-Google-Smtp-Source: AKy350bpv2i7LVGztpCvL9K+IopcdFKdyv11QsqYGtjWIc1F6UdHNMt0SaBiG8OgKGj3TFFgu8uP0A==
X-Received: by 2002:ac2:5083:0:b0:4de:d16f:3938 with SMTP id f3-20020ac25083000000b004ded16f3938mr979980lfm.53.1680658552391;
        Tue, 04 Apr 2023 18:35:52 -0700 (PDT)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2561a000000b004cb8de497ffsm2572326lfd.154.2023.04.04.18.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 18:35:52 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/msm/mdss: Fix spelling mistake "Unuspported" -> "Unsupported"
Date:   Wed,  5 Apr 2023 04:35:48 +0300
Message-Id: <168065850331.1260361.4926214097299835454.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329093026.418847-1-colin.i.king@gmail.com>
References: <20230329093026.418847-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Mar 2023 10:30:26 +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_error message. Fix it.
> 
> 

Applied, thanks!

[1/1] drm/msm/mdss: Fix spelling mistake "Unuspported" -> "Unsupported"
      https://gitlab.freedesktop.org/lumag/msm/-/commit/44310e2964f2

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
