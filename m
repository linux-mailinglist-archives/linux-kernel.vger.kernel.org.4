Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02B76410DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiLBWsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiLBWsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:48:08 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAC4A557F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 14:48:06 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id a14-20020a921a0e000000b00302a8ffa8e5so6709854ila.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 14:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0imnhvm+kf10bcAGQciUCVzWuZXXiWmFQ1RsUVVuTw=;
        b=kbarmBE+ReiJB9n4xwMFX3H4tvxZI00hfxXiwLhf0hrlmG2lwDbA8WlcUfypHXN8JJ
         pKIGzmgCvpn4GJpYHfZkUybDRk6PjziKEaJEeWOGiTD5hukxzuNrHEnOhz4BYL1cSmfc
         s7oVuDB3eE/SrF3COCc9IcLXY6Lqd2LcObrC7ANVe1U9JOHadhhqEnNzoNh8DBrR3rpt
         5uOipw2Dbp2B4WqkFoMTrLWl0zvhsSmxwnZK2+s6tKSI4LPU5goCwqmmEYzAc6ala8EK
         e3CPcjBJ7iOAW0Vt7UD+6EiEzQ7vI3kaU/U37HAFbDSy8563dPwaadO26auVwGzPVEMT
         md7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0imnhvm+kf10bcAGQciUCVzWuZXXiWmFQ1RsUVVuTw=;
        b=5CK38pLFd+hMf71+v2fo2OckwBI2HfAcxQ5HoVRi9eLN4Jb2Lt/3OSbCNyoWnvHyyy
         HxYtkwMWBoRySJPtfBVC+1duOJtAEfk5261W6zTZaHvB7JuqBkZJioLEla5aICQCySni
         0c/Jf/J1BOxdxjuU6xjyFO0IkkGqbWVD16vxs73TpY+iS8cLZkP50W3EWv6vJFnMXj3C
         2iaNCcwQgBGxoYjM9K4ZyJOJLkWDa7vSWnpIF7U922ZOBnez9P6WsaROAt2rxHrkJ4Ig
         tYUY127/2idKBxXCi5Mbqjeay2jq7wunwVj2xDtX2twgskcb0w0egvNVeVvxRbwbtK8l
         QrcA==
X-Gm-Message-State: ANoB5plhtztF92ZbSy/TeilNWnVO36sZQyLmj6TVGsCE5Gt5tKQuBAXU
        /HY+S/wKCokHnZH7U65FhDBB9dOB0iomDyI=
X-Google-Smtp-Source: AA0mqf6TF+b4GR3uPUIetXie9acj2yjiT18qv25+y5jB+jOCKS4ZBR4GRR5YFcJnHLJASTSAmyHAF+UgGFyjegc=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a05:6638:480a:b0:38a:3357:8a4 with SMTP
 id cp10-20020a056638480a00b0038a335708a4mr18794jab.53.1670021286086; Fri, 02
 Dec 2022 14:48:06 -0800 (PST)
Date:   Fri,  2 Dec 2022 16:47:43 -0600
In-Reply-To: <20221202224744.1447448-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221202224540.1446952-1-allenwebb@google.com> <20221202224744.1447448-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202224744.1447448-4-allenwebb@google.com>
Subject: [PATCH v6 4/5] docs: Add entry for /sys/module/*/modalias
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to include the modalias sysfs attribute for
modules.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 Documentation/ABI/testing/sysfs-module | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-module b/Documentation/ABI/testing/sysfs-module
index 08886367d0470..1244a0e8d133e 100644
--- a/Documentation/ABI/testing/sysfs-module
+++ b/Documentation/ABI/testing/sysfs-module
@@ -48,6 +48,18 @@ Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:	Show the initialization state(live, coming, going) of
 		the module.
 
+What:		/sys/module/*/modalias
+Date:		Nov 2022
+KernelVersion:  6.2
+Contact:	Allen Webb <allenwebb@google.com>
+Description:    Module match-id-based modaliases
+
+                These match against MODALIAS values included in the uevent of
+                devices when they are created. The attribute is implemented for
+                subsystems with the authorized attribute such as USB so
+                userspace can make authorization decisions based on which
+                modules match the device.
+
 What:		/sys/module/*/taint
 Date:		Jan 2012
 KernelVersion:	3.3
-- 
2.37.3

