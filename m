Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C8615297
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKATyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKATyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:54:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B878517E2A;
        Tue,  1 Nov 2022 12:54:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t1so5775660wmi.4;
        Tue, 01 Nov 2022 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuPYW3zcmBbw/VTLcYCO1tzZneqt2rKUrwkpyfyHXaA=;
        b=ePmKysLlsWIIrpxBnQwGmTxA8jrtQv3EEJWPlVNv0FjO539w+L3M9nfdRQoAvRaeCm
         tIaz8M13OrAJlH4pw/B03hGQGIu/pTnEUFUQKcDBtJv0Ku+4a7igmtz5NP6/qriJzw0N
         Xt7ao+EVfXLpJDYV8Pv/HRt7Nj5NogfgIm+hhlGR3u0I6n22wOiueb7Em7848eSVPsd/
         yscUj7eYpmw8duxdUewdLoXbQgvAHqD5rpJ9mkxdD0a2pMbszYt4Js4dMi5cp4T/QUCR
         APH2tm6Ej7U6JEWaO4h6+beA9o1F34y21Qxeyj69bZRWWQh9jweJp0pQ5OZpoxPNgv7o
         vkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuPYW3zcmBbw/VTLcYCO1tzZneqt2rKUrwkpyfyHXaA=;
        b=v6hqXoWRfgX2ONS784iMJgUWO1omDZYPfHcW+R04X3YhmlQR4nWJdNlCSfh8quV7q3
         Q8815hc9l1hFWn4iwmqnIs79DBwMoJeimvX2G0+lx+lvm9X97Ie1lBQtzspXzSBMrtmV
         yArjyzJsY53BlNf6c1wPJZ2dwWiAW6d8ShNQiwz//jDkhS2xi+fscvVL1nmSMB1Xrd4o
         Rqky/9/Z6EJq/CxWNaaK2eXvuAQl2lg5Y90TFiYtd5iZJ4GdFt5nzZQ+SScJPmW/17rp
         ITwrMzFKPH9g8MMvdMFcVi1tDPsMiLwM+hv2OWhYzZf7RI4cTGKt7TA6MwUl7w+66QSq
         KKRQ==
X-Gm-Message-State: ACrzQf1lofyUa5u1VCuhwkjJI5tJnGgzTawd0OZPthny8QwyS8tTpyJo
        VYeaOIQLNgMLzh9+AID5LoxE1VboDeG0dw==
X-Google-Smtp-Source: AMsMyM6XDoR+JLtuV8pTJXSsZLauz0OFFqAsu5LviGTv34Bp61ju7jmu5NEIRSxB1CpfKwkEvtKy5Q==
X-Received: by 2002:a05:600c:554b:b0:3cf:84ea:3097 with SMTP id iz11-20020a05600c554b00b003cf84ea3097mr137791wmb.100.1667332445352;
        Tue, 01 Nov 2022 12:54:05 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003cf75213bb9sm6092617wmo.8.2022.11.01.12.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Nov 2022 12:54:04 -0700 (PDT)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz
Subject: [PATCH 0/3] power: supply: cpcap-battery improvements
Date:   Tue,  1 Nov 2022 21:53:42 +0200
Message-Id: <1667332425-12536-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements few improvememts to cpcap-battery driver
