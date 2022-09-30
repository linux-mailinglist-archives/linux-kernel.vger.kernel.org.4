Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DF35F1518
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiI3Vlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiI3Vln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:41:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39120857C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:41:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 78so5176632pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=LHKjqiv/1IHiQva1vWxJ8QVlM67W4929ggbGJZR64u0=;
        b=FEV0LEPSMUlSbwnVYD7mmedr/iHQ0xyAf5qU00LNXYcOuaLKugLFBkuVC39Lt/YJd5
         Eo42iKlC8ydkOvxLBF168YxPi5HGb+yashCijTKzrI2iQNniLKARB4eFNwYHZZHZX18G
         yIOGCNWh4sAbwwguZwrdJCzgwnzu6QziSqIeLxmW6/5FTsSeYSAss82v3DCuWStdd+Tv
         rMknqB5ja5yzNIsqc3OJ6kLIWTPIm9p4lXODhJwfMGamIkzqgCroHAFsch/J9vlUw5VY
         +uq8vmdEVhA4zx4KkmVei59WXosO5u5E9waoefGAXde8xh5AozVFsRxNB+0oSubHC2ET
         dFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LHKjqiv/1IHiQva1vWxJ8QVlM67W4929ggbGJZR64u0=;
        b=7X2/xBjlhTtfMU+JbMBJnybzpbIhizr94YMN//EMH1x4VSgzbif2VPFdrB/eyP30RM
         vFLFtVVUh1JgI57R3PfsjSyD4VYsHrq8R7B0jmEhMIAPsrCX+ohBi/CP3r5ywLuQSSwH
         uij7yabS6PwAYVP/014KYs2xxaXFwXqY2uMdzTRokkar2FWofWlqB62m0IdaPIOTuxIN
         McfbZFc+DrUE74YwJqRCO5IembFpq3V3/m6cHbH++1W/Kn94wxUJpWpDm4barShf4hBT
         t70t09N/PS+60A/xpNBXGo1vj2QBpBt4iEN5MWHUFeA6Upg4Es6eOBlcqEGx45fLAfZi
         PxdA==
X-Gm-Message-State: ACrzQf1qZCtTSq9q6mkN4RntOQOC1SExl9BGUcunnBsQwyRDaOEEQAVZ
        xp38MYVg94jfqs04zC1Zyw4=
X-Google-Smtp-Source: AMsMyM45UxdTWoNBNzj5nmv40+tuCZZ04crLXO/v8089MJ7ZK0zmjLx9WXcPJ2v0P3sOxm35pV4yYA==
X-Received: by 2002:a05:6a02:186:b0:439:49a3:479b with SMTP id bj6-20020a056a02018600b0043949a3479bmr9250552pgb.171.1664574101595;
        Fri, 30 Sep 2022 14:41:41 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id p124-20020a62d082000000b0053617cbe2d2sm2281711pfg.168.2022.09.30.14.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:41:39 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc:     "David C . Rankin" <drankinatty@suddenlinkmail.com>,
        Steven J Abner <pheonix.sja@att.net>
Subject: [RFC PATCH 0/1] drm/amdgpu: Fix NULL-deref in amdgpu_device_fini_sw()
Date:   Sat,  1 Oct 2022 05:41:09 +0800
Message-Id: <20220930214110.1074226-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are several reports of "Fatal error during GPU init" will cause
NULL-deref in amdgpu_device_fini_sw(). Although the NULL-deref is result
instead of reason, this NULL-deref will confuse user.

https://lore.kernel.org/lkml/a8bce489-8ccc-aa95-3de6-f854e03ad557@suddenlinkmail.com/
https://lore.kernel.org/lkml/AT9WHR.3Z1T3VI9A2AQ3@att.net/

This is probably because "adev" is not fully initialized when
amdgpu_device_init() failed. Thus subsequent amdgpu_device_fini_sw()
will try to release "adev->reset_domain" and cause NULL-deref.

This patch fixes this problem by guarding the code with an "if".
However, I'm new to this module and I didn't fully understand the code,
so please review my code carefully.

Best Regards,
Zhang Boyang


