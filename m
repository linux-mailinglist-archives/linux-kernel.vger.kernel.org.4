Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3957461D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGCSLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGCSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:11:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443ABE75
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:11:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b80b343178so26763425ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688407888; x=1690999888;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zk6jWIKfxALkH5YWG9XODZj23fNJc2D4nFUwyOlmNpw=;
        b=HsuoTLXTUY3IpeT6bR1dj7J6LGfIS/eQiwYegMg+JPrgQbnJcjJho7BSgm+okN/KNl
         7hjS+jJRDiI8EqMjqwECoEAWa4MEB4wmIgzDkFy9V18m9biZitc8gHYdXzHCojUeG+Rj
         pMHdm+xGC6FN+onR+wygpBsE4U+Tj7x1vRvxQN5qbh0Vt7OPLuI+HBxdoJThfFuDYjR1
         5aiumOcYsk+SC74OBOxl1tAdUaphoZ846oi0s1E5x9xWCQoMniZpoTp7H+xqlEt6ef2O
         rCN5Vu8xIZ5S2ce9iZCoWLlTdZp6b/R61sm7MyxtNZerPu7N11lppbVKoXt+Ee9yZ2o+
         VPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407888; x=1690999888;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk6jWIKfxALkH5YWG9XODZj23fNJc2D4nFUwyOlmNpw=;
        b=h3LR6YXNYBywUzjrpMIhouK3oFivg7RgaEhQfmjwnmShv58xWYG9yl/3r0rHXbm/kq
         EllFVdTYO+Wb5tehM/Qq2dVjv/HVU3hVDksi1MgZzKmRDpNn9ORbz9a2A4Ddno6zzAVN
         4oONvPW0rt/GdFVdwHyIa57QC0Bf5dXX5TQ9ZzJaYmGF1TuTuC9Vy5MEZkrWNWfCUW+a
         j/6OOfDQkkdkCrhnr2DLl8ChYr2tGjLE9mYZ78SqMF6WlMY0T0pyroFa3HwR6Hkm3a/w
         qb7GbJnwlzPh/fj6BdNDEpa9vvy5x0hCCMQjOdX357Jwffp+Xpxuva3QpeOObiBSGco8
         IjOg==
X-Gm-Message-State: ABy/qLafgjCB4l5CrHAIS6PI/eUMfoLpqg6gQEYquJxgGNFotWSGXqL5
        eCP3UAYURS9KODExOFOkfQLmxA==
X-Google-Smtp-Source: APBJJlFy325cJq87q6d/v98dNxLzLD4Y9j3AOpQ5sEXrAjPzkjzJ29egWfrMYo/aV2dyEdJJ9ouadA==
X-Received: by 2002:a17:903:1210:b0:1b5:5192:fa15 with SMTP id l16-20020a170903121000b001b55192fa15mr10334920plh.20.1688407888286;
        Mon, 03 Jul 2023 11:11:28 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id k16-20020a170902761000b001b3f9a5d4besm15572309pll.255.2023.07.03.11.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:11:27 -0700 (PDT)
Date:   Mon, 03 Jul 2023 11:11:27 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jul 2023 11:11:25 PDT (-0700)
Subject:     Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
In-Reply-To: <CAHk-=wijh9Gi14SRe0riD8Y9EdPpo3MNU_XDu8vpjY6xWdNhpQ@mail.gmail.com>
CC:     Marc Zyngier <maz@kernel.org>, Conor Dooley <conor@kernel.org>,
        apatel@ventanamicro.com, oliver.sang@intel.com,
        Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-ce7af44f-732e-4a48-adb4-62deb17b3eb9@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023 10:46:55 PDT (-0700), Linus Torvalds wrote:
> On Mon, 3 Jul 2023 at 10:34, Marc Zyngier <maz@kernel.org> wrote:
>>
>> Comparing with what we do on arm64, a less radical change would be to
>> move the IPI init after notify_cpu_starting(), which explicitly
>> enables RCU usage.
>
> Ack, that looks right to me.

I don't see anything wrong with it and it's passing my tests, but we've 
got a handful of ways to boot so it's all a bit messy and I might be 
messing something.

I'm still catching up a bit as I took both days off this weekend.  
Hopefully just an oversight in a bigger rafactoring, but I'll give it 
another look.

Marc: are you going to send that as a patch?
