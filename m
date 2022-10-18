Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E4D602B09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJRMC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJRMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:02:23 -0400
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF19ABE501
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:01:17 -0700 (PDT)
Received: by mail-pf1-f196.google.com with SMTP id y8so13821311pfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHxDRCnZucCtm+QxtCIlhgW5wwIPRmfeRehNf+TVkxE=;
        b=KRCp0TOaWa6RM5wNLrgP5IpPlBNUI6U10rEhxYzV3h5MTaORFlVlIrEIyJBLN/z3eo
         e6WI64Gk0hLklCb5tIws+0NsAP6N0IA0IMMwU+RQabNMrNYyfXfb+8EmMkIvGQXwGay0
         SuJdSQPjSoM81csbcBMYIGKJyrK28kvTiGqXzFSgLCCNDjr7OzzBUAONnrSIzpifo4wZ
         0NRxAJmTT86NiwlnGvStwTiWHmVVSFqEbXJRw246oh2rB4jGSS7aEBMhY+r9hykiPcZE
         OXZtlq8MMcjeL+53xYlIbMNqdsxKkwmFZNktbBLWChRG5f3sEwUfaK1bRfE/tyLaNQRj
         W7Ig==
X-Gm-Message-State: ACrzQf3xtB0ltQ8vGqbyDukD3YQvcY14f7EWFyMWklFkONqTiQu/BzbH
        6bA12y6RUGO+gEySPANiug==
X-Google-Smtp-Source: AMsMyM5ggyzEKM0qRc2E4l4kcqEwjQateIO8nAHGkJE0SzMqm0qwp+DXqJGEo81wwW1r8+Ds/HtTNw==
X-Received: by 2002:a05:6a00:1a8e:b0:565:b185:cc10 with SMTP id e14-20020a056a001a8e00b00565b185cc10mr2576263pfv.71.1666094477384;
        Tue, 18 Oct 2022 05:01:17 -0700 (PDT)
Received: from localhost.localdomain (ns1002484.ip-51-81-243.us. [51.81.243.185])
        by smtp.gmail.com with ESMTPSA id v18-20020a634812000000b0043b565cb57csm7893851pga.73.2022.10.18.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:01:17 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, kelulanainsley@gmail.com
Subject: [PATCH 0/5] tracing: Revmoe absolute timestamp logic and interface
Date:   Tue, 18 Oct 2022 20:00:51 +0800
Message-Id: <20221018120056.1321426-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit efe6196a6bc5 ("ring-buffer: Allow ring_buffer_event_time_stamp() to
return time stamp of all events") make ring_buffer_event_time_stamp() have
the ability to return time stamp of all events. The hist trigger had
also switch to the new logic to get time_stamp. The absolute timestamp
logic had bocome useless, so it showed be removed.


