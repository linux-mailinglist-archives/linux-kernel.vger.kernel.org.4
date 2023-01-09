Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCA662F74
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbjAISrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjAISrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:47:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215FA1901C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:47:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w3so10510559ply.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4xbEUz+l7pEeC2bJ2Istz4CduYkgmHAwjtj7GDJFIrg=;
        b=gGM5QTd4jsaM5390khMYrTyPZ9B3Wntx0R6uefG5ndPWO8XUfIV1OL70LiklWfJ1mc
         IvlUz1GiJlG18OEJElMO15xzxSJJ28n//rCrp52037rbP3CB0JDQ8ZuDIQPZO/5Yr+Xd
         OvtDJGY1dDoRuiATgBKm1kZkGPDSu0TG5F2BWGPEyz1zRlVciNhAxkpsHeP1VoVXaqQA
         kUiewP5qGEshcInL2Kyfbi4o1V+oJ0nPr50gNYUZcwVLPgXg8q7OMWPKxqT8sMpL0j+e
         PSNghOAzlC3GRa67MDOynZU1xwr5bauqJK31Dl2NyVWa0lg72RoiBZVSfowmsWyXjGlX
         lW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xbEUz+l7pEeC2bJ2Istz4CduYkgmHAwjtj7GDJFIrg=;
        b=AGH9DA7ZV9iKJKLQtuoE3RhbVliCZQEATyatQBL4T1IPKDED6WGztdT3G65r0ZwzF/
         PshubZKLzQ+GYbKhgzBfIslp3ItxVIzjx7vAPxMbcBdWYNHlcBfwPjGGixI36hLZGwzb
         XLzUAiUQhGJo1+p8dfEniz8ErQWqgWUDAWdtVymPI33Zf0WT4tC0WcHiOybFinpS1VaW
         QT2OGCq+R985Wn22BGIf3Fd9JPk6X6wWSZngCB71ypRifteR7H5Bp7Mcx10cfHXss6In
         Jx/77U2Nkac6U1+6oS2pFKEOA9Sqp4jcOGKkCRm317ksQ6GB0tDq5t35JEW5CwbsOhA9
         b6EQ==
X-Gm-Message-State: AFqh2koiWQQHD1JVM/Z8gMsP5myvgAYH1zpVDt880b62O+NtzpVKCExK
        sfZca+WuLSf3dh/RUPrcJJoKew==
X-Google-Smtp-Source: AMrXdXuSompBiR8zLNRIyy7WUOc4HTorvI5yaJzuY6QIsJ1fL6WFcYcTjnqWV5mN3pMHLLxms+hHig==
X-Received: by 2002:a17:902:b713:b0:190:c550:d295 with SMTP id d19-20020a170902b71300b00190c550d295mr64328108pls.9.1673290020669;
        Mon, 09 Jan 2023 10:47:00 -0800 (PST)
Received: from localhost (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b0018853416bbcsm6539787plj.7.2023.01.09.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:47:00 -0800 (PST)
Date:   Mon, 9 Jan 2023 19:46:57 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: lan966x: check for ptp to be enabled in
 lan966x_ptp_deinit()
Message-ID: <Y7xhIXET9d5J7Rzt@nanopsycho>
References: <20230109153223.390015-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109153223.390015-1-clement.leger@bootlin.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jan 09, 2023 at 04:32:23PM CET, clement.leger@bootlin.com wrote:
>If ptp was not enabled due to missing IRQ for instance,
>lan966x_ptp_deinit() will dereference NULL pointers.
>
>Fixes: d096459494a8 ("net: lan966x: Add support for ptp clocks")
>Signed-off-by: Clément Léger <clement.leger@bootlin.com>
>Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
