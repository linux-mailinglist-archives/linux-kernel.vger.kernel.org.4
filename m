Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE66162CE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiKPXTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiKPXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:18:59 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CDD623A4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:18:58 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so4717126pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YAsix4Ocn5wpHLscvr9CypGxgbi6eWxwp982B1e3fM=;
        b=ao1d+YlYl+V5vZrhhCOUDweYvAvSC3A10UC2MnFkKCeMA2r56PKfZt1RoGTyCMCWi/
         z7C0N0cKoKJzJG6Vk1AdnMG5BHkiBZ+3nzY1oKSZZ/h9mZRPkWRe9Beix97ux0+7TIVz
         jqG1MEEMVXffNWDvFH7VDRc0bxvIOOUmdJH7JUJELB+9h7QwoJAfyXe2LaCJXxoklxnx
         9oVkptbrxex2Y1A4eYixu3TT8ogh8SWYIMZAidIH+WHIEYA1K1dlv+U9vRuyiM96zbu8
         Qww2FG1xbTL864eZr4FakSr/hPvJGecbeB+gd6XySvEky4BRxrjkXQSTTiw28oNApCIh
         bmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YAsix4Ocn5wpHLscvr9CypGxgbi6eWxwp982B1e3fM=;
        b=0BzarQiHDU14lZlIvfz7m4itHTiGo2jY/sSZud56XtcfC47AVkU5b/yI3FPuiNQHyv
         QWN4CxqtTkq9zfs3vJykATYt7dTDIiHy0YWGUmKRwtb5sHhux+yzwj61pKVReFwUOhuN
         iy9KPP495frYWGIDiZdm292YWLjSYn0mqst0PjfFTFK3WCwe5kXFvAZg3gybTMWHBfnF
         m2kDD7lBjY2f1VnIZJYfRuaBtBkZWQgN2II33knHW4zBMWEXJbdezN8C6CKlGoG4qQ1A
         rGpSKfWsWtKco1uZdPaJUoI1Oy7JIRiHKxwA+JFS2IhVlB1luW6OFUUbCMzF96BXdj9l
         +wpA==
X-Gm-Message-State: ANoB5plKwQJqtQQiKVtXKX1UrJKxHkkJ3/juuscQyLRWccR4Z6tv4289
        6Job8q5DtSNolDjV1K1Qf5kMFdyhj5s=
X-Google-Smtp-Source: AA0mqf6hinthAEF7g8kY9Vi1riz6CiYW3nP7rYXq2xbqL6aXUJDl3a3MEmFfLas0sKzhF8Mq/+8EDQ==
X-Received: by 2002:a17:90a:694b:b0:200:8f06:e9cc with SMTP id j11-20020a17090a694b00b002008f06e9ccmr6132054pjm.7.1668640738061;
        Wed, 16 Nov 2022 15:18:58 -0800 (PST)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id u190-20020a6260c7000000b0056b8b17f914sm11382633pfb.216.2022.11.16.15.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:18:57 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org
Subject: Re: [RFC][PATCH 0/4] cachestat: a new syscall for page cache state of files
Date:   Wed, 16 Nov 2022 15:18:56 -0800
Message-Id: <20221116231856.3325180-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221115182901.2755368-1-nphamcs@gmail.com>
References: <20221115182901.2755368-1-nphamcs@gmail.com>
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

There are some build errors that has to do with specific arch/config -
but these are not related to the the main logic of the implementation.
Of course, I'll address these in v2 of the patch set, but in the
meantime, please feel free to take a look at this RFC and give me your
thoughts and suggestion.
