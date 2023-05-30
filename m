Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD9716A92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjE3RN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjE3RNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:13:24 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66210E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:13:15 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-338bd590bc1so751245ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685466795; x=1688058795;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9lZV7bV7fcpjfbgqIwMWLtZa7MEtpBcanyjWNz9SA4=;
        b=xyLFhYk7xI5CYPvLeQkuOD1Z89KueAAajRiTaDrZh07ITGjo9jHqbiKMRbYZNbWzv+
         HmqqhLHdAzzjmAJTVdhuSMPg3cI9nGuwVAMhg2Ep8MLU9EtD+G4iOjxIA/b6N7IM1sao
         PUThVWll/0JIgxIiHuGwZ2BSuxITRKUZZ5Solv/TPxkLNQEJxplaEMDGjCPJQ/1zJdrn
         lDN4I0wagYiQuROt+XpyZZ5vDDKUrX3tum8wJOej2yoID/95poYBmxfHyD5pe8dx3SKX
         Eap3C+aY+sOde5CJZi+AqyFha0Lw1FxVoxW7//8A0MyKUyVK9TZA1KwGojvFzrLhWzce
         4P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466795; x=1688058795;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9lZV7bV7fcpjfbgqIwMWLtZa7MEtpBcanyjWNz9SA4=;
        b=cl23uPDpiPkT1un89Ojd40k1k7D0RmLEg4hWLgmdyh748nE6kk1qFtz3P+5+YcujrL
         HAnPCFX8VOrMulOnuOFykrCUmv7+w8Mce9Qlo4bpr4JmtV6METtlS2Am5xR2GFHSMylK
         lM79ZMnyVW+Uh+yKFQnE3EeTgp7/ZrUOTSRvVH2b54+diYcUNOBnBUZ4HP9X/wghnvu4
         yPB+5f6hGCwgsB2ibs1qB128Rn1/MZlrQgWepiTitffDOzopX5uzs/onIku7pV2ijiUK
         4LeNikYzZQmBNr/YxPxYcFMlJE9UVLyf+6rFlJJmMa56gmygDkdfDbRkrPWqSp8Kb/r7
         1ZBA==
X-Gm-Message-State: AC+VfDxKr0HYQEBTMsvmmsRfICFENaOexwUXWULHrDb8YjqERGf0da6Y
        vBVESUI28R+yAEDBEkuX8KKMbA==
X-Google-Smtp-Source: ACHHUZ4H0t7i48FfHuwAM9EvQXL2x+v9wdYmg8vgH6Bl+e7aisaRBhtMo7bNHYR/aHixz5BEUVFlkw==
X-Received: by 2002:a92:c568:0:b0:33b:c4c:f425 with SMTP id b8-20020a92c568000000b0033b0c4cf425mr60590ilj.3.1685466794987;
        Tue, 30 May 2023 10:13:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y59-20020a029541000000b0040fa32ccb0bsm817352jah.79.2023.05.30.10.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:13:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
References: <20230419-const-partition-v3-0-4e14e48be367@weissschuh.net>
Subject: Re: [PATCH v3 0/4] block: constify some structures of
 partitions/core.c
Message-Id: <168546679410.36719.118353258344450301.b4-ty@kernel.dk>
Date:   Tue, 30 May 2023 11:13:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 May 2023 19:09:56 +0200, Thomas Weißschuh wrote:
> A few structures containing function pointers that could and should be
> const are not. Change that.
> 
> 

Applied, thanks!

[1/4] block: constify partition prober array
      commit: 539050f92ea7666bca17c2c380d8071d2f93dcde
[2/4] block: constify struct part_type part_type
      commit: cdb37f73cf05631c4f7401f2cd99878733c0c3d9
[3/4] block: constify struct part_attr_group
      commit: 0bd478005cfc7f50ccb769744d952e9687ee75b4
[4/4] block: constify the whole_disk device_attribute
      commit: a378f6a40fac4a2f1812adea7017613d2bd5dab6

Best regards,
-- 
Jens Axboe



