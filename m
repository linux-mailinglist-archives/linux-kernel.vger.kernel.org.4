Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B224673BB33
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjFWPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjFWPLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790DE2D4E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:10:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569e7aec37bso9783397b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533042; x=1690125042;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xDW512AMWN2/l8Gl/XnRAjtww3e9CB3zNKNI+7nHZzU=;
        b=2XRCyitvwHsFaseO2qHq/bXJOkP4xrmj5rEBBjiRGnqTp1l+mA57nY3tu5XumWk4QZ
         mPN5wN2mTl2S+TRIuHPmM1nZm8jwfZGdifN5ah2itJnX0ehHHdh4fD2NRfTUXKDcOQdB
         E22KFdK5y7Q3PweNqkeEWv//t3Y2eslsPp6Z+LQceN0RPTdo7a/5J/DtYCVFukS2lTEN
         PCu+XcV2FNF/8Wkkvr/aqtJfqRmSLM2oBJi0FZaywwvTcf3j5jg9fRLkh2MwSC3aCcSJ
         6TMpzkwpjn9bK1rLCBhnQUYK8W0LI0Mh8huoa5EllWkTsjSY3geq6Ennn+4OAEea/Suy
         /BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533042; x=1690125042;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDW512AMWN2/l8Gl/XnRAjtww3e9CB3zNKNI+7nHZzU=;
        b=dQjmYHcSTbhtd/gZWQe1qt0lUMAtREJU3jTwa0iKObSaVcrtnQzoqT2rsnZxUj1cy2
         dLPytv4vKd9JCc33mPy+HlfLMYd2CW2MNwjYgiKisZKBapTfsiypl2Ak4y7BjA6Gpof3
         +KEh4BRhVJ2FDgO53Q9Lld4YCDM+3qwXXAUNVGk+c/z2TZXKvbpLInUmCI5TQRvRr2CH
         ayGHCHNYPxTLtmqiPHW4/abXwYmsG7WpSOAnBajSZ64Hy82UQBzAw6iGiRNi6bN8X2CV
         fZBFxg065a+NCMJhMoNQ5o8nLoJ1YUCdOK08evWe/9uWMQVnd2bB3qqJj1ik6tzimM+n
         KwBw==
X-Gm-Message-State: AC+VfDxYnsXI3rc+B5UJeVYeNnRBV90Hq2VxJ3OQcHhDGNxzork1fDqe
        6YQpj2RnILKEl3/C2HLznXsA9XeQ6GV8
X-Google-Smtp-Source: ACHHUZ5duT0Q2E0Bc88n4bLv6s1lkYEBuH2PD0kd/fBAJAijrWkmtz0YR1Rc4REacVm35/dVvpMG24QtfW80
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:5d47:84a:2819:bba4])
 (user=kyletso job=sendgmr) by 2002:a5b:ccd:0:b0:bd1:7934:b4fe with SMTP id
 e13-20020a5b0ccd000000b00bd17934b4femr9439305ybr.13.1687533042671; Fri, 23
 Jun 2023 08:10:42 -0700 (PDT)
Date:   Fri, 23 Jun 2023 23:10:33 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230623151036.3955013-1-kyletso@google.com>
Subject: [PATCH v2 0/3] Some fixes for select_usb_power_delivery
From:   Kyle Tso <kyletso@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update v2

- Add "Cc: stable@vger.kernel.org" to each patch

== original cover letter ==

Hi, here are some fixes about the attribute "select_usb_power_delivery"
in typec/class.c

===

usb: typec: Set port->pd before adding device for typec_port

This one is about the visibility of the attribute. port->pd should be
set before device_add otherwise the visibility will be false because
port->pd is NULL.

===

usb: typec: Iterate pds array when showing the pd list

This patch fixes a problem about the incorrect fetching of the pointers
to each usb_power_delivery handle.

===

usb: typec: Use sysfs_emit_at when concatenating the string

This patch changes the use of the API from sysfs_emit to sysfs_emit_at
because the buffer address is not aligned to PAGE_SIZE.

===

Kyle Tso (3):
  usb: typec: Set port->pd before adding device for typec_port
  usb: typec: Iterate pds array when showing the pd list
  usb: typec: Use sysfs_emit_at when concatenating the string

 drivers/usb/typec/class.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

