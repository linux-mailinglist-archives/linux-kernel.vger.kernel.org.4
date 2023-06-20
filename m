Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C18736D12
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjFTNTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjFTNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:18:45 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E391FD4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:23 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-760dff4b701so59550439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687267101; x=1689859101;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLVHgwkUvI5frBa0zQY5JXyD7/vRwXg7Z/40OmKjKWY=;
        b=vfbwQ/arg0v8WEFSyRtGXp8mzfaAnK3jv3bBI9ziMOBB1rMZ6GsnXqTQEeE8KJ71aX
         BNXttGGbEXIypNDUJ4e+E2pfH1Rcar0vJ+wXMyaJUEfUHgPfd1AEctNUQUoVvlqyIKkL
         6iy/I9vWnpzN7eRu9wvaZw12W0OQUjb0yUat4yrvKFEM2YGglzhI6Zqpqtfm8bO48GoF
         46rqM16HYQf3XDrBoJ0j4bjw9okt/sPkLl/stSntcmwCYqg4G6y95fX/SpAxEK4G2KPh
         bXzR2eJ3ylHuIcs48Qi3xlK0vKCX02DQLyKIcWU16yp4rR87LtPRMoSG+zQf1SUcsHEn
         hCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267101; x=1689859101;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLVHgwkUvI5frBa0zQY5JXyD7/vRwXg7Z/40OmKjKWY=;
        b=RYUhW/N0NuiTugk5oK5vdIduoVsO1E4fZE8INVKLnzmA4hn3Mx8UNp7mJC1yI7nlYY
         gOkDkd2zLzB3P++R93BNzbezWL5DBcwZiRIcbEiNYZv+aw2CAJFNPS/6ISek6+7gnbS9
         nGmrFWzAZmGElEc2v40vPZlBzyQEQ90Q39EZ0GfjNJrHYljtIjSYZ0x4y+Pnpi7DaKB5
         m1GoNKVArELMJkrBsC+MrNBlaB8zxWVY3uEh2uF7562TASyHzl+/eyipCuTEkzM4LyIX
         RW99vIbeYk4KPJFb0bmiGcu/VSR0AYhkDjIGimde9+LqAOjzzg/OV80UH6lxCl75hTID
         IxRg==
X-Gm-Message-State: AC+VfDyamu3ooVaT3ta4Kg01cfOC5noi5ib3RCQv+cCNzvRB8gdrOeKm
        KeVESf9JOdWy/drQhY3/ITbfdQ==
X-Google-Smtp-Source: ACHHUZ7i6NQjY2D0sHTWi3V0GJgHJ2MKRNFUPsDrcm+rxtrkHypCG6HQLTj9Xum/4/+rwfmuZB58Vw==
X-Received: by 2002:a05:6e02:2182:b0:343:9470:4ee8 with SMTP id j2-20020a056e02218200b0034394704ee8mr3878694ila.3.1687267101454;
        Tue, 20 Jun 2023 06:18:21 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r23-20020a634417000000b005143448896csm1399994pga.58.2023.06.20.06.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:18:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, stable@vger.kernel.org
In-Reply-To: <20230607170837.1559-1-demi@invisiblethingslab.com>
References: <20230607170837.1559-1-demi@invisiblethingslab.com>
Subject: Re: [PATCH] block: increment diskseq on all media change events
Message-Id: <168726710016.3595534.9633662613974186996.b4-ty@kernel.dk>
Date:   Tue, 20 Jun 2023 07:18:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Jun 2023 13:08:37 -0400, Demi Marie Obenour wrote:
> Currently, associating a loop device with a different file descriptor
> does not increment its diskseq.  This allows the following race
> condition:
> 
> 1. Program X opens a loop device
> 2. Program X gets the diskseq of the loop device.
> 3. Program X associates a file with the loop device.
> 4. Program X passes the loop device major, minor, and diskseq to
>    something.
> 5. Program X exits.
> 6. Program Y detaches the file from the loop device.
> 7. Program Y attaches a different file to the loop device.
> 8. The opener finally gets around to opening the loop device and checks
>    that the diskseq is what it expects it to be.  Even though the
>    diskseq is the expected value, the result is that the opener is
>    accessing the wrong file.
> 
> [...]

Applied, thanks!

[1/1] block: increment diskseq on all media change events
      commit: b90ecc0379eb7bbe79337b0c7289390a98752646

Best regards,
-- 
Jens Axboe



