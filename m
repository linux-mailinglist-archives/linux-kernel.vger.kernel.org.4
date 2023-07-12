Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6925975000E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGLH3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGLH3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:29:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E94E5C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:29:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-579e9b95b86so72442917b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689146939; x=1691738939;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tsuXREvsrn1UmDo9EliDCD4RsbsJpLJ9JUGOT866VTo=;
        b=TZv/WOugLJFK5patBFYf9CjbhkE3/o0leTZemNCM4fD/xamCi367TZsnRS22SaCFca
         drSBGPe9Zq9aFs2Rb2vrwk+BvzJXmnyBRm8iBlw/pTQ0DxKDgZ7yTI+B5EtOqEjNtH/1
         QxeCouZeLkEKEWlbpg07wEiieaxxrlPZhgSWAATEKEyf3oQyhw2elFdXREoFbivwDqhu
         MRDTW1vFuLprx0qzWGN2Lm1qyfvzGHkU54UUQfL5j8AynofS9zZhPZu0OwrHZaC2yrM6
         Akv26/t8fdKnyUq8EuBgtMSpSPM7Aa+iYFOiVX8xTBi0hVNRvU4v4CpMIgrBxVeVmueI
         PhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689146939; x=1691738939;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsuXREvsrn1UmDo9EliDCD4RsbsJpLJ9JUGOT866VTo=;
        b=UuzQgyrs7+q9menHfvyEghJehTXXBnNZCgigWWv48JpYDqlNlmCmfdDQrIPcPeudEG
         ezEg6P5ufuayofrUPfYm/XZqECaJp0B5JbUrqhVCwxlY4OL47U3mNR48hSVKlNMN3A9U
         6yqk2T/HnxT1nZU2bus2o6inGx+ZifiWI/mDXpL8+VA2t0H2/gUIzd/vSJVl1T06ImRu
         nILy3hPRgMGIQZEuYPgSeYPiegT9ghdWc7Q4Vb8ggG30ViEz1JPJV4zx29jbD3acWxy4
         FblKjycTiUxKchpy0/kXBiWBynymm9wx/UuDjlH9mstReHOwBbqT43alc+sEr9BMzSl9
         e16A==
X-Gm-Message-State: ABy/qLaZpLcNOLmLXy6lIvyvFKqPEHTbnhXfbrRqqzmJsEpJaIL6lCOf
        rj3rXs9FOqxKvlwz1pQ76JMRwwRSvm/x
X-Google-Smtp-Source: APBJJlHpV/qV+o9RosV/Gz3jOlAFPqd3Jzlxy/qB2ZXYVY+rjW2+Gcs+LNXN2bUwGzlp+iUyS3Qnon98v2C2
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:a359:73aa:74d4:e205])
 (user=kyletso job=sendgmr) by 2002:a25:da85:0:b0:c4d:9831:9712 with SMTP id
 n127-20020a25da85000000b00c4d98319712mr154191ybf.0.1689146939261; Wed, 12 Jul
 2023 00:28:59 -0700 (PDT)
Date:   Wed, 12 Jul 2023 15:28:51 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230712072853.1755559-1-kyletso@google.com>
Subject: [PATCH 0/2] mutiple selectable capabilities in tcpm
From:   Kyle Tso <kyletso@google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit a7cff92f0635 ("usb: typec: USB Power Delivery helpers for
ports and partners"), typec_operations has two new ops .pd_get and
.pd_set providing selection of different PD capabilities. This commit
implements these two ops in tcpm.

To support multiple capabilities, new dt-binding properties need to be
defined to create a tree structure for the driver to get each set of
capabilities one by one. The first tier of the child node under
connector is called "capabilities". Under this child node lies several
2nd tier of child nodes whose names are in the pattern of ^caps[0-9]+$.
And the source and sink capabilities are placed in these nodes.

Kyle Tso (2):
  dt-bindings: connector: Add child nodes for multiple PD capabilities
  usb: typec: tcpm: Support multiple capabilities

 .../bindings/connector/usb-connector.yaml     |  44 ++
 drivers/usb/typec/tcpm/tcpm.c                 | 406 ++++++++++++++----
 2 files changed, 364 insertions(+), 86 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

