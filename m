Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C02B6E39BE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDPPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDPPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:19:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658F11BE7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:18:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kx14so3099447pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681658339; x=1684250339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+mFyYIESIr8FNAXPWiIF3dqEDGQyLtd8kXWu8xTRR8=;
        b=ghVi2V/DBXAUTjrwsnwtPUxkdkxMwoEpGhdwnl9bhgO6bLEJl4gFaM9BoA50ihUU2B
         EZKeLGqtlz6boUyMI5CvikvHAEFeEN3nfCcdJyiBm3L1Sp6T3GwNR/JSfEEScQ/9V6FP
         X2dDqycoMdShaMPnfzNH0sPm+dOvbX5FzifCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681658339; x=1684250339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+mFyYIESIr8FNAXPWiIF3dqEDGQyLtd8kXWu8xTRR8=;
        b=AfOnDNUaI/BwsdDCJqAC5IgT08tTrqBDxNCSaBy2zmr7qBh4eWhfdfvIqocBARA+U3
         czA0YUi3j6v2hVqBpOyEamACeZQCn21nBCjqiwz9/Qf51Npf39t/ocmjB9xp6zUuGDet
         YqNh7dxpki5FDElgsH4muR7Kzi4ekJOmuW5KuNtPcpGpn8LReivoMA0eHpsAUrwQYFAW
         1oDyOk6z6np3YOTKAHq3YuNAu0p83AZco4Wy2h/bY3j8g5uMtGfSbxQTSymskugW6vNa
         sDl64wwdpSa7MXn9TRJyFkWeEMm1nNTor6TOXU3MQyU2HS8v9JA2fZgAXabhQABNRji+
         uiJw==
X-Gm-Message-State: AAQBX9cA5EIM19W886uT7qjjOgQVlDYiHzzACNmoYHSo6z9EIk2YsFbN
        iVuUX4qdj8HQ+ZY0+nrpOAaX1g==
X-Google-Smtp-Source: AKy350a4p2zxyerAHHe2Wj0BSwj/128IXx9kIfm/iH5k2mFijXGNwR40/crapYHpNJQIBMxDFTI/nQ==
X-Received: by 2002:a17:90a:4ec2:b0:23f:7c82:2468 with SMTP id v2-20020a17090a4ec200b0023f7c822468mr12034883pjl.31.1681658338896;
        Sun, 16 Apr 2023 08:18:58 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a440100b00246f73c3acesm7317040pjg.33.2023.04.16.08.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:18:58 -0700 (PDT)
Date:   Mon, 17 Apr 2023 00:18:53 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <20230416151853.GK25053@google.com>
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/16 01:20), Yu Zhao wrote:
> 
> Seeing the following crashes from mm-unstable. Please take a look. Thanks.
> 

Hi,

Did you bisect it down to this series?
