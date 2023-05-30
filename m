Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169FD716518
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjE3OvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjE3OvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:51:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815271B5;
        Tue, 30 May 2023 07:50:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3992300a12.1;
        Tue, 30 May 2023 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685458246; x=1688050246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u2CdqQI+jVcz+1gBhFBjF296hftWh22Nbb1YkjjGzw=;
        b=Tis4dnHjCk3bfnKOqN2dOqcbHdbHtoGgBItWkaaX/fZhLmWlNzHeYZJiyxl/GduQeb
         VoWOrVht9h5XhNQkS4mgGZCCFRX+3whoAEY+GEWQHtxfcbSLg2MYTp+Ttmf1dGfw/IUn
         1Xmc6JHzWY3XUPRLTvwE0ymqWdkcFD4QO83mrQFZyu/A+RJ4sc5e57TVoRmGi9+SpB7+
         RcvxyEpsCSleo+IEVLCEFQnDggQnl1YdYHFAIcDSD2sLN3MXxfBzFuQebvEK6wcpYxUE
         Y7SkZd87BzqeyiTqRERCTIvYTF37V5nd8AuebdGuPRikGk55igPC25ZgR8XCymLJ5VL1
         UlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685458246; x=1688050246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3u2CdqQI+jVcz+1gBhFBjF296hftWh22Nbb1YkjjGzw=;
        b=YPehu5XSKNp86fLMmDR/9RzvAEjCLUAkbco7hR43GZXzsA1pD+u5GdsFOz/wU6xIAv
         ebxR/XDKkKuNVnGbobLGmmi7Shs1/w6MmJnMjjqzWoAHcqD/Vtbtq+XuEAc7LU/78Ue1
         sEhjt6EnNborA3537bo1MAdIfMbU3So8IfESFRZE/abMdyXFdhg57rZo4fQkqrnRK8Qf
         RXhQgLcMQ/3A1IaFNR2wOz9bE0px4xCVHpkeBrQsOx2G2wi6/+LVQS7nFwLhSoYj2fvg
         H6+8zUSSHrt1K+hKz8BiOraP6274xth7++Joth3EaKMq5R2S4ZkGIDvTjAfpU0pgQIEk
         K3gQ==
X-Gm-Message-State: AC+VfDxrVKMOl95vYokdjrLQBfGxZx9yELeJ+Y8bDkRGYuSIzdeqH4ZS
        KFv0c+TFoJSZw7FnN6SHqiTKJKV+BtE=
X-Google-Smtp-Source: ACHHUZ4f85uWui/DJ8VmAZe+7MWeLD7UKC8GCgm/q+0O5PlnRNVumZi8INcdRUPIgYDKYyTwCbF6DQ==
X-Received: by 2002:a17:902:e5c4:b0:1b0:6e16:b92c with SMTP id u4-20020a170902e5c400b001b06e16b92cmr1477977plf.54.1685458246437;
        Tue, 30 May 2023 07:50:46 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090274c100b001acacff3a70sm10326918plt.125.2023.05.30.07.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:50:46 -0700 (PDT)
From:   SungHwan Jung <onenowy@gmail.com>
To:     ilpo.jarvinen@linux.intel.com
Cc:     hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        SungHwan Jung <onenowy@gmail.com>
Subject: Re: Re: [PATCH] platform/x86: hp-wmi: Add thermal profile for Victus 16-d1xxx
Date:   Tue, 30 May 2023 23:50:12 +0900
Message-Id: <20230530145012.16284-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3b5feff0-1d59-37cb-9a5d-22186271a6a4@linux.intel.com>
References: <3b5feff0-1d59-37cb-9a5d-22186271a6a4@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your review. I have cleaned the patch, but found that it needs to set
the performance profile several times to get maximum power of dedicated gpu.
So I'll look into this. Thanks.
